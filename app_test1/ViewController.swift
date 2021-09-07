//
//  ViewController.swift
//  app_test1
//
//  Created by Eric Chang on 2021/9/2.
//

import UIKit

class ViewController: UIViewController {
 
    //定義六個座標點分別代表六個button位置
    var firstLocation = CGRect()
    var secondLocation = CGRect()
    var thirdLocation = CGRect()
    var forthLocation = CGRect()
    var fifthLocation = CGRect()
    var sixthLocation = CGRect()
    
    //被覆蓋button的tag
    var coveredButtonTag: Int = 0
    //被拖曳button的初始位置
    lazy var tempLocation: CGPoint = {
        return CGPoint()
    }()
    //宣告一個陣列代表六個位置分別存放的button
//    var buttonList: [Int] = [1,2,3,4,5,6]
    //宣告一個陣列代表六個位置分別存放的button
    lazy var buttonList2: [UIButton] = [button1, button2, button3, button4, button5, button6]
    //被拖曳button在陣列中的初始位置
    var currentLocation: Int = 0
    
    var viewIsLoad: Bool = false
            
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var navigatorBar: UINavigationItem!
    
    @IBAction func printNumber(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            print("This is \(sender.title(for: .normal)!) button")
        case 2:
            print("This is \(sender.title(for: .normal)!) button")
        case 3:
            print("This is \(sender.title(for: .normal)!) button")
        case 4:
            print("This is \(sender.title(for: .normal)!) button")
        case 5:
            print("This is \(sender.title(for: .normal)!) button")
        case 6:
            print("This is \(sender.title(for: .normal)!) button")
        default:
            break
        }
    }
    
    @IBAction func handlePan(_ gesture: UIPanGestureRecognizer) {
        // 1
        let translation = gesture.translation(in: subview)
        // 2
        guard let gestureView = gesture.view else {
            return
        }
    
        if gesture.state == .began{
            //從storyboard拉出來的view有設定約束，故在每次呼叫view時都須解除約束
            view.translatesAutoresizingMaskIntoConstraints = false
            
//            subview.translatesAutoresizingMaskIntoConstraints = false
            
            //暫存被拖曳button的位置
            tempLocation = gestureView.frame.origin

            //找出被拖曳button在array中位置
            currentLocation = buttonList2.firstIndex(of: gestureView as! UIButton)!
            
            //將被拖曳button的圖層移至最上方
            subview.bringSubviewToFront(gestureView)
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            gestureView.alpha = 0.7
        })
    
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        
        // 3
        gesture.setTranslation(.zero, in: view)
        
        if gesture.state == .ended{
            gestureView.alpha = 1
            //拖曳結束，進入交換程式點
            changeLocation(judgeView: gestureView as! UIButton)
            
            var printList = ""
            for index in buttonList2{
                printList.append(String(index.tag))
            }
            print(printList)
            }
        
    }
    
    func changeLocation(judgeView: UIButton){
        //firstButton move：被拖曳button移至新目標
        UIView.animate(withDuration: 0.1, animations: {
            judgeView.frame.origin = self.judgeLocation(judgeView: judgeView)
        })

        //secondButton move：被覆蓋button移至被拖曳button初始位置
        switch coveredButtonTag{
        case 1:
            UIView.animate(withDuration: 0.3, animations: {
                self.button1.frame.origin = self.tempLocation
            })
            //將被覆蓋button的tag放至被拖曳button的在array的位置
            buttonList2[currentLocation] = button1
        case 2:
            UIView.animate(withDuration: 0.3, animations: {
                self.button2.frame.origin = self.tempLocation
            })
            buttonList2[currentLocation] = button2
        case 3:
            UIView.animate(withDuration: 0.3, animations: {
                self.button3.frame.origin = self.tempLocation
            })
            buttonList2[currentLocation] = button3
        case 4:
            UIView.animate(withDuration: 0.3, animations: {
                self.button4.frame.origin = self.tempLocation
            })
            buttonList2[currentLocation] = button4
        case 5:
            UIView.animate(withDuration: 0.3, animations: {
                self.button5.frame.origin = self.tempLocation
            })
            buttonList2[currentLocation] = button5
        case 6:
            UIView.animate(withDuration: 0.3, animations: {
                self.button6.frame.origin = self.tempLocation
            })
            buttonList2[currentLocation] = button6
        default:
            break
        }
    }
    
    func judgeLocation(judgeView: UIButton) -> CGPoint{
        if firstLocation.contains(judgeView.center) {
            //將被覆蓋button的tag取出
            coveredButtonTag = buttonList2[0].tag
            //將被拖曳button的tag放至array被覆蓋button的位置
            buttonList2[0] = judgeView
            return firstLocation.origin
        }else if secondLocation.contains(judgeView.center) {
            coveredButtonTag = buttonList2[1].tag
            buttonList2[1] = judgeView
            return secondLocation.origin
        }else if thirdLocation.contains(judgeView.center) {
            coveredButtonTag = buttonList2[2].tag
            buttonList2[2] = judgeView
            return thirdLocation.origin
        }else if forthLocation.contains(judgeView.center) {
            coveredButtonTag = buttonList2[3].tag
            buttonList2[3] = judgeView
            return forthLocation.origin
        }else if fifthLocation.contains(judgeView.center) {
            coveredButtonTag = buttonList2[4].tag
            buttonList2[4] = judgeView
            return fifthLocation.origin
        }else if sixthLocation.contains(judgeView.center){
            coveredButtonTag = buttonList2[5].tag
            buttonList2[5] = judgeView
            return sixthLocation.origin
        }else{
            coveredButtonTag = buttonList2[currentLocation].tag
            buttonList2[currentLocation] = judgeView
            return judgeView.frame.origin
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        view.translatesAutoresizingMaskIntoConstraints = false
        if viewIsLoad{
            buttonList2[0].frame = firstLocation
            buttonList2[1].frame = secondLocation
            buttonList2[2].frame = thirdLocation
            buttonList2[3].frame = forthLocation
            buttonList2[4].frame = fifthLocation
            buttonList2[5].frame = sixthLocation
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !viewIsLoad{
            firstLocation = button1.frame
            secondLocation = button2.frame
            thirdLocation = button3.frame
            forthLocation = button4.frame
            fifthLocation = button5.frame
            sixthLocation = button6.frame
            
//            buttonList2.forEach {
//                print($0.frame)
//                $0.constraints.forEach{ constraint in
//                    constraint.isActive = false
//                }
//                $0.removeConstraints($0.constraints)
//            }
//            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        viewIsLoad = true


    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        for button in buttonList2{
//            subview.removeConstraints(button.constraints)
//        }
//        buttonList2.forEach {
//            $0.constraints.forEach{constraint in
//                constraint.isActive = false
//            }
//            $0.removeConstraints($0.constraints)
//        }
//
//         NSLayoutConstraint.activate([
//            buttonList2[0].topAnchor.constraint(equalTo: subview.topAnchor, constant: 20),
//            buttonList2[1].topAnchor.constraint(equalTo: subview.topAnchor, constant: 20),
//
//            buttonList2[2].topAnchor.constraint(equalTo: buttonList2[0].bottomAnchor, constant: 10),
//            buttonList2[3].topAnchor.constraint(equalTo: buttonList2[1].bottomAnchor, constant: 10),
//
//            buttonList2[4].topAnchor.constraint(equalTo: buttonList2[2].bottomAnchor, constant: 10),
//            buttonList2[5].topAnchor.constraint(equalTo: buttonList2[3].bottomAnchor, constant: 10),
//
//            buttonList2[4].bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: -20),
//            buttonList2[5].bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: -20),
//
//            buttonList2[0].leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 20),
//            buttonList2[2].leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 20),
//            buttonList2[4].leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 20),
//
//            buttonList2[0].trailingAnchor.constraint(equalTo: buttonList2[1].leadingAnchor, constant: -10),
//            buttonList2[2].trailingAnchor.constraint(equalTo: buttonList2[3].leadingAnchor, constant: -10),
//            buttonList2[4].trailingAnchor.constraint(equalTo: buttonList2[5].leadingAnchor, constant: -10),
//
//            buttonList2[1].trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -20),
//            buttonList2[3].trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -20),
//            buttonList2[5].trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -20),
//
//            buttonList2[0].widthAnchor.constraint(equalTo: buttonList2[1].widthAnchor),
//            buttonList2[2].widthAnchor.constraint(equalTo: buttonList2[3].widthAnchor),
//            buttonList2[4].widthAnchor.constraint(equalTo: buttonList2[5].widthAnchor),
//
//            buttonList2[0].heightAnchor.constraint(equalTo: buttonList2[2].heightAnchor),
//            buttonList2[2].heightAnchor.constraint(equalTo: buttonList2[4].heightAnchor),
//            buttonList2[1].heightAnchor.constraint(equalTo: buttonList2[3].heightAnchor),
//            buttonList2[3].heightAnchor.constraint(equalTo: buttonList2[5].heightAnchor),
//        ])


    }
}

