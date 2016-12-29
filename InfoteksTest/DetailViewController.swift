//
//  DetailViewController.swift
//  InfoteksTest
//
//  Created by NIKOLAY FOKIN on 28.12.16.
//  Copyright © 2016 Fonixsoft LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailCreatorLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var mainView: UIView!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let detailTitleLabel = self.detailTitleLabel {
                detailTitleLabel.text = detail.title
                detailTitleLabel.sizeToFit()
            }
            
            if let detailCreatorLabel = self.detailCreatorLabel {
                detailCreatorLabel.text = detail.creator
                detailCreatorLabel.sizeToFit()
            }
            
            if let detailDateLabel = self.detailDateLabel {
                detailDateLabel.text = detail.date
                detailDateLabel.sizeToFit()
            }
            
            if let detailDescriptionLabel = self.detailDescriptionLabel {
                detailDescriptionLabel.text = detail.description
                detailDescriptionLabel.sizeToFit()
            }
            
            if let mainView = self.mainView {
                mainView.isHidden = false
            }            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: RSSChannelItem? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    @IBAction func openPage(_ sender: Any) {
        if let detailItem = detailItem {
            if let link = detailItem.link {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url, options: [:],completionHandler: nil)
                }
            }
        }
    }
    
    @IBAction func openComments(_ sender: Any) {
        if let detailItem = detailItem {
            if let link = detailItem.comments {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url, options: [:],completionHandler: nil)
                }
            }
        }
    }
    

}

