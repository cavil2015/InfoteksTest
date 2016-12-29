//
//  MasterViewController.swift
//  InfoteksTest
//
//  Created by NIKOLAY FOKIN on 28.12.16.
//  Copyright © 2016 Fonixsoft LLC. All rights reserved.
//

import UIKit
import SVPullToRefresh

class MasterViewController: UITableViewController, RSSDelegate {

    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        Engine.impl.rss.delegate = self
        
        tableView.reloadData()
        tableView.addPullToRefresh(actionHandler: {
            Engine.impl.rss.update()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rssLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }        
    }
   
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let feed = Engine.impl.rss.feed {
                    let items = feed.items
                    let index = indexPath.row
                    if items.count > index {
                        let item = feed.items[index]
                        
                        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                        controller.detailItem = item
                        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                        controller.navigationItem.leftItemsSupplementBackButton = true
                    }
                }
                
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feed = Engine.impl.rss.feed {
            return feed.items.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let feed = Engine.impl.rss.feed {
            let items = feed.items
            let index = indexPath.row
            if items.count > index {
                let item = feed.items[index]
                cell.textLabel!.text = item.title
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

