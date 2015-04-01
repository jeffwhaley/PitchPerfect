//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jeff Whaley on 3/23/15.
//  Copyright (c) 2015 Jeff Whaley. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
// Holds the audio location so can be saved across views
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL!, title:String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }


}
