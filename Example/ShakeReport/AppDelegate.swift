//
//  AppDelegate.swift
//  ShakeReport
//
//  Created by git on 12/10/2015.
//  Copyright (c) 2015 git. All rights reserved.
//

import UIKit

import ShakeReport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {      
    /**
    *  Configure ShakeReport with an array of email recipients (required)
    *  and an optional custom subject line to use for all bug reports.
    */
    ShakeReport.configure(to: ["example@email.com"], subject: "Bug Report")
    
    return true
  }

}
