//
//  ViewController.swift
//  Vincent
//
//  Created by Nada on 07/06/2022.
//

import UIKit
import GPUImage

class FiltersViewController: UIViewController {

    @IBOutlet weak var renderView: RenderView!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let picture = PictureInput(image: UIImage(named: "starry-night")!)
        let filter = SaturationAdjustment()
        picture --> filter --> renderView
        picture.processImage()
    }
}

