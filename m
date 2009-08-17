Subject: Re: Why use write_lock_irq() in services.c
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1250534155.3629.142.camel@moss-pluto.epoch.ncsc.mil>
References: <1250533573.4829.9.camel@dhcp231-106.rdu.redhat.com>
	 <1250534155.3629.142.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 14:38:10 -0400
Message-Id: <1250534290.4829.13.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-17 at 14:35 -0400, Stephen Smalley wrote:
> On Mon, 2009-08-17 at 14:26 -0400, Eric Paris wrote:
> > In security_load_policy() and security_set_bools() we take
> > write_lock_irq(&policy_rwlock);  I want to make sure I understand why we
> > need the _irq.  Is it just because it's possible that in irq context we
> > might come down a path that leads to a read_lock() which would deadlock
> > against the write_lock?  There is no concern for irqs to ever get to a
> > write_lock that I can see, is that correct as well?
> > 
> > /me playing with locking a bit....
> 
> Correct.  As per Documentation/spinlocks.txt.
> 
> And we wouldn't really need a read/write lock at all if:
> a) load_policy could atomically switch the policies (by way of the
> changes I've previously sketched, and
> b) set_bools acted on a copy of the policydb and then atomically
> switched to it rather than mutating the active policy state (but that
> would make boolean setting more heavy weight).

I don't want to tell you I'm working on exactly that because you might
expect results.  As we both know at any moment I might see a shiny
bobble and run off to do something else.  So, if you can think of some
other reason I'm making sure I understand that locking correctly I would
appreciate it if you believe that situation.  Believing anything that
results in no perceptible benefit to the community is always the safest
when dealing with me *smile*.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
