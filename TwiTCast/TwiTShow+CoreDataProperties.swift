//
//  TwiTShow+CoreDataProperties.swift
//  TwiTCast
//
//  Created by Dean Martindale on 9/16/15.
//  Copyright © 2015 Dean Martindale. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension TwiTShow {

    @NSManaged var idNumber: String?
    @NSManaged var teaser: String?
    @NSManaged var title: String?
    @NSManaged var showThumbnailArtURL: String?
    @NSManaged var showCoverArtURL: String?

}
