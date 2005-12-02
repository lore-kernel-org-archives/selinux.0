Subject: Re: [patch] checkpolicy cleanups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com
In-Reply-To: <439057E9.9050400@tresys.com>
References: <1133456901.28437.16.camel@moss-spartans.epoch.ncsc.mil>
	 <438FD2AB.6090408@tresys.com>
	 <1133529023.28437.92.camel@moss-spartans.epoch.ncsc.mil>
	 <439057E9.9050400@tresys.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 13:41:12 -0500
Message-Id: <1133548872.28437.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-12-02 at 09:19 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > What part of libsepol doesn't work on non-Linux platforms?  The
> > checkpolicy changes are just to drop out the netlink class dependency,
> > which was Linux-specific; libsepol doesn't have such a dependency
> > presently (but see below).
> > 
> I've never tried it, I just don't assume things are properly portable 
> until I see it :)

SE-BSD has used earlier versions of it, not sure when they last
re-based.

> Interesting, I hadn't seen that on the trustedbsd list. Are they at 
> policy version 15?

They were up to version 17 at some point, don't know if they went beyond
it.

> in libsepol it could be surrounded by LINUX ifdefs, but you are probably 
>   right about it not being necessary in practice.

That wouldn't help with this particular problem (which isn't SE-BSD
related); in this case, policy for a non-Linux platform is being built
on a Linux host, I believe.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
