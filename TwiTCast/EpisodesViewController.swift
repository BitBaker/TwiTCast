//
//  EpisodesViewController.swift
//  TwiTCast
//
//  Created by Dean Martindale on 9/8/15.
//  Copyright © 2015 Dean Martindale. All rights reserved.
//

import UIKit
import CoreData

class EpisodesViewController: UITableViewController {
    
    var shows = [TwiTShow]()
    
    @IBAction func reloadButtonPressed(sender: AnyObject) {
        fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = sharedContext()
        let fetchRequest = NSFetchRequest(entityName: "TwiTShow")
        try! shows = context.executeFetchRequest(fetchRequest) as! [TwiTShow]
        try! context.save()
        tableView.reloadData()
        
        if shows.isEmpty {
            fetchData()
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("episodeInfoCellIdentifier", forIndexPath: indexPath) as! TableViewCell
        
        

        let episode = shows[indexPath.row]
        cell.showTitleLabel.text = episode.title
        cell.tagLineLabel.text = episode.teaser
        
        
        // Handles image loading for the cover art
        let url = NSURL(string: episode.showThumbnailArtURL!)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            cell.showThumbnailImageView.image = UIImage(data: data!)
        }
        return cell
    }
    
    func fetchData() {
        
        let apiKey = "17376f26296519c47358ce6f766e050a"
        let appID = "36fc14f6"
        
        let endpoint = "https://twit.tv/api/v1.0/shows"
        
        let url = NSURL(string: endpoint)!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appID, forHTTPHeaderField: "app-id")
        request.addValue(apiKey, forHTTPHeaderField: "app-key")
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {(data, response, error) -> Void in
            if error == nil {
                
                let fullData = JSON(data: data!)
                let results = fullData["shows"]
                
                if results.count == 0 {
                    print("Error loading feed")
                } else {

                    let context = sharedContext()
                    for item in results.array! {
                        if item["active"].boolValue{
                            let newEpisode = NSEntityDescription.insertNewObjectForEntityForName("TwiTShow", inManagedObjectContext: context) as! TwiTShow
                            newEpisode.title = item["label"].string
                            newEpisode.teaser = item["tagLine"].string
                            newEpisode.showThumbnailArtURL = item["coverArt","derivatives","thumbnail"].string
                            newEpisode.showCoverArtURL = item["coverArt","derivatives","twit_album_art_300x300"].string
                        }
                    }
                    try! context.save()
                }

            } else {
                print(error)
                print(error?.code)
                print(response)
            }
        }
        task.resume()
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)!
        
        
        let viewController = segue.destinationViewController as! ShowViewController
        
        viewController.showCoverArt = shows[indexPath.row].showCoverArtURL
        viewController.showTitle = shows[indexPath.row].title
        
    }

}
