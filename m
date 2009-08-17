Subject: Re: Why use write_lock_irq() in services.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1250533573.4829.9.camel@dhcp231-106.rdu.redhat.com>
References: <1250533573.4829.9.camel@dhcp231-106.rdu.redhat.com>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 14:35:55 -0400
Message-Id: <1250534155.3629.142.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-17 at 14:26 -0400, Eric Paris wrote:
> In security_load_policy() and security_set_bools() we take
> write_lock_irq(&policy_rwlock);  I want to make sure I understand why we
> need the _irq.  Is it just because it's possible that in irq context we
> might come down a path that leads to a read_lock() which would deadlock
> against the write_lock?  There is no concern for irqs to ever get to a
> write_lock that I can see, is that correct as well?
> 
> /me playing with locking a bit....

Correct.  As per Documentation/spinlocks.txt.

And we wouldn't really need a read/write lock at all if:
a) load_policy could atomically switch the policies (by way of the
changes I've previously sketched, and
b) set_bools acted on a copy of the policydb and then atomically
switched to it rather than mutating the active policy state (but that
would make boolean setting more heavy weight).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
