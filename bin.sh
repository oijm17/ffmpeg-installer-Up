#!/bin/bash

ERROR=0

install_ffmpeg() {
    echo " -------------- Installing FFmpeg + Presets -------------- "
    cd $DOWNDIR
    rm -vrf FFmpeg-master
    wget -N https://github.com/FFmpeg/FFmpeg/archive/master.zip -O ffmpeg.zip
    unzip ffmpeg.zip
    cd FFmpeg-master/
    wget -N http://mirror.ffmpeginstaller.com/source/presets/presets.tar.gz
    tar -xvzf presets.tar.gz
    export PKG_CONFIG_PATH=/usr/lib/pkgconfig:$PKG_CONFIG_PATH
    ./configure --prefix=/usr --enable-shared --enable-nonfree --enable-libcaca --enable-demuxer=flac --enable-muxer=flac \
    --enable-gpl --enable-pthreads --enable-decoder=liba52 --enable-libvidstab --enable-libopenjpeg \
    --enable-libfdk-aac --enable-libopus --enable-libmp3lame --enable-libbluray --enable-libass --enable-libvo-amrwbenc \
    --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid --enable-libx265 --enable-parser=flac \
    --extra-cflags=-I/usr/include/ --extra-ldflags=-L/usr/lib --enable-runtime-cpudetect --enable-decoder=flac \
    --enable-version3 --extra-version=syslint --enable-libopencore-amrnb --enable-encoder=flac --enable-libfreetype \
    --enable-libopencore-amrwb --enable-avfilter --enable-libvpx --enable-libspeex || local ERROR=1
    make || local ERROR=1
    make tools/qt-faststart || local ERROR=1
    make install $DESTDIR || local ERROR=1
    cp -vf tools/qt-faststart /usr/bin/
    ldconfig

    return $ERROR
}

install_mediainfo() {
    echo " -------------- Installing Medianfo -------------- "
    cd $DOWNDIR
    rm -vrf mplayer-*
    sudo rpm -ivh http://mediaarea.net/download/binary/libzen0/0.4.32/libzen0-0.4.32.x86_64.CentOS_7.rpm || local ERROR=0
    sudo rpm -ivh http://mediaarea.net/download/binary/libmediainfo0/0.7.80/libmediainfo0-0.7.80.x86_64.CentOS_7.rpm || local ERROR=0
    sudo rpm -ivh http://mediaarea.net/download/binary/mediainfo/0.7.80/mediainfo-0.7.80.x86_64.CentOS_7.rpm || local ERROR=0

    return $ERROR
}

install_mplayer() {
    echo " -------------- Installing MPlayer -------------- "
    cd $DOWNDIR
    rm -vrf mplayer-*
    wget -N http://mplayerhq.hu/MPlayer/releases/MPlayer-1.3.0.tar.gz
    tar -xzvf MPlayer-1.3.0.tar.gz
    cd MPlayer-1.3.0
    sed -i 1521d configure
    ./configure --prefix=/usr --codecsdir=/usr/lib/codecs \
    --extra-cflags=-I/usr/include/ --extra-ldflags=-L/usr/lib \
    --confdir=/usr/etc/mplayer || local ERROR=1
    make || local ERROR=1
    make install $DESTDIR || local ERROR=1
    cp -f etc/codecs.conf /usr/etc/mplayer/codecs.conf

    return $ERROR
}

install_mp4box() {
    echo " -------------- Installing MP4Box -------------- "
    cd $DOWNDIR
    rm -rf gpac
    svn co https://github.com/gpac/gpac/trunk gpac
    cd gpac/
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    #./configure --prefix=/usr --extra-cflags=-I/usr/include/ \
    #--extra-ldflags=-L/usr/lib --disable-wx --strip
    make || local ERROR=1
    make install $DESTDIR  || local ERROR=1
    
    return $ERROR
}

install_flvtool2() {
    echo " -------------- Installing FlvTool2 -------------- "
    cd $DOWNDIR
    rm -vrf flvtool2
    git clone https://github.com/unnu/flvtool2.git flvtool2
    cd flvtool2
    ruby setup.rb config || local ERROR=1
    ruby setup.rb setup || local ERROR=1
    ruby setup.rb install || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_flvtoolpp() {
    echo " -------------- Installing FlvTool++ -------------- "
    cd $DOWNDIR
    rm -vrf flvtool++
    mkdir -pv flvtool++
    chown -R root.root flvtool++
    cd flvtool++
    wget -N http://repo.bstack.net/flvtool++/flvtool++-1.2.1.tar.gz
    tar zxf flvtool++-1.2.1.tar.gz
    scons
    cp -vrf flvtool++ /usr/bin
    
    ldconfig
    return $ERROR
}

install_yamdi() {
    echo " -------------- Installing Yamdi -------------- "
    cd $DOWNDIR
    rm -vrf yamdi-1.9
    wget -N https://downloads.sourceforge.net/project/yamdi/yamdi/1.9/yamdi-1.9.tar.gz
    tar -zxvf yamdi-1.9.tar.gz
    cd yamdi-1.9
    gcc yamdi.c -o yamdi -O2 -Wall  -D_FILE_OFFSET_BITS=647 || local ERROR=1
    mv -vf yamdi /usr/bin/
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_ffmpegphp() {
    echo " -------------- Installing FFmpeg-Php -------------- "
    cd $DOWNDIR
    rm -rfv ffmpeg-php
    git clone https://github.com/tony2001/ffmpeg-php.git
    cd ffmpeg-php
    phpize
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1


    if grep -q "^extension=ffmpeg.so" /usr/local/lib/php.ini
    then
      echo "Extension already enabled in php.ini, ignoring"
    else
      echo "Installing extension in php.ini"
      echo "extension=ffmpeg.so" >> /usr/local/lib/php.ini
      php -m | grep ffmpeg
      /etc/init.d/httpd restart
    fi
    
    return $ERROR
}
