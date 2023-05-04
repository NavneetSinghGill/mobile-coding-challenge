//
//  mobile_coding_challengeTests.swift
//  mobile-coding-challengeTests
//
//  Created by Navneet Singh Gill on 2023-05-03.
//

import XCTest
@testable import mobile_coding_challenge

final class mobile_coding_challengeTests: XCTestCase {
    
    var podcastsViewController: PodcastsViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        podcastsViewController = PodcastsViewController()
        podcastsViewController?.interactor = PodcastsInteractorInterface()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPodcastsViewControllerInteractorConnection() throws {
        podcastsViewController?.showTheBestPodcasts()
        if let interactor = podcastsViewController?.interactor as? PodcastsInteractorInterface {
            XCTAssertTrue(interactor.didExecuteGetBestPodcasts)
        } else {
            XCTAssertTrue(false, "No interactor present in PodcastsViewController")
        }
    }

}

class PodcastsInteractorInterface: PodcastsBusinessLogic, PodcastsDataStore {
    
    var didExecuteGetBestPodcasts = false
    
    func getBestPodcasts(request: mobile_coding_challenge.Podcasts.GetBestPodcasts.Request) {
        didExecuteGetBestPodcasts = true
    }
    
    var podcast: mobile_coding_challenge.Podcast?
}
