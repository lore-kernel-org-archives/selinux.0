Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0N70uRb013013
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 02:00:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0N70tCa027275
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 07:00:55 GMT
Received: from twilight.cs.hut.fi (twilight.cs.hut.fi [130.233.40.5])
        by jazzband.ncsc.mil  with ESMTP id i0N70sVC027272 for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 07:00:55 GMT
Date: Fri, 23 Jan 2004 09:00:39 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: selinux@tycho.nsa.gov
Subject: libselinux upgrade from 1.4-1 to 1.4-6 broke installwatch.so
Message-ID: <20040123070039.GE11115051@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

CheckInstall is a product that monitors software installation ("make
install" for instance) and records the copied files. Using this information,
it creates an RPM, DEP or slackware package. It includes installwatch.so
that is used with preloading (LD_PRELOAD=/usr/local/lib/installwatch.so) for
the actual monitoring.  See:
http://asic-linux.com.mx/~izto/checkinstall/index.php

Basically everything that depends on /lib/libselinux.so.1 (things like cp,
mkdir, mv etc etc) no longer work on Fedora Core devel installation when
run with LD_PRELOAD=/usr/local/lib/installwatch.so. The result is
segmentation fault.

I traced it back to upgrade from libselinux-1.4-1 to libselinux-1.4-6:

 root@babbage:/>rpm -q checkinstall glibc coreutils libselinux
 checkinstall-1.5.3-1
 glibc-2.3.3-1
 coreutils-5.0-35
 libselinux-1.4-1
 root@babbage:/>LD_PRELOAD=/usr/local/lib/installwatch.so cp /etc/issue
 /tmp/FOOO
 root@babbage:/>^D
 root@babbage:/backup-versioned>chroot 2003-12-21T052000 
 root@babbage:/>rpm -q checkinstall glibc coreutils libselinux
 checkinstall-1.5.3-1
 glibc-2.3.3-1
 coreutils-5.0-35
 libselinux-1.4-6
 root@babbage:/>LD_PRELOAD=/usr/local/lib/installwatch.so cp /etc/issue
 /tmp/FOOO
 zsh: segmentation fault  LD_PRELOAD=/usr/local/lib/installwatch.so cp
 /etc/issue /root/FOOO

So with libselinux-1.4-1, it works, with 1.4-6 is broken. I tried
tried building checkinstall-1.6.0beta3 from source, but its installwatch.so
shows the same behaviour.

I'm running a kernel (2.4.21-jam1+security_fixes) that doesn't include
selinux fwiw. Nothing else wrt. glibc, coreutils or libselinux seems broken
on this installation.

I tried copying the libselinux-1.4-1 versions of lib/libselinux.so.1 to
/lib, and this fixes the current installation
wrt. checkinstall. So it is really libselinux that makes the
difference (/bin/cp does depend on other libraries, too).

Also, I added this bug to redhat bugzilla:
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=114067

So if anybody is interested enough, comments can be added there, too.

 
-- v --

v@iki.fi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
