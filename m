Subject: Re: Signal problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050426192327.70954.qmail@web51507.mail.yahoo.com>
References: <20050426192327.70954.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 15:56:16 -0400
Message-Id: <1114545376.30521.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-26 at 12:23 -0700, Steve G wrote:
> Some background -- we have a CAPP requirement to identify the sender of the 
> TERM signal to the audit daemon. We placed a hook inside check_kill_permission().
> It was called on a PPC, but my i686 kernel never sees it. I think there is some
> arch specific code that changes how signals are delivered on ix86.
> 
> My test was simply /etc/rc.d/init.d/auditd stop
> and then look for a message stating the shutdown signal was received.

Isn't this unreliable anyway, e.g. your hook might queue up the audit
message for processing by auditd, but auditd gets the signal before it
handles the message and exits without emptying the queue?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
