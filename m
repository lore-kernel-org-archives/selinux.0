Subject: Re: refpolicy roles / RBAC separation RFC
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1209495402.25678.239.camel@moss-spartans.epoch.ncsc.mil>
References: <1209484450.6110.47.camel@gorn>
	 <1209495402.25678.239.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Apr 2008 15:34:25 -0400
Message-Id: <1209497665.6110.65.camel@gorn>
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
> > 
> > So for example, all of the home directory types will be collapsed into
> > home_t and home_dir_t.  This results in /root having the context
> > root:sysadm_r:home_dir_t.
> > 
> > My current idea for RBAC rules is to group object classes in RBAC
> > constraints similar to the current MLS constraints (e.g. file classes
> > together, network classes together).  The basic RBAC rule will be:
> > 
> > constrain { dir file ... } { getattr read write .... }
> > 	r1 == r2
> > 	or r1 == system_r
> > 	or r2 == object_r
> > 	or r1 == rbac_subj_role_file_exempt
> > 	or r2 == rbac_obj_role_file_exempt
> 
> Do we think there will ever be another "exempt" object role other than
> object_r?  What benefit would it provide?

Perhaps if someone wants an exempt only on a specific set of object
classes, like on files or on process?  I don't have a good example, so I
could just as well drop it.

> > 	or t1 == rbac_subj_type_file_exempt
> > 	or t2 == rbac_obj_type_file_exempt;
> > 
> > Is this too coarse?  Do we want to break it down into read and write
> > rather than just exempt?
> 
> Seems reasonable as a starting point - offhand I don't see the use case
> for splitting it into read/write cases.

I didn't have a use case on this one either.

> > Unfortunately this necessitates some kernel and userspace changes:
[...]
> > Login programs and newrole will have to be changed to set the role on
> > the terminal.
> 
> Not if we get the security_compute_sid logic right and introduce
> role_change rules analogous to the type_change rules.  Then the existing
> security_compute_relabel() calls by login programs and newrole will
> return the desired context.

I just assumed that userspace changes would be preferred since there
doesn't necessarily have to be any logic in figuring out what role to
set on the object, the app would just set whatever role was logging in
(or the role being changed to, in the case of newrole).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
