Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FLikWt029071
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:44:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FLiimR028576
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:44:44 GMT
Received: from whms0094.cwshs.com (mailout.cgi.com [66.110.7.6])
        by jazzband.ncsc.mil  with ESMTP id h9FLiijp028566 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:44:44 GMT
Received: from whml0344.cgi.com ([10.254.251.20]) by
          whms0094.cwshs.com (Netscape Messaging Server 4.15 whms0094 Jul
          22 2001 13:33:35) with SMTP id HMTJ2D02.XAH for
          <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:44:37 -0400
Received: from RWANNER ([207.164.204.5]) by whms0335.cwshs.com
          (Netscape Messaging Server 4.15 whms0335 Jan 17 2002 00:23:08)
          with SMTP id HMTJ2C01.PBE for <selinux@tycho.nsa.gov>; Wed, 15
          Oct 2003 17:44:36 -0400
From: "Richard Herbert Wanner" <richard.wanner@cgi.com>
To: "SELinux NSA" <selinux@tycho.nsa.gov>
Subject: More 2.4 Build problems on RH 9.0
Date: Wed, 15 Oct 2003 17:42:50 -0400
Message-ID: <GMECJOINLDFDGEEPGINLAEGOCKAA.richard.wanner@cgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1066241904.7399.84.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the help with my kernel build problems.  I now have a good working 2.4 kernel and I am on to the userland install.

Sorry, but again I have an error.  Checkpolicy made ok, but libselinux seems to have a missing header file.

cc -o fgetfilecon.o -c Wall -fPIC -I..include fgetfilecon.c
fgetfilecon.c:7:24: attr/xattr.h: No such file or directory
fgetfilecon.c: In function 'fgetfilecon':
fgetfilecon.c:22:warning implicit declaration of function 'fgetxattr'
make[1]: *** [fgetfilecon.o] Error 1
make[1]: Leaving directory '/tmp/selinux-usr/libselinux/src
make: *** [install] Error 2

I am assuming from the name that xattr.h has to do with extended attributes.  I enabled 
(CONFIG_DEVPTS_FS_XATTR), (CONFIG_DEVPTS_FS_SECURITY), (CONFIG_EXT2_FS_XATTR), and (CONFIG_EXT2_FS_SECURITY) along with the security parameters before building the kernel.  

Any suggestions would be appreciated.

Thanks
Rick



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
