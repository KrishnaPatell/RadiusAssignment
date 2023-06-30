//
//  HomeDataSource.swift
//  iosAssignment
//
//  Created by C100-174 on 30/06/23.
//

import Foundation
import UIKit

class HomeDataSource:NSObject {
    
    //MARK:- CONSTANTS
    let kSECTION_HEADER_HEIGHT : CGFloat = 40.0

    //MARK:- VARIABLES
    private let tableView : UITableView
    private let viewModel: HomeViewModel
    private let viewController: UIViewController
    private var homeViewController : HomeVC? {
        get{
            viewController as? HomeVC
        }
    }
    init(tableView: UITableView,viewModel: HomeViewModel , viewController: UIViewController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.viewController = viewController
        self.tableView.register("FacilitiesCell")
        
    }

}

//MARK: - UITABLEVIEW DELEGATE AND DATASOURCE
extension HomeDataSource : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getTotalFacilities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getOptionsCountForFacility(AtPos: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FacilitiesCell") as? FacilitiesCell {
            cell.selectionStyle = .none

            let objFac = viewModel.getFacilities(AtPos: indexPath.section)
            let arrOptions = viewModel.getOptionsForFacility(AtPos: indexPath.section)
            let obj = arrOptions[indexPath.row]
            
            cell.lblName.text = obj.name
            cell.imgIcon.image = UIImage(named: obj.icon ?? "")
           
            if viewModel.checkIfFacilityOptionSelectedOrNot(facilityId: objFac?.facilityId ?? "", optionId: obj.id ?? "") {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
       }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let objFac = viewModel.getFacilities(AtPos: section)
        return objFac?.name ?? ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kSECTION_HEADER_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objFac = viewModel.getFacilities(AtPos: indexPath.section)
        let arrOptions = viewModel.getOptionsForFacility(AtPos: indexPath.section)
        let obj = arrOptions[indexPath.row]
        
        viewModel.setSelectedOptionWithFacility(facilityId: objFac?.facilityId ?? "", optionId: obj.id ?? "", forIndex: indexPath.section)
       
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView, let label = headerView.textLabel{
            headerView.contentView.backgroundColor = kCOLOR_THEME.withAlphaComponent(0.5)
            label.textColor = kCOLOR_WHITE
            label.font = UIFont(name: fFONT_BOLD_O, size: calculateForWidth(size: 17.0))
        }
    }
}


