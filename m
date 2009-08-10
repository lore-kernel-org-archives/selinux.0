Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7AIRr6Q011456
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 14:27:53 -0400
Received: from mail-yx0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7AIROTv003174
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 18:27:24 GMT
Received: by yxe7 with SMTP id 7so3786641yxe.32
        for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 11:27:52 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 10 Aug 2009 11:27:52 -0700
Message-ID: <dd18b0c30908101127m38999d83h655a0e58751138cf@mail.gmail.com>
Subject: compiling SELinux in xserver seems to not find /lib64
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

seems I'm hitting this error while building
the xserver:(with enabling selinux)

make[4]: *** No rule to make target `-lselinux', needed by `Xorg'.  Stop.

here's how I compiled the xserver:


 ./configure --enable-install-setuid
--with-dri-driver-path="/usr/lib64/xorg/modules/dri"
--with-fontdir="/usr/share/fonts"  --with-log-dir=/var/log
--enable-secure-rpc --enable-xcsecurity --enable-xselinux
--enable-config-dbus --prefix=/usr --libdir=/usr/lib64
--sysconfdir=/etc --localstatedir=/var LDFLAGS=-L/lib64 LIBS=-L/lib64
CFLAGS=" -m64 -mtune=core2 -march=core2 -mfpmath=both  -O2 -pipe
-fomit-frame-pointer -fstack-protector" CXXFLAGS="${CFLAGS}"
MAKEOPTS="{-j3}" PKG_CONFIG_PATH=/usr/lib64/pkgconfig LDFLAGS=-L/lib64
LIBS=-L/lib64

even giving this twice seems to make no difference.
LDFLAGS=-L/lib64 LIBS=-L/lib64

any ideas?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
