import Bash
import Foundation
import CiFoundation
import Tasks
import Cocoapods
import Git
import SingletonHell

public final class StaticChecksTask: LocalTask {
    public let name = "StaticChecksTask"
    
    private let swiftLint: SwiftLint
    private let conditionalCompilationClausesChecker: ConditionalCompilationClausesChecker
    
    public init(
        swiftLint: SwiftLint,
        conditionalCompilationClausesChecker: ConditionalCompilationClausesChecker)
    {
        self.swiftLint = swiftLint
        self.conditionalCompilationClausesChecker = conditionalCompilationClausesChecker
    }
    
    public func execute() throws {
        try swiftLint.lint()
        try conditionalCompilationClausesChecker.checkConditionalCompilationClauses()
        
        // TODO: Check that no testing code leaks to production (if it is accidentally linked in release build)
        //       For list of frameworks that are linked in app see: Tests/Pods/Target Support Files/Pods-TestedApp/Pods-TestedApp.release.xcconfig
        //       Snapshot:
        //       - GCDWebServer
        //       - MixboxBuiltinIpc
        //       - MixboxFoundation
        //       - MixboxInAppServices
        //       - MixboxIpc
        //       - MixboxIpcCommon
        //       - MixboxIpcSbtuiHost
        //       - MixboxTestability
        //       - MixboxUiKit
        //       - SBTUITestTunnel
        //       - TestsIpc (only in test project)
    }
}
