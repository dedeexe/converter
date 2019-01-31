
import UIKit

extension UIView {
    static func instantiateFromNib<T:UIView>(named name:String) -> T {
        guard let nib = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError()
        }
        
        return nib
    }
}
