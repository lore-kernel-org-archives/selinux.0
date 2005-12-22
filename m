Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03J1fXf022842
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:01:41 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03J1dah000607
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:01:39 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k03J0pQd032325
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:00:51 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k03J0pGB032324
	for selinux@tycho.nsa.gov; Tue, 3 Jan 2006 14:00:51 -0500
Date: Wed, 21 Dec 2005 20:19:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, Chris Wright <chrisw@sous-sol.org>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Adding audit messge to newrole
Message-ID: <20051222041912.GX20219@sorel.sous-sol.org>
References: <20051221174113.9362.qmail@web51510.mail.yahoo.com> <1135188555.18223.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1135188555.18223.104.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> Yes, but I'm still not sure about the implications.  Not all kernel
> operations compare capability sets, e.g. signals only compare the uids
> of the relevant tasks.  So if you switch to the caller's uid while still
> possessing all capabilities, you may be opening yourself to manipulation
> by the caller.  ptrace does compare the permitted sets for a subset
> relationship.  Might still be safer to shed everything you can first,
> and then drop CAP_SETUID last after the setuid.

It's definitely safer.  Regarding signals, given it's setuid, you can
still send it signals before it has dropped uid.

> > Any reason we can't move this up earlier in main()?
> > 
> > I suppose we could move it above the selinux enabled call.
> > 
> > >Ideally, it should be the first thing in main() to ensure that everything 
> > >else runs under the caller's uid as before.
> > 
> > But after the bindtext call for localization?
> 
> I would assume before, as you otherwise risk still having uid 0 and
> capabilities at that point if there is some locale-related exploit.
> Purging the environment on entry to main() wouldn't hurt either.
> http://www.dwheeler.com/secure-programs/Secure-Programs-HOWTO/

Agreed.

thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
