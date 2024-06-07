//
//  ProductTableViewCell.swift
//  MVVMYogeshPatel
//
//  Created by Macintosh on 23/04/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var discriptioLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    var product: Product? {
    
     didSet {
        productDetailConfiguration()
    }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func productDetailConfiguration(){
        guard let product = product else {
            return
        }
        productTitle.text = product.title
        productCategoryLabel.text = product.category
        discriptioLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)

    }
}
