//
//  PodcastsPresenter.swift
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

protocol PodcastsPresentationLogic
{
  func presentBestPodcasts(response: Podcasts.GetBestPodcasts.Response?, error: CustomError?)
}

class PodcastsPresenter: PodcastsPresentationLogic
{
    weak var viewController: PodcastsDisplayLogic?
  
    func presentBestPodcasts(response: Podcasts.GetBestPodcasts.Response?, error: CustomError?) {
        if let error = error?.getReadableError() {
            let viewModelFailure = Podcasts.GetBestPodcasts.ViewModelFailure(error: error)
            viewController?.displayErrorMessageForBestPodcasts(viewModelFailure: viewModelFailure)
        } else if let response = response {
            let viewModelSuccess = Podcasts.GetBestPodcasts.ViewModelSuccess(podcasts: response.podcasts)
            viewController?.displayBestPodcasts(viewModelSuccess: viewModelSuccess)
        }
    }
    
}
