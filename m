Subject: Re: [PATCH] newrole cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20060110223808.66858.qmail@web51501.mail.yahoo.com>
References: <20060110223808.66858.qmail@web51501.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:55:47 -0500
Message-Id: <1137160547.3445.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-10 at 14:38 -0800, Steve G wrote:
> Hi,
> 
> I've been reviewing newrole in preparation for another patch to add auditing to
> it. The patch is fairly self-explanatory. Some highlights:
> 
> - little const cleanup
> - pass tty to pam
> - add a function to verify the shell is in fact known to /etc/shells
> - make sure no signals are blocked
> - If in enforcing mode and error: getting tty context, computing new context, or
> setting new context  then exit with -1.
> - Loop the wait call to handle EINTR
> - open the tty read only or write only depending on stdin, stdout, stderr.
> - pass return from pam_* functions to pam_end
> 
> The patch is attached.

Merged the updated patch as of policycoreutils 1.29.7.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
