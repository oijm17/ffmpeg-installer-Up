#!/bin/bash
##### Control Script for instaslling prerequisites #####

####PRE SETUP####
install_ruby() {
    echo " -------------- Installing Ruby -------------- "
    if [ ! -f /usr/bin/ruby ]; then
      /scripts/installruby
    fi
    return $?
}

remove_stuff() {
    rm -rf /lib/liba52*
    rm -rf /lib/libamr*
    rm -rf /lib/libavcodec*
    rm -rf /lib/libavformat*
    rm -rf /lib/libavutil*
    rm -rf /lib/libdha*
    rm -rf /lib/libfdk*
    rm -rf /lib/libopus*
    rm -rf /lib/libmp3lame*
    rm -rf /lib/libmp4v2*
    rm -rf /lib/libogg*
    rm -rf /lib/libtheora*
    rm -rf /lib/libvorbis*
    rm -rf /lib/libxvidcore.*
    rm -rf /lib/libx265*
    rm -rf /lib/libFLAC*
    rm -rf /lib/libao*
    rm -rf /lib/libvo-aacenc*
    rm -rf /lib/libvidstab*
    rm -rf /lib/libopenjp2*
    rm -rf /lib/libbluray*
    rm -rf /lib/libcaca*
    rm -rf /lib/libass*
    rm -rf /lib/libvo-amrwbenc*
    rm -rf /lib/libspeex*
    rm -rf /lib/liboggz*
    rm -rf /lib/php/modules/psstream*

    rm -rf /usr/lib/liba52*
    rm -rf /usr/lib/libamr*
    rm -rf /usr/lib/libavcodec*
    rm -rf /usr/lib/libavformat*
    rm -rf /usr/lib/libavutil*
    rm -rf /usr/lib/libdha*
    rm -rf /usr/lib/libfdk*
    rm -rf /usr/lib/libopus*
    rm -rf /usr/lib/libmp3lame*
    rm -rf /usr/lib/libmp4v2*
    rm -rf /usr/lib/libogg*
    rm -rf /usr/lib/libtheora*
    rm -rf /usr/lib/libvorbis*
    rm -rf /usr/lib/libxvidcore.*
    rm -rf /usr/lib/libx265*
    rm -rf /usr/lib/libFLAC*
    rm -rf /usr/lib/libao*
    rm -rf /usr/lib/libvo-aacenc*
    rm -rf /usr/lib/libvidstab*
    rm -rf /usr/lib/libopenjp2*
    rm -rf /usr/lib/libbluray*
    rm -rf /usr/lib/libcaca*
    rm -rf /usr/lib/libass*
    rm -rf /usr/lib/libvo-amrwbenc*
    rm -rf /usr/lib/libspeex*
    rm -rf /usr/lib/liboggz*
    rm -rf /usr/lib/php/modules/psstream*

    rm -rf /usr/local/lib/liba52*
    rm -rf /usr/local/lib/libamr*
    rm -rf /usr/local/lib/libavcodec*
    rm -rf /usr/local/lib/libavformat*
    rm -rf /usr/local/lib/libavutil*
    rm -rf /usr/local/lib/libdha*
    rm -rf /usr/local/lib/libfdk*
    rm -rf /usr/local/lib/libopus*
    rm -rf /usr/local/lib/libmp3lame*
    rm -rf /usr/local/lib/libmp4v2*
    rm -rf /usr/local/lib/libogg*
    rm -rf /usr/local/lib/libtheora*
    rm -rf /usr/local/lib/libvorbis*
    rm -rf /usr/local/lib/libxvidcore.*
    rm -rf /usr/local/lib/libx265*
    rm -rf /usr/local/lib/libFLAC*
    rm -rf /usr/local/lib/libao*
    rm -rf /usr/local/lib/libvo-aacenc*
    rm -rf /usr/local/lib/libvidstab*
    rm -rf /usr/local/lib/libopenjp2*
    rm -rf /usr/local/lib/libbluray*
    rm -rf /usr/local/lib/libcaca*
    rm -rf /usr/local/lib/libass*
    rm -rf /usr/local/lib/libvo-amrwbenc*
    rm -rf /usr/local/lib/libspeex*
    rm -rf /usr/local/lib/liboggz*
    rm -rf /usr/local/lib/php/modules/psstream.*

    rm -rf /usr/share/ffmpeg
    rm -rf /usr/local/share/ffmpeg
    rm -rf /etc/httpd/conf.d/psstream.ini

    unlink /usr/bin/ffmpeg >/dev/null 2>&1
    unlink /usr/local/bin/ffmpeg >/dev/null 2>&1
    unlink /usr/bin/mediainfo >/dev/null 2>&1
    unlink /usr/local/bin/mediainfo >/dev/null 2>&1
    unlink /bin/mplayer >/dev/null 2>&1
    unlink /usr/bin/mplayer >/dev/null 2>&1
    unlink /usr/local/bin/mplayer >/dev/null 2>&1
    unlink /bin/mencoder >/dev/null 2>&1
    unlink /usr/bin/mencoder  >/dev/null 2>&1
    unlink /usr/local/bin/mencoder >/dev/null 2>&1
    unlink /bin/flvtool2 >/dev/null 2>&1
    unlink /usr/bin/flvtool2 >/dev/null 2>&1
    unlink /usr/local/bin/flvtool2 >/dev/null 2>&1
    unlink /usr/bin/flvtool++ >/dev/null 2>&1
    unlink /usr/local/bin/flvtool++ >/dev/null 2>&1
    unlink /usr/bin/yamdi >/dev/null 2>&1
    unlink /usr/local/bin/yamdi >/dev/null 2>&1
    rm -rf /usr/local/cpffmpeg
    rm -rf $HOME/tmp
    mkdir -p $HOME/tmp

    return $?
}

