//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by Jeffrey Ip on 2016-04-12.
//  Copyright © 2016 Jeffrey Ip. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    //MARK: Properties
    var detailViewController: DetailViewController? = nil
    var newsItems = [NewsItem]()
    struct NewsItem {
        let category: String
        let headline: String
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    let currentDate = NSDate()
    let dateFormatter = NSDateFormatter()
    let kTableHeaderHeight: CGFloat = 279.0
    
    //MARK: Initial Set-up
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBarHidden = true
        self.prefersStatusBarHidden()
        
        //create the array of NewsItems
        
        let world = NewsItem(category: "World", headline: "Climate change protests, divestments meet fossil fuels realities")
        let europe = NewsItem(category: "Europe", headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
        let middleEast = NewsItem(category: "Middle East", headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        let africa = NewsItem(category: "Africa", headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
        let asiaPacific = NewsItem(category: "Asia Pacific", headline: "Despite UN ruling, Japan seeks backing for whale hunting")
        let americas = NewsItem(category: "Americas", headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
        let world2 = NewsItem(category: "World", headline: "South Africa in $40 billion deal for Russian nuclear reactors")
        let europe2 = NewsItem(category: "Europe", headline: "'One million babies' created by EU student exchanges")
        
        newsItems = [world, europe, middleEast, africa, asiaPacific, americas, world2, europe2]
        
        dateFormatter.dateFormat = "MMMM dd"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        dateLabel.text = convertedDate
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
    }

    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell

        cell.categoryLabel.text = newsItems[indexPath.row].category
        cell.categoryLabel.textColor = self.setTextColor(indexPath)
        cell.headlineLabel.text = newsItems[indexPath.row].headline
        
        return cell
    }
    
    func setTextColor(indexPath: NSIndexPath) -> UIColor {
        switch newsItems[indexPath.row].category {
        case "World":
            return UIColor .redColor()
        case "Europe":
            return UIColor .greenColor()
        case "Americas":
            return UIColor .blueColor()
        case "Middle East":
            return UIColor .yellowColor()
        case "Africa":
            return UIColor .orangeColor()
        case "Asia Pacific":
            return UIColor .purpleColor()
        default:
            return UIColor .blackColor()
        }
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            newsItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    //MARK: UIScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

//     MARK: - Segues
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "showDetail" {
    //            if let indexPath = self.tableView.indexPathForSelectedRow {
    //
    //                let controller = segue.destinationViewController as! DetailViewController
    //                controller.detailItem = object
    //            }
    //        }
    //    }
}

