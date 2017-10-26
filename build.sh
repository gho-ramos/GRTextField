set -o pipefail && xcodebuild test -enableCodeCoverage YES -workspace Example/GRTextField.xcworkspace -scheme GRTextField-Example -destination 'platform=iOS Simulator,name=iPhone 5s,OS=11.0' | xcpretty
pod lib lint
