//
//  ViewController.swift
//  Vincent
//
//  Created by Nada on 07/06/2022.
//

import UIKit
import CoreImage
import CoreAudio
import CoreMedia

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var filterButtons: [UIButton]!
    
    let context = CIContext()
    let image = UIImage(named: "starry-night")
    let filters = [CIFilter(name: "CISepiaTone"),
                   CIFilter(name: "CIPhotoEffectNoir"),
                   CIFilter(name: "CIColorMonochrome"),
                   CIFilter(name: "CIColorInvert"),
                   CIFilter(name: "CIVignetteEffect")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createThumbnails()
    }
    
    func createThumbnails() {
        let thumbnailSize = CGSize(width: filterButtons[0].frame.size.width * 0.9, height: filterButtons[0].frame.size.height * 0.9)
        for index in filterButtons.indices {
            guard let cgImage = applyFilter(filters[index]) else { return }
            let uiImage = UIImage(cgImage: cgImage)
            let thumbnail = uiImage.preparingThumbnail(of: thumbnailSize)
            filterButtons[index].setImage(thumbnail, for: .normal)
        }
    }
    
    func applyFilter(_ filter: CIFilter?, withIntensity intensity: NSNumber = 0.5, andColor color: CIColor = CIColor(color: .blue)) -> CGImage? {
        guard let filter = filter else { return nil }
        
        guard let uiImage = image else { return nil }
        let ciImage = CIImage(image: uiImage)
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        if filter.inputKeys.contains("inputIntensity") {
            filter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        
        if filter.inputKeys.contains("inputColor") {
            filter.setValue(color, forKey: kCIInputColorKey)
        }
        
        guard let outputImage = filter.outputImage else { return nil }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return cgImage
    }
    
    @IBAction func sepiaFilterButtonTapped(_ sender: UIButton) {
        guard let cgImage = applyFilter(CIFilter(name: "CISepiaTone")) else { return }
        imageView.image = UIImage(cgImage: cgImage)
    }
    
    @IBAction func noirFilterButtonTapped(_ sender: UIButton) {
        guard let cgImage = applyFilter(CIFilter(name: "CIPhotoEffectNoir")) else { return }
        imageView.image = UIImage(cgImage: cgImage)
    }
    
    @IBAction func monochromeFilterButtonTapped(_ sender: UIButton) {
        guard let cgImage = applyFilter(CIFilter(name: "CIColorMonochrome"), andColor: CIColor.blue) else { return }
        imageView.image = UIImage(cgImage: cgImage)
    }
    
    @IBAction func invertFilterButtonTapped(_ sender: UIButton) {
        guard let cgImage = applyFilter(CIFilter(name: "CIColorInvert")) else { return }
        imageView.image = UIImage(cgImage: cgImage)
    }
    
    @IBAction func vignetteFilterButtonTapped(_ sender: UIButton) {
        guard let cgImage = applyFilter(CIFilter(name: "CIVignetteEffect")) else { return }
        imageView.image = UIImage(cgImage: cgImage)
    }
}

