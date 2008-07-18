Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6I0eYwg032370
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 20:40:34 -0400
Received: from arlo.cse.psu.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6I0eVJc016530
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 00:40:34 GMT
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
From: Mohamed Hassan <mhassan@cse.psu.edu>
To: Willis Vandevanter <vandevwa@jmu.edu>
Cc: selinux@tycho.nsa.gov, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        ynakam@hitachisoft.jp
In-Reply-To: <4c63b15c0807152215p271dc8e6m1854ab006245b35@mail.gmail.com>
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com>
	 <487D46B5.9070608@ak.jp.nec.com>
	 <4c63b15c0807152215p271dc8e6m1854ab006245b35@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 20:40:12 -0400
Message-Id: <1216341612.6120.1.camel@cairo>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Willis,
We were working on porting SELinux on OopenMoko as part of our research
here at Penn State. We successfully got SELinux to work on the phone.

You can try enabling extended attributes (xattr) in jffs2. This will
require recompiling mtd-utils-native with selinux support (libacl and
libattr is required by mtd) 

Modify bitbake.conf to flash the phone with selinux enabled jffs2
Here is the batch
http://www.cse.psu.edu/~mhassan/openmoko_se/bitbake-conf-selinux.patch

You can also check our init patch at
http://www.cse.psu.edu/~mhassan/openmoko_se/sysvinit-selinux.patch

Hope this will help.

Thanks,
M Hassan

On Wed, 2008-07-16 at 01:15 -0400, Willis Vandevanter wrote:
> KaiGai said:
>         I guess selinuxfs is not mounted.
> 
> I unmounted and remounted /selinux after I copied the new
> libselinux.so.1 onto the device. sestatus still returns disabled.
> 
> I also have the following in /etc/fstab:
>         selinux                /selinux        selinuxfs       noauto
>         0       0
> 
> KaiGai said:
>         If your /sbin/init is implemented using busybox, consider to
>         turn on
>         "SELinux support" option
> 
> /sbin/init is implemented using busybox, but I'm not sure if the
> SELinux support option is turned on.  I will have to check on this in
> the morning. 
> 
> Russell said:
>         What exactly is the output of "sestatus"?
> 
> The output of sestatus is:
>         SELinux status:                 disabled
> 
> Justin said:
>         do a ldd /sbin/init, you should see libsepol, and libselinux
>         if not install sysvinit
> 
> The output from ldd /sbin/init is:
>             libc.so.6 => /lib/libc.so.6 (0x40025000)
>             /lib/ld-linux.so.3 (0x40000000)
> 
> Oddly enough this is also the output when sestatus reports SELinux as
> enabled. sysvinit is installed.
> 
>         in grub.conf put selinux=1 enforcing=1/0  <~~~1=on 0=off
> 
> I rebooted with the boot parameters appended, but still sestatus
> reports SELinux as disabled. Even stranger is dmesg has the following:
> 
> 
>         ....
>         Security Framework initialized
>         SELinux:  Initializing.
>         SELinux:  Starting in permissive mode
>         .......
>         SELinux:  Registering netfilter hooks
>         io scheduler noop registered
>         io scheduler deadline registered (default)
>         ......
> 
> 
> It is late here right now =)). I will try the strace on sestatus
> tomorrow morning.
> 
> 
> -Willis
>  
> On Tue, Jul 15, 2008 at 8:54 PM, KaiGai Kohei <kaigai@ak.jp.nec.com>
> wrote:
>         Willis,
>         
>         I guess selinuxfs is not mounted.
>         
>         In SELinux environment, /sbin/init is extended to mount
>         selinuxfs
>         on /selinux. It enables to communicate between kernel and
>         userspaces.
>         
>         If your /sbin/init is implemented using busybox, consider to
>         turn on
>         "SELinux support" option and make /selinux directory on your
>         jffs2 image.
>         
>         
>         Willis Vandevanter wrote:
>                 -----BEGIN PGP SIGNED MESSAGE-----
>                 Hash: SHA1
>                 
>                 Hello All,
>                 
>                   I am working on developing a targeted SELinux policy
>                 for
>                 
>                 OpenMoko devices (www.openmoko.org
>                 <http://www.openmoko.org>) as a Google Summer Of Code
>                 project
>                 
>                 (http://code.google.com/p/selinux-openmoko/).
>                 
>                 Background:
>                 I have cross-compiled the necessary SELinux code
>                 (libselinux-1.34.15,
>                 checkpolicy-1.34.7, libsemanage-1.10.9,
>                 libsepol-1.16.14,
>                 policycoreutils-1.34.16) and devloped a very basic
>                 targeted policy. I
>                 ported the code on to the device. The policy compiles
>                 (make) and
>                 installs (make install).
>                 
>                 Where I am stuck:
>                 When cross-compiling libselinux I get some strange
>                 behavior.
>                 Specifically, I compiled libselinux with the following
>                 flags:
>                  make
>                 CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/cc ARCH=arm
>                 LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
>                  I then copied the new libselinux.so.1 on to the
>                 device. sestatus
>                 returns that SELinux is enabled and lists the correct
>                 policy version,
>                 
>         
>         Is it your host environment, isn't it?
>         
>                 etc. *BUT* make relabel doesn't work. make relabel (or
>                 setfiles) gives
>                 the following error:
>                 
>                 file_contexts/file_contexts: Invalid argument make:
>                 *** [relabel] Error 1
>                 The error seems to be that file_contexts is not being
>                 interpreted as a
>                 regular file (i.e. S_ISREG(sb.st_mode) in setfiles.c
>                 is returning 0).
>                 I assume this is because I compiled libselinux without
>                 the OpenMoko
>                 specific header files (ie with my
>                 host-x86 /usr/include rather than
>                 the device specific ones), so I re-compiled
>                 libselinux:
>                 
>                 make
>                 CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/ccARCH=arm
>                 LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
>                 INCLUDEDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/usr/include
>                 I then copied libselinux.so.1 on to the device.
>                 setfiles will now
>                 correctly label the filesystem, but sestatus now
>                 returns SELinux as
>                 disabled. I set /etc/selinux/config file to permissive
>                 and rebooted,
>                 but it is still listed as disabled.
>                 
>                 How is SELinux determined to be enabled? Could missing
>                 or
>                 mis-configured header files in the
>                 OpenMoko /usr/include cause SELinux
>                 to appear as disabled?
>                 
>                 I apologize for the long email. The policy I am using
>                 is available at
>                 http://code.google.com/p/selinux-openmoko/. The
>                 cross-compiled
>                 
>                 binaries are also available. I am using a 2.6.24.7
>                 <http://2.6.24.7> kernel with SELinux
>                 
>                 and JFFS2 XATTR enabled.
>                 
>                 Thank you for your help,
>                  Willis
>                 
>                  -----BEGIN PGP SIGNATURE-----
>                 Version: GnuPG v1.4.6 (GNU/Linux)
>                 
>                 iD8DBQFIfSH2qCokMvr1WNARAuJdAJ0Q9iWp7
>                 +V0jTxen92WfE8RFnpJeACgiRyX
>                 vAFzngclbVPHIZ/YckQi3Sg=
>                 =P7dW
>                 -----END PGP SIGNATURE-----
>                 
>         
>         -- 
>         OSS Platform Development Division, NEC
>         KaiGai Kohei <kaigai@ak.jp.nec.com>
>         
>         --
>         This message was distributed to subscribers of the selinux
>         mailing list.
>         If you no longer wish to subscribe, send mail to
>         majordomo@tycho.nsa.gov with
>         the words "unsubscribe selinux" without quotes as the message.
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
