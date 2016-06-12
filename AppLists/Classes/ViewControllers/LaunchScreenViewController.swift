//
//  LaunchScreenViewController.swift
//  AppLists
//
//  Created by 이 동준 on 2016. 6. 7..
//  Copyright © 2016년 이 동준. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    

    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()

        NSLog("Start Launch Screen ViewController")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(1.0,
            animations: { void in
                self.titleLabel.alpha = 1.0
                self.mainLabel.alpha = 0.0
            },
            completion: { finished in
                
            })
        
        let informationConnector: InformationConnector = InformationConnector(type: "free", delegate: self)
        informationConnector.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegate
    func completeLoadInformation(result: NSArray?, data: NSData?, error: ErrorType?) {
        if result == nil {
            // error
            
            let errorString: NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            
            
//            let alertView: UIAlertView = UIAlertView(
//                title: "Error",
//                message:errorString as String,
//                delegate: self,
//                cancelButtonTitle: "Confirm",
//                otherButtonTitles: nil)
            
        }
        
        NSLog("result : \(result)")
        
//        for var item in result! {
        for (var index: Int = 0; index < result?.count; index += 1) {
            let item: NSDictionary = (result?.objectAtIndex(index))! as! NSDictionary
            
            let supportedDevices: NSArray = item.objectForKey("supportedDevices") as! NSArray
            
            NSLog("supportedDevices : \(supportedDevices)")
        }
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let tabBarController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController")
        (((UIApplication.sharedApplication().delegate?.window)!)! as UIWindow).rootViewController = tabBarController
        
        let freeTableViewController = mainStoryboard.instantiateViewControllerWithIdentifier("FreeTableViewController") as! FreeTableViewController
        freeTableViewController.dataSource = result
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
