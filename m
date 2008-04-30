Subject: Re: refpolicy roles / RBAC separation RFC
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1209498521.25678.258.camel@moss-spartans.epoch.ncsc.mil>
References: <1209484450.6110.47.camel@gorn>
	 <1209495402.25678.239.camel@moss-spartans.epoch.ncsc.mil>
	 <1209497665.6110.65.camel@gorn>
	 <1209498521.25678.258.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 09:48:30 -0400
Message-Id: <1209563310.1053.7.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-04-29 at 15:48 -0400, Stephen Smalley wrote:
> On Tue, 2008-04-29 at 15:34 -0400, Christopher J. PeBenito wrote:
> > On Tue, 2008-04-29 at 14:56 -0400, Stephen Smalley wrote:
> > > On Tue, 2008-04-29 at 11:54 -0400, Christopher J. PeBenito wrote:
> > > > Next we will be doing an experiment attempting to use the SELinux RBAC
> > > > functionality to separate users instead of SELinux TE.  What this means
> > > > is that the role field will start being used more substantially than it
> > > > currently is.  In a nutshell, this means that all user objects will have
> > > > the user's role rather than object_r.  Then the separate types will be
> > > > collapsed into one type where possible.  This will result in per-role
> > > > types (e.g., user_mozilla_t, staff_mozilla_t) collapsing too
> > > > (mozilla_t).
[...]
> > > > Unfortunately this necessitates some kernel and userspace changes:
> > [...]
> > > > Login programs and newrole will have to be changed to set the role on
> > > > the terminal.
> > > 
> > > Not if we get the security_compute_sid logic right and introduce
> > > role_change rules analogous to the type_change rules.  Then the existing
> > > security_compute_relabel() calls by login programs and newrole will
> > > return the desired context.
> > 
> > I just assumed that userspace changes would be preferred since there
> > doesn't necessarily have to be any logic in figuring out what role to
> > set on the object, the app would just set whatever role was logging in
> > (or the role being changed to, in the case of newrole).
> 
> So under that approach, would userspace cease using
> security_compute_relabel() altogether?  As its only real use today is to
> obtain a derived type, and you are eliminating those.
> 
> I suppose that would be simpler.

I didn't think of removing security_compute_relabel().  I figured it
would stick around for compatibility.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
