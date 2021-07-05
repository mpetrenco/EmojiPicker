//
//  Array+Additions.swift
//  HabitApp
//
//  Created by Mihai Petrenco on 6/27/21.
//

import Foundation

extension Array {
    
    /**
     * A convenience method that splits an array into subarrays with a specified element count.
     *
     * - Parameter size: - the size of the subarrays.
     * - Returns: An array of the split sub-arrays.
     *
     * **Example:**
     * For a `size` of `4`, we get:
     * [1, 2, 3, 4, 5, 6, 7, 8, 9] => [1, 2, 3, 4], [5, 6, 7, 8], [9]
     */
    func split(by size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}
