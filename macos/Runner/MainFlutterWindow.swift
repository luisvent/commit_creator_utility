import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
      let flutterViewController = FlutterViewController.init()
      flutterViewController.backgroundColor = .clear
      
      let visualEffectView = NSVisualEffectView()
      visualEffectView.material = .underWindowBackground  // The material of the view. This sets the blur effect.
      visualEffectView.blendingMode = .behindWindow  // The blending mode. This makes the blur effect appear behind the window.
      visualEffectView.state = .active  // The state. This makes the blur effect active.
      flutterViewController.view.addSubview(visualEffectView, positioned: .below, relativeTo: flutterViewController.view)
      visualEffectView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        visualEffectView.topAnchor.constraint(equalTo: flutterViewController.view.topAnchor),
        visualEffectView.bottomAnchor.constraint(equalTo: flutterViewController.view.bottomAnchor),
        visualEffectView.leadingAnchor.constraint(equalTo: flutterViewController.view.leadingAnchor),
        visualEffectView.trailingAnchor.constraint(equalTo:flutterViewController.view.trailingAnchor),
      ])

    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
    RegisterGeneratedPlugins(registry: flutterViewController)
      
    super.awakeFromNib()
  }
}
