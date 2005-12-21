Subject: Re: newrole cleanup patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051221173402.54751.qmail@web51512.mail.yahoo.com>
References: <20051221173402.54751.qmail@web51512.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 12:49:00 -0500
Message-Id: <1135187340.18223.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-21 at 09:34 -0800, Steve G wrote:
> >Any particular reason you didn't use the getusershell(3) function for
> >this purpose?
> 
> Yep. Didn't know about it. :)
> 
> Would you prefer the patch be modified to use it?

I think so, unless there is some known problem with it.  It abstracts
away the details of where the shell information comes from and what the
default values are, so it seems useful.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
