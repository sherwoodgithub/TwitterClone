//
//  TweetCell.swift
//  TweetyBird
//
//  Created by Stephen on 1/5/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
  @IBOutlet weak var userNameLabel : UILabel!
  @IBOutlet weak var tweetLabel : UILabel!
  @IBOutlet weak var tweetImageView : UIImageView!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
