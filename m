Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89EljLa000358
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 10:47:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h89Ek8LY019424
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 14:46:08 GMT
Received: from mx1.avenit.de (nexus6.avenit.de [80.237.241.2])
	by jazzswing.ncsc.mil  with SMTP id h89Ek7sG019421
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 14:46:08 GMT
From: "Romix" <romix@php.cd>
To: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: how to add a user with rights to login via ssh on selinux?
Date: Tue, 9 Sep 2003 16:47:23 +0200
Message-ID: <006501c376e1$4cc11fb0$4200000a@roadwarrior>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <200309092353.22849.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 9 Sep 2003 23:47, Romix wrote:
> > sorry, i posted the wrong line, but sshd was running in the 
> same context:
> > 23618    243 root:sysadm_r:sysadm_chkpwd_t            /usr/sbin/sshd
> >
> > so i changed it (i executed "/etc/init.d/sshd start" as root from a 
> > local login and not via ssh):
> > 24176    195 root:staff_r:staff_t                     /usr/sbin/sshd
> 
> Firstly you should be sysadm_r:sysadm_t when you start 
> daemons.  Secondly you 
> should use "run_init".
> 
> Do the following:
> newrole -r sysadm_r
> run_init /etc/init.d/sshd start
> 
> Then things should be fine.

ok, i think i understand now, that was the information missing :) 
now sshd is running in system_u:system_r:sshd_t context and my user can
login :D

thanks a lot for your help.

cu, Romain


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
