Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7DI4vPa010205
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 14:04:57 -0400
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7DI4u3N007149
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 18:04:56 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l7DI3qWl027562
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 14:03:52 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l7DI4UWO005790
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 14:04:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: mls level of the terminal window problem
Date: Mon, 13 Aug 2007 11:04:52 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0219DC99@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Can anyone explain to me why the mls level of the tcontext in the below
audit log messages is s0-s4:c0.c255? 

I'm using newrole to set the level of the shell to s4:c0.c255, and
that's the level that I believe tcontext should be as well. See the
sequence of commands below.

Here are the relevant audit log messages:

type=AVC msg=audit(1187026747.020:747955): avc:  denied  { use } for
pid=15302 comm="vsftpstart" name="1" dev=devpts ino=3
scontext=root:system_r:ftp_trans_t:s4:c0.c255
tcontext=root:system_r:unconfined_t:s0-s4:c0.c255 tclass=fd

type=SYSCALL msg=audit(1187026747.020:747955): arch=c000003e syscall=59
success=yes exit=0 a0=13cddc08 a1=13ced7e8 a2=13cb9d08 a3=4 items=0
ppid=15264 pid=15302 auid=1873 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 tty=pts1 comm="vsftpstart" exe="/bin/bash"
subj=root:system_r:ftp_trans_t:s4:c0.c255 key=(null)

type=AVC_PATH msg=audit(1187026747.020:747955):  path="/dev/pts/1"


Here is the sequence of commands that I typed in. These confirm that my
terminal is set to s4:c0.c255 after using newrole. The above audit log
messages are generated from the "/usr/sbin/vsftpstart" command. They
result from the attempt to print out the "Starting vsftpd ..." msg. The
only reason the message successfully prints is because I'm in permissive
mode.

[root@m2ut5 ~]# getenforce
Permissive
[root@m2ut5 ~]# id
uid=0(root) gid=0(root)
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),101(pkcs
11),4500(m2) context=root:system_r:unconfined_t:s0-s4:c0.c255
[root@m2ut5 ~]# tty
/dev/pts/1
[root@m2ut5 ~]# ls -Z /dev/pts/1
crw--w----  clarkson tty root:object_r:devpts_t:s0        /dev/pts/1
[root@m2ut5 ~]# newrole -l s4:c0.c255
Authenticating clarkson.
Password:
[clarkson@m2ut5 /root]# id
uid=0(root) gid=0(root)
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),101(pkcs
11),4500(m2) context=root:system_r:unconfined_t:s4:c0.c255
[clarkson@m2ut5 /root]# tty
/dev/pts/1
[clarkson@m2ut5 /root]# ls -Z /dev/pts/1
crw--w----  clarkson tty root:object_r:devpts_t:s4:c0.c255 /dev/pts/1
[clarkson@m2ut5 /root]# /usr/sbin/vsftpstart
Starting vsftpd for vsftpd:                                [  OK  ]





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
