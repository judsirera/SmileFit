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

        // Setup color picker
        self.initColorPickerView()
        self.setColorName(index: 0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init components
    
    func initColorPickerView() {
        let colorPickerView = ColorPickerView(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.height - 300,
                                                            width: UIScreen.main.bounds.width,
                                                            height: 100))
        colorPickerView.colors = ColorManager.colorsList
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.style = .square
        colorPickerView.selectionStyle = .check
        
        view.addSubview(colorPickerView)
    }
    
    func setColorName(index: Int) {
        self.lbl_colorName.text = ColorManager.colorListNames[index]
    }
    
    // MARK: - ColorPickerViewDelegate
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.setColorName(index: indexPath.item)
        self.view.backgroundColor = ColorManager.colorsList[indexPath.item]
        User.sharedUser.color = ColorManager.colorListNames[indexPath.item]
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


class ColorManager {
    
    static let SCREEN_DEFAULT: String = "ScreenDefault"
    static let PINK: String = "Pink"
    static let PURPLE: String = "Purple"
    static let CAKI: String = "Caki"
    static let GREEN: String = "Green"
    static let SKIN: String = "Skin"
    static let DARK: String = "Dark"
    static let RED: String = "Red"
    
    static let colorListNames: [String] = {
        return [ColorManager.SCREEN_DEFAULT,
                ColorManager.PINK,
                ColorManager.CAKI,
                ColorManager.PURPLE,
                ColorManager.GREEN,
                ColorManager.RED,
                ColorManager.SKIN]
    }()
    
    static let colorsList: [UIColor] = {
        var c: [UIColor] = []
        for colorname in ColorManager.colorListNames {
            c.append(getColor(name: colorname))
        }
        return c
    }()
    
    static func getColor(name: String) -> UIColor {
        return UIColor(named: name)!
    }
    
    
}









