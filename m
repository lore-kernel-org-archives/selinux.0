Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA6FBKMA014995
	for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2005 10:11:20 -0500 (EST)
Received: from web51510.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id jA6F5Vcn002553
	for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2005 15:05:31 GMT
Message-ID: <20051106150512.8941.qmail@web51510.mail.yahoo.com>
Date: Sun, 6 Nov 2005 07:05:12 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: multiple avcs in 1 audit event
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I was running some leaks checks of aureport and found something strange. I have
places where there are 2 avc denials for the same audit event. I am wondering if
this is really the correct action? Why was the syscall allowed to proceed to
where a second problem was encountered (this is using the audit.88 kernel)?
Here's the audit event, basically. I have a shared /opt via samba and accessed it
without disabling se linux - I have to disable se linux or it just doesn't work
right.

----
type=PATH msg=audit(10/21/05 09:09:06.571:618) :
name=policycoreutils-1.27.14/newrole/newrole.c flags=follow inode=1280463
dev=03:05 mode=file,644 ouid=sgrubb ogid=sgrubb rdev=00:00
type=CWD msg=audit(10/21/05 09:09:06.571:618) :  cwd=/opt
type=AVC_PATH msg=audit(10/21/05 09:09:06.571:618) : 
path=/opt/policycoreutils-1.27.14/newrole/newrole.c
type=SYSCALL msg=audit(10/21/05 09:09:06.571:618) : arch=i386 syscall=stat64
success=yes exit=0 a0=bff74df0 a1=bff74870 a2=570ff4 a3=bff74870 items=1 pid=3010
auid=sgrubb uid=nobody gid=root euid=nobody suid=root fsuid=nobody egid=nobody
sgid=nobody fsgid=nobody comm=smbd exe=/usr/sbin/smbd
type=AVC msg=audit(10/21/05 09:09:06.571:618) : avc:  denied  { getattr } for 
pid=3010 comm=smbd name=newrole.c dev=hda5 ino=1280463
scontext=root:system_r:smbd_t tcontext=user_u:object_r:user_home_t tclass=file
type=AVC msg=audit(10/21/05 09:09:06.571:618) : avc:  denied  { search } for 
pid=3010 comm=smbd name=policycoreutils-1.27.14 dev=hda5 ino=1280454
scontext=root:system_r:smbd_t tcontext=user_u:object_r:user_home_t tclass=dir



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
