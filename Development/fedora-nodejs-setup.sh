#!/bin/bash

echo -e "\nInstalling VSCodium\n"
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install -y codium

echo -e "\nInstalling Codium extensions\n"
codium --install-extension dbaeumer.vscode-eslint
codium --install-extension PKief.material-icon-theme
codium --install-extension ecmel.vscode-html-css
codium --install-extension xabikos.JavaScriptSnippets
codium --install-extension christian-kohler.path-intellisense
codium --install-extension DigitalBrainstem.javascript-ejs-support
codium --install-extension phoenisx.cssvar
codium --install-extension pranaygp.vscode-css-peek
codium --install-extension Zignd.html-css-class-completion


echo -e "\nInstalling dev packages\n"
sudo dnf install -y gh nodejs

echo -e "\nInstalling extra packages\n"
sudo dnf install -y google-droid-fonts-all
