import Foundation
import PlaygroundSupport
import SpriteKit

class SortDirector {
    var sortNodeList : [SortNode] = []
    var delay : Double = 0.0
    func move(index:Int, direction:Direction) {
        self.delay += 1.0
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
}

struct SortNode {
    var shape : CustomShapeNode
    var value : String
}

public class GameScene: SKScene {
    
    public override init() {
        super.init()
    }
    
    public override init(size:CGSize) {
        super.init(size: size)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func didMove(to view: SKView) {
        let sorter = SortDirector()
        
        //Create Blue Node
        let blueSquare = CustomShapeNode(rectOf: CGSize(width: 50, height: 50),
                                         position: CGPoint(x: -50, y: 0))
        blueSquare.fillColor = UIColor.blue
        let blueLabel = SKLabelNode(text: "3")
        blueLabel.horizontalAlignmentMode = .center
        blueLabel.verticalAlignmentMode = .center
        blueLabel.fontName = "Menlo"
        blueSquare.addChild(blueLabel)
        let blueNode = SortNode(shape:blueSquare, value: "3")
        sorter.sortNodeList.append(blueNode)
        
        addChild(blueNode.shape)

        //Create Green Node
        let greenSquare = CustomShapeNode(rectOf: CGSize(width: 50, height: 50), position: CGPoint(x: 0, y: 0))
        greenSquare.fillColor = UIColor.green
        let greenLabel = SKLabelNode(text:"2")
        greenLabel.horizontalAlignmentMode = .center
        greenLabel.verticalAlignmentMode = .center
        greenLabel.fontName = "Menlo"
        greenSquare.addChild(greenLabel)
        let greenNode = SortNode(shape:greenSquare, value: "2")
        sorter.sortNodeList.append(greenNode)
        
        addChild(greenNode.shape)

        //Create Red Node
        let redSquare = CustomShapeNode(rectOf: CGSize(width: 50, height: 50), position: CGPoint(x: 50, y: 0))
        redSquare.fillColor = UIColor.red
        let redLabel = SKLabelNode(text:"1")
        redLabel.horizontalAlignmentMode = .center
        redLabel.verticalAlignmentMode = .center
        redLabel.fontName = "Menlo"
        redSquare.addChild(redLabel)
        let redNode = SortNode(shape:redSquare, value: "1")
        sorter.sortNodeList.append(redNode)

        addChild(redNode.shape)

        insertionSort(director: sorter)
    }

    func insertionSort(director:SortDirector){
        var A = director.sortNodeList
        var i = 1
        while i < A.count {
            let x = A[i].value
            let xShape = A[i].shape
            var j = i - 1
            if j >= 0 && A[j].value > x {
                print("Remove \(x)")
                let indexToRemove = director.getIndex(fromValue: x)
                director.move(index:indexToRemove,direction: .Up)
            }
            
            while j >= 0 && A[j].value > x {
                let indexToMoveLeft = director.getIndex(fromValue: x)
                let indexToMoveRight = director.getIndex(fromValue: A[j].value)
                print("shift \(x) left")
                director.move(index:indexToMoveLeft,direction: .Left)
                print("shift \(A[j].value) right")
                director.move(index: indexToMoveRight, direction: .Right)
                A[j+1].shape = A[j].shape
                A[j+1].value = A[j].value
                j = j - 1
            }
            
            if A[j+1].value != x {
                print("Insert \(x) at index \(j+1)")
                let indexToMoveDown = director.getIndex(fromValue: x)
                director.move(index:indexToMoveDown, direction: .Down)
            }
            A[j+1].value = x
            A[j+1].shape = xShape
            i = i + 1
        }
    }

    func printlist(list:[SortNode]) {
        var l : String = ""
        for n in list {
            l += "\(n.value) "
        }
        print(l)
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
