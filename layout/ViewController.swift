//
//  ViewController.swift
//  layout
//
//  Created by Inpyo Hong on 2020/12/18.
//

import UIKit
import BonMot

class ViewController: UIViewController {
    @IBOutlet weak var showHostInfoView: UIView!
    @IBOutlet weak var textBannerView: UIView!
    @IBOutlet weak var noticeLabelView: UIView!
    @IBOutlet weak var showHostInfoLabel: UILabel!
    @IBOutlet weak var textBannerLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var noticeSeeMoreView: UIView!
    @IBOutlet weak var noticeSeeMoreLabel: UILabel!
    @IBOutlet weak var noticeLabelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var noticeDetailButton: UIButton!
    
    var attributedStringShadow: NSShadow = {
      let shadow = NSShadow()
      shadow.shadowColor = UIColor(white: 20.0 / 255.0, alpha: 0.4)
      shadow.shadowOffset = CGSize(width: 0, height: 1)
      return shadow
    }()
    
    let seeMoreStr: NSAttributedString = {
      let shadow = NSShadow()
      shadow.shadowColor = UIColor(white: 20.0 / 255.0, alpha: 0.4)
      shadow.shadowOffset = CGSize(width: 0, height: 1)

      let seeMoreTextStyle = StringStyle(
        .font(.systemFont(ofSize: 17)),
        .lineBreakMode(.byCharWrapping),
        .color(.white),
        .baselineOffset(4),
        .extraAttributes([
          .shadow: shadow
        ])
      )

      return NSAttributedString.composed(
        of: [
          ("더보기", "iconArrowRightWhSm")
        ].map {
          NSAttributedString.composed(of: [
            $0.styled(with: seeMoreTextStyle),
            UIImage(named: $1)!
          ])
        }, separator: " ")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showHostInfoLabel.text = "\n\n"
        print("showHostInfoLabel height", self.showHostInfoLabel.frame.size.height)
        noticeSeeMoreLabel.attributedText = NSAttributedString(attributedString: seeMoreStr)
        showHostInfoLabel.text = "Nullam id dolor id nibh ultricies vehicula ut id elit.Nullam id dolor id nibh ultricies vehicula ut id elit."
        showHostInfoView.isHidden = false
        
        let noticeAttributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.noticeAttributeText(image: "iconManagerYellowSm", baselineOffset: 4, message: "Nullam id dolor id nibh ultricies vehicula ut id elit.Nullam id dolor id nibh ultricies vehicula ut id elit."))
        self.noticeLabel.attributedText = noticeAttributedString
        
        DispatchQueue.main.async {
            print("showHostInfoLabel height", self.showHostInfoLabel.frame.size.height)
            if self.showHostInfoLabel.frame.size.height > 50 {
                self.noticeLabel.numberOfLines = 2
            }
        }
        
        DispatchQueue.main.async {
            print("noticeLabel height", self.noticeLabel.frame.size.height)
            if self.noticeLabel.frame.size.height > 50 {
                self.noticeSeeMoreView.isHidden = false
                self.noticeLabel.numberOfLines = 2
                self.noticeLabelTrailingConstraint.constant = 80
                self.noticeDetailButton.isEnabled = true
            }
        }
    }

    @IBAction func tapnoticeDetailButton(_ sender: Any) {
        print(#function)
    }
    
    func noticeAttributeText(image: String, baselineOffset: CGFloat, message: String) -> NSAttributedString {
      let attributedString: NSAttributedString = {
        let textStyle = StringStyle(
          .font(.systemFont(ofSize: 17)),
          .lineBreakMode(.byCharWrapping),
          .color(UIColor(red: 1.0, green: 226.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)),
          .baselineOffset(baselineOffset),
          .extraAttributes([
            .shadow: self.attributedStringShadow
          ])
        )

        return NSAttributedString.composed(
          of: [
            (image, message)
          ].map {
            NSAttributedString.composed(of: [
              UIImage(named: $0)!,
              $1.styled(with: textStyle)
            ])
          }, separator: " ")
      }()

      return attributedString
    }
}
