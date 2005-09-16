Subject: Re: Doing testing with MCS looks like we get initial roles/levels
	by using fromcon.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <432B1157.8070703@redhat.com>
References: <4329DF91.2060208@redhat.com>
	 <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>
	 <432AFFE4.3010001@redhat.com>
	 <1126894521.27393.81.camel@moss-spartans.epoch.ncsc.mil>
	 <432B1157.8070703@redhat.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 14:51:23 -0400
Message-Id: <1126896683.27393.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-16 at 14:39 -0400, Daniel J Walsh wrote:
> Not sure how the admim would set this up.  I was thinking the admin 
> would just state that
> when dwalsh logs in I want this as his preferred context.  Policy could 
> allow or modify the preferred context
> as it sees fit.

No, I don't think we want them specifying a full context.  Considering
it further, I don't think they should even specify the role.  They can
just specify a SELinux username and a range, and let the rest of the
context (role, type) be computed based on policy in the usual manner, so
that we can still have per-fromcon roles and types for a given user.

> Correct and this translation would be purely option from libselinux 
> point of view.  pam and other freinds need it.

But if pam and other SELinux userland depends on it and you put it into
libsetrans, then it has to be provided by every libsetrans
implementation, not just yours.  At which point it would be better to
have it in a separate library that doesn't have multiple instances.  

> Yes.  This might be a reason to change the function call, although as 
> your example showed it
> might it be disconcerting from the user to request he logs in as role 
> (nurse_r) but gets user_r when logging in locally.

Admin should just specify that the Linux user default to nurse_u and
s0:c0,c3 and let the usual rules apply to role and type selection for
nurse_u.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
