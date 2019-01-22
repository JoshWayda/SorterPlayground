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
        //9 2 1 8 4 5 7 6 3
        sorter.addSortNode(color: UIColor(rgb: 0x967ADC), value: "9")
        sorter.addSortNode(color: UIColor(rgb: 0xE9573F), value: "2")
        
        
        sorter.addSortNode(color: UIColor(rgb: 0xA0D468), value: "4")
        sorter.addSortNode(color: UIColor(rgb: 0x4A89DC), value: "7")
        sorter.addSortNode(color: UIColor(rgb: 0x4BCFAD), value: "5")
        
        
        sorter.addSortNode(color: UIColor(rgb: 0x5D9CEC), value: "6")
        sorter.addSortNode(color: UIColor(rgb: 0xED5565), value: "1")
        sorter.addSortNode(color: UIColor(rgb: 0xFFCE54), value: "3")
        sorter.addSortNode(color: UIColor(rgb: 0xAC92EC), value: "8")
        sorter.ready()
        
        self.selectionSort(director: sorter)
        //sorter.swap(leftIndex: 2, rightIndex: 7)
        //self.insertionSort(director: sorter)
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

    //SELECTION SORT IMPLEMENTATION
    /*
     /* a[0] to a[n-1] is the array to sort */
     int i,j;
     int n; // initialise to a's length
     
     /* advance the position through the entire array */
     /*   (could do j < n-1 because single element is also min element) */
     for (j = 0; j < n-1; j++)
     {
     /* find the min element in the unsorted a[j .. n-1] */
     
     /* assume the min is the first element */
     int iMin = j;
     /* test against elements after j to find the smallest */
     for (i = j+1; i < n; i++)
     {
     /* if this element is less, then it is the new minimum */
     if (a[i] < a[iMin])
     {
     /* found new minimum; remember its index */
     iMin = i;
     }
     }
     
     if (iMin != j)
     {
     swap(a[j], a[iMin]);
     }
     }
     */

    func selectionSort(director:SortDirector) {
        var A = director.sortNodeList
        let n : Int = A.count
        printlist(list: A)
        for j in 0 ..< n-1 {
            var iMin : Int = j
            for i in j+1 ..< n {
                if A[i].value < A[iMin].value {
                    iMin = i
                }
            }
            
            if iMin != j {
                printlist(list:director.sortNodeList)
                print("swap: A[\(j)]:\(A[j].value) with A[\(iMin)]:\(A[iMin].value) : move \(iMin - j)")
                //director.swap(leftIndex: j, rightIndex: iMin)
                director.swap(leftIndex: director.getIndex(fromValue: A[j].value), rightIndex: director.getIndex(fromValue: A[iMin].value), distance: iMin - j)
                let temp = A[j]
                A[j] = A[iMin]
                A[iMin] = temp
                printlist(list: A)
            }
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
