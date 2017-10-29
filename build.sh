set -o pipefail && xcodebuild test -enableCodeCoverage YES -workspace Example/GRTextField.xcworkspace -scheme GRTextField-Example -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.1' | xcpretty
pod lib lint
