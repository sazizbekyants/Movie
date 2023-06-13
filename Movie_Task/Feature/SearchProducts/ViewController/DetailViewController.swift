//
//  DetailViewController.swift
//  Quinbay
//
//  Created by Sergo Azizbekyants on 15.06.23.
//

import UIKit

class DetailViewController: UIViewController {

    var productDetails: ProductDetails?
    var viewModel: ProductDetailsControllerViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let productDetails = productDetails else { return }
        viewModel = ProductDetailsControllerViewModel(productDetail: productDetails)
    }
}
