import UIKit
import YourSDK

class ViewController: UIViewController {

    var eligibleOffer: Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Fetch some offers from YourSDK.
         */
        YourSDKInterface.fetchOffers { offers in
            guard let offer = offers.first else { return }
            self.eligibleOffer = offer
            self.imageView.image = offer.image
            self.titleLabel.text = "Earn \(offer.value) on \(offer.brand)"
            self.descriptionLabel.text = offer.offerDescription
        }
    }
    
    @IBAction func claimOffer(_ sender: Any) {
        guard let offer = eligibleOffer else { return }
        
        /*
         Claim an offer from YourSDK.
         */
        YourSDKInterface.claimOffer(offer)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var claimButton: UIButton! {
        didSet {
            claimButton.layer.cornerRadius = 10.0
        }
    }
}

