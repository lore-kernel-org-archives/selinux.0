Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23934
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 08:39:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA08162
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 13:37:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id NAA08158 for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 13:37:47 GMT
Message-Id: <200211071346.IAA06987@moss-shockers.ncsc.mil>
Date: Thu, 7 Nov 2002 08:46:01 -0500 (EST)
From: "Stephen D. Smalley" <sds@facesaver.epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@facesaver.epoch.ncsc.mil>
Subject: Re: IOCTL from rm
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Some time ago Steve sent me a patch to display the IOCTL that is denied to 
> help tracking down strange IOCTLs.  I applied the patch with the following 
> results.
> 
> How do I proceed from here?
> 
> On Wed, 6 Nov 2002 15:02, System Administrator wrote:
> > Nov  6 06:26:23 ivanova kernel: avc:  denied  { ioctl } for  pid=22219
> > exe=/bin/rm path=/root dev=09:01 ino=176512
> > scontext=system_u:system_r:system_crond_t
> > tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir Nov  6 06:26:23
> > ivanova kernel: selinux_file_ioctl:  denied ioctl 5401 Nov  6 06:26:23
> > ivanova kernel: avc:  denied  { ioctl } for  pid=22220 exe=/bin/rm
> > path=/root dev=09:01 ino=176512 scontext=system_u:system_r:system_crond_t
> > tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir Nov  6 06:26:23
> > ivanova kernel: selinux_file_ioctl:  denied ioctl 5401 Nov  6 06:26:23
> > ivanova kernel: avc:  denied  { ioctl } for  pid=22221 exe=/bin/rm
> > path=/root dev=09:01 ino=176512 scontext=system_u:system_r:system_crond_t
> > tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir Nov  6 06:26:23
> > ivanova kernel: selinux_file_ioctl:  denied ioctl 5401

include/asm-i386/ioctls.h defines TCGETS as 0x5401.  This should fail anyway on 
a directory, with errno ENOTTY, even if the permission were granted.  Hence,
we can probably just use a dontaudit rule to suppress this audit message.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
