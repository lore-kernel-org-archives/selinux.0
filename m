Subject: Re: [PATCH] remove selinux stacked ops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@osdl.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@wirex.com
In-Reply-To: <20050826162241.GG7762@shell0.pdx.osdl.net>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
	 <20050825225104.GC7762@shell0.pdx.osdl.net>
	 <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1125057491.5812.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1125059398.5812.53.camel@moss-spartans.epoch.ncsc.mil>
	 <20050826162241.GG7762@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 12:50:22 -0400
Message-Id: <1125075022.8692.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 09:22 -0700, Chris Wright wrote:
> I left it for two reasons.  Making it built-in will mean you can't
> load another security module.

CONFIG_SECURITY=n achieves the same effect.

>   Some distros use the module already, so
> it's compatibility.  

I'd assume that they only do that so that they can load something else
as primary, and then optionally stack capability under it.  Which they
can still achieve (just by modifying their primary to use the commoncap
functions directly).

> These aren't the best reasons to keep it long term.

Yes, it seems confusing to leave it.  I can easily see people leaving it
enabled as long as it remains without realizing that it is no longer
serving any purpose.  And it will definitely kick out an error message
if you leave SELinux+capability enabled together due to the failed
registration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
