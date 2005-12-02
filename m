Subject: Re: [patch] checkpolicy cleanups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com
In-Reply-To: <438FD2AB.6090408@tresys.com>
References: <1133456901.28437.16.camel@moss-spartans.epoch.ncsc.mil>
	 <438FD2AB.6090408@tresys.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 08:10:23 -0500
Message-Id: <1133529023.28437.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-01 at 23:50 -0500, Joshua Brindle wrote:
> Will libsepol be made to work on non-Linux platforms, since that is 
> where all the meat of checkpolicy is now anyway? This would be nice 
> since modules should basically work afterwards.

What part of libsepol doesn't work on non-Linux platforms?  The
checkpolicy changes are just to drop out the netlink class dependency,
which was Linux-specific; libsepol doesn't have such a dependency
presently (but see below).

> Also I know on SEBSD, at least, the binary format has changed somewhat 
> which may make the current format compatibility scheme inadequate.

I think that they may have reverted back to our format (splitting
classes rather than extending the access vector), but am not completely
certain.  There was some discussion of that earlier.

> It is interesting that we hadn't already done that. As it stands an 
> automatically downgraded policy loaded into a pre-fine grained netlink 
> kernel will not have netlink rules and will deny everything right?

Yes, it would deny all accesses to netlink sockets.  But this would only
happen on a kernel <= 2.6.7 (before the introduction of the fine-grained
netlink class support in 2.6.8), so it isn't clear it matters in
practice for anyone.  And someone who is still using 2.6.7 or earlier
should likely be using an older policy anyway (that still uses the
single netlink class).

I don't think it is worth introducing the netlink compatibilty "hack"
into libsepol, and doing so would create the same problem there for
non-Linux platforms.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
