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


import Introspect
import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension ScrollView {
    /// Creates a ScrollView with a ScrollViewReader
    public init<ProxyContent: View>(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, @ViewBuilder content: @escaping (ScrollViewProxy) -> ProxyContent) where Content == ScrollViewReader<ProxyContent> {
        self.init(axes, showsIndicators: showsIndicators, content: {
            ScrollViewReader(content: content)
        })
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    /// Adds an ID to this view so you can scroll to it with `ScrollViewProxy.scrollTo(_:alignment:animated:)`
    public func scrollId<ID: Hashable>(_ id: ID) -> some View {
        modifier(ScrollViewProxyPreferenceModifier(id: id))
    }
    
    @available(swift, obsoleted: 1.0, renamed: "scrollId(_:)")
    public func id<ID: Hashable>(_ id: ID, scrollView: ScrollViewProxy) -> some View { self }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ScrollViewProxyPreferenceData: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    var geometry: GeometryProxy
    var id: AnyHashable
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ScrollViewProxyPreferenceKey: PreferenceKey {
    static var defaultValue: [ScrollViewProxyPreferenceData] { [] }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ScrollViewProxyPreferenceModifier: ViewModifier {
    let id: AnyHashable
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(
                key: ScrollViewProxyPreferenceKey.self,
                value: [.init(geometry: geometry, id: self.id)]
            )
        })
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ScrollViewReader<Content: View>: View {
    private var content: (ScrollViewProxy) -> Content

    @State private var proxy = ScrollViewProxy()
    
    public init(@ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
        self.content = content
    }

    public var body: some View {
        content(proxy)
            .coordinateSpace(name: proxy.space)
            .transformPreference(ScrollViewProxyPreferenceKey.self) { preferences in
                preferences.forEach { preference in
                    self.proxy.save(geometry: preference.geometry, for: preference.id)
                }
            }
            .onPreferenceChange(ScrollViewProxyPreferenceKey.self) { _ in
                // seems this will not be called due to ScrollView/Preference issues
                // https://stackoverflow.com/a/61765994/3019595
            }
            .introspectScrollView { self.proxy.coordinator.scrollView = $0 }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ScrollViewProxy {
    fileprivate class Coordinator {
        var frames = [AnyHashable: CGRect]()
        weak var scrollView: UIScrollView?
    }
    fileprivate var coordinator = Coordinator()
    fileprivate var space: UUID = UUID()

    fileprivate init() {}

    /// Scrolls to an edge or corner
    public func scrollTo(_ alignment: Alignment, animated: Bool = true) {
        guard let scrollView = coordinator.scrollView else { return }

        let contentRect = CGRect(origin: .zero, size: scrollView.contentSize)
        let visibleFrame = frame(contentRect, with: alignment)
        scrollView.scrollRectToVisible(visibleFrame, animated: animated)
    }

    /// Scrolls the view with ID to an edge or corner
    public func scrollTo<ID: Hashable>(_ id: ID, alignment: Alignment = .top, animated: Bool = true) {
        guard let scrollView = coordinator.scrollView else { return }
        guard let cellFrame = coordinator.frames[id] else {
            return print("ID (\(id)) not found, make sure to add views with `.id(_:scrollView:)`")
        }

        let visibleFrame = frame(cellFrame, with: alignment)
        scrollView.scrollRectToVisible(visibleFrame, animated: animated)
    }

    private func frame(_ frame: CGRect, with alignment: Alignment) -> CGRect {
        guard let scrollView = coordinator.scrollView else { return frame }

        var visibleSize = scrollView.visibleSize
        visibleSize.width -= scrollView.adjustedContentInset.horizontal
        visibleSize.height -= scrollView.adjustedContentInset.vertical

        var origin = CGPoint.zero
        switch alignment {
        case .center:
            origin.x = frame.midX - visibleSize.width / 2
            origin.y = frame.midY - visibleSize.height / 2
        case .leading:
            origin.x = frame.minX
            origin.y = frame.midY - visibleSize.height / 2
        case .trailing:
            origin.x = frame.maxX - visibleSize.width
            origin.y = frame.midY - visibleSize.height / 2
        case .top:
            origin.x = frame.midX - visibleSize.width / 2
            origin.y = frame.minY
        case .bottom:
            origin.x = frame.midX - visibleSize.width / 2
            origin.y = frame.maxY - visibleSize.height
        case .topLeading:
            origin.x = frame.minX
            origin.y = frame.minY
        case .topTrailing:
            origin.x = frame.maxX - visibleSize.width
            origin.y = frame.minY
        case .bottomLeading:
            origin.x = frame.minX
            origin.y = frame.maxY - visibleSize.height
        case .bottomTrailing:
            origin.x = frame.maxX - visibleSize.width
            origin.y = frame.maxY - visibleSize.height
        default:
            fatalError("Not implemented")
        }

        origin.x = max(0, min(origin.x, scrollView.contentSize.width - visibleSize.width))
        origin.y = max(0, min(origin.y, scrollView.contentSize.height - visibleSize.height))
        return CGRect(origin: origin, size: visibleSize)
    }

    fileprivate func save(geometry: GeometryProxy, for id: AnyHashable) {
        coordinator.frames[id] = geometry.frame(in: .named(space))
    }
}

extension UIEdgeInsets {
    /// top + bottom
    var vertical: CGFloat {
        return top + bottom
    }
    /// left + right
    var horizontal: CGFloat {
        return left + right
    }
}
