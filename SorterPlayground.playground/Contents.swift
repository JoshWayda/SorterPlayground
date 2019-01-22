//: A SpriteKit based Playg round

import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: Device.GetTweetableDimension())
let scene = GameScene(size:sceneView.frame.size)
scene.backgroundColor = UIColor.white
scene.anchorPoint = CGPoint(x:0.5,y:0.5)
// Set the scale mode to scale to fit the window
scene.scaleMode = .aspectFill
sceneView.showsPhysics = true
// Present the scene
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

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

/*
var a : [Int] = [3,2,1]
var n : Int = a.count

for j in 0 ..< n-1 {
    var iMin : Int = j
    for i in j+1 ..< n {
        if a[i] < a[iMin] {
            iMin = i
        }
    }

    if iMin != j {
        let temp = a[j]
        a[j] = a[iMin]
        a[iMin] = temp
    }
}
*/
