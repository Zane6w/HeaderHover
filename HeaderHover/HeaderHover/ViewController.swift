//
//  ViewController.swift
//  HeaderHover
//
//  Created by zhi zhou on 2017/5/3.
//  Copyright © 2017年 zhi zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let headerView = UIView()
    var originalOffsetY: CGFloat = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Header Hover"
        
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension ViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if originalOffsetY != -1 {
            if offsetY < originalOffsetY {
                headerView.frame.origin.y = offsetY - originalOffsetY - headerView.bounds.height
            }
        }
    }
    
}


extension ViewController {
    
    func setupTableView() {
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        
        let headerHeight: CGFloat = 200
        headerView.frame = CGRect(x: 0, y: -headerHeight, width: tableView.bounds.width, height: headerHeight)
        
        let imageView = UIImageView(frame: headerView.bounds)
        imageView.image = #imageLiteral(resourceName: "headerImage")
        headerView.addSubview(imageView)
        
        tableView.addSubview(headerView)
        
        
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        
        self.view.addSubview(tableView)
        
        if let navBar = navigationController?.navigationBar {
            originalOffsetY = -navBar.frame.maxY + tableView.contentOffset.y
        } else {
            originalOffsetY = tableView.contentOffset.y
        }
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}













