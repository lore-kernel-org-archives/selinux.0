Subject: Re: Getting the real task name in avc messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050330210212.38072.qmail@web51507.mail.yahoo.com>
References: <20050330210212.38072.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 16:14:41 -0500
Message-Id: <1112217281.8012.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 13:02 -0800, Steve G wrote:
> I'm not sure we need this information for regular auditing. I haven't seen
> regular audit messages that showed the interpreter instead of the program. The
> problem does exist for avc denials.

Presently the syscall auditing (i.e. audit_log_exit) doesn't show the
program name at all, just the pid.  That's why I suggested moving this
to audit_log_exit, so that you can get more useful information.  pid is
rarely helpful except for long lived processes, whereas the exe and comm
can be helpful.

> I know about that. I know where to find the full path (example code is over in
> the proc file system), but I don't have time to improve this patch right now. I
> just want to get this out in the open and show that the status quo can be
> improved a little.

avc_audit() already does that (the exe= info).  So you just need to move
it over.  See my patch that I just sent.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
