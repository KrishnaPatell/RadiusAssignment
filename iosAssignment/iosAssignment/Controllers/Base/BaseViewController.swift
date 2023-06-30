//
//  BaseViewController.swift
//  GoLocal
//
//  Created by C100-174 on 24/12/20.
//

import UIKit
import Reachability
import SwiftMessages

var BASEVIEW_CONTROLLER : BaseViewController?
var CURRENT_NAVIGATION : UINavigationController?

class BaseViewController: UIViewController {

    //MARK:- VARIABLES
    
    var reachability : Reachability?
    var bannerIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // if BASEVIEW_CONTROLLER == nil {
        BASEVIEW_CONTROLLER = self
        //}
        
        do{
            reachability =  try Reachability()
        } catch let error as NSError
        {
            print(error.localizedDescription)
        }
       
        checkRechabiliy()
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        BASEVIEW_CONTROLLER = self
        navigationController?.navigationBar.barStyle = .default
    }
    
    func backToHome(withAnimation : Bool){
        self.navigationController?.popToRootViewController(animated: withAnimation)
    }
    func isTabbarHidden(_ isHidden : Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }
    
    //MARK:- Check Network Reachability
   func checkRechabiliy()
   {
       print("Check Reachability...")
       reachability?.whenReachable = { reachability in
           self.showLightBanner(message: "Connected", bgColor: .green, fontColor: .white)
           if reachability.connection == .wifi {
               print("Reachable via WiFi")
               IS_NETWORK_CONNECTED =  true
           } else {
               print("Reachable via Cellular")
               IS_NETWORK_CONNECTED =  true
           }
       }
       reachability?.whenUnreachable = { _ in
            print("Not reachable")
           IS_NETWORK_CONNECTED = false
            //self.showBanner(bannerTitle: .noInternet, message: kCHECK_INTERNET_CONNECTION, type: .error)
            self.showLightBanner(message: kCHECK_INTERNET_CONNECTION, bgColor: .orange, fontColor: .white)
       }
       
       do {
           try reachability?.startNotifier()
       } catch {
           print("Unable to start notifier")
       }
   }
    
    func openSettingApp(title: String, message: String) {
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "Go to settings", style: .default, handler: {_ in
         UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
       })
       let closeAction = UIAlertAction(title: "Close", style: .destructive, handler: {_ in
           //self.enableLocation()
       })
       alert.addAction(okAction)
       alert.addAction(closeAction)
       present(alert, animated: true, completion: nil)
   }
 
    
    func navigateToHome(){
       
    }
    
    func navigateToLoginRoot(){
        
    }
    
    func showBanner(bannerTitle : BannerTitle = .none , message : String, type : Theme){
        
        let cView = MessageView.viewFromNib(layout: .cardView)
        cView.configureTheme(type)
        cView.configureDropShadow()
    
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        type == .warning ? cView.configureContent(title: bannerTitle.rawValue, body: message, iconText: iconText) : cView.configureContent(title:  bannerTitle.rawValue, body: message)
        cView.button?.isHidden = true
        cView.titleLabel?.textColor = .darkGray
        var bodyColor = UIColor()
        if type == Theme.error || type == Theme.success { bodyColor = .white}
        else { bodyColor = .darkGray}
        cView.bodyLabel?.textColor = bodyColor
        var cConfig = SwiftMessages.defaultConfig
        cConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        
        SwiftMessages.show(config: cConfig, view: cView)
    }
    
    func showLightBanner(message : String, bgColor :UIColor, fontColor : UIColor) {
        let status = MessageView.viewFromNib(layout: .statusLine)
        status.backgroundView.backgroundColor = bgColor
        status.bodyLabel?.textColor = fontColor
        status.configureContent(body: message)
        var statusConfig = SwiftMessages.defaultConfig
        statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        statusConfig.preferredStatusBarStyle = .lightContent
        
        SwiftMessages.show(config: statusConfig, view: status)
    }
 
    
    func popTwoViewBack(_ withPresentAnimation : Bool = false) {
            if withPresentAnimation
            {
                let transition:CATransition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromBottom
                self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: false)
            }
            else
            {
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            }
        }
    
    func popToVC(totalController : Int = 0) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - (totalController + 1)], animated: true)
        
    }
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:-LOGOUT
    func actionPerformAfterLogout(){
        USER_DEFAULTS.removeObject(forKey: DEFAULT_KEYS.userDetails.rawValue)
    }
    
    //MARK:- OPEN UIACTIVITY CONTROLLER
    func openActivityController(arrData : [Any], completion : @escaping(Bool) -> Void) {
        let vc = UIActivityViewController(activityItems:  arrData , applicationActivities: [])
        vc.excludedActivityTypes = [.addToReadingList, .assignToContact, .copyToPasteboard, .postToFlickr, .postToTencentWeibo, .postToVimeo, .postToWeibo, .print]
        vc.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
           if completed {
            completion(true)
           }
        }
        present(vc, animated: true)
        
    }
    
    
    func openConfirmationPopup(strMessage : String, btn1 : String, btn2 : String, completion:@escaping (Bool) -> ()) {
        let alertController = UIAlertController(title: "", message: strMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: btn1, style: .default) { [self] (action) in
            completion(true)
            self.dismiss(animated: true, completion: nil)
        }
        let action1 = UIAlertAction(title: btn2, style: .default) { [self] (action) in
            completion(true)
                 }
        alertController.addAction(action)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
    
    var previousViewController: UIViewController? { viewControllers.last { $0 != topViewController } }
}


