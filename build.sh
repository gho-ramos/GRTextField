set -o pipefail && xcodebuild test -enableCodeCoverage YES -workspace Example/GRTextField.xcworkspace -scheme GRTextField-Example -destination 'platform=iOS Simulator,name=iPhone 5,OS=10.0' | xcpretty
pod lib lint
