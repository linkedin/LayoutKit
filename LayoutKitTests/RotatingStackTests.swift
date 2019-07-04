// Copyright 2018 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import XCTest
@testable import LayoutKit

class RotatingStackTests: XCTestCase {

    func testVerticalAlignment() {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 64.0))
        let stack = AutoRotateStackLayout<UIButton>(
            sublayouts: [
                ButtonLayout(type: .system, title: "Hello World! "),
                ButtonLayout(type: .system, title: "Hello One! "),
                ButtonLayout(type: .system, title: "Hello Two! "),
                ButtonLayout(type: .system, title: "Hello Three! "),
                ButtonLayout(type: .system, title: "Hello Four! "),
                ButtonLayout(type: .system, title: "Hello Five! "),
                ButtonLayout(type: .system, title: "Hello All! ")
            ])
        stack.arrangement(width: view.frame.width).makeViews(in: view)

        // Since `StackLayout` do not conform to `Equatable`, we are checking equality of the object (pointers).
        XCTAssertTrue(stack.stackLayoutToUse === stack.verticalStackLayout)
    }

    func testHorizontalAlignment() {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 64.0))
        let stack = AutoRotateStackLayout<UIButton>(
            sublayouts: [
                ButtonLayout(type: .system, title: "Hello World! "),
                ButtonLayout(type: .system, title: "Hello All! ")
            ])
        stack.arrangement(width: view.frame.width).makeViews(in: view)

        // Since `StackLayout` do not conform to `Equatable`, we are checking equality of the object (pointers).
        XCTAssertTrue(stack.stackLayoutToUse === stack.horizontalStackLayout)
    }
}
