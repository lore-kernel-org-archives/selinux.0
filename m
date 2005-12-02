Message-ID: <438FD2AB.6090408@tresys.com>
Date: Thu, 01 Dec 2005 23:50:51 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, SELinux-dev@tresys.com
Subject: Re: [patch] checkpolicy cleanups
References: <1133456901.28437.16.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133456901.28437.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Just FYI, a couple of cleanups have been committed to checkpolicy,
> attached below.  
> 
> First patch was based on patches submitted by George Coker and drops out
> the compatibility handling of netlink classes from checkpolicy as well
> as making fs_use optional.  The motivation was to allow checkpolicy to
> work for non-Linux platforms where the netlink classes are meaningless.
Will libsepol be made to work on non-Linux platforms, since that is 
where all the meat of checkpolicy is now anyway? This would be nice 
since modules should basically work afterwards.

Also I know on SEBSD, at least, the binary format has changed somewhat 
which may make the current format compatibility scheme inadequate.

> I think that the compatibility code there is no longer necessary since
> the change occurred back in Linux 2.6.8, and it would only matter if you
> were trying to compile a newer policy source with the fine-grained
> netlink classes to a form useable by a 2.6.7 or older kernel.  Also,
> even if we wanted to retain this remapping support, we would need to
> move it into libsepol to handle policy modules and automatic downgrading
> of policy upon policy load.

It is interesting that we hadn't already done that. As it stands an 
automatically downgraded policy loaded into a pre-fine grained netlink 
kernel will not have netlink rules and will deny everything right?
> 
> Second patch adds error checking for a number of cases in checkpolicy
> where it was failing to check for failure on ebitmap_set_bit calls
> (which can occur due to an out of memory condition); I happened to
> notice that lack of such checking when merging the first patch.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
