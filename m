Subject: Re: [PATCH] remove selinux stacked ops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@osdl.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@wirex.com
In-Reply-To: <1125057491.5812.38.camel@moss-spartans.epoch.ncsc.mil>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
	 <20050825225104.GC7762@shell0.pdx.osdl.net>
	 <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1125057491.5812.38.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 08:29:58 -0400
Message-Id: <1125059398.5812.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 07:58 -0400, Stephen Smalley wrote:
> Ok, as with my prior comment, this one is also invalidated by the fact
> that the static inlines fall back to the cap_ functions if the operation
> is NULL.  So I suppose this would work.

Given these changes, what purpose does the capability module and the
CONFIG_SECURITY_CAPABILITIES option serve anymore?  Should capability.c
be removed entirely?

Also seems to obsolete the cap_stack module in the stacking patch set.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
