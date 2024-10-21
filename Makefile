deploy:
	flutter clean
	flutter pub get
	cd ios && pod install
	cd ..

release:
	flutter build appbundle

freezed:
	flutter pub run build_runner build --delete-conflicting-outputs