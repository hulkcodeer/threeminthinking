deploy:
	flutter clean
	flutter pub get
	cd ios && pod install
	cd ..

release:
	flutter build appbundle
