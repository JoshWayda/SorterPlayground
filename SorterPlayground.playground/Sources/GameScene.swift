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
        sorter.addSortNode(color: UIColor(rgb: 0x4A89DC), value: "7")
        sorter.addSortNode(color: UIColor(rgb: 0x4BCFAD), value: "5")
        sorter.addSortNode(color: UIColor(rgb: 0xFFCE54), value: "3")
        sorter.addSortNode(color: UIColor(rgb: 0xED5565), value: "1")
        sorter.addSortNode(color: UIColor(rgb: 0xAC92EC), value: "8")
        sorter.addSortNode(color: UIColor(rgb: 0x5D9CEC), value: "6")
        sorter.addSortNode(color: UIColor(rgb: 0xA0D468), value: "4")
        sorter.addSortNode(color: UIColor(rgb: 0xE9573F), value: "2")

        sorter.ready()
        //sorter.copy(leftIndex: 0, rightIndex: 1, distance: 1)
        
        
        self.MergeSort(director: sorter)
        //self.bubbleSort(director: sorter)
        //self.TopDownMergeSort(A: &<#T##[SortNode]#>, B: &<#T##[SortNode]#>, n: <#T##Int#>)
        //self.selectionSort(director: sorter)
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
    
    func bubbleSort(director:SortDirector){
        var A = director.sortNodeList
        var n = A.count
        var swapped : Bool
        repeat {
            swapped = false
            for i in 1...n-1 {
                if A[i-1].value > A[i].value {
                    director.swap(leftIndex: director.getIndex(fromValue: A[i-1].value), rightIndex: director.getIndex(fromValue: A[i].value), distance: 1)
                    let temp = A[i-1]
                    A[i-1] = A[i]
                    A[i] = temp
                    swapped = true
                }
            }
        } while swapped
    }
    
    //*********************************
    //MERGE SORT IMPLEMENTATION
    //*********************************
    func MergeSort(director: SortDirector) {
        var toSort : [SortNode] = director.sortNodeList
        var myCopy : [SortNode] = []
        TopDownMergeSort(A:&toSort,B:&myCopy,n:toSort.count)
        printlist(list: toSort)
    }
    
    func TopDownMergeSort(A:inout [SortNode], B:inout [SortNode], n : Int) {
        CopyArray(A: A, iBegin: 0, iEnd: n, B: &B)
        TopDownSplitMerge(B: &B, iBegin: 0, iEnd: n, A: &A)
    }
    
    func TopDownSplitMerge(B:inout [SortNode], iBegin : Int, iEnd : Int, A:inout [SortNode]) {
        if iEnd - iBegin < 2 {
            return
        }
        
        let iMiddle = (iEnd + iBegin) / 2
        TopDownSplitMerge(B: &A, iBegin: iBegin, iEnd: iMiddle, A: &B)
        TopDownSplitMerge(B: &A, iBegin: iMiddle, iEnd:iEnd, A: &B)
        TopDownMerge(A: &B, iBegin: iBegin, iMiddle: iMiddle, iEnd: iEnd, B: &A)
    }
    
    var mergeSortDelay : Double = 0.0
    func TopDownMerge(A:inout [SortNode], iBegin:Int, iMiddle:Int, iEnd:Int, B:inout [SortNode]) {
        var i = iBegin
        var j = iMiddle
        for k in iBegin ..< iEnd {
            mergeSortDelay += 1.0
            if (i < iMiddle && (j >= iEnd || A[i].value <= A[j].value)) {
                A[i].shape.xPos += CGFloat(50*(k-i))
                A[i].shape.yPos += -100
                A[i].shape.moveTo(xIncrement: A[i].shape.xPos, yIncrement: A[i].shape.yPos, delay: mergeSortDelay)
                B[k] = A[i]
                i = i + 1
            }
            else {
                A[j].shape.xPos += CGFloat(50*(k-j))
                A[j].shape.yPos += -100
                A[j].shape.moveTo(xIncrement: A[j].shape.xPos, yIncrement: A[j].shape.yPos, delay: mergeSortDelay)
                B[k] = A[j]
                j = j + 1
            }
        }
        
        mergeSortDelay += 1.0
        //move all back up to zero
        for k in iBegin ..< iEnd {
            A[k].shape.yPos += 100
            A[k].shape.moveTo(xIncrement: A[k].shape.xPos, yIncrement: A[k].shape.yPos, delay: mergeSortDelay)
        }
    }
    
    func CopyArray(A:[SortNode], iBegin : Int, iEnd : Int, B:inout [SortNode]) {
        for k in iBegin ..< iEnd {
            //print("k:\(k)")
            B.append(A[k])
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
