import UIKit
@_implementationOnly import Button

/**
* Your SDK that makes use of the Button Publisher SDK.
* A Partner App will interface with Your SDK, and not the Button SDK.
*/
public class YourSDKInterface: NSObject {
    
    internal static var configuration = Configuration()
    
    /// Starts YourSDK
    @objc public static func start() {
        print("YourSDK :: Started successfully 🎉")
        
        // You can use some internal configuration to control whether Button is enabled or not.
        configuration.isButtonEnabled = true
        
        if configuration.isButtonEnabled {
            /*
             Get your application Id from the [Button Dashboard](https://app.usebutton.com)
             */
            #error("Please specify your Button application Id to run the project.")
            let buttonApplicationId: String = <# Your Application Id #>
            
            Button.debug.isLoggingEnabled = true
            Button.configure(applicationId: buttonApplicationId) { error in
                guard error == nil else {
                    print("YourSDK :: Button failed to initialize '\(error!.localizedDescription)'")
                    return
                }
            }
        }
    }
    
    /*
     Fetch available offers.
     */
    @objc public static func fetchOffers(completion: @escaping ([Offer]) -> ()) {
        DispatchQueue.global().async {
            
            /*
             Fake offer for the example.
             */
            var image: UIImage?
            if let data = try? Data(contentsOf: URL(string: "https://button.imgix.net/org-2f10e13350a753c5/icon/6f7d6de631d793ba.png")!) {
                image = UIImage(data: data, scale: UIScreen.main.scale)
            }
            let fakeOffer = Offer(url: "https://www.ubereats.com/",
                              brand: "UberEats",
                              value: "5% Cash Back",
                              description: "Launch UberEats from PartnerApp and make a purchase to earn cash back.",
                              image: image)
            DispatchQueue.main.async {
                completion([fakeOffer])
            }
        }
    }
    
    /*
     Claim a specific offer
     */
    public static func claimOffer(_ offer: Offer) {
        let url = URL(string: offer.url)!
        guard Self.configuration.isButtonEnabled else {
            UIApplication.shared.open(url, options: [:])
            return
        }
        let request = PurchasePathRequest(url: url)
        Button.purchasePath.fetch(request: request) { purchasePath, error in
            purchasePath?.start()
        }
    }
    
    /*
     A confuguration object returned from a service indicating features to enable/disable.
     */
    internal struct Configuration {
        var isButtonEnabled: Bool = false
    }
}

/*
 Represents an offer available via YourSDK to be displayed in PartnerApp.
 */
@objc public class Offer: NSObject {
    public var url: String
    public var image: UIImage?
    public var brand: String
    public var value: String
    public var offerDescription: String
    init(url: String, brand: String, value: String, description: String, image: UIImage?) {
        self.url = url
        self.brand = brand
        self.value = value
        self.offerDescription = description
        self.image = image
    }
}
