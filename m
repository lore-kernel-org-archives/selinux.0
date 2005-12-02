Message-ID: <439057E9.9050400@tresys.com>
Date: Fri, 02 Dec 2005 09:19:21 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, SELinux-dev@tresys.com
Subject: Re: [patch] checkpolicy cleanups
References: <1133456901.28437.16.camel@moss-spartans.epoch.ncsc.mil>	<438FD2AB.6090408@tresys.com> <1133529023.28437.92.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133529023.28437.92.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2005-12-01 at 23:50 -0500, Joshua Brindle wrote:
> 
>>Will libsepol be made to work on non-Linux platforms, since that is 
>>where all the meat of checkpolicy is now anyway? This would be nice 
>>since modules should basically work afterwards.
> 
> 
> What part of libsepol doesn't work on non-Linux platforms?  The
> checkpolicy changes are just to drop out the netlink class dependency,
> which was Linux-specific; libsepol doesn't have such a dependency
> presently (but see below).
> 
I've never tried it, I just don't assume things are properly portable 
until I see it :)

> 
>>Also I know on SEBSD, at least, the binary format has changed somewhat 
>>which may make the current format compatibility scheme inadequate.
> 
> 
> I think that they may have reverted back to our format (splitting
> classes rather than extending the access vector), but am not completely
> certain.  There was some discussion of that earlier.
> 
Interesting, I hadn't seen that on the trustedbsd list. Are they at 
policy version 15?
> 
>>It is interesting that we hadn't already done that. As it stands an 
>>automatically downgraded policy loaded into a pre-fine grained netlink 
>>kernel will not have netlink rules and will deny everything right?
> 
> 
> Yes, it would deny all accesses to netlink sockets.  But this would only
> happen on a kernel <= 2.6.7 (before the introduction of the fine-grained
> netlink class support in 2.6.8), so it isn't clear it matters in
> practice for anyone.  And someone who is still using 2.6.7 or earlier
> should likely be using an older policy anyway (that still uses the
> single netlink class).
>
> I don't think it is worth introducing the netlink compatibilty "hack"
> into libsepol, and doing so would create the same problem there for
> non-Linux platforms.
> 

in libsepol it could be surrounded by LINUX ifdefs, but you are probably 
  right about it not being necessary in practice.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
