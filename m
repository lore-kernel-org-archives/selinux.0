Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3J40XZ017437
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 14:04:00 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3J40JZ013641
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 19:04:00 GMT
Subject: Re: selinux without sysvinit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alejandro Mery <amery@geeks.cl>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4188E956.7020808@geeks.cl>
References: <4188E956.7020808@geeks.cl>
Content-Type: text/plain
Message-Id: <1099508399.1213.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 14:00:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 09:21, Alejandro Mery wrote:
> Hi, i am a complete newbie about selinux but i would like to use it on 
> my machines.
> 
> the 'problem' is i don't use sysvinit. i use runit 
> http://smarden.org/runit/ instead.
> 
> runit has only 3 stages, and runs an script on each one.
> stage 1: configures the machine
> stage 2: run services and keep them supervised (like daemontools)
> stage 3: stop services, umount and halt
> 
> on download page you said sysvinit patch can be replaced by initrd, how? 
> how safe is it? may i need to patch runit in the same way?

You either need to load a policy prior to running your runit program
(e.g. via an initrd, which is what we originally did), or modify your
runit program to load a policy and re-exec itself into the correct
security domain (as is done by the sysvinit patch).  Entirely up to you;
cost of doing it from the initrd is that you have to rebuild the initrd
if you need to change anything in that bootstrapping policy (you can
always load a more complete policy later).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
