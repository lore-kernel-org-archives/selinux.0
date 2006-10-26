From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>  <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
Date: Thu, 26 Oct 2006 18:09:34 +0100
Message-ID: <24017.1161882574@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > Sounds okay.  I'm not sure how I'd allow that to be configured.  I suspect
> > it'd have to involve the cache module calling an LSM hook for each cache.
> 
> I'd expect some userspace process to provide the proper context for each
> cache to the cache module during normal configuration, and that context would
> come from the same config file that defines the rest of the cache info.

This is read by the cachefilesd daemon and fed to the module prior to the
start of the caching.

> There would need to be a permission check (via a security hook call) at that
> point between the process' context and the provided context to prevent a
> given process from setting the context arbitrarily.

Okay.

> Is the configuration of the cache module done by the cache daemon itself?

Yes.

> What access checks is it normally subjected to?  Do you already perform a
> check against the cache dir?

The module lets the VFS DAC and MAC stuff check that root has writable access
to the cache dir and will also do checks of the xattr if it's there already.

> The cache module would then internally store the per-cache context values,

Okay.

> and prior to creating a file within the cache, it would set the current
> fscreate attribute (via a security hook call) to that per-cache value, in
> much the same way it is presently setting the fsuid/fsgid.

That sounds reasonable.  There has to be some way to revert it, though.

> The fscreate attribute is normally set via the security_setprocattr hook
> (when a task writes to /proc/self/attr/fscreate);

That makes it sound like fscreate is a per-process attribute, not a per-thread
attribute.  The former would definitely be a problem.

> however, you may want a specialized hook for this purpose that distinguishes
> the fact that you are doing this internally.  Or possibly your mechanism for
> exempting the cache module from permission checking would allow you to just
> use security_setprocattr as is.

Sounds feasible, I think; but I still need to revert the change I imposed.

> You may also want to convert the context value to a secid once when it is
> first configured, and then later just pass the secid to the hook call for
> setting the fscreate value for efficiency.

I'm not sure what you mean by that.  Can you give a pseudo-code example?

> We would need a security_secctx_to_secid() hook for that, and then a variant
> of security_setprocattr() that takes a secid instead of a context value.
> Some similar handling already exists for audit, secmark, peersec, and
> netlink, although some of those are using selinux specific interfaces
> presently (but they can be turned into LSM hooks fairly easily).

You make it sound so simple:-)

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
