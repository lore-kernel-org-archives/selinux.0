Subject: Re: Getting the real task name in avc messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050330195313.44516.qmail@web51504.mail.yahoo.com>
References: <20050330195313.44516.qmail@web51504.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 15:41:30 -0500
Message-Id: <1112215290.8012.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 11:53 -0800, Steve G wrote:
> Hello,
> 
> Attached is a patch to the kernel that puts the program's name into the avc
> message. This lets you know the script that caused the problem instead of
> /bin/bash. Feedback would be appreciated.

I don't think you want to put this in avc_audit.  Instead, the goal is
to migrate processing from avc_audit to audit_log_exit where it makes
sense to do so.  Note that anytime avc_audit generates an audit message,
audit_log_exit will be called upon syscall exit, so by adding a call to
your new function to audit_log_exit, you'll ensure that this information
is recorded for every avc denial as well as every other audit message.
Note that you don't need to repeate the syscall= and per= information,
as it will already be handled by audit_log_exit for you.  I also think
that the exe= logging should be moved to audit_log_exit, and the
existing logging of the comm should be removed from avc_audit entirely.

Note that the comm field is less complete (not a full path and may even
be truncated) and is not trustworthy (can be changed by the process to
any arbitrary string).  So you can't rely on it, but it can be useful
for debugging.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
