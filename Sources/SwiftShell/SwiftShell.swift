	// The Swift Programming Language
	// https://docs.swift.org/swift-book

import Foundation

public enum ShellError: LocalizedError {
	case couldNotRun(String)
	case couldNotDecode(String)
	
	public var errorDescription: String? {
		switch self {
			case .couldNotRun(let command):
				"Failed to run: \(command)"
			case .couldNotDecode(let pipeData): "Could not decode \(pipeData)"
		}
	}
}

@discardableResult // Add to suppress warnings when you don't want/need a result
func shell(_ command: String, _ executablePath: String = "/bin/bash") throws -> String {
	let task = Process()
	let pipe = Pipe()

	task.standardOutput = pipe
	task.standardError = pipe
	task.arguments = ["-c", command]
	task.executableURL = URL(fileURLWithPath: executablePath)
	task.standardInput = nil
	guard let _ = try? task.run() else { throw ShellError.couldNotRun(command) }
	
	let data = pipe.fileHandleForReading.readDataToEndOfFile()
	guard let output = try? String(data: data, encoding: .utf8) else { throw ShellError.couldNotDecode(data.base64EncodedString()) }
	
	return output
}
