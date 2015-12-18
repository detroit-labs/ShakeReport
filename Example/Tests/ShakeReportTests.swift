import UIKit
import XCTest

import Nimble

@testable import ShakeReport

class ShakeReportTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
    
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: Shake Tests
  
  func testViewControllerCanBecomeFirstResponder() {
    let viewController = UIViewController()
    
    expect(viewController.canBecomeFirstResponder()).to(beTrue())
  }
  
  func testShakingTriggersScreenshot() {
    class MockViewController: UIViewController {
      var captureScreenshotWasCalled = false
      
      override func captureScreenshot() -> UIImage? {
        captureScreenshotWasCalled = true
        return nil
      }
    }
    
    let viewController = MockViewController()
    
    viewController.motionEnded(.MotionShake, withEvent: nil)
    
    expect(viewController.captureScreenshotWasCalled).to(beTrue())
  }
  
  func testShakingPresentsReportPrompt() {
    class MockViewController: UIViewController {
      var presentReportPromptWasCalled = false
      
      override func presentReportPrompt(reportActionHandler: (UIAlertAction) -> Void) {
        presentReportPromptWasCalled = true
      }
    }
    
    let viewController = MockViewController()
    
    viewController.motionEnded(.MotionShake, withEvent: nil)
    
    expect(viewController.presentReportPromptWasCalled).to(beTrue())
  }
  
  func testsPresentReportPrompt() {    
    class MockViewController: UIViewController {
      var alertTitle: String? = nil
      var alertMessage: String? = nil
      var reportActionTitle: String? = nil
      var cancelActionTitle: String? = nil
      
      override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let alertController = viewControllerToPresent as? UIAlertController {
          alertTitle = alertController.title
          alertMessage = alertController.message
          
          if let reportAction = alertController.actions.first {
            reportActionTitle = reportAction.title
          }
          
          if let cancelAction = alertController.actions.last {
            cancelActionTitle = cancelAction.title
          }
        }
      }
    }
    
    let viewController = MockViewController()
    
    viewController.presentReportPrompt { (action) -> Void in
      // no-op
    }
    
    expect(viewController.alertTitle).to(equal("Shake detected!"))
    expect(viewController.alertMessage).to(equal("Would you like to report a bug?"))
    expect(viewController.reportActionTitle).to(equal("Report A Bug"))
    expect(viewController.cancelActionTitle).to(equal("Cancel"))
  }
    
}
