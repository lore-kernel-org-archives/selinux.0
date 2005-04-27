Subject: Re: Signal problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050426201806.58515.qmail@web51501.mail.yahoo.com>
References: <20050426201806.58515.qmail@web51501.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 07:25:47 -0400
Message-Id: <1114601147.4115.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-26 at 13:18 -0700, Steve G wrote:
> >Isn't this unreliable anyway, e.g. your hook might queue up the audit
> >message for processing by auditd, but auditd gets the signal before it
> >handles the message and exits without emptying the queue?
> 
> The message would be in syslog in that scenario. It isn't there either.

Not necessarily; it could be queued on the netlink socket while
audit_pid was still non-zero, and then the signal is received and auditd
doesn't drain it properly. 

Trivial test for you would be to make your original hook call printk()
instead of audit_log*, and see if you get the message
in /var/log/messages or dmesg as expected.  In any event, I definitely
get SELinux permission denials and audit messages via the existing
security hook there for signal delivery.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
