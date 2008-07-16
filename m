Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6G5Tc0u019040
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 01:29:38 -0400
Received: from mail4.hitachi.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6G5TamS015177
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 05:29:37 GMT
Received: from mlsv2.hitachi.co.jp (unknown [133.144.234.166])
	by mail4.hitachi.co.jp (Postfix) with ESMTP id C067B33CC9
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 14:29:17 +0900 (JST)
Date: Wed, 16 Jul 2008 14:29:16 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: "Willis Vandevanter" <vandevwa@jmu.edu>
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov,
        "KaiGai Kohei" <kaigai@ak.jp.nec.com>
In-Reply-To: <4c63b15c0807152215p271dc8e6m1854ab006245b35@mail.gmail.com>
References: <487D46B5.9070608@ak.jp.nec.com> <4c63b15c0807152215p271dc8e6m1854ab006245b35@mail.gmail.com>
Message-Id: <20080716141941.E446.F42EC909@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

On Wed, 16 Jul 2008 01:15:48 -0400
"Willis Vandevanter" wrote:
> KaiGai said:
> 
> > I guess selinuxfs is not mounted.
> 
> 
> I unmounted and remounted /selinux after I copied the new libselinux.so.1
> onto the device. sestatus still returns disabled.
Does policy loaded ?
If not, sestatus will return SELinux is disabled.

You have to mount /selinux then load_policy.
BusyBox's /sbin/init does both when SELinux option is enabled.

> 
> I also have the following in /etc/fstab:
> 
> > selinux                /selinux        selinuxfs       noauto  0       0
> 
> 
> KaiGai said:
> 
> > If your /sbin/init is implemented using busybox, consider to turn on
> > "SELinux support" option
> >
> 
> /sbin/init is implemented using busybox, but I'm not sure if the SELinux
> support option is turned on.  I will have to check on this in the morning.
> 
> Russell said:
> 
> > What exactly is the output of "sestatus"?
> 
> 
> The output of sestatus is:
> 
> > SELinux status:                 disabled
> 
> 
> Justin said:
> 
> > do a ldd /sbin/init, you should see libsepol, and libselinux if not install
> > sysvinit
> >
> 
> The output from ldd /sbin/init is:
> 
> >     libc.so.6 => /lib/libc.so.6 (0x40025000)
> >     /lib/ld-linux.so.3 (0x40000000)
> >
> 
> Oddly enough this is also the output when sestatus reports SELinux as
> enabled. sysvinit is installed.
> 
> in grub.conf put selinux=1 enforcing=1/0  <~~~1=on 0=off
> >
> 
> I rebooted with the boot parameters appended, but still sestatus reports
> SELinux as disabled. Even stranger is dmesg has the following:
> 
> ....
> > Security Framework initialized
> > SELinux:  Initializing.
> > SELinux:  Starting in permissive mode
> > .......
> > SELinux:  Registering netfilter hooks
> > io scheduler noop registered
> > io scheduler deadline registered (default)
> > ......
> >
> 
> 
> It is late here right now =)). I will try the strace on sestatus tomorrow
> morning.
> 
> -Willis
> 
> On Tue, Jul 15, 2008 at 8:54 PM, KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:
> 
> > Willis,
> >
> > I guess selinuxfs is not mounted.
> >
> > In SELinux environment, /sbin/init is extended to mount selinuxfs
> > on /selinux. It enables to communicate between kernel and userspaces.
> >
> > If your /sbin/init is implemented using busybox, consider to turn on
> > "SELinux support" option and make /selinux directory on your jffs2 image.
> >
> >
> > Willis Vandevanter wrote:
> >
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Hello All,
> >>
> >>   I am working on developing a targeted SELinux policy for
> >> OpenMoko devices (www.openmoko.org <http://www.openmoko.org>) as a Google
> >> Summer Of Code project
> >> (http://code.google.com/p/selinux-openmoko/).
> >>
> >> Background:
> >> I have cross-compiled the necessary SELinux code (libselinux-1.34.15,
> >> checkpolicy-1.34.7, libsemanage-1.10.9, libsepol-1.16.14,
> >> policycoreutils-1.34.16) and devloped a very basic targeted policy. I
> >> ported the code on to the device. The policy compiles (make) and
> >> installs (make install).
> >>
> >> Where I am stuck:
> >> When cross-compiling libselinux I get some strange behavior.
> >> Specifically, I compiled libselinux with the following flags:
> >>  make
> >> CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/cc ARCH=arm
> >> LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
> >>  I then copied the new libselinux.so.1 on to the device. sestatus
> >> returns that SELinux is enabled and lists the correct policy version,
> >>
> >
> > Is it your host environment, isn't it?
> >
> >  etc. *BUT* make relabel doesn't work. make relabel (or setfiles) gives
> >> the following error:
> >>
> >> file_contexts/file_contexts: Invalid argument make: *** [relabel] Error 1
> >> The error seems to be that file_contexts is not being interpreted as a
> >> regular file (i.e. S_ISREG(sb.st_mode) in setfiles.c is returning 0).
> >> I assume this is because I compiled libselinux without the OpenMoko
> >> specific header files (ie with my host-x86 /usr/include rather than
> >> the device specific ones), so I re-compiled libselinux:
> >>
> >> make
> >> CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/ccARCH=arm
> >> LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
> >> INCLUDEDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/usr/include
> >> I then copied libselinux.so.1 on to the device. setfiles will now
> >> correctly label the filesystem, but sestatus now returns SELinux as
> >> disabled. I set /etc/selinux/config file to permissive and rebooted,
> >> but it is still listed as disabled.
> >>
> >> How is SELinux determined to be enabled? Could missing or
> >> mis-configured header files in the OpenMoko /usr/include cause SELinux
> >> to appear as disabled?
> >>
> >> I apologize for the long email. The policy I am using is available at
> >> http://code.google.com/p/selinux-openmoko/. The cross-compiled
> >> binaries are also available. I am using a 2.6.24.7 <http://2.6.24.7>
> >> kernel with SELinux
> >> and JFFS2 XATTR enabled.
> >>
> >> Thank you for your help,
> >>  Willis
> >>
> >>  -----BEGIN PGP SIGNATURE-----
> >> Version: GnuPG v1.4.6 (GNU/Linux)
> >>
> >> iD8DBQFIfSH2qCokMvr1WNARAuJdAJ0Q9iWp7+V0jTxen92WfE8RFnpJeACgiRyX
> >> vAFzngclbVPHIZ/YckQi3Sg=
> >> =P7dW
> >> -----END PGP SIGNATURE-----
> >>
> >
> > --
> > OSS Platform Development Division, NEC
> > KaiGai Kohei <kaigai@ak.jp.nec.com>
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> > the words "unsubscribe selinux" without quotes as the message.
> >

-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
