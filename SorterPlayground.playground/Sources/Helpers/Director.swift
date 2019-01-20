import Foundation
import PlaygroundSupport
import SpriteKit

class SortDirector {
    var sortNodeList : [SortNode]
    var delay : Double = 0.0
    var scene : SKScene
    init() {
        self.sortNodeList = []
        self.delay = 0.0
        self.scene = SKScene()
    }
    
    convenience init(scene: SKScene) {
        self.init()
        self.sortNodeList = []
        self.delay = 0.0
        self.scene = scene
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func move(index:Int, direction:Direction) {
        self.delay += 0.25
        sortNodeList[index].shape.move(direction: direction, delay: self.delay)
    }
    
    func getIndex(fromValue value:String) -> Int {
        for index in 0..<sortNodeList.count {
            if sortNodeList[index].value == value {
                return index
            }
        }
        return -1
    }
    
    func addSortNode(color:UIColor, value:String) {
        let square = CustomShapeNode(rectOf: CGSize(width: 50, height: 50))
        square.fillColor = color
        
        let label = SKLabelNode(text: value)
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.fontName = "Menlo"
        square.addChild(label)
        
        let node = SortNode(shape:square, value: value)
        self.sortNodeList.append(node)
    }
    
    func ready() {
        //node count
        //scene width
        //square size = scene width / node count
        //if size > 50 then
        //  use 50
        //  width of all squares together = node count * 50
        //  if even square count shift position by -25
        //     so startPos = (count / 2 * -50) - 25
        //  else
        //      startPos = (count - 1) / 2 * -50
        //else use size
        
        let nodeCount = sortNodeList.count
        let sceneWidth = scene.frame.width
        var squareSize = sceneWidth / CGFloat(nodeCount)
        if squareSize > 50 {
            squareSize = 50
        }
        
        let squareListWidth = nodeCount * 50
        var startPos : CGFloat
        if squareListWidth % 2 == 0 {
            startPos = (CGFloat(nodeCount) / 2 * -50) - 25
        }
        else {
            startPos = (CGFloat(nodeCount) - 1) / 2 * -50
        }
        startPos += 50
        for index in 0..<nodeCount {
            sortNodeList[index].shape.setInitialPosition(x:startPos)
            scene.addChild(sortNodeList[index].shape)
            print("sortNodeList[\(index)]: \(sortNodeList[index].value) x:\(startPos)")
            startPos += CGFloat(squareSize)
        }
        
    }
}
