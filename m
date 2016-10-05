Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u957T59K022394
 for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2016 03:29:06 -0400
Received: by mail-pa0-f53.google.com with SMTP id ry6so6076873pac.3
 for <selinux@tycho.nsa.gov>; Wed, 05 Oct 2016 00:28:39 -0700 (PDT)
Received: from localhost ([2404:e800:e600:540:e4c7:e123:7bab:ce0b])
 by smtp.gmail.com with ESMTPSA id y11sm60429610pfa.4.2016.10.05.00.28.36
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Oct 2016 00:28:37 -0700 (PDT)
Date: Wed, 5 Oct 2016 15:28:34 +0800
From: Jason Zaman <jason@perfinion.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: restorecon -r goes up the tree?
Message-ID: <20161005072834.GA8208@meriadoc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hey all,

There have been a few changes to restorecon just before RC1 and it
appears to not stay in the dir it was pointed at anymore?

meriadoc ~ # mount | grep "/dev"
udev on /dev type devtmpfs (rw,nosuid,relatime,seclabel,size=10240k,nr_inodes=1521608,mode=755)
devpts on /dev/pts type devpts (rw,relatime,seclabel,gid=5,mode=620,ptmxmode=000)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime,seclabel)
shm on /dev/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,seclabel)

meriadoc ~ # restorecon -rv /dev/
Warning no default label for /run/sm-notify.pid
Warning no default label for /run/cgmanager/fs
Warning no default label for /run/user/1000/dconf
Warning no default label for /run/user/1000/dconf/user
Warning no default label for /run/user/1000/gvfs
Warning no default label for /run/lightdm.pid
Warning no default label for /run/dbus.pid
^C

I'd already run restorecon so this output isnt as verbose as it was
before (scrollback fell off). But the first time it was also going into
/usr and /lib and many other places that are not /dev. /dev and /run are
also separate mountpoints so its not just that its doing the entire
rootfs or something cuz if that was the case it would stay in /dev.
Also "/dev" vs "/dev/" makes no difference.

-- Jason
