Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA19458
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 17:46:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA06278
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 22:44:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA06274 for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 22:44:06 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8BBBB92713
	for <selinux@tycho.nsa.gov>; Thu,  7 Nov 2002 09:45:50 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CF66DA9CD
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2002 23:45:45 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: IOCTL from rm
Date: Wed, 6 Nov 2002 17:34:22 +0100
References: <20021106140203.767AFFAD5@ivanova.coker.com.au>
In-Reply-To: <20021106140203.767AFFAD5@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <200211061734.22702.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some time ago Steve sent me a patch to display the IOCTL that is denied to 
help tracking down strange IOCTLs.  I applied the patch with the following 
results.

How do I proceed from here?

On Wed, 6 Nov 2002 15:02, System Administrator wrote:
> Nov  6 06:26:23 ivanova kernel: avc:  denied  { ioctl } for  pid=22219
> exe=/bin/rm path=/root dev=09:01 ino=176512
> scontext=system_u:system_r:system_crond_t
> tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir Nov  6 06:26:23
> ivanova kernel: selinux_file_ioctl:  denied ioctl 5401 Nov  6 06:26:23
> ivanova kernel: avc:  denied  { ioctl } for  pid=22220 exe=/bin/rm
> path=/root dev=09:01 ino=176512 scontext=system_u:system_r:system_crond_t
> tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir Nov  6 06:26:23
> ivanova kernel: selinux_file_ioctl:  denied ioctl 5401 Nov  6 06:26:23
> ivanova kernel: avc:  denied  { ioctl } for  pid=22221 exe=/bin/rm
> path=/root dev=09:01 ino=176512 scontext=system_u:system_r:system_crond_t
> tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir Nov  6 06:26:23
> ivanova kernel: selinux_file_ioctl:  denied ioctl 5401

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
