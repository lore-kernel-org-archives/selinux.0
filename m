Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89CGNLa028935
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 08:16:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h89CGMmw012741
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 12:16:22 GMT
Received: from mx1.avenit.de (nexus6.avenit.de [80.237.241.2])
        by jazzband.ncsc.mil  with SMTP id h89CGL9d012738 for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 12:16:22 GMT
From: "Romix" <romix@php.cd>
To: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: how to add a user with rights to login via ssh on selinux?
Date: Tue, 9 Sep 2003 14:16:07 +0200
Message-ID: <005901c376cc$28890460$4200000a@roadwarrior>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200309092054.12989.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> From your description it seems that you correctly added the user and 
> configured your system.
> 
> Does "dmesg" display any avc messages concerning the login?

yes there are some messages, but i don´t understand them (is that explained
somewhere?):

avc:  denied  { read } for  pid=23997 exe=/usr/sbin/sshd
path=socket:[257597] dev=00:00 ino=257597
scontext=root:sysadm_r:sysadm_chkpwd_t
tcontext=root:sysadm_r:sysadm_chkpwd_t tclass=unix_stream_socket
avc:  denied  { write } for  pid=23998 exe=/usr/sbin/sshd
path=socket:[257596] dev=00:00 ino=257596
scontext=root:sysadm_r:sysadm_chkpwd_t
tcontext=root:sysadm_r:sysadm_chkpwd_t tclass=unix_stream_socket
avc:  denied  { getattr } for  pid=23997 exe=/usr/sbin/sshd
path=socket:[257601] dev=00:00 ino=257601
scontext=root:sysadm_r:sysadm_chkpwd_t
tcontext=root:sysadm_r:sysadm_chkpwd_t tclass=udp_socket
avc:  denied  { getattr } for  pid=23997 exe=/usr/sbin/sshd
scontext=root:sysadm_r:sysadm_chkpwd_t tcontext=system_u:object_r:devpts_t
tclass=filesystem
avc:  denied  { search } for  pid=23997 exe=/usr/sbin/sshd dev=00:08 ino=1
scontext=root:sysadm_r:sysadm_chkpwd_t tcontext=system_u:object_r:devpts_t
tclass=dir

> Is sshd running in the correct context?  "ps --context | grep 
> sshd" will show 
> you the context.

23994    243 root:sysadm_r:sysadm_chkpwd_t            grep sshd

is sysadm_chkpwd_t the right domain?

cu, Romain



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
