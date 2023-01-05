macos:
	@cargo build --release --lib --target aarch64-apple-darwin
	@cargo build --release --lib --target x86_64-apple-darwin
	@cargo +nightly build -Z build-std --release --lib --target aarch64-apple-ios-macabi
	@cargo +nightly build -Z build-std --release --lib --target x86_64-apple-ios-macabi
	@$(RM) -rf libs/libmunchausen-macos.a
	@$(RM) -rf libs/libmunchausen-maccatalyst.a
	@lipo -create -output libs/libmunchausen-macos.a \
		target/aarch64-apple-darwin/release/libmunchausen.a \
		target/x86_64-apple-darwin/release/libmunchausen.a
	@lipo -create -output libs/libmunchausen-maccatalyst.a \
		target/aarch64-apple-ios-macabi/release/libmunchausen.a \
		target/x86_64-apple-ios-macabi/release/libmunchausen.a

ios:
	@cargo build --release --lib --target aarch64-apple-ios
	@cargo build --release --lib --target aarch64-apple-ios-sim
	@cargo build --release --lib --target x86_64-apple-ios
	@$(RM) -rf libs/libmunchausen-ios.a
	@$(RM) -rf libs/libmunchausen-ios-sim.a
	@cp target/aarch64-apple-ios/release/libmunchausen.a libs/libmunchausen-ios.a
	@lipo -create -output libs/libmunchausen-ios-sim.a \
		target/aarch64-apple-ios-sim/release/libmunchausen.a \
		target/x86_64-apple-ios/release/libmunchausen.a
