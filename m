Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4EpeXZ023394
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 09:51:42 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4Epe8i025431
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 14:51:40 GMT
Subject: Re: selinux without sysvinit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alejandro Mery <amery@geeks.cl>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41897DD3.5060407@geeks.cl>
References: <4188E956.7020808@geeks.cl>
	 <1099508399.1213.188.camel@moss-spar tans.epoch.ncsc.mil>
	 <41897DD3.5060407@geeks.cl>
Content-Type: text/plain
Message-Id: <1099579644.3174.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 09:47:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 19:54, Alejandro Mery wrote:
> > You either need to load a policy prior to running your runit program
> > (e.g. via an initrd, which is what we originally did), or modify your
> > runit program to load a policy and re-exec itself into the correct
> > security domain (as is done by the sysvinit patch).
> 
> what do you think about an selinux init to load policy and replace 
> itself with /sbin/init (any) after that?

Yes, that should work as well, and I think some people have actually
used that approach in the past.  But if you decide to move aside
/sbin/init and replace it with a small program that loads policy and
then runs the real init program, be careful that telinit is then
redirected to the real init program.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
