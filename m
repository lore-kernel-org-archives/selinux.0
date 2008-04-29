Subject: Re: refpolicy roles / RBAC separation RFC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1209484450.6110.47.camel@gorn>
References: <1209484450.6110.47.camel@gorn>
Content-Type: text/plain
Date: Tue, 29 Apr 2008 14:56:42 -0400
Message-Id: <1209495402.25678.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-29 at 11:54 -0400, Christopher J. PeBenito wrote:
> For those interested all of the user roles have been separated out into
> individual modules in a new roles refpolicy layer, in refpolicy trunk.
> This should enable interested users to add and remove roles more easily.
> Each of the user roles has a module named after it (e.g., sysadm module
> for sysadm_r), except user_r, which has a name unprivuser, since its not
> possible to use "user" as a module name since it is a policy keyword.
> 
> Next we will be doing an experiment attempting to use the SELinux RBAC
> functionality to separate users instead of SELinux TE.  What this means
> is that the role field will start being used more substantially than it
> currently is.  In a nutshell, this means that all user objects will have
> the user's role rather than object_r.  Then the separate types will be
> collapsed into one type where possible.  This will result in per-role
> types (e.g., user_mozilla_t, staff_mozilla_t) collapsing too
> (mozilla_t).
> 
> So for example, all of the home directory types will be collapsed into
> home_t and home_dir_t.  This results in /root having the context
> root:sysadm_r:home_dir_t.
> 
> My current idea for RBAC rules is to group object classes in RBAC
> constraints similar to the current MLS constraints (e.g. file classes
> together, network classes together).  The basic RBAC rule will be:
> 
> constrain { dir file ... } { getattr read write .... }
> 	r1 == r2
> 	or r1 == system_r
> 	or r2 == object_r
> 	or r1 == rbac_subj_role_file_exempt
> 	or r2 == rbac_obj_role_file_exempt

Do we think there will ever be another "exempt" object role other than
object_r?  What benefit would it provide?

> 	or t1 == rbac_subj_type_file_exempt
> 	or t2 == rbac_obj_type_file_exempt;
> 
> Is this too coarse?  Do we want to break it down into read and write
> rather than just exempt?

Seems reasonable as a starting point - offhand I don't see the use case
for splitting it into read/write cases.

> Unfortunately this necessitates some kernel and userspace changes:
> 
> Roles aren't respected on objects in the kernel.  So if you create a
> file in a directory that has the role staff_r, the file will have an
> object_r role instead of staff_r.

That's an easy patch to security_compute_sid() to inherit role from the
target (related object) context rather than using object_r always.   In
which case we'll just inherit from the parent directory by default.  And
then role transition support on object classes.

> Login programs and newrole will have to be changed to set the role on
> the terminal.

Not if we get the security_compute_sid logic right and introduce
role_change rules analogous to the type_change rules.  Then the existing
security_compute_relabel() calls by login programs and newrole will
return the desired context.

> The above example rule utilizes a role attribute, which doesn't exist.
> In the absence of role attributes, role dominance can be used, but its
> unclear if the dominance code works, since no one uses it.

Yes, I think we should just add role attribute support.

> Genhomedircon may need to be updated.
> 
> Tools such as audit2allow will need more audit2why-like support and
> policy info to fix RBAC denials (a general constraints usability issue).

Dan has already moved audit2why into a shared object with a swig wrapper
to enable use by audit2allow.  Extending it to export more information
about constraint denials should be doable, although creating suitable
shared library interfaces for libsepol to get the information from the
policy will be more work.

> Comments?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
