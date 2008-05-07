Subject: Re: refpolicy roles / RBAC separation RFC
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1209495402.25678.239.camel@moss-spartans.epoch.ncsc.mil>
References: <1209484450.6110.47.camel@gorn>
	 <1209495402.25678.239.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 07 May 2008 13:32:26 -0400
Message-Id: <1210181546.8778.20.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-04-29 at 14:56 -0400, Stephen Smalley wrote:
> On Tue, 2008-04-29 at 11:54 -0400, Christopher J. PeBenito wrote:
> > Next we will be doing an experiment attempting to use the SELinux RBAC
> > functionality to separate users instead of SELinux TE.  What this means
> > is that the role field will start being used more substantially than it
> > currently is.  In a nutshell, this means that all user objects will have
> > the user's role rather than object_r.  Then the separate types will be
> > collapsed into one type where possible.  This will result in per-role
> > types (e.g., user_mozilla_t, staff_mozilla_t) collapsing too
> > (mozilla_t).
[...]
> > The above example rule utilizes a role attribute, which doesn't exist.
> > In the absence of role attributes, role dominance can be used, but its
> > unclear if the dominance code works, since no one uses it.

Turns out that I can't use role dominance because dom and domby in
constraints only seem to work (syntax error) between r1 and r2, rather
than r1 and a specific role.

> Yes, I think we should just add role attribute support.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
