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
        self.delay += 0.5
        sortNodeList[index].shape.move(direction: direction, delay: self.delay)
    }
    
    func swap(leftIndex:Int, rightIndex: Int, distance: Int) {
        self.delay += 0.5
        sortNodeList[leftIndex].shape.move(direction: .Down, delay: self.delay)
        sortNodeList[rightIndex].shape.move(direction: .Up, delay: self.delay)

        for _ in 0 ..< distance {
            self.delay += 0.5
            //print("move sortNodeList[\(leftIndex)]:\(sortNodeList[leftIndex].value) right")
            //print("move sortNodeList[\(rightIndex)]:\(sortNodeList[rightIndex].value) left")
            sortNodeList[leftIndex].shape.move(direction: .Right, delay: self.delay)
            sortNodeList[rightIndex].shape.move(direction: .Left, delay: self.delay)
        }
        self.delay += 0.5
        sortNodeList[leftIndex].shape.move(direction: .Up, delay: self.delay)
        sortNodeList[rightIndex].shape.move(direction: .Down, delay: self.delay)
        //find distance between left and right index.
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
            //print("sortNodeList[\(index)]: \(sortNodeList[index].value) x:\(startPos)")
            startPos += CGFloat(squareSize)
        }
        
    }
}
