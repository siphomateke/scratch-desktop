#!/bin/sh

pkgname="scratch-desktop"
pkgver=3.11.1
arch=amd64
tmpdir="/tmp/scratch-desktop"
srcdir="$tmpdir/electron"
destdir=$PWD

install_dependencies() {
    apt install p7zip nodejs wget
    npm install -g electron@^6 electron-installer-debian --unsafe-perm=true
}

prepare() {
    mkdir -p "$tmpdir"
    mkdir -p "$srcdir"
    
    # Copy Electron deb build config
    cp ./electron-deb-config.json "$srcdir"
    
    cd "$tmpdir"
    # Download installer
    wget "https://downloads.scratch.mit.edu/desktop/Scratch%20Desktop%20Setup%20$pkgver.exe" -O "$pkgname-$pkgver-setup.exe"
    # Extract app from installer
    7z x -so $pkgname-$pkgver-setup.exe "\$PLUGINSDIR/app-32.7z" > app-32.7z
    # Extract app archive
    7z x -y -bsp0 -bso0 app-32.7z -o$srcdir
    rm ./app-32.7z
    
    cd "$srcdir"
    
    # Fix permissions
    chmod 755 locales
    chmod 755 swiftshader
    chmod 755 resources
    chmod 755 resources/static
    chmod 755 resources/static/assets
    
    # Download icon
    wget -c -O resources/icon.png 'https://scratch.mit.edu/images/download/icon.png'
    
    # TODO: Remove all DLL and exe files
    
    # Add Linux Electron files
    cp -rf /usr/lib/node_modules/electron/dist/* ./
    ln -fsr electron scratch-desktop
}

package() {
    cd "$srcdir"
    electron-installer-debian --config ./electron-deb-config.json --dest $destdir --arch $arch
    rm -r $tmpdir
}

install_dependencies && prepare && package
echo "Successfully created installer for Scratch Desktop $pkgver!"
