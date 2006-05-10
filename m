Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4AK3BhA022508
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 16:03:11 -0400
Received: from web51514.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k4AK3AsL028505
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 20:03:10 GMT
Message-ID: <20060510200300.51127.qmail@web51514.mail.yahoo.com>
Date: Wed, 10 May 2006 13:03:00 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: avcs when setting a watch
To: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've been testing the LSPP kernel and noticed that I'm getting AVC's whenever I
set a watch in root. auditctl -w /root/.bashrc  I get this:

----
type=AVC msg=audit(05/10/2006 15:28:39.091:2848) : avc:  denied  { search } for
 pid=8679 comm=auditctl name=root dev=hda7 ino=2326529
scontext=user_u:system_r:auditctl_t:s0 tcontext=root:object_r:user_home_dir_t:s0
tclass=dir
----
type=CONFIG_CHANGE msg=audit(05/10/2006 15:28:39.091:2849) : auid=sgrubb
subj=user_u:system_r:auditctl_t:s0 add rule to list=4 res=0
----
type=SOCKADDR msg=audit(05/10/2006 15:28:39.091:2848) : saddr=netlink pid:0
type=SYSCALL msg=audit(05/10/2006 15:28:39.091:2848) : arch=x86_64 syscall=sendto
success=yes exit=1088 a0=3 a1=7fffc3e30c10 a2=440 a3=0 items=0 ppid=8636 pid=8679
auid=sgrubb uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
fsgid=root tty=tty2 comm=auditctl exe=/sbin/auditctl
subj=user_u:system_r:auditctl_t:s0

What appears to be happening, is auditctl sends the watch to the kernel, the
kernel does a path lookup to see if the path is valid and if there is not already
a watch set at the same place. Somewhere in the process, an AVC is generated and
the config change is reported as failed. (If auditctl was responsible for this,
the syscall wouldn't be a sendto.)

Should the policy be adjusted to let auditctl search anywhere (even though its
not guilty) or should the kernel itself be unconfined?

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
