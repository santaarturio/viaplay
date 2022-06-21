import UIKit

class ShadowView: UIView {
  
  private var setupShadowDone: Bool = false
  
  private func setupShadow() {
    if setupShadowDone { return }
    layer.cornerRadius = 10
    layer.shadowOffset = CGSize(width: 0, height: 4)
    layer.shadowRadius = 3.0
    layer.shadowOpacity = 0.3
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowPath = UIBezierPath(
      roundedRect: self.bounds,
      byRoundingCorners: .allCorners,
      cornerRadii: CGSize(width: 10, height: 10)).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
    
    setupShadowDone = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupShadow()
  }
}
