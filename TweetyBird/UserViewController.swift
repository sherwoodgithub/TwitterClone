//
//  UserViewController.swift
//  TweetyBird
//
//  Created by Stephen on 1/9/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var networkController : NetworkController!
  var userID : String!
  var tweets = [Tweet]()
  var tweetUser : Tweet!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "USER_CELL")
    self.tableView.estimatedRowHeight = 144
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.networkController.fetchTimelineForUser(self.userID, completionHandler: { (tweets, errorDescription) -> () in
      self.tweets = tweets!
      self.tableView.reloadData()
    })
    // Do any additional setup after loading the view.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("USER_CELL", forIndexPath: indexPath) as TweetCell
    let tweet = self.tweets[indexPath.row]
    //cell.textLabel?.text = tweet.text
    cell.tweetLabel.text = tweet.text
    cell.userNameLabel.text = tweet.userName
    if tweet.image == nil {
      self.networkController.fetchImageForTweet(tweet, completionHandler: { (image) -> () in
        //        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        cell.tweetImageView.image = tweet.image
      })
    } else {
      cell.tweetImageView.image = tweet.image
    }
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TWEET_VC") as TweetViewController
    var tweetToPass = self.tweets[indexPath.row]
    tweetVC.theTweet = tweetToPass
    tweetVC.networkVC = self.networkController
    self.navigationController?.pushViewController(tweetVC, animated: true)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
