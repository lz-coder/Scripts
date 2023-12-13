#!/bin/bash

flutterVersion="3.16.3"
flutterFile="flutter_linux_$flutterVersion-stable.tar.xz"
flutterUrl="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$flutterFile"

androidStudioVersion="2022.3.1.21"
androidStudioFile="android-studio-$androidStudioVersion-linux.tar.gz"
androidStudioUrl="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.21/$androidStudioFile"

installDir="$HOME/.local/opt/"

echo -e "\n## Downloading Flutter ##\n"
wget $flutterUrl
echo -e "\n## Downloading Android Studio ##\n"
wget $androidStudioUrl

if [[ ! -d $installDir ]]; then
    mkdir -p $installDir
fi

echo -e "\n## Installing Flutter in $installDir ##\n"
tar -xvf ./$flutterFile -C $installDir
rm ./$flutterFile
echo -e "\n## Installing Android Studio in $installDir ##\n"
tar -xvf ./$androidStudioFile -C $installDir
rm ./$androidStudioFile

echo -e "\n## Installing VScode ##\n"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

echo -e "\n## Installing VScode Extensions ##\n"
code --install-extension Dart-Code.dart-code
code --install-extension Dart-Code.flutter
code --install-extension Google.arb-editor
code --install-extension usernamehw.errorlens
code --install-extension formulahendry.code-runner
code --install-extension vscode-icons-team.vscode-icons

echo -e "\n## Installing development packages ##\n"
sudo dnf install -y clang cmake git-core gh gtk3-devel ninja-build pkgconf-pkg-config xz-devel libstdc++-devel pinentry-gnome3 libsecret chromium gnome-themes-extra

echo -e "\n## Configuring PATH ##\n"
cat >> $HOME/.bashrc << 'EOL'

## ANDROID STUDIO && FLUTTER ##
PATH="$HOME/.local/opt/flutter/bin:$PATH"
PATH="$HOME/.local/opt/android-studio/bin:$PATH"
PATH="$HOME/.local/Android/Sdk/cmdline-tools/latest/bin:$PATH"
export JAVA_HOME="$HOME/.local/opt/android-studio/jbr"
PATH="$PATH:$JAVA_HOME"
export ANDROID_HOME="$HOME/.local/Android/Sdk"
PATH="${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export CHROME_EXECUTABLE="/bin/chromium-browser"
export PATH
EOL

echo -e "\n## Enjoy :) ##\n"