run_yum() {
    echo " -------------- Running Yum -------------- "
    sed -i '/exclude/s/^/#/g' /etc/yum.conf
    yum remove -y rpmforge-release ffmpeg x264 libvpx libogg libvorbis libtheora libx264 x265 wt-cpanel-ffmpeg-php xvidcore lame* mencoder mplayer flvtool2 gpac*

    yum groupinstall "Development Tools" -y
    yum install ruby php-devel boost-devel curl-devel gcc gcc-c++ libgcc gd gd-devel gettext libogg-devel nasm opencv dbus-devel lua-devel \
    cmake mercurial libjpeg* libjpeg-devel* libstdc++* libstdc++-devel* libtiff* vorbis-tools libvpx-devel libdvdread-devel libxcb-devel \
    libtiff-devel* opus-devel* libtool* libxml* libxml2* wget ant fribidi-devel alsa-lib-devel flac flac-devel xcb-util-devel mesa-libGLU-devel \
    libxml2-devel* zlib* zlib-devel* automake* autoconf* samba-common* libvorbis-devel libao-devel pulseaudio-libs-devel libgcrypt-devel \
    ncurses-devel ncurses patch make apr-util giflib-devel giflib neon libtheora-devel qt-devel gsm-devel libbluray-devel libdvdnav-devel \
    expat-devel gettext-devel openssl-devel subversion SDL-devel freeglut-devel perl speex-devel libcaca-devel bzip2-devel libffi-devel -y
    
    #Installing third party package dependencies
    yum install epel-release -y
    yum --enablerepo=epel install libdc1394-devel zvbi yasm a52dec-devel \
    libva-devel libass-devel libkate-devel libcddb-devel libmodplug-devel -y
    
    sed -i '/exclude/s/^#//g' /etc/yum.conf
    
    rpm -ivh http://repo.bstack.net/scons/scons-1.3.1-1.noarch.rpm
    rpm -e alsa-lib --nodeps
    return 0
}

check_threads() {
    echo " -------------- Checking For Perl Compatibility -------------- "
    if ! /usr/bin/perl -e "use threads;"
    then
        if [ -f /usr/bin/perl5.10.1 ]
        then
            mv /usr/bin/perl /usr/bin/perl.old
            ln -s /usr/bin/perl5.10.1 /usr/bin/perl
        else
            cd /usr/local/src
            rm -rf ActivePerl*
            wget http://downloads.activestate.com/ActivePerl/releases/5.24.1.2402/ActivePerl-5.24.1.2402-x86_64-linux-glibc-2.15-401614.tar.gz
            tar xzf ActivePerl*
            cd ActivePerl*
            sh install.sh --license-accepted --prefix /opt/wt-perl/ --no-install-html
            mv /usr/bin/perl /usr/bin/perl.old
            ln -s /opt/wt-perl/bin/perl-static /usr/bin/perl
        fi
    fi
    
    return $?
}

#Git client
install_git() {
    echo " -------------- Installing Git (If Necessary) -------------- "
    cd $DOWNDIR
    if ! hash git 2>/dev/null
    then
        if [ -f /usr/local/cpanel/3rdparty/bin/git ]
        then
            alias git=/usr/local/cpanel/3rdparty/bin/git
        else 
            cd $DOWNDIR
            rm -vrf git-master
            yum -y install expat-devel gettext-devel openssl-devel zlib-devel
            wget -N https://github.com/git/git/archive/master.tar.gz
            tar -xzvf master.tar.gz
            cd git-master
            make prefix=/usr/local all
            make prefix=/usr/local install
        fi
    fi
    return $?
}
