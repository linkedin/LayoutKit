// Copyright 2018 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

/**
 A layout that stacks sublayouts along the horizontal axis by default.
 If there is not enough space available along the horizontal axis, then it stacks all sublayouts along the vertical axis.
 */
open class AutoRotateStackLayout<V: View>: BaseLayout<V> {

    let horizontalStackLayout: StackLayout<V>
    let verticalStackLayout: StackLayout<V>

    var stackLayoutToUse: StackLayout<V>

    public init(spacing: CGFloat = 0,
                distribution: StackLayoutDistribution = .fillFlexing,
                alignment: Alignment = .fill,
                flexibility: Flexibility = .inflexible,
                viewReuseId: String? = nil,
                sublayouts: [Layout],
                config: ((V) -> Void)? = nil) {
        horizontalStackLayout = StackLayout(
            axis: .horizontal,
            spacing: spacing,
            distribution: distribution,
            alignment: alignment,
            flexibility: flexibility,
            viewReuseId: viewReuseId,
            sublayouts: sublayouts,
            config: config)

        verticalStackLayout = StackLayout(
            axis: .vertical,
            spacing: spacing,
            distribution: distribution,
            alignment: alignment,
            flexibility: flexibility,
            viewReuseId: viewReuseId,
            sublayouts: sublayouts,
            config: config)

        stackLayoutToUse = horizontalStackLayout

        super.init(alignment: alignment, flexibility: flexibility, viewReuseId: viewReuseId, config: config)
    }
}

extension AutoRotateStackLayout: ConfigurableLayout {

    public func measurement(within maxSize: CGSize) -> LayoutMeasurement {
        // Prioritize using the StackLayout with .horizontal axis. Use StackLayout with .vertical axis only if the horizontal StackView does not fit in the available width.
        let horizontalStackMeasurement = horizontalStackLayout.measurement(within: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        stackLayoutToUse = horizontalStackMeasurement.size.width > maxSize.width ? verticalStackLayout : horizontalStackLayout

        return stackLayoutToUse.measurement(within: maxSize)
    }

    public func arrangement(within rect: CGRect, measurement: LayoutMeasurement) -> LayoutArrangement {
        return stackLayoutToUse.arrangement(within: rect, measurement: measurement)
    }
}
