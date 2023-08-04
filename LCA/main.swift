//
//  main.swift
//  LCA
//
//  Created by Ts SaM on 4/8/2023.
//

import Foundation

struct Edge {
    let from: Int
    let to: Int
}

class Graph {}

func solution() {
    
    let N = Int(readLine()!)!
    var edges: [Edge] = []
    
    for _ in 1..<N {
        let edgeNums = readLine()!.split(separator: " ").compactMap({ Int($0) })
        edges.append(Edge(from: edgeNums[0], to: edgeNums[1]))
    }
    
    let M = Int(readLine()!)!
    var pairs: [[Int?]] = []
    
    for _ in 0..<M {
        let pairNums = readLine()!.split(separator: " ").compactMap({ Int($0) })
        pairs.append(pairNums)
    }
    
    
    let result = helper1(N, edges, M, pairs)
    
    print("Sample Output : ")
    for lca in result {
        print(lca)
    }
}


func helper1(_ n: Int, _ edges: [Edge], _ m: Int, _ pairs: [[Int?]]) -> [Int] {
    
    var parent: [Int] = Array(repeating: 0, count: n + 1)
    var visited: [Bool] = Array(repeating: false, count: n + 1)
    var graph: [[Int]] = Array(repeating: [], count: n + 1)
    
    for edge in edges {
//        print("from : \(edge.from) -- to : \(edge.to)")
        let u = edge.from
        let v = edge.to
        graph[u].append(v)
        graph[v].append(u)
    }
    
    let queue = Queue<Int>()
    queue.enqueue(item: 1)
    visited[1] = true
    parent[1] = 0
    
    while !queue.isEmpty() {
        let node = queue.dequeue()!
        for child in graph[node] {
//            print("node : \(node)")
            if !visited[child] {
                visited[child] = true
                parent[child] = node
                queue.enqueue(item: child)
//                print(queue.description);
            }
        }
    }
    
    
    func findNode(_ u: Int, _ v: Int) -> Int {
        var ancestors = Set<Int>()
        var i = u
        
        while i != 0 {
//            print(i)
            ancestors.insert(i)
            i = parent[i]
        }
        
        i = v
        while !ancestors.contains(i) {
            i = parent[i]
        }
        
        return i
    }
    
    var result: [Int] = []
    
    for pair in pairs {
        let lca = findNode(pair[0]!, pair[1]!)
        result.append(lca)
    }
    
    return result
}

solution()
