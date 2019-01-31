
import UIKit

protocol ImageRequester : class {
    
    func didRequestImage(at address:String, for imageView:UIImageView)
    
}
