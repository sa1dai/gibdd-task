//
//  WizardViewController.swift
//  gibdd
//
//  Created by Admin on 18.02.2021.
//

import UIKit

class WizardViewController: UIViewController {
  static var pageNumber: Int = 4
  
  @IBOutlet var pageControl: UIPageControl!
  
  var showButton: ((Bool) -> Void) = { _ in }
  
  var isLastPage: Bool {
    let pageIndex = pageControl.currentPage
    return pageIndex == WizardViewController.pageNumber - 1
  }
}

extension WizardViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.bounds.width
    pageControl.currentPage = Int(scrollView.contentOffset.x / pageWidth)
    showButton(isLastPage)
  }
}
