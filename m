Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <22702.1161878644@redhat.com>
References: <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 12:34:47 -0400
Message-Id: <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-26 at 17:04 +0100, David Howells wrote:
> > Thus, the cache daemon instance for external data can't tamper with the
> > cache of internal data, or vice versa.  Now, your default configuration may
> > just use a single set of security attributes for all caches, and you might
> > have a default definition in your configuration that is applied in the
> > absence of any per-cache value, but you would be providing a mechanism by
> > which people who want to isolate different caches can do so.
> 
> Sounds okay.  I'm not sure how I'd allow that to be configured.  I suspect
> it'd have to involve the cache module calling an LSM hook for each cache.

I'd expect some userspace process to provide the proper context for each
cache to the cache module during normal configuration, and that context
would come from the same config file that defines the rest of the cache
info.  There would need to be a permission check (via a security hook
call) at that point between the process' context and the provided
context to prevent a given process from setting the context arbitrarily.
Is the configuration of the cache module done by the cache daemon
itself?  What access checks is it normally subjected to?  Do you already
perform a check against the cache dir?

The cache module would then internally store the per-cache context
values, and prior to creating a file within the cache, it would set the
current fscreate attribute (via a security hook call) to that per-cache
value, in much the same way it is presently setting the fsuid/fsgid.
The fscreate attribute is normally set via the security_setprocattr hook
(when a task writes to /proc/self/attr/fscreate); however, you may want
a specialized hook for this purpose that distinguishes the fact that you
are doing this internally.  Or possibly your mechanism for exempting the
cache module from permission checking would allow you to just use
security_setprocattr as is.  You may also want to convert the context
value to a secid once when it is first configured, and then later just
pass the secid to the hook call for setting the fscreate value for
efficiency.  We would need a security_secctx_to_secid() hook for that,
and then a variant of security_setprocattr() that takes a secid instead
of a context value.  Some similar handling already exists for audit,
secmark, peersec, and netlink, although some of those are using selinux
specific interfaces presently (but they can be turned into LSM hooks
fairly easily).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
