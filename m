Date: Tue, 26 Apr 2005 13:16:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: Signal problem
Message-ID: <20050426201627.GC493@shell0.pdx.osdl.net>
References: <20050426192327.70954.qmail@web51507.mail.yahoo.com> <1114545376.30521.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1114545376.30521.77.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> On Tue, 2005-04-26 at 12:23 -0700, Steve G wrote:
> > Some background -- we have a CAPP requirement to identify the sender of the 
> > TERM signal to the audit daemon. We placed a hook inside check_kill_permission().
> > It was called on a PPC, but my i686 kernel never sees it. I think there is some
> > arch specific code that changes how signals are delivered on ix86.
> > 
> > My test was simply /etc/rc.d/init.d/auditd stop
> > and then look for a message stating the shutdown signal was received.
> 
> Isn't this unreliable anyway, e.g. your hook might queue up the audit
> message for processing by auditd, but auditd gets the signal before it
> handles the message and exits without emptying the queue?

Ah, right.  That's the issue Steve's been wrestling with.  There's not a nice
race free way to ensure that audit message is delivered via auditd.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
