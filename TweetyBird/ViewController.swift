//
//  ViewController.swift
//  TweetyBird
//
//  Created by Stephen on 1/5/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit
import Accounts
import Social


class ViewController: UIViewController, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var tweets = [Tweet]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      let accountStore = ACAccountStore() // create an empty ACAccount store class (empty because of open/close parens
      let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter) // what type of ACAccountStore? Twitter (see: .accountTypeWithAccount... )
      accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in // third param: { (granted : ... refers to if access granted
        if granted {
          // create accounts property with accountStore type values
          let accounts = accountStore.accountsWithAccountType(accountType)  // Why this line?
          if !accounts.isEmpty {                                            // if it's not empty
            let twitterAccount = accounts.first as ACAccount
            // setup url we'll make attempt to
            let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
            let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
            twitterRequest.account = twitterAccount
            twitterRequest.performRequestWithHandler() { (data, response, error) -> Void in
              switch response.statusCode {
              case 200...299 :
                /* JSON parsing!
                NSJSONSerialization: class to import JSON into this.Class
                JSONObjectWithData: method of previous (performRequestWithHandler), 3 params:
                1st param: data, reference to "data" param from line 36 (twitterRequest.perform...) closure  */
                if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {   // accessing property of JSONObjectWithData
                  for object in jsonArray {
                    if let jsonDictionary = object as? [String: AnyObject] {
                      let tweet = Tweet(jsonDictionary) // Tweet(jsonDictionary) runs the Tweet class init
                      self.tweets.append(tweet)
                      
                      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in // tells SLRequest to go back to main thread
                        self.tableView.reloadData()       // only going to happen once back on main thread... updating user with new data we just parsed through
                      })
                    }
                  } 
                }
              case 300...599 :
                println("Shit, my bad")
              default :
                println("Default")
              }
            }
          }
        }
      }
      //change comments around
      /* DAY 1 junk!
      if let jsonPath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") { //looks for match in bundle for "tweet" & "json" thus tweet.json
        if let jsonData = NSData(contentsOfFile: jsonPath) { //says: use following code if jsonPath retrieved by NSData's contentsOfFile
          var error : NSError? //var for error param, next line
          if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [AnyObject] { // ( param jsonData = from local bundle )
            for object in jsonArray {
              if let jsonDictionary = object as? [String: AnyObject] {
                let tweet = Tweet(jsonDictionary) // remember: this jsonDictionary reflects class Tweet's jsonDictionary's TYPE (because of previous lines this file), not it's NAME. What you call this.jsonDictionary means nil
                self.tweets.append(tweet)
              }
            }
          }
        }
      } */
      
      self.tableView.dataSource = self
    }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath : indexPath) as TweetCell
    let tweet = self.tweets[indexPath.row]
    cell.tweetLabel.text = tweet.text
    return cell
  }
}

