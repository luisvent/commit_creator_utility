import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    var statusBar: StatusBarController?
    var popover = NSPopover()

    override init() {
        super.init()
        popover.behavior = .transient // To make the popover hide when the user clicks outside
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        super.applicationDidFinishLaunching(aNotification)
        
        guard let mainFlutterWindow = mainFlutterWindow else {
            print("mainFlutterWindow is nil")
            return
        }

        if let controller = mainFlutterWindow.contentViewController as? FlutterViewController {
            popover.contentSize = NSSize(width: 400, height: 725) // Adjust the size to your needs
            popover.contentViewController = controller // Set the Flutter view controller as the popover content
        } else {
            print("Unable to cast contentViewController to FlutterViewController")
        }

        // Initialize the status bar controller with the popover
        statusBar = StatusBarController(popover)

        // Close the default Flutter window
        mainFlutterWindow.close()
    }
}
