Subject: Re: refpolicy roles / RBAC separation RFC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1210181546.8778.20.camel@gorn>
References: <1209484450.6110.47.camel@gorn>
	 <1209495402.25678.239.camel@moss-spartans.epoch.ncsc.mil>
	 <1210181546.8778.20.camel@gorn>
Content-Type: text/plain
Date: Wed, 07 May 2008 14:07:05 -0400
Message-Id: <1210183625.6434.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-07 at 13:32 -0400, Christopher J. PeBenito wrote:
> On Tue, 2008-04-29 at 14:56 -0400, Stephen Smalley wrote:
> > On Tue, 2008-04-29 at 11:54 -0400, Christopher J. PeBenito wrote:
> > > Next we will be doing an experiment attempting to use the SELinux RBAC
> > > functionality to separate users instead of SELinux TE.  What this means
> > > is that the role field will start being used more substantially than it
> > > currently is.  In a nutshell, this means that all user objects will have
> > > the user's role rather than object_r.  Then the separate types will be
> > > collapsed into one type where possible.  This will result in per-role
> > > types (e.g., user_mozilla_t, staff_mozilla_t) collapsing too
> > > (mozilla_t).
> [...]
> > > The above example rule utilizes a role attribute, which doesn't exist.
> > > In the absence of role attributes, role dominance can be used, but its
> > > unclear if the dominance code works, since no one uses it.
> 
> Turns out that I can't use role dominance because dom and domby in
> constraints only seem to work (syntax error) between r1 and r2, rather
> than r1 and a specific role.

Ah, yes.  And that's true not only of checkpolicy but the constraint
evaluator in libsepol and the kernel too.  Only supports == and != for
comparing against a specific value or membership within a specific type
attribute, and the dominance operators are limited to comparing source
and target.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
