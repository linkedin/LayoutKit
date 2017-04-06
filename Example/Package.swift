// Copyright 2017 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "LayoutKitSampleApp",
    dependencies: [
        .Package(url: "https://github.com/linkedin/LayoutKit.git", majorVersion: 4),
    ]
)
