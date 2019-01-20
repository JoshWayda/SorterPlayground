import Foundation
import PlaygroundSupport
import SpriteKit

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
        let sorter = SortDirector(scene:self)
        sorter.addSortNode(color: UIColor.blue, value: "3")
        sorter.addSortNode(color: UIColor.gray, value: "9")
        sorter.addSortNode(color: UIColor.orange, value: "6")
        sorter.addSortNode(color: UIColor.darkGray, value: "7")
        
        sorter.addSortNode(color: UIColor.cyan, value: "8")
        sorter.addSortNode(color: UIColor.magenta, value: "5")
        sorter.addSortNode(color: UIColor.purple, value: "4")
        
        sorter.addSortNode(color: UIColor.red, value: "1")
        sorter.addSortNode(color: UIColor.green, value: "2")
        sorter.ready()
        
        self.insertionSort(director: sorter)
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
