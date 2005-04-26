Date: Tue, 26 Apr 2005 13:48:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steve G <linux_4ever@yahoo.com>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
   selinux@tycho.nsa.gov
Subject: Re: Signal problem
Message-ID: <20050426204846.GE493@shell0.pdx.osdl.net>
References: <20050426203837.1560.qmail@web51507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050426203837.1560.qmail@web51507.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Steve G (linux_4ever@yahoo.com) wrote:
> >Upon termination, what's queued to the netlink socket but not yet
> >received is going to be lost, right?
> 
> I've also tested with nonfatal signals. This bug has been verified by other
> people, too.

Nonfatal signals are delivered to auditd, but don't generate the audit
record?  Is it being filtered away?

> >Perhaps you need to be able to set pid == 0, and still drain the fd 
> >when you recieve a TERM?
> 
> There's no way to drain the netlink socket in a race-free way. I've created a
> whole new technique as a consequence. I'm just down to placing the hook.

If you first set audit_pid to 0, all future messages will go to syslog.  It's
only current netlink socket queue that needs to be drained.  So there's
no livelock issue, just a race against the typical 5 seconds or whatever
it is for init scripts between TERM and KILL while you madly drain the
queue.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
