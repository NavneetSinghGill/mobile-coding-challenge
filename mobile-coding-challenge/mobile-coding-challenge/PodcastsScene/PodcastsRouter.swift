//
//  PodcastsRouter.swift
//  mobile-coding-challenge
//
//  Created by Navneet Singh Gill on 2023-05-03.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol PodcastsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PodcastsDataPassing
{
  var dataStore: PodcastsDataStore? { get }
}

class PodcastsRouter: NSObject, PodcastsRoutingLogic, PodcastsDataPassing
{
  weak var viewController: PodcastsViewController?
  var dataStore: PodcastsDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: PodcastsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: PodcastsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
