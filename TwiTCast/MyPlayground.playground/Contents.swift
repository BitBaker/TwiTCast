//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
XCPSetExecutionShouldContinueIndefinitely()

let url = NSURL(string: "http://private-anon-740d4938e-twittv.apiary-mock.com/api/v1.0/episodes?filter[id]=1642")!
let request = NSURLRequest(URL: url)


let session = NSURLSession.sharedSession()
let task = session.dataTaskWithRequest(request) { data, response, error in
    
    if error != nil {
        // Handle error...
        return
    }
    print(error)
    print(response!)
    print(NSString(data: data!, encoding: NSUTF8StringEncoding))
}

task.resume()

