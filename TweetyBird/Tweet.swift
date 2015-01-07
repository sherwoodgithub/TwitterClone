//
//  Tweet.swift
//  TweetyBird
//
//  Created by Stephen on 1/5/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import Foundation

class Tweet {
  var text : String
  var userName : String
  init ( _ jsonDictionary : [String : AnyObject ] ) { // the dictionary passed in: STRING==KEY, ANYOBJECT==VAL
    self.text = jsonDictionary["text"] as String
    let userDictionary = jsonDictionary["user"] as [String: AnyObject]  // pull ref to inner dictionary
    self.userName = userDictionary["name"] as String                    // access values in inner dictionary
  }
}