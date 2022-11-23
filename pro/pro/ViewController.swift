import GoogleMobileAds

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate,GADBannerViewDelegate {
    
    
    var webView: WKWebView!
    let screenSize = UIScreen.main.bounds
    // Ad banner
       var adMobBannerView = GADBannerView()
       
       
       // IMPORTANT: REPLACE THE RED STRING BELOW WITH THE UNIT ID YOU'VE GOT BY REGISTERING YOUR APP IN http://apps.admob.com
       let ADMOB_BANNER_UNIT_ID = "ca-app-pub-3940256099942544/2934735716"

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        // Init AdMob banner
        initAdMobBanner()

        let webConfiguration = WKWebViewConfiguration()
                webConfiguration.dataDetectorTypes = [.all]
                webView = WKWebView(frame: .zero, configuration: webConfiguration)
                
                
                webView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(webView)
                
                NSLayoutConstraint.activate([
                    webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
                
                let myURL = URL(string:"https://app.phpsmarter.com/mobile.php")
                let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)

                if #available(iOS 11.0, *) {
                    webView.scrollView.contentInsetAdjustmentBehavior = .never;
                }

                webView.navigationDelegate = self
                        webView.allowsBackForwardNavigationGestures = true
        
        initAdMobBanner()
        
    }
  
    func initAdMobBanner() {
        
        
        let screenHeight = screenSize.height - 55
         if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            adMobBannerView.frame = CGRect(x: 20, y: screenHeight, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView.frame = CGRect(x: 80, y: screenHeight, width: 468, height: 60)
        }
        
        adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        view.addSubview(adMobBannerView)
            
        let request = GADRequest()
        adMobBannerView.load(request)
    }
        

    // Hide the banner
    func hideBanner(_ banner: UIView) {
            UIView.beginAnimations("hideBanner", context: nil)
            banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
            UIView.commitAnimations()
            banner.isHidden = true
    }
        
    // Show the banner
    func showBanner(_ banner: UIView) {
            UIView.beginAnimations("showBanner", context: nil)
            banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
            UIView.commitAnimations()
            banner.isHidden = false
    }
        
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView!) {
            showBanner(adMobBannerView)
    }
        
    // NO AdMob banner available
    
        
        
        
        
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let screenHeight = size.height - 55
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            adMobBannerView.frame = CGRect(x: 20, y: screenHeight, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView.frame = CGRect(x: 80, y: screenHeight, width: 468, height: 60)
        }
    }
   }

