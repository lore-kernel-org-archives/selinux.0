Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89DroLa029764
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 09:53:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h89Drhmw021594
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 13:53:43 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h89Dre9d021571 for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 13:53:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Romix" <romix@php.cd>, <selinux@tycho.nsa.gov>
Subject: Re: how to add a user with rights to login via ssh on selinux?
Date: Tue, 9 Sep 2003 23:53:22 +1000
References: <006101c376d8$fe52ab30$4200000a@roadwarrior>
In-Reply-To: <006101c376d8$fe52ab30$4200000a@roadwarrior>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309092353.22849.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Sep 2003 23:47, Romix wrote:
> sorry, i posted the wrong line, but sshd was running in the same context:
> 23618    243 root:sysadm_r:sysadm_chkpwd_t            /usr/sbin/sshd
>
> so i changed it (i executed "/etc/init.d/sshd start" as root from a local
> login and not via ssh):
> 24176    195 root:staff_r:staff_t                     /usr/sbin/sshd

Firstly you should be sysadm_r:sysadm_t when you start daemons.  Secondly you 
should use "run_init".

Do the following:
newrole -r sysadm_r
run_init /etc/init.d/sshd start

Then things should be fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
