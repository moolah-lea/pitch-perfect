//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Murrali Ramasamy on 28/4/15.
//  Copyright (c) 2015 KingPick. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}