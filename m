Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k17MQAXf000495
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 17:26:10 -0500 (EST)
Received: from web51507.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k17MQ8kS029065
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 22:26:08 GMT
Message-ID: <20060207222609.11476.qmail@web51507.mail.yahoo.com>
Date: Tue, 7 Feb 2006 14:26:09 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: auditctl examples?
To: David Slater <ds@hypertechsystems.com>, selinux@tycho.nsa.gov
In-Reply-To: <43E9024D.9030304@hypertechsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I apologize if this is not the appropriate forum for this question, but it
appears
>to be the logical path thus far.

linux-audit might be a better place
(http://www.redhat.com/mailman/listinfo/linux-audit), but this is fine.

>Specifically, I would like to understand the concept of adding a watch to a 
>filesystem object.  I would like to generate an audit entry in
>/var/log/audit/audit.log each time a restricted directory is accessed.

You cannot write one rule that checks access of a directory. The rules have to be
written for the object that is being accessed. A watch on a directory will get
you changes to the directory entries which is not exactly what you might expect.
The RHEL4 watches are somewhat based on inode auditing.

[root@endeavor ~]# mkdir /home/secret
[root@endeavor ~]# touch /home/secret/noread.txt
[root@endeavor ~]# auditctl -w /home/secret/noread.txt
[root@endeavor ~]# cat /home/secret/noread.txt
[root@endeavor ~]# ausearch -ts 17:15:00 -f noread.txt
----
time->Tue Feb  7 17:20:17 2006
type=PATH msg=audit(1139350817.975:1048): name="/home/secret/noread.txt"
flags=101  inode=459666 dev=03:03 mode=0100644 ouid=0 ogid=0 rdev=00:00
type=CWD msg=audit(1139350817.975:1048):  cwd="/root"
type=FS_INODE msg=audit(1139350817.975:1048): inode=459666 inode_uid=0
inode_gid=0 inode_dev=03:03 inode_rdev=00:00
type=FS_WATCH msg=audit(1139350817.975:1048): watch_inode=459666
watch="noread.txt" filterkey= perm=0 perm_mask=4
type=SYSCALL msg=audit(1139350817.975:1048): arch=40000003 syscall=5 success=yes
exit=3 a0=bff90c12 a1=8000 a2=0 a3=8000 items=1 pid=3929 auid=4325 uid=0 gid=0
euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 comm="cat" exe="/bin/cat"

The audit watches only work on the RHEL4 kernel for now. There is ongoing work to
make a new filesystem audit framework, but its not upstream. This framework
should have the ability to set a watch on a dir and get accesses for files it
contains.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
