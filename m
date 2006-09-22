Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MGBpBL024669
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 12:11:51 -0400
Received: from web51505.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8MGAqEW017727
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:10:52 GMT
Message-ID: <20060922161150.72513.qmail@web51505.mail.yahoo.com>
Date: Fri, 22 Sep 2006 09:11:50 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: mkdir avc
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

When there is a denial doing mkdir syscall, should there be an avc_path or path
audit record? Example:

type=AVC msg=audit(1118918038.404:14545): avc:  denied  { create } for  pid=4407
comm="useradd" name="usertwo" scontext=root:sysadm_r:useradd_t:s0-s15:c0.c1023
tcontext=root:object_r:user_home_dir_t:s0 tclass=dir
type=SYSCALL msg=audit(1118918038.404:14545): arch=c000003e syscall=83 success=no
exit=-13 a0=813cc0 a1=0 a2=2 a3=1 items=0 ppid=4222 pid=4407 auid=0 uid=0 gid=0
euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 comm="useradd"
exe="/usr/sbin/useradd" subj=root:sysadm_r:useradd_t:s0-s15:c0.c1023 key=(null)

Seems like we should know the path being created or the parent dir where it
failed.

Thanks,
-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
