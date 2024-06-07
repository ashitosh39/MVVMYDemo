//
//  ProductListViewController.swift
//  MVVMYogeshPatel
//
//  Created by Macintosh on 23/04/24.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    private var viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        configration()
            }

}
extension ProductListViewController{
func configration(){
   
    initViewModel()
    observeEvent()
    InitilizeTableView()
}
func InitilizeTableView(){
    productTableView.delegate = self
    productTableView.dataSource = self
}

func initViewModel(){
    viewModel.fetchProducts()
}
func observeEvent(){
    viewModel.eventHandler = {[weak self]event in
        guard let  self = self else {return}
        
        switch event{
        case .loading:
          print("Product loading...")
        case .stopLoading:
            print("Stop loading...")
        case .dataLoaded:
            print("Dataloaded...")
            print(self.viewModel.products)
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        case .error(let error):
            print(error)
            }
         }
     }
  }
extension ProductListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ProductTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        ProductTableViewCell.product = viewModel.products[indexPath.row]
        return ProductTableViewCell
    }

    }

extension ProductListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

}

