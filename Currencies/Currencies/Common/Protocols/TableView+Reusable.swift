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
    
    func registerReusableCell<T:UITableViewCell>(_ :T.Type, nibName:String) where T:ReusableCell {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusableCell<T:UITableViewCell>(_ :T.Type) where T:ReusableCell {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
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
