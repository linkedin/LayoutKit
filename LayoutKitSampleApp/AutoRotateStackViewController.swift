// Copyright 2018 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit
import LayoutKit

class AutoRotateStackViewController: UIViewController {

    private var autoRotateStackLayout: AutoRotateStackLayout<View>?

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.white

        let helloWorldLayout1 = ButtonLayout(type: .system, title: "Hello World! ");
        let helloWorldLayout2 = ButtonLayout(type: .system, title: "Hello World! ");
        let helloWorldLayout3 = ButtonLayout(type: .system, title: "Hello World! ");
        let helloWorldLayout4 = ButtonLayout(type: .system, title: "Hello World! ");
        let helloWorldLayout5 = ButtonLayout(type: .system, title: "Hello World! ");

        let autoRotateStackLayout = AutoRotateStackLayout(sublayouts: [
            helloWorldLayout1,
            helloWorldLayout2,
            helloWorldLayout3,
            helloWorldLayout4,
            helloWorldLayout5
            ])
        autoRotateStackLayout.arrangement(width: view.frame.width).makeViews(in: view)
        self.autoRotateStackLayout = autoRotateStackLayout
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let autoRotateStackLayout = autoRotateStackLayout {
            autoRotateStackLayout.arrangement(width: view.frame.width).makeViews(in: view)
        }
    }

}
