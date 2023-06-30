//
//  HomeVC.swift
//  iosAssignment
//
//  Created by C100-174 on 30/06/23.
//

import UIKit

class HomeVC: BaseViewController {

    //MARK: - IBOUTLETS
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: - VARIABLES
    var dataSource: HomeDataSource?
    var viewModel = HomeViewModel()
    
    //MARK: - CONSTANTS
        
    //MARK: - VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        
    }
    
    //MARK: - SETUP AND INITITALIZATION
    func setUpLayout() {
        self.dataSource = HomeDataSource(tableView: self.tblView, viewModel: viewModel, viewController: self)
        tblView.dataSource = dataSource
        tblView.delegate = dataSource
        
        interactWithModel()
        viewModel.API_GetData()
        interactWithModel()
    }
    
    func interactWithModel() {
        
        viewModel.needToReload.bind { needToReload in
            if needToReload {
                self.tblView.reloadData()
            }
        }
        
        viewModel.isLoaderHidden.bind { isHidden in
            if isHidden {
                hideLoader()
            } else {
                showLoader()
            }
            self.tblView.isHidden = !isHidden
        }
        
        viewModel.warningTextMessage.bind { message in
            self.showBanner(message: message, type: .error)
        }
        
        viewModel.reloadSection.bind { section in
            self.tblView.reloadSections(IndexSet(integer: section), with: .none)
        }
    }
}
