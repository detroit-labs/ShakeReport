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
    
}
