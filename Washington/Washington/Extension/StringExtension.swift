//
//  StringExtension.swift
//  Washington
//
//  Created by Bob on 2021/10/9.
//  Copyright © 2021年 None. All rights reserved.
//

import Foundation

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
}

