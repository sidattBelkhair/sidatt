#!/bin/bash

# 🚀 Script de Build Multi-Plateforme pour Sidatt Portfolio

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   Sidatt Portfolio - Multi-Platform Build Script${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"

# Functions
clean_project() {
    echo -e "${YELLOW}🧹 Cleaning project...${NC}"
    flutter clean
    flutter pub get
    echo -e "${GREEN}✅ Project cleaned${NC}"
}

build_web() {
    echo -e "${YELLOW}🌐 Building for Web...${NC}"
    flutter build web --release --web-renderer html
    echo -e "${GREEN}✅ Web build complete!${NC}"
    echo -e "${BLUE}📁 Output: build/web${NC}"
}

build_android() {
    echo -e "${YELLOW}📱 Building for Android...${NC}"
    
    if [ ! -f "android/key.properties" ]; then
        echo -e "${RED}❌ Error: android/key.properties not found${NC}"
        echo -e "${YELLOW}To create signing key:${NC}"
        echo "keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload-key"
        exit 1
    fi
    
    flutter build appbundle --release
    echo -e "${GREEN}✅ Android build complete!${NC}"
    echo -e "${BLUE}📁 Output: build/app/outputs/bundle/release/app-release.aab${NC}"
}

build_ios() {
    echo -e "${YELLOW}🍎 Building for iOS...${NC}"
    
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo -e "${RED}❌ Error: iOS build requires macOS${NC}"
        exit 1
    fi
    
    flutter build ios --release
    echo -e "${GREEN}✅ iOS build complete!${NC}"
    echo -e "${BLUE}📁 Open with Xcode: open ios/Runner.xcworkspace${NC}"
}

run_tests() {
    echo -e "${YELLOW}🧪 Running tests...${NC}"
    flutter test
    echo -e "${GREEN}✅ Tests passed!${NC}"
}

show_menu() {
    echo ""
    echo -e "${BLUE}Select build target:${NC}"
    echo "1) Clean project"
    echo "2) Build Web"
    echo "3) Build Android"
    echo "4) Build iOS"
    echo "5) Run Tests"
    echo "6) Build All (Web + Android)"
    echo "7) Exit"
    echo ""
}

# Main script
while true; do
    show_menu
    read -p "Enter choice [1-7]: " choice
    
    case $choice in
        1)
            clean_project
            ;;
        2)
            build_web
            ;;
        3)
            build_android
            ;;
        4)
            build_ios
            ;;
        5)
            run_tests
            ;;
        6)
            clean_project
            build_web
            build_android
            echo -e "${GREEN}✅ All builds complete!${NC}"
            ;;
        7)
            echo -e "${GREEN}👋 Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac
done
