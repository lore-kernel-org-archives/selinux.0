Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h47GvaI4010995
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 12:57:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h47GvMVf019015
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 16:57:22 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h47GvL4D019012
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 16:57:21 GMT
Subject: /dev/pts/* denials w/devfs
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1052326645.13937.23.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 07 May 2003 11:57:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to integrate SELinux with Gentoo
(http://www.gentoo.org/proj/en/hardened/), however I'm encountering some
problems.  The problem surrounds /dev/pts/* denials.  Gentoo uses devfs,
so I have a feeling that it might be causing some problems.  For
example, the following are the denials I get when logging in via ssh. 
The ssh.te is still the stock from selinux-small, and openssh is
patched.  I also have the devfsd-se.so devfsd module running. 
Suggestions?

Thanks, Chris

avc:  denied  { getattr } for  pid=3909 exe=/usr/sbin/sshd path=/pts/1
dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:devpts_t tclass=chr_file
 
avc:  denied  { read write } for  pid=3909 exe=/usr/sbin/sshd
path=/pts/1 dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:devpts_t tclass=chr_file
 
avc:  denied  { ioctl } for  pid=3909 exe=/usr/sbin/sshd path=/pts/1
dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:devpts_t tclass=chr_file
 
avc:  denied  { setattr } for  pid=3909 exe=/usr/sbin/sshd path=/pts/1
dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:devpts_t tclass=chr_file
 
avc:  denied  { relabelfrom } for  pid=3909 exe=/usr/sbin/sshd
path=/pts/1 dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:devpts_t tclass=chr_file
 
avc:  denied  { relabelto } for  pid=3909 exe=/usr/sbin/sshd path=/pts/1
dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=pebenito:object_r:devpts_t tclass=chr_file
 
avc:  denied  { ioctl } for  pid=3909 exe=/usr/sbin/sshd path=/pts/1
dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=pebenito:object_r:devpts_t tclass=chr_file
 
avc:  denied  { read write } for  pid=3911 exe=/usr/sbin/sshd
path=/pts/1 dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=pebenito:object_r:devpts_t tclass=chr_file
 
avc:  denied  { getattr } for  pid=3912 exe=/usr/sbin/sshd path=/pts/1
dev=00:07 ino=917 scontext=system_u:system_r:sshd_t
tcontext=pebenito:object_r:devpts_t tclass=chr_file
 
avc:  denied  { read write } for  pid=3912 exe=/bin/bash path=/pts/1
dev=00:07 ino=917 scontext=pebenito:user_r:user_t
tcontext=pebenito:object_r:devpts_t tclass=chr_file
 
avc:  denied  { ioctl } for  pid=3912 exe=/bin/bash path=/pts/1
dev=00:07 ino=917 scontext=pebenito:user_r:user_t
tcontext=pebenito:object_r:devpts_t tclass=chr_file
 
avc:  denied  { getattr } for  pid=3912 exe=/bin/bash path=/pts/1
dev=00:07 ino=917 scontext=pebenito:user_r:user_t
tcontext=pebenito:object_r:devpts_t tclass=chr_file

-- 
Chris PeBenito
<pebenito@ieee.org>
AIM: PeBenito78
ICQ#: 10434387

"Engineering does not require science. Science helps
a lot, but people built perfectly good brick walls 
long before they knew why cement works."-Alan Cox

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
