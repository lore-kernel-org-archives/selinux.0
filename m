Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6FMHQ47028620
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 18:17:26 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6FMHPMO023043
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 22:17:26 GMT
Received: by nf-out-0910.google.com with SMTP id b21so2149057nfd.4
        for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 15:17:24 -0700 (PDT)
Message-ID: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com>
Date: Tue, 15 Jul 2008 18:17:24 -0400
From: "Willis Vandevanter" <vandevwa@jmu.edu>
To: selinux@tycho.nsa.gov
Subject: OpenMoko/JFFS2 sestatus difficulties
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15993_27822822.1216160244524"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_15993_27822822.1216160244524
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello All,

   I am working on developing a targeted SELinux policy for
OpenMoko devices (www.openmoko.org) as a Google Summer Of Code project
(http://code.google.com/p/selinux-openmoko/).

Background:
I have cross-compiled the necessary SELinux code (libselinux-1.34.15,
checkpolicy-1.34.7, libsemanage-1.10.9, libsepol-1.16.14,
policycoreutils-1.34.16) and devloped a very basic targeted policy. I
ported the code on to the device. The policy compiles (make) and
installs (make install).

Where I am stuck:
When cross-compiling libselinux I get some strange behavior.
Specifically, I compiled libselinux with the following flags:
 make
CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/cc ARCH=arm
LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
 I then copied the new libselinux.so.1 on to the device. sestatus
returns that SELinux is enabled and lists the correct policy version,
etc. *BUT* make relabel doesn't work. make relabel (or setfiles) gives
the following error:

file_contexts/file_contexts: Invalid argument make: *** [relabel] Error 1
The error seems to be that file_contexts is not being interpreted as a
regular file (i.e. S_ISREG(sb.st_mode) in setfiles.c is returning 0).
I assume this is because I compiled libselinux without the OpenMoko
specific header files (ie with my host-x86 /usr/include rather than
the device specific ones), so I re-compiled libselinux:

make
CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/ccARCH=arm
LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
INCLUDEDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/usr/include
I then copied libselinux.so.1 on to the device. setfiles will now
correctly label the filesystem, but sestatus now returns SELinux as
disabled. I set /etc/selinux/config file to permissive and rebooted,
but it is still listed as disabled.

How is SELinux determined to be enabled? Could missing or
mis-configured header files in the OpenMoko /usr/include cause SELinux
to appear as disabled?

I apologize for the long email. The policy I am using is available at
http://code.google.com/p/selinux-openmoko/. The cross-compiled
binaries are also available. I am using a 2.6.24.7 kernel with SELinux
and JFFS2 XATTR enabled.

Thank you for your help,
  Willis


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIfSH2qCokMvr1WNARAuJdAJ0Q9iWp7+V0jTxen92WfE8RFnpJeACgiRyX
vAFzngclbVPHIZ/YckQi3Sg=
=P7dW
-----END PGP SIGNATURE-----

------=_Part_15993_27822822.1216160244524
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">-----BEGIN PGP SIGNED MESSAGE-----<br>Hash: SHA1<br><br>Hello All,<br><br>&nbsp;&nbsp; I am working on developing a targeted SELinux policy for<br>OpenMoko devices (<a href="http://www.openmoko.org">www.openmoko.org</a>) as a Google Summer Of Code project<br>
(<a href="http://code.google.com/p/selinux-openmoko/">http://code.google.com/p/selinux-openmoko/</a>). <br><br>Background:<br>I have cross-compiled the necessary SELinux code (libselinux-1.34.15,<br>checkpolicy-1.34.7, libsemanage-1.10.9, libsepol-1.16.14,<br>
policycoreutils-1.34.16) and devloped a very basic targeted policy. I<br>ported the code on to the device. The policy compiles (make) and<br>installs (make install).<br><br>Where I am stuck:<br>When cross-compiling libselinux I get some strange behavior.<br>
Specifically, I compiled libselinux with the following flags:<br>&nbsp;make<br>CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/cc ARCH=arm<br>LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib <br>&nbsp;I then copied the new libselinux.so.1 on to the device. sestatus<br>
returns that SELinux is enabled and lists the correct policy version,<br>etc. *BUT* make relabel doesn&#39;t work. make relabel (or setfiles) gives<br>the following error:<br><br>file_contexts/file_contexts: Invalid argument&nbsp;make: *** [relabel] Error 1<br>
The error seems to be that file_contexts is not being interpreted as a<br>regular file (i.e. S_ISREG(sb.st_mode) in setfiles.c is returning 0).<br>I assume this is because I compiled libselinux without the OpenMoko<br>specific header files (ie with my host-x86 /usr/include rather than<br>
the device specific ones), so I re-compiled libselinux:<br><br>make<br>CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/ccARCH=arm<br>LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib<br>INCLUDEDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/usr/include<br>
I then copied libselinux.so.1 on to the device. setfiles will now<br>correctly label the filesystem, but sestatus now returns SELinux as<br>disabled. I set /etc/selinux/config file to permissive and rebooted,<br>but it is still listed as disabled. <br>
<br>How is SELinux determined to be enabled? Could missing or<br>mis-configured header files in the OpenMoko /usr/include cause SELinux<br>to appear as disabled? <br><br>I apologize for the long email. The policy I am using is available at<br>
<a href="http://code.google.com/p/selinux-openmoko/">http://code.google.com/p/selinux-openmoko/</a>. The cross-compiled<br>binaries are also available. I am using a <a href="http://2.6.24.7">2.6.24.7</a> kernel with SELinux<br>
and JFFS2 XATTR enabled.<br><br>Thank you for your help,<br>&nbsp; Willis<br><br>&nbsp;<br>-----BEGIN PGP SIGNATURE-----<br>Version: GnuPG v1.4.6 (GNU/Linux)<br><br>iD8DBQFIfSH2qCokMvr1WNARAuJdAJ0Q9iWp7+V0jTxen92WfE8RFnpJeACgiRyX<br>
vAFzngclbVPHIZ/YckQi3Sg=<br>=P7dW<br>-----END PGP SIGNATURE-----<br><br><br></div>

------=_Part_15993_27822822.1216160244524--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
