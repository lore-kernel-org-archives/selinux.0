Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89DCdLa029406
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 09:12:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h89DB3LY008049
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 13:11:03 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h89DB2sG008046
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 13:11:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Romix" <romix@php.cd>, <selinux@tycho.nsa.gov>
Subject: Re: how to add a user with rights to login via ssh on selinux?
Date: Tue, 9 Sep 2003 23:12:30 +1000
References: <005901c376cc$28890460$4200000a@roadwarrior>
In-Reply-To: <005901c376cc$28890460$4200000a@roadwarrior>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309092312.30592.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Sep 2003 22:16, Romix wrote:
> > Does "dmesg" display any avc messages concerning the login?
>
> yes there are some messages, but i don´t understand them (is that explained
> somewhere?):
>
> avc:  denied  { read } for  pid=23997 exe=/usr/sbin/sshd
> path=socket:[257597] dev=00:00 ino=257597
> scontext=root:sysadm_r:sysadm_chkpwd_t
> tcontext=root:sysadm_r:sysadm_chkpwd_t tclass=unix_stream_socket

This is wrong.  Either sshd has the wrong type or you started it in the wrong 
manner.

Run "ls --context /usr/sbin/sshd" to see the type of the file, it should be 
sshd_exec_t.

> > Is sshd running in the correct context?  "ps --context | grep
> > sshd" will show
> > you the context.
>
> 23994    243 root:sysadm_r:sysadm_chkpwd_t            grep sshd
>
> is sysadm_chkpwd_t the right domain?

That's the context of the "grep" process, and it's not the right domain for 
sshd or for grep.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
