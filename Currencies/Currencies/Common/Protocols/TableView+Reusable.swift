import UIKit

enum ReusableCellError : Error {
    case reusableCellNotFound
}

protocol ReusableCell : class {
    static var reuseIdentifier : String { get }
}

extension ReusableCell {
    static var reuseIdentifier : String { return String(describing: self) }
}

extension UITableView {
    
    func registerReusableCell<T:UITableViewCell>(_ :T.Type) where T:ReusableCell {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
}

extension UITableView {
    func dequeueCell<T:UITableViewCell>(indexPath:IndexPath) throws -> T where T:ReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            throw ReusableCellError.reusableCellNotFound
        }
        
        return cell
    }
}
