Date: Tue, 26 Apr 2005 13:28:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steve G <linux_4ever@yahoo.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Signal problem
Message-ID: <20050426202759.GD493@shell0.pdx.osdl.net>
References: <20050426201806.58515.qmail@web51501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050426201806.58515.qmail@web51501.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Steve G (linux_4ever@yahoo.com) wrote:
> >Isn't this unreliable anyway, e.g. your hook might queue up the audit
> >message for processing by auditd, but auditd gets the signal before it
> >handles the message and exits without emptying the queue?
> 
> The message would be in syslog in that scenario. It isn't there either.

Upon termination, what's queued to the netlink socket but not yet
received is going to be lost, right?  Perhaps you need to be able to set
pid == 0, and still drain the fd when you recieve a TERM?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
