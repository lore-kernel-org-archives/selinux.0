Subject: Re: [RFC PATCH] 1/2 decouple fscontext/context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1151619092.26384.90.camel@localhost.localdomain>
References: <1151536165.26384.48.camel@localhost.localdomain>
	 <1151596403.6999.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1151619092.26384.90.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 10:39:05 -0400
Message-Id: <1151678345.29428.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-29 at 18:11 -0400, Eric Paris wrote:
> suggestion for a meaningful name?  context_mount_set_perm()?

may_context_mount()?

> So you are saying that both should check against the superblock.  The
> question is if this second check should be the 'new' superblock context
> (since may have been just set by fscontext=) or should I be checking the
> 'old' sb sid here?

Rechecking the old one would be redundant with the prior check, so
checking the updated one seems more useful.

> Originally when I put this in I didn't know if there was any way to get
> mount point labeling behavior without a context= option.  During testing
> I looked around and realized there was no other way (that I saw) but
> never pulled this back out.

Right, so you can drop the conditional.  Makes it easier to understand
as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
