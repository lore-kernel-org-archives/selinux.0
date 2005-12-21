Subject: Re: newrole cleanup patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051220195134.61236.qmail@web51505.mail.yahoo.com>
References: <20051220195134.61236.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 10:40:08 -0500
Message-Id: <1135179608.18223.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-12-20 at 11:51 -0800, Steve G wrote:
> Hi,
> 
> I've been reviewing newrole in preparation for another patch to add auditing to
> it. The patch is fairly self-explanatory. Some highlights:
<snip>
> - add a function to verify the shell is infact known to /etc/shells
<snip>

Any particular reason you didn't use the getusershell(3) function for
this purpose?  It seems that it has as fallback in case /etc/shells
doesn't exist at all on the system (still permitting /bin/sh
and /bin/csh).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
