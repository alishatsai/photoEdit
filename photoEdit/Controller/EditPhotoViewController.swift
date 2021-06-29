    //
    //  EditPhotoViewController.swift
    //  photoEdit
    //
    //  Created by Alisha on 2021/6/15.
    //
    
    import UIKit
    import CoreImage.CIFilterBuiltins
    import SpriteKit
    
    class EditPhotoViewController: UIViewController ,UIColorPickerViewControllerDelegate{
        
        @IBOutlet weak var mainMenuView: UIView!
        @IBOutlet weak var cropMenuView: UIView!
        @IBOutlet weak var filterMenuView: UIView!
        @IBOutlet weak var rotateMenuView: UIView!
        @IBOutlet weak var cuteImgMenuView: UIView!
        @IBOutlet weak var wordMenuView: UIView!
        
        
        @IBOutlet weak var editBackgroundView: UIView!
        @IBOutlet weak var editImageView: UIImageView!

        @IBOutlet weak var filterScrollView: UIScrollView!
        @IBOutlet weak var cropScrollView: UIScrollView!
        @IBOutlet weak var cuteImgScrollView: UIScrollView!
        
        @IBOutlet weak var rotateBtn: UIButton!
        @IBOutlet weak var cropBtn: UIButton!
        @IBOutlet weak var filterBtn: UIButton!
        @IBOutlet weak var cuteBtn: UIButton!
        @IBOutlet weak var wordBtn: UIButton!
        @IBOutlet weak var selectWordColorBtn: UIButton!
        @IBOutlet weak var getBoldBtn: UIButton!
        @IBOutlet weak var getItalicBtn: UIButton!
        @IBOutlet weak var getSmallBtn: UIButton!
        @IBOutlet weak var getBigBtn: UIButton!
        //裁切矩形的Button
        @IBOutlet weak var clearItemBtn: UIButton!
        @IBOutlet weak var clearBgBtn: UIButton!
        @IBOutlet weak var cropRect0: UIButton!
        @IBOutlet weak var cropRect1to1: UIButton!
        @IBOutlet weak var cropRect3to4: UIButton!
        @IBOutlet weak var cropRect4to3: UIButton!
        @IBOutlet weak var cropRect9to16: UIButton!
        @IBOutlet weak var cropRect16to9: UIButton!
        
        @IBOutlet weak var upDownSlider: UISlider!
        @IBOutlet weak var leftRightSlider: UISlider!
        @IBOutlet weak var sizeSlider: UISlider!
        
        @IBOutlet weak var wordTextField: UITextField!

        var photoImg = PhotoSetting()
        var filterNum: Int = 0
        var oneDegree = (CGFloat).pi/180
        var cuteImg = UIImageView()
        var backView = UIView() //裝載background
        var background = UIImageView()
        var maskTimes = 1 //這邊如果設定０，遮色片mask後的主圖會消失，除非要再次選擇遮色片
        var getBoldTimes = 0
        var getItalicTimes = 0
        var getBigTimes = 0
        var getSmallTimes = 0
        var pressWordTimes = 0
        var fontSize: CGFloat = 50
        var newFontSize: CGFloat = 50
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //讀取圖片
            editImageView.image = photoImg.photo
            
            editImageView.frame = editBackgroundView.bounds
            background.frame = editBackgroundView.bounds
            //設定編輯區域框線
            editBackgroundView.layer.borderWidth = 0.5
            editBackgroundView.layer.borderColor = .init(gray: 0.5, alpha: 0.5)
            
            scrollViewStyle()
            
            childMenuStyle()
            
            wordStyle()
            
            //隱藏childMenu
            cropMenuView.isHidden = true
            filterMenuView.isHidden = true
            rotateMenuView.isHidden = true
            cuteImgMenuView.isHidden = true
            wordMenuView.isHidden = true
            //隱藏slider
            sizeSlider.isHidden = true
            upDownSlider.isHidden = true
            leftRightSlider.isHidden = true
            //設定cropRect底色
            cropRect0.backgroundColor = .cuteOrange
            cropRect1to1.backgroundColor = .cuteOrange
            cropRect3to4.backgroundColor = .cuteOrange
            cropRect4to3.backgroundColor = .cuteOrange
            cropRect16to9.backgroundColor = .cuteOrange
            cropRect9to16.backgroundColor = .cuteOrange
        }
        
        func scrollViewStyle() {
            filterScrollView.frame = filterMenuView.bounds
            filterScrollView.contentSize = CGSize(width: 1200, height: 0)
            cropScrollView.frame = cropMenuView.bounds
            cropScrollView.contentSize = CGSize.init(width: 800, height: 0)
            cuteImgScrollView.frame = cuteImgMenuView.bounds
            cuteImgScrollView.contentSize = CGSize(width: 3880, height: 0)
        }
        
        func childMenuStyle(){
            cropMenuView.backgroundColor = .clear
            filterMenuView.backgroundColor = .clear
            rotateMenuView.backgroundColor = .clear
            cuteImgMenuView.backgroundColor = .clear
            wordMenuView.backgroundColor = .clear
        }
        
        func wordStyle() {
            if wordTextField == nil {
                wordTextField.isHidden = true
            }else {
                wordTextField.isHidden = false
            }
            wordTextField.isEnabled = false
            wordTextField.layer.borderWidth = 0
            wordTextField.minimumFontSize = fontSize
            wordTextField.frame.size.height = fontSize*1.5
            wordTextField.font = UIFont.systemFont(ofSize: fontSize)
            wordTextField.backgroundColor = .clear
            wordTextField.borderStyle = .none
            wordTextField.clearButtonMode = .whileEditing
            wordTextField.adjustsFontSizeToFitWidth = true
        }

        //選取翻轉功能
        @IBAction func pressRotate(_ sender: Any) {
            cropMenuView.isHidden = true
            filterMenuView.isHidden = true
            rotateMenuView.isHidden = false
            cuteImgMenuView.isHidden = true
            wordMenuView.isHidden = true
            
            if wordTextField == nil {
                wordTextField.isHidden = true
            }else {
                wordTextField.isHidden = false
            }
            wordTextField.isEnabled = false
            
            sizeSlider.isHidden = true
            upDownSlider.isHidden = true
            leftRightSlider.isHidden = true
            
            photoImg.flipCounts = 0
            photoImg.isFlipHorizontal = false
            photoImg.isFlipUpDown = false
            editImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        //選取裁切功能
        @IBAction func pressCrop(_ sender: Any) {
            cropMenuView.isHidden = false
            filterMenuView.isHidden = true
            rotateMenuView.isHidden = true
            cuteImgMenuView.isHidden = true
            wordMenuView.isHidden = true
        
            if wordTextField == nil {
                wordTextField.isHidden = true
            }else {
                wordTextField.isHidden = false
            }
            wordTextField.isEnabled = false
            
            sizeSlider.isHidden = true
            upDownSlider.isHidden = true
            leftRightSlider.isHidden = true
        }
        
        //選取濾鏡功能
        @IBAction func pressfilter(_ sender: Any) {
            cropMenuView.isHidden = true
            filterMenuView.isHidden = false
            rotateMenuView.isHidden = true
            cuteImgMenuView.isHidden = true
            wordMenuView.isHidden = true
            
            if wordTextField == nil {
                wordTextField.isHidden = true
            }else {
                wordTextField.isHidden = false
            }
            wordTextField.isEnabled = false
            
            sizeSlider.isHidden = true
            upDownSlider.isHidden = true
            leftRightSlider.isHidden = true
        }
        
        //選取貼圖功能
        @IBAction func pressCute(_ sender: Any) {
            photoImg.isCuteImg = true
            photoImg.isShowWord = false
            
            cropMenuView.isHidden = true
            filterMenuView.isHidden = true
            rotateMenuView.isHidden = true
            cuteImgMenuView.isHidden = false
            wordMenuView.isHidden = true
            
            if wordTextField == nil {
                wordTextField.isHidden = true
            }else {
                wordTextField.isHidden = false
            }
            wordTextField.isEnabled = false
            
            sizeSlider.isHidden = false
            upDownSlider.isHidden = false
            leftRightSlider.isHidden = false
        }
        
        //選取文字功能
        @IBAction func pressWord(_ sender: Any) {
            pressWordTimes += 1
            photoImg.isShowWord = true
            photoImg.isCuteImg = false
            
            cropMenuView.isHidden = true
            filterMenuView.isHidden = true
            rotateMenuView.isHidden = true
            cuteImgMenuView.isHidden = true
            wordMenuView.isHidden = false
            
            wordTextField.isHidden = false
            wordTextField.isEnabled = true
            wordTextField.font = UIFont.systemFont(ofSize: newFontSize)
            
            sizeSlider.isHidden = false
            upDownSlider.isHidden = false
            leftRightSlider.isHidden = false
            
            if pressWordTimes % 2 != 0 {
                wordTextField.placeholder = "message"
            }else{
                wordTextField.placeholder = .none
            }
        }
        
        //圖片逆時針翻轉
        @IBAction func flipLeft(_ sender: Any) {
            photoImg.flipCounts -= 1
            editImageView.transform = CGAffineTransform(rotationAngle: oneDegree*90*CGFloat(photoImg.flipCounts))
        }
        
        //圖片順時針翻轉
        @IBAction func flipRight(_ sender: Any) {
            photoImg.flipCounts += 1
            editImageView.transform = CGAffineTransform(rotationAngle: oneDegree*90*CGFloat(photoImg.flipCounts))
        }
        
        //圖片水平翻轉
        @IBAction func flipHorizontal(_ sender: Any) {
            if photoImg.isFlipHorizontal == true {
                if editImageView.transform == CGAffineTransform(scaleX: -1, y: 1) {
                    editImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    photoImg.isFlipHorizontal = false
                }
                if editImageView.transform == CGAffineTransform(scaleX: -1, y: -1) {
                    editImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
                    photoImg.isFlipHorizontal = false
                }
            }
            else {
                if editImageView.transform == CGAffineTransform(scaleX: 1, y: 1) {
                    editImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
                    photoImg.isFlipHorizontal = true
                }
                if editImageView.transform == CGAffineTransform(scaleX: 1, y: -1) {
                    editImageView.transform = CGAffineTransform(scaleX: -1, y: -1)
                    photoImg.isFlipHorizontal = true
                }
            }
        }
        
        //圖片垂直翻轉
        @IBAction func flipUpDown(_ sender: Any) {
            if photoImg.isFlipUpDown == true {
                if editImageView.transform == CGAffineTransform(scaleX: 1, y: -1) {
                    editImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    photoImg.isFlipUpDown = false
                }
                if editImageView.transform == CGAffineTransform(scaleX: -1, y: -1) {
                    editImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
                    photoImg.isFlipUpDown = false
                }
            }
            else {
                if editImageView.transform == CGAffineTransform(scaleX: 1, y: 1) {
                    editImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
                    photoImg.isFlipUpDown = true
                }
                if editImageView.transform == CGAffineTransform(scaleX: -1, y: 1) {
                    editImageView.transform = CGAffineTransform(scaleX: -1, y: -1)
                    photoImg.isFlipUpDown = true
                }
            }
        }
        
        //裁切－矩形
        @IBAction func cropSquare(_ sender: UIButton) {
            //注意：editImageView不能設定autoLayout，並且要設定AspectFit
            editImageView.frame = editBackgroundView.bounds
            let width = editBackgroundView.frame.width
            var height = Int()
            switch sender {
            case cropRect0:
                height = Int(width / 414 * 500)
                editImageView.layer.cornerRadius = 0
                editImageView.contentMode = .scaleAspectFit
            case cropRect1to1:
                height = Int(width)
                editImageView.contentMode = .scaleAspectFill
            case cropRect3to4:
                height = Int(width / 3 * 4)
                editImageView.contentMode = .scaleAspectFill
            case cropRect4to3:
                height = Int(width / 4 * 3)
                editImageView.contentMode = .scaleAspectFill
            case cropRect9to16:
                height = Int(width / 9 * 16)
                editImageView.contentMode = .scaleAspectFit
            case cropRect16to9:
                height = Int(width / 16 * 9)
                editImageView.contentMode = .scaleAspectFill
            default:
                break
            }
            editImageView.bounds.size = CGSize(width: CGFloat(width), height: CGFloat(height))
        }
        
        //裁切－圓型
        @IBAction func cropOval(_ sender: Any) {
            editImageView.layer.cornerRadius = (editImageView.frame.width)/2
        }
        
        //裁切－三角形
        @IBAction func cropTriangle(_ sender: Any) {
            photoImg.isMask = true
            maskTimes += 1
            let imageView = UIImageView(image: UIImage(systemName: "triangle.fill"))
            imageView.frame = editImageView.bounds
            editImageView.mask = imageView
        }
        
        //裁切－菱形
        @IBAction func cropDiamond(_ sender: Any) {
            photoImg.isMask = true
            maskTimes += 1
            let imageView = UIImageView(image: UIImage(systemName: "diamond.fill"))
            imageView.frame = editImageView.bounds
            editImageView.mask = imageView
        }
        
        //裁切－星形
        @IBAction func cropStar(_ sender: Any) {
            photoImg.isMask = true
            maskTimes += 1
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.frame = editImageView.bounds
            editImageView.mask = imageView
        }
        
        //裁切-愛心型
        @IBAction func cropHeart(_ sender: Any) {
            photoImg.isMask = true
            maskTimes += 1
            let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
            imageView.frame = editImageView.bounds
            editImageView.mask = imageView
        }
        
        //清除貼圖或背景圖
        @IBAction func clear(_ sender: UIButton) {
            if sender == clearItemBtn {
                cuteImg.image = .none
            }
            if sender == clearBgBtn {
                background.image = .none
            }
        }
        
        //選取貼圖
        @IBAction func pressCuteImg(_ sender: UIButton) {
            upDownSlider.value = 0
            leftRightSlider.value = 0
            sizeSlider.value = 1
                        
            cuteImg.image = sender.currentImage
            cuteImg.contentMode = .scaleAspectFill
            let width = editImageView.frame.size.width*0.5
            let height = editImageView.frame.size.width*0.5
            cuteImg.frame = CGRect(x: 0, y: 0, width: width, height: height)
            cuteImg.center = editBackgroundView.center
            editBackgroundView.addSubview(cuteImg)
        }
        
        //選取背景圖
        @IBAction func pressBackground(_ sender: UIButton) {
            background.image = sender.currentBackgroundImage
            background.contentMode = .scaleAspectFill
            backView.addSubview(background)
            
            if photoImg.isMask == true {
                editBackgroundView.insertSubview(backView, at: 1)
            }else{
                editBackgroundView.insertSubview(backView, at: 0)
            }
            if maskTimes > 1 {
                editBackgroundView.insertSubview(backView, at: 0)
                backView.addSubview(background)
            }
        }
        
        //建立濾鏡
        func buildFilter() {
            let filterArray = ["","CIPhotoEffectTonal","CIPhotoEffectMono","CIPhotoEffectTransfer", "CIPhotoEffectInstant","CIPhotoEffectFade","CIPhotoEffectProcess", "CIPhotoEffectChrome","CIFalseColor","CIColorPosterize","CILineOverlay","CIComicEffect"]
            
            if photoImg.photo != nil {
                let ciImage = CIImage(image: photoImg.photo!)

                if let filter = CIFilter(name: filterArray[filterNum]) {
                    filter.setValue(ciImage, forKey: kCIInputImageKey)
                    
                    if let outputImage = filter.outputImage ,
                       let cgImg = CIContext().createCGImage(outputImage, from: outputImage.extent) {
                        let image = UIImage(cgImage: cgImg)
                        editImageView.image = image
                    }
                }
            }
        }
        
        //選取濾鏡風格
        @IBAction func pressFilterBtn(_ sender: UIButton) {
            if sender.tag == 0 {
                editImageView.image = photoImg.photo
            }else {
                filterNum = sender.tag
                buildFilter()
            }
        }
        
        //調整文字
        @IBAction func selectWordStyle(_ sender: UIButton) {
            switch sender {
            case selectWordColorBtn:
                let controller = UIColorPickerViewController()
                controller.delegate = self
                present(controller, animated: true, completion: nil)
            case getBoldBtn: do {
                getBoldTimes += 1
                if getBoldTimes % 2 != 0 {
                    self.wordTextField.font = UIFont.boldSystemFont(ofSize: newFontSize)
                }else {
                    self.wordTextField.font = UIFont.systemFont(ofSize: newFontSize)
                }
            }
            case getItalicBtn: do {
                getItalicTimes += 1
                if getItalicTimes % 2 != 0{
                    self.wordTextField.font = UIFont.italicSystemFont(ofSize: newFontSize)
                }else {
                    self.wordTextField.font = UIFont.systemFont(ofSize: newFontSize)
                }
            }
            case getBigBtn: do {
                self.getBigTimes += 1
                newFontSize = fontSize + CGFloat(getBigTimes)
                wordTextField.font = UIFont.systemFont(ofSize: newFontSize)
            }
            case getSmallBtn: do {
                self.getSmallTimes -= 1
                newFontSize = fontSize + CGFloat(getSmallTimes)
                wordTextField.font = UIFont.systemFont(ofSize: newFontSize)
            }
            default:
                wordTextField.font = UIFont.systemFont(ofSize: fontSize)
            }
        }
        
        //讓ViewController當作colorPicker的delegate
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            wordTextField.textColor = viewController.selectedColor
        }
        
        //點選slider
        @IBAction func pressSlider(_ sender: UISlider) {
            leftRightSlider.maximumValue = Float(editImageView.frame.size.height*0.7)
            leftRightSlider.minimumValue = sender.maximumValue * -1
            upDownSlider.maximumValue = Float(editImageView.frame.size.height*0.7)
            upDownSlider.minimumValue = sender.maximumValue * -1
            sizeSlider.maximumValue = 2
            sizeSlider.minimumValue = 0.1
            if photoImg.isCuteImg == true {
                photoImg.isShowWord = false
                cuteImg.transform = CGAffineTransform(translationX: CGFloat(leftRightSlider.value), y: CGFloat(upDownSlider.value)).scaledBy(x: CGFloat(sizeSlider.value), y: CGFloat(sizeSlider.value))
            }
                        
            if photoImg.isShowWord == true {
                photoImg.isCuteImg = false
                wordTextField.transform = CGAffineTransform(translationX: CGFloat(leftRightSlider.value), y: CGFloat(upDownSlider.value)).scaledBy(x: CGFloat(sizeSlider.value)*2, y: CGFloat(sizeSlider.value)*2)
            }
        }
        
        //儲存編輯後的圖片
        @IBAction func saveEditedPhoto(_ sender: UIButton) {
            let renderer = UIGraphicsImageRenderer(size: editBackgroundView.bounds.size)
            let editedImage = renderer.image { UIGraphicsImageRendererContext in
                editBackgroundView.drawHierarchy(in: editBackgroundView.bounds, afterScreenUpdates: true)
            }
            let activityViewController = UIActivityViewController(activityItems: [editedImage], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    //定義客制顏色
    extension UIColor {
        public class var cuteOrange: UIColor {
            return UIColor(red:255/255, green:195/255 ,blue:95/255 , alpha:0.8)
        }
    }
