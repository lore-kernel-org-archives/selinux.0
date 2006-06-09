Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k59AbPYZ018330
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 06:37:25 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149802915.2580.62.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1149802915.2580.62.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com
Subject: Re: General security concerns with the key subsystem 
Date: Fri, 09 Jun 2006 11:11:34 +0100
Message-ID: <29985.1149847894@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> I wanted to follow up on the discussion we started awhile ago, about
> whether we should add unlink permissions to the key subsystem.  I'd be
> glad to add them wherever they're necessary, if you're in favor of this.

We can restart that discussion if you wish.  Do you agree with the idea of
simply adding a new security op that takes { task, keyring, key } and says
whether the task is allowed to unlink that key from that keyring?

Actually adding an UNLINK permission to a key has major problems that need to
be addressed.

> Also, I think this would be a good time to look at the rest of the
> subsystem and try to root out any really severe overt or covert
> channels, if possible.

I'm not sure what you're getting at exactly.

> The most glaring covert channel in the system is the serial number pool.
> Not only is it globally shared, but it has a perfectly predictable
> generation pattern.

Whilst per-process key ID spaces would be nice, it's a little tricky to do,
since an operation may bring a whole host of new keys into a process's
awareness.

> I have a feeling it will be difficult to completely get rid of this channel
> without adding a lot of overhead to the system and requiring some major
> changes to the key-handling code, but there must be something we can do
> about it.  If we randomized the serial numbers, its bandwidth should drop
> significantly, and it doesn't look like that would disrupt your code too
> much, since you're storing keys in rb trees that don't really have any
> dependence on a sequential serial number layout.

I wouldn't have any objection with some other way of allocating key IDs.  The
rb-tree is used to look up keys by ID and to prevent duplicate numbers
cropping up.  Using incremental allocation provides a simple way of finding a
unique key.  I'm not sure what the best way of getting random numbers would be
though.

> The more I think and write about the following, the less convinced I
> become that it's actually a problem SELinux/LSM should defend against,
> but I'll throw it out there anyway to see what you think...  I'm a bit
> concerned about the whole request_key system, which involves the kernel
> invoking an arbitrary callback function.  I know that by default it
> simply invokes a helper that runs with root privileges and prompts the
> user.  However, it's possible that a new type could define a callback
> that could be used to transfer information from one context to another.
> An arbitrary string can be passed along as "call info", so this could be
> a very high-bandwidth channel.

The alternate callback method was requested by the NFS people.  They want to
be able to communicate with gssd or something through the rpc_pipefs
filesystem.

Note that new types are only creatable in kernel modules.  Userspace can't
create them directly.

> Of course, this requires collusion from within the kernel, but perhaps
> we should still try to guard against it.  The most logical way to
> exploit this would be to craft a kernel module that sets up a new key
> type with a request callback that shoves information into some
> particular task or context, and then have a task in some other context
> make requests.

If the attacker can load custom kernel modules, you've pretty much already
lost...

I'm not sure what you're trying to defend against here.

> I think it might be useful to add another hook in
> __request_key_construction to at least regulate which contexts are
> permitted to request keys in the first place.  This would probably
> eliminate most of these concerns without disrupting users of the key
> subsystem.  For example, the only kernel feature that currently uses
> keys, ecryptfs, only requests keys during the mount process.

That would be reasonable, but remember request_key() is more likely in general
to be called from open(), creat(), mkdir(), rmdir(), etc. than from mount
since you ideally want your mountpoints to be user agnostic if possible.

> I was glad to see that negative keys and missing keys are handled
> identically (from the user's perspective) during searches, otherwise the
> error values could have been used to form a channel if two contexts
> share limited access to a keyring.

The main purpose of negative keys is to limit the rate at which request_key()
calls invoke /sbin/request-key or similar.

> However, another way to form a channel would be to move a key between the
> negatively and positively instantiated states, using a fixed description
> string, and simply check the outcome of a search using that description.
> Fortunately, your framework uses a ratcheting mechanism to ensure that
> positively instantiated keys can't be transformed back into negatively
> instantiated keys.  However, an almost identical channel can be formed using
> the "expiry" checks.  This would be a fairly low-bandwidth channel, since
> the smallest timeout is 1 second.  However, this could become significant if
> multiple keys were manipulated simultaneously.  It might be advantageous for
> us to restrict the contexts that are allowed to update the timeouts on keys
> after they have been instantiated, while still allowing them to update other
> attributes.

You require SETATTR permission to modify the timeout on a key, and so it will
invoke SE Linux to do a permissions check.

Permitting an expired key to be rejuvenated by updating it with add_key()
seemed reasonable, but that possibility can be eliminated if you'd prefer.

Revoked keys must be replaced.

> Finally, if we wish to permit the usage of /proc/keys in a secure
> environment, it may be advisable to not list a key unless the current
> context has permission to "view" the key.

/proc/keys is a debugging option, and should be disabled on production
systems.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
