import Foundation
import PlaygroundSupport
import SpriteKit

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
        let whiteSquare = CustomShapeNode(rectOf: CGSize(width: 50, height: 50), position: CGPoint(x: 0, y: 0))
        whiteSquare.fillColor = UIColor.blue
        whiteSquare.position = CGPoint(x:0,y:0)
        
        //whiteSquare.physicsBody = SKPhysicsBody(rectangleOf:whiteSquare.frame.size)
        //whiteSquare.physicsBody?.affectedByGravity = false

        addChild(whiteSquare)
        whiteSquare.move(direction:.Up)
        whiteSquare.move(direction:.Right)
        whiteSquare.move(direction:.Down)
        whiteSquare.move(direction:.Left)
        //insertionSort()
    }

    func insertionSort() -> [String]{
        var A = "2 3 1".components(separatedBy: " ")
        var i = 1
        while i < A.count {
            var x = A[i]
            var j = i - 1
            if j >= 0 && A[j] > x {
                print("Remove \(x)")
            }
            
            while j >= 0 && A[j] > x {
                print("shift \(x) left")
                print("shift \(A[j]) right")
                A[j+1] = A[j]
                j = j - 1
            }
            
            if A[j+1] != x {
                print("Insert \(x) at index \(j+1)")
            }
            A[j+1] = x
            i = i + 1
        }
        return A
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
