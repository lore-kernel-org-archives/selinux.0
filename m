Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA14609
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:47:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA14101
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 21:45:56 GMT
Received: from mail.outstep.com (a904j637.tower.wayne.edu [141.217.140.65])
	by jazzswing.ncsc.mil  with ESMTP id VAA14097
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 21:45:55 GMT
Received: from outstep.com (localhost.localdomain [127.0.0.1])
	by mail.outstep.com (Postfix) with SMTP id 743BF3BE42
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:41:22 -0500 (EST)
Message-ID: <1183.192.168.1.12.1014673282.squirrel@192.168.1.2>
Date: Mon, 25 Feb 2002 16:41:22 -0500 (EST)
Subject: pptp and SELinux errors
From: "Lonnie Cumberland" <lonnie@outstep.com>
To: <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

I have been working to get a daemon called PPTP set up and which
provides me to set up a VPN with another machine.

The problem is that I am getting come errors and it will not let me
connect.

---------------------------------------------------------------------

Feb 25 16:40:20 tarus pptpd[2246]: CTRL: Client 192.168.1.12 control
connection started
Feb 25 16:40:20 tarus pptpd[2246]: CTRL: Starting call (launching
pppd, opening GRE)
Feb 25 16:40:20 tarus kernel:
Feb 25 16:40:20 tarus kernel: avc:  denied  { create } for  pid=2246
exe=/usr/sbin/pptpctrl scontext=root:sysadm_r:sysadm_t
tcontext=root:sysadm_r:sysadm_t tclass=rawip_socket
Feb 25 16:40:20 tarus kernel:
Feb 25 16:40:20 tarus kernel: avc:  denied  { read write } for
pid=2247 exe=/usr/sbin/pppd path=/dev/ppp dev=03:02 ino=33955
scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:device_t
tclass=chr_file
Feb 25 16:40:20 tarus pppd[2247]: pppd 2.4.1 started by root, uid 0
Feb 25 16:40:20 tarus modprobe: modprobe: Can't locate module tty-
ldisc-3
Feb 25 16:40:20 tarus kernel:
Feb 25 16:40:20 tarus kernel: avc:  denied  { bind } for  pid=2246
exe=/usr/sbin/pptpctrl lport=47 scontext=root:sysadm_r:sysadm_t
tcontext=root:sysadm_r:sysadm_t tclass=rawip_socket
Feb 25 16:40:20 tarus kernel:
Feb 25 16:40:20 tarus kernel: avc:  denied  { connect } for  pid=2246
exe=/usr/sbin/pptpctrl laddr=192.168.1.7 lport=47
scontext=root:sysadm_r:sysadm_t tcontext=root:sysadm_r:sysadm_t
tclass=rawip_socket
Feb 25 16:40:20 tarus pppd[2247]: Couldn't set tty to PPP discipline:
Invalid argument
Feb 25 16:40:20 tarus pppd[2247]: Exit.
Feb 25 16:40:20 tarus pptpd[2246]: GRE: read
(fd=4,buffer=804d8c0,len=8196) from PTY failed: status = -1 error =
Input/output error
Feb 25 16:40:20 tarus pptpd[2246]: CTRL: PTY read or GRE write failed
(pty,gre)=(4,5)
Feb 25 16:40:20 tarus pptpd[2246]: CTRL: Client 192.168.1.12 control
connection finished
Feb 25 16:41:33 tarus kernel:
Feb 25 16:41:33 tarus kernel: avc:  denied  { search } for  pid=2237
exe=/usr/bin/mc dev=00:0a ino=2 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:unlabeled_t tclass=dir
Feb 25 16:41:33 tarus kernel:
Feb 25 16:41:33 tarus kernel: avc:  denied  { read } for  pid=2237
exe=/usr/bin/mc dev=00:0a ino=2 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:unlabeled_t tclass=dir
Feb 25 16:41:40 tarus kernel:
Feb 25 16:41:40 tarus kernel: avc:  denied  { getattr } for  pid=2237
exe=/usr/bin/mc path=/lonnie/.sversionrc dev=00:0a ino=98114
scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:unlabeled_t tclass=file

--------------------------------------------------------------------

I am trying to find out if this is an SELinunx policy problem or a
configuration problem with pptp.

does anyone have any ideas on this?

Cheers,
Lonnie

-- 
 Lonnie Cumberland
 OutStep Technologies Incorporated
 EMAIL: Lonnie@OutStep.com
      : Lonnie_Cumberland@yahoo.com

 The Basis Express Virtual Office
               &
 Data Backup and Recovery Services

 URL: http://www.basis-express.com

"The Virtual Office without boundries!!!"





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
