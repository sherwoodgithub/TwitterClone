//
//  NetworkController.swift
//  TweetyBird
//
//  Created by Stephen on 1/7/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//
//
// NOTES: 
/* init: every class needs 1 init (even if empty) */
/* twitterAccount : ACAccount     this would create a NetworkController property of ACAccount type
twitterAccount = ACAccount()  initializes an empty class of ACAccount while assigning to twitterAccount */
/* JSON parsing!
NSJSONSerialization: class to import JSON into this.Class
JSONObjectWithData: method of previous (performRequestWithHandler), 3 params:
1st param: data, reference to "data" param from line 36 (twitterRequest.perform...) closure  */

import Foundation
import Accounts
import Social

class NetworkController {

  var twitterAccount : ACAccount?
  var imageQueue = NSOperationQueue()
  
  init () {
    
  }
  
  func fetchHomeTimeLine (completionHandler : ([Tweet]?, String?) -> ()) {
    let accountStore = ACAccountStore()
    // type of AccountStore is Twitter (see: .accountTypeWithAccount... )
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    // third param: { (granted : ... refers to if access granted
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in
      if granted {
        // create accounts property with accountStore type values
        let accounts = accountStore.accountsWithAccountType(accountType)
        if !accounts.isEmpty {
          self.twitterAccount = accounts.first as? ACAccount
          // setup url we'll make attempt to
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          twitterRequest.account = self.twitterAccount
          twitterRequest.performRequestWithHandler() { (data, response, error) -> Void in
            switch response.statusCode {
            case 200...299 :

              // accessing property of JSONObjectWithData
              if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
                var tweets = [Tweet]()
                for object in jsonArray {
                  if let jsonDictionary = object as? [String: AnyObject] {
                    // Tweet(jsonDictionary) runs the Tweet class init
                    let tweet = Tweet(jsonDictionary)
                    tweets.append(tweet)
                    }
                  }
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweets, nil)
                })
              }
              
            case 300...599 :
              println("Shit, our bad")
            default :
              println("Default")
            } // switch
          } // performRequestWithHandler
        } // if accounts empty
      } // if granted
    } // requestAccessToAccountWithType
  } // fetchHomeTimeLine
  
  func fetchInfoForTweet (tweetID : String, completionHandler : ([String: AnyObject]?, String?) -> () ) {
    let requestURL = "https://api.twitter.com/1.1/statuses/show.json?id=\(tweetID)"
    let url = NSURL (string: requestURL)
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url!, parameters: nil)
    request.account = self.twitterAccount
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      if error == nil {
        switch response.statusCode {
        case 200...299 :
          
          if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [String : AnyObject] {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(jsonDictionary, nil)
            })
          }
          default:
          println("default fired, fetchInfoForTweet")
        }
      }
    }
  }
  
  
  func fetchImageForTweet (tweet: Tweet, completionHandler : (UIImage?) -> () ) {
    if let imageURL = NSURL(string: tweet.imageURL) {
      self.imageQueue.addOperationWithBlock({ () -> Void in
        if let imageData = NSData(contentsOfURL: imageURL) {
          tweet.image = UIImage (data: imageData)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(tweet.image)
          })
        }
      })
    }
  }
}
