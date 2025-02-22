//
//  PodcastsViewController.swift
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

protocol PodcastsViewControllerDelegate: AnyObject {
    func updateFavouriteIn(podcast: Podcast)
}

protocol PodcastsDisplayLogic: AnyObject
{
    func displayBestPodcasts(viewModelSuccess: Podcasts.GetBestPodcasts.ViewModelSuccess)
    func displayErrorMessageForBestPodcasts(viewModelFailure: Podcasts.GetBestPodcasts.ViewModelFailure)
}

class PodcastsViewController: UIViewController, PodcastsDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: Podcasts.GetBestPodcasts.ViewModelSuccess? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var isGetBestPodcastsAPIinProgress = false
    
    var interactor: PodcastsBusinessLogic?
    var router: (NSObjectProtocol & PodcastsRoutingLogic & PodcastsDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PodcastsInteractor()
        let presenter = PodcastsPresenter()
        let router = PodcastsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, let destination = segue.destination as? PodcastDetailViewController {
            switch identifier {
            case "PodcastsToPodcastDetails":
                if let podcast = sender as? Podcast {
                    destination.podcast = podcast
                    destination.delegate = self
                }
            default:
                return
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNibs()
        showTheBestPodcasts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    //MARK: Private methods
    func loadNibs() {
        let podcastsTableViewCellNib = UINib(nibName: PodcastsTableViewCellConstants.identifier, bundle: nil)
        tableView.register(podcastsTableViewCellNib, forCellReuseIdentifier: PodcastsTableViewCellConstants.identifier)
        
        let loaderTableViewCellNib = UINib(nibName: LoaderTableViewCellConstants.identifier, bundle: nil)
        tableView.register(loaderTableViewCellNib, forCellReuseIdentifier: LoaderTableViewCellConstants.identifier)
    }
    
    // MARK: Interactions
    
    //Get the best prodcasts through API
    func showTheBestPodcasts() {
        if !isGetBestPodcastsAPIinProgress {
            
            let genreID = "93"
            let region = "us"
            
            if viewModel == nil { //This is the first api call when viewmodel is empty
                let request = Podcasts.GetBestPodcasts.Request(
                    genreID: genreID,
                    page: "1",
                    region: region)
                
                isGetBestPodcastsAPIinProgress = true
                interactor?.getBestPodcasts(request: request)
            } else if let viewModel = viewModel, viewModel.hasNext { //This executes when we have more pages to be fetched
                let request = Podcasts.GetBestPodcasts.Request(
                    genreID: genreID,
                    page: "\(viewModel.nextPageNumber)",
                    region: region)
                
                isGetBestPodcastsAPIinProgress = true
                interactor?.getBestPodcasts(request: request)
            }
        }
    }
    
    //The success block for get the best prodcasts
    func displayBestPodcasts(viewModelSuccess: Podcasts.GetBestPodcasts.ViewModelSuccess) {
        isGetBestPodcastsAPIinProgress = false
        if viewModel == nil {
            viewModel = viewModelSuccess
        } else {
            viewModel?.updateNextPage(viewModel: viewModelSuccess)
        }
    }
    
    //The failure block for get the best prodcasts
    func displayErrorMessageForBestPodcasts(viewModelFailure: Podcasts.GetBestPodcasts.ViewModelFailure) {
        //TODO: Display error
        isGetBestPodcastsAPIinProgress = false
    }
    
}

extension PodcastsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PodcastsTableViewCellConstants.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0, let podcast = viewModel?.podcasts[indexPath.row] as? Podcast {
            performSegue(withIdentifier: "PodcastsToPodcastDetails", sender: podcast)
        }
    }
    
}

extension PodcastsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let viewModel = viewModel, viewModel.hasNext {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0://Podcasts section
            return viewModel?.podcasts.count ?? 0
        case 1://Loader section
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0://Podcasts section
            var cell = tableView.dequeueReusableCell(withIdentifier: PodcastsTableViewCellConstants.identifier) as? PodcastsTableViewCell
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: PodcastsTableViewCellConstants.identifier) as? PodcastsTableViewCell
            }
            //Fill the podcast cell with information
            cell?.load(podcast: viewModel?.podcasts[indexPath.row])
            
            return cell ?? PodcastsTableViewCell()
            
        case 1://Loader section
            var cell = tableView.dequeueReusableCell(withIdentifier: LoaderTableViewCellConstants.identifier) as? LoaderTableViewCell
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: LoaderTableViewCellConstants.identifier) as? LoaderTableViewCell
            }
            
            return cell ?? LoaderTableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom < height {
            //Fetch new podcasts when the tableview reaches the end
            showTheBestPodcasts()
        }
    }
}

extension PodcastsViewController: PodcastsViewControllerDelegate {
    
    //Find an update the respective podcast
    func updateFavouriteIn(podcast: Podcast) {
        if let viewModel = viewModel, let index = viewModel.podcasts.firstIndex(where: { element in
            podcast.id == element.id
        }) {
            self.viewModel?.podcasts[index].isFavourite = podcast.isFavourite
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
