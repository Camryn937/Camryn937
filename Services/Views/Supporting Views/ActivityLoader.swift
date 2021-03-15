/// Copyright (c) 2020 Capsule LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///

import SwiftUI
import UIKit


struct AnimationCircleStrokeSpin: View {
    let size: CGFloat
    let style = StrokeStyle(lineWidth: 3, lineCap: .round)
    @State var animate = false
    let color1 = Color.gray.opacity(0.7)
    let color2 = Color.gray
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color1, color2]), center: .center),
                    style: style)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                .zIndex(5.0)
        }
        .frame(width: size, height: size)
        .onAppear(perform: {
            animate.toggle()
        })
    }
}

struct AnimationCircleStrokeSpin_preview: PreviewProvider {
    static var previews: some View {
        AnimationCircleStrokeSpin(size: 30)
    }
}



struct SegmentController<Content: View>: UIViewControllerRepresentable {
    var content: () -> Content
    let views: [AnyView] = [AnyView(LoadingView(size: 80)), AnyView(AboutView())]
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> UISegmentController {
        let vc = UISegmentController()
        
        return vc
    }
    
    func updateUIViewController(_ viewController: UISegmentController, context: Context) {
        
        print("Updating UIVC ----")
    }
}

class UISegmentController: UIViewController, UIScrollViewDelegate {

    lazy var scrollView: UIScrollView = {
        let vc = UIScrollView()
        vc.delegate = self
        vc.contentSize = CGSize(width: 1000, height: view.frame.height-100)
        vc.backgroundColor = .red
        vc.isDirectionalLockEnabled = true

        return vc
    }()

    let textData: String = "Just to add onto the already great answers, you might want to add multiple labels in your project so doing all of this (setting size, style etc) will be a pain. To solve this, you can create a separate UILabel class."



    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        let textLable = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 200))
        textLable.text = textData
        scrollView.addSubview(textLable)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
