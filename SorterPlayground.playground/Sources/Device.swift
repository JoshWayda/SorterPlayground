import Foundation
import SpriteKit
public class Device {
    public static func GetLandscapeSE() -> CGRect {
        return CGRect(x:0 , y:0, width: 568, height: 320)
    }
    public static func GetPortraitSE() -> CGRect {
        return CGRect(x:0 , y:0, width: 320, height: 568)
    }
    public static func GetLandscape6sPlus() -> CGRect {
        return CGRect(x:0 , y:0, width: 736, height: 414)
    }
    public static func GetPortrait6sPlus() -> CGRect {
        return CGRect(x:0 , y:0, width: 414, height: 736)
    }
    public static func GetLandscape6s() -> CGRect {
        return CGRect(x:0 , y:0, width: 667, height: 375)
    }
    public static func GetPortrait6s() -> CGRect {
        return CGRect(x:0 , y:0, width: 375, height: 667)
    }
    public static func GetTweetableDimension() -> CGRect {
        return CGRect(x:0 , y:0, width: 640, height: 360)
    }
    
}
