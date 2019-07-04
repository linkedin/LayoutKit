// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

/// The main menu for the sample app.
class MenuViewController: UITableViewController {

    private let reuseIdentifier = " "

    private let viewControllers: [UIViewController.Type] = [
        BenchmarkViewController.self,
        FeedScrollViewController.self,
        FeedCollectionViewController.self,
        FeedTableViewController.self,
        StackViewController.self,
        AutoRotateStackViewController.self,
        NestedCollectionViewController.self,
        ForegroundMiniProfileViewController.self,
        BackgroundMiniProfileViewController.self,
        OverlayViewController.self,
        BatchUpdatesCollectionViewController.self,
        BatchUpdatesTableViewController.self
    ]

    convenience init() {
        self.init(style: .grouped)
        title = "Menu"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = String(describing: viewControllers[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = viewControllers[indexPath.row].init()
        viewController.title = String(describing: viewController)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
