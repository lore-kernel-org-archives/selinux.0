Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i165kPRb021001
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 00:46:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i165kOOi003592
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 05:46:24 GMT
Received: from smtp106.mail.sc5.yahoo.com (smtp106.mail.sc5.yahoo.com [66.163.169.226])
        by jazzband.ncsc.mil  with SMTP id i165kNWW003589 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 05:46:23 GMT
Date: Thu, 5 Feb 2004 23:46:01 -0600
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Issues relabeling filesystems
From: Ignacio Tripodi <ignaciot@unt.edu>
To: selinux@tycho.nsa.gov
Message-Id: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm running SELinux on User Mode Linux, on a Fedora Core 1 root 
filesystem I built. When trying to label the filesystem, I encountered 
this problem:

[root@umlSELinux policy]# make relabel
/usr/sbin/setfiles file_contexts/file_contexts `mount | awk 
'/ext[23].*rw/{print $3}'`
/usr/sbin/setfiles:  read 419 specifications
/usr/sbin/setfiles:  labeling files under /
/usr/sbin/setfiles: relocation error: /usr/sbin/setfiles: symbol 
nftw64, version GLIBC_2.3.3 not defined in file libc.so.6 with link 
time reference
make: *** [relabel] Error 127

I actually included glibc-2.3.2 when I built the root-filesystem, as 
well as glibc-common-2.3.2, glibc-debug-2.3.2, glibc-devel-2.3.2, 
glibc-headers-2.3.2, etc. Any clues of what this error means will be 
highly appreciated.
Thanks!

Ignacio
CoPS Lab
University of North Texas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFAIyofwGqh0xtlFYsRAuoUAJ9oHHDPKOd5awVXV87GmkHvYyo4xwCfU0mt
AVi+HvBUwFABlwn9ItWTz7w=
=KCpw
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
