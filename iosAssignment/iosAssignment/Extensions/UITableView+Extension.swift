//
//  UITableView+Extension.swift
//  Freddy
//
//  Created by C100-107 on 22/05/19.
//  Copyright © 2019 C100-107. All rights reserved.
//

import Foundation
import UIKit
extension UITableView{
    func register(_ cellClass: String) {
        register(UINib(nibName: cellClass, bundle: nil), forCellReuseIdentifier: cellClass)
    }
    func register(_ cellClass: [String]) {
        for cellString in cellClass {
            register(UINib(nibName: cellString, bundle: nil), forCellReuseIdentifier: cellString)
        }
    }
    func registerHeaderFooter(_ cellClass: String) {
        register(UINib(nibName: cellClass, bundle: nil), forHeaderFooterViewReuseIdentifier: cellClass)
    }
    
	func scrollToBottom(){
		
		DispatchQueue.main.async {
			let indexPath = IndexPath(
				row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
				section: self.numberOfSections - 1)
			if (self.numberOfRows(inSection:  self.numberOfSections - 1) - 1) >= 0{
				self.scrollToRow(at: indexPath, at: .bottom, animated: false)
			}
			
		}
	}
    func scrollToTop() {
        setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//        DispatchQueue.main.async {
//            let indexPath = IndexPath(row: 0, section: 0)
//            self.scrollToRow(at: indexPath, at: .top, animated: false)
//        }
    }
	
    func setHeaderFootertView(headHeight: CGFloat, footHeight: CGFloat) {
        var view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: headHeight))
        tableHeaderView = view
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: footHeight))
        tableFooterView = view
    }
    
    
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
    
	func getFrame(ofIndexPath indexPath: IndexPath) -> CGRect {
		   let rect = self.rectForRow(at: indexPath)
		   return self.convert(rect, to: self.superview)
	}
    
    func reloadDataAndKeepOffset() {
        // stop scrolling
        setContentOffset(contentOffset, animated: false)
        
        // calculate the offset and reloadData
        let beforeContentSize = contentSize
        reloadData()
        layoutIfNeeded()
        let afterContentSize = contentSize
        
        // reset the contentOffset after data is updated
        let newOffset = CGPoint(
            x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: contentOffset.y + (afterContentSize.height - beforeContentSize.height))
        setContentOffset(newOffset, animated: false)
    }
    
}
