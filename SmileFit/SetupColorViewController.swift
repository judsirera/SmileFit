//
//  SetupColorViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 2/2/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit
import IGColorPicker

class SetupColorViewController: ParentViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
    

    //MARK: Properties
    
    @IBOutlet weak var lbl_colorName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("hello")
        // Setup color picker
        
        let colorPickerView = ColorPickerView(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.height - 300,
                                                            width: UIScreen.main.bounds.width,
                                                            height: 100))
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.style = .square
        colorPickerView.selectionStyle = .check
        
        view.addSubview(colorPickerView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ColorPickerViewDelegate
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.lbl_colorName.text = String(indexPath.item)
        self.view.backgroundColor = colorPickerView.colors[indexPath.item]
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

}
