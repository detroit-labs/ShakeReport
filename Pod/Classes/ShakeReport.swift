//
//  ShakeReport.swift
//  Pods
//
//  Created by Dan Trenz on 12/10/15.
//

import UIKit
import MessageUI


public class ShakeReport {
  
  private struct Config {
    static var toRecipients: [String]?
    static var subject: String?
  }
  
  // MARK: - Configuration
  
  /**
  Set bug report email recipient(s) and custom subject line.
  
  - parameter toRecipients: List of email addresses to which the report will be sent.
  - parameter subject:      Custom subject line to use for the report email.
  */
  public class func configure(to toRecipients: [String]!, subject: String?) {
    Config.toRecipients = toRecipients
    Config.subject = subject
  }
  
}

extension UIViewController: MFMailComposeViewControllerDelegate {
  
  // MARK: - UIResponder
  
  override public func canBecomeFirstResponder() -> Bool {
    return true
  }
  
  override public func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if motion == .MotionShake {
      let cachedScreenshot = captureScreenshot()
      
      let actionSheet = UIAlertController(title: "Shake detected!", message: "Would you like to report a bug?", preferredStyle: .ActionSheet)
      
      let reportBugAction = UIAlertAction(title: "Report A Bug", style: .Default, handler: { (action) -> Void in
        self.composeReport(cachedScreenshot)
      })
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { _ in }
      
      actionSheet.addAction(reportBugAction)
      actionSheet.addAction(cancelAction)
      
      presentViewController(actionSheet, animated: true, completion: nil)
    }
  }
  
  // MARK: - Report methods
  
  /**
  Take a screenshot for the current screen state.
  
  - returns: Screenshot image.
  */
  private func captureScreenshot() -> UIImage? {
    var screenshot: UIImage? = nil
    
    if let layer = UIApplication.sharedApplication().keyWindow?.layer {
      let scale = UIScreen.mainScreen().scale
      
      UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
      
      if let context = UIGraphicsGetCurrentContext() {
        layer.renderInContext(context)
      }
      
      screenshot = UIGraphicsGetImageFromCurrentImageContext()
      
      UIGraphicsEndImageContext()
    }
    
    return screenshot;
  }
  
  /**
   Present the user with a mail compose view with the recipient(s) & subject line
   pre-populated, and the screenshot attached.
   
   - parameter screenshot: The screenshot to attach to the report.
   */
  private func composeReport(screenshot: UIImage?) {
    if MFMailComposeViewController.canSendMail() {
      let mailComposer = MFMailComposeViewController()
      
      guard let toRecipients = ShakeReport.Config.toRecipients else {
        print("ShakeReport – Error: No mailTo addresses given.")
        return
      }
      
      mailComposer.setToRecipients(toRecipients)
      
      if let subject = ShakeReport.Config.subject {
        mailComposer.setSubject(subject)
      } else {
        mailComposer.setSubject("Bug Report")
      }
      
      mailComposer.mailComposeDelegate = self
      
//      if let screenshot = screenshot, let screenshotJPEG = UIImageJPEGRepresentation(screenshot, CGFloat(1.0)) {
//        mailComposer.addAttachmentData(screenshotJPEG, mimeType: "image/jpeg", fileName: "screenshot.jpeg")
//      }
      
      presentViewController(mailComposer, animated: true, completion: nil)
    }
  }
  
  // MARK: - MFMailComposeViewControllerDelegate
  
  public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    if let error = error {
      print("ShakeReport – Error: \(error)")
    }
    
    switch result {
    case MFMailComposeResultFailed:
      print("ShakeReport – Bug report send failed.")
      break;
      
    case MFMailComposeResultSent:
      print("ShakeReport – Bug report sent!")
      break;
      
    default:
      // noop
      break;
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
}
