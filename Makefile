# build_runner 파일 자동 생성을 위한 watch
watch:
	dart run build_runner watch

# 기존 생성 파일 삭제 후 새로 생성
build:
	dart run build_runner build --delete-conflicting-outputs

# 한번만 생성
build-once:
	dart run build_runner build

# ios 빌드&클린
ios-build:
	flutter clean
	flutter pub get
	cd ios && pod install
	cd ..

clean:
	flutter clean
	flutter pub get

# android 빌드&클린
aos-release:
	flutter build appbundle --release --dart-define=ENVIRONMENT=PRODUCTION --flavor=prod