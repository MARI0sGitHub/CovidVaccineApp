//
//  InfoViewController.swift
//  vaccine
//
//  Created by MAC BOOK PRO 2013 EARLY on 2022/09/06.
//

import UIKit
import SafariServices

class InfoViewController: UIViewController {
    @IBOutlet weak var urlTextView: UITextView! {
        didSet {
            urlTextView.delegate = self
            urlTextView.isSelectable = true
            urlTextView.isEditable = false
            urlTextView.dataDetectorTypes = .link
            urlTextView.textColor = .blue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tabCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//텍스트 뷰 내용중 url을 포함 하고 있을 때
//해당 url의 내용을 표시하는 사파리 뷰 컨트롤러를 띄운다
extension InfoViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            let safariView: SFSafariViewController = SFSafariViewController(url: URL)
            self.present(safariView, animated: true, completion: nil)
            return false
        }
}
