Subject: Re: refpolicy roles / RBAC separation RFC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <4818ADD4.4000505@redhat.com>
References: <1209484450.6110.47.camel@gorn>  <48175B0A.4080800@redhat.com>
	 <1209496821.25678.249.camel@moss-spartans.epoch.ncsc.mil>
	 <4818637C.30108@redhat.com>
	 <1209559500.25678.268.camel@moss-spartans.epoch.ncsc.mil>
	 <48189194.1090607@redhat.com>
	 <1209575852.25678.332.camel@moss-spartans.epoch.ncsc.mil>
	 <4818ADD4.4000505@redhat.com>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 13:50:47 -0400
Message-Id: <1209577847.25678.360.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-30 at 13:35 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Wed, 2008-04-30 at 11:34 -0400, Daniel J Walsh wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Stephen Smalley wrote:
> >>> On Wed, 2008-04-30 at 08:18 -0400, Daniel J Walsh wrote:
> >>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>> Hash: SHA1
> >>>>
> >>>> Stephen Smalley wrote:
> >>>>> On Tue, 2008-04-29 at 13:29 -0400, Daniel J Walsh wrote:
> >>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>>> Hash: SHA1
> >>>>>>
> >>>>>> Christopher J. PeBenito wrote:
> >>>>>>> For those interested all of the user roles have been separated out into
> >>>>>>> individual modules in a new roles refpolicy layer, in refpolicy trunk.
> >>>>>>> This should enable interested users to add and remove roles more easily.
> >>>>>>> Each of the user roles has a module named after it (e.g., sysadm module
> >>>>>>> for sysadm_r), except user_r, which has a name unprivuser, since its not
> >>>>>>> possible to use "user" as a module name since it is a policy keyword.
> >>>>>>>
> >>>>>>> Next we will be doing an experiment attempting to use the SELinux RBAC
> >>>>>>> functionality to separate users instead of SELinux TE.  What this means
> >>>>>>> is that the role field will start being used more substantially than it
> >>>>>>> currently is.  In a nutshell, this means that all user objects will have
> >>>>>>> the user's role rather than object_r.  Then the separate types will be
> >>>>>>> collapsed into one type where possible.  This will result in per-role
> >>>>>>> types (e.g., user_mozilla_t, staff_mozilla_t) collapsing too
> >>>>>>> (mozilla_t).
> >>>>>>>
> >>>>>>> So for example, all of the home directory types will be collapsed into
> >>>>>>> home_t and home_dir_t.  This results in /root having the context
> >>>>>>> root:sysadm_r:home_dir_t.
> >>>>>>>
> >>>>>>> My current idea for RBAC rules is to group object classes in RBAC
> >>>>>>> constraints similar to the current MLS constraints (e.g. file classes
> >>>>>>> together, network classes together).  The basic RBAC rule will be:
> >>>>>>>
> >>>>>>> constrain { dir file ... } { getattr read write .... }
> >>>>>>> 	r1 == r2
> >>>>>>> 	or r1 == system_r
> >>>>>>> 	or r2 == object_r
> >>>>>>> 	or r1 == rbac_subj_role_file_exempt
> >>>>>>> 	or r2 == rbac_obj_role_file_exempt
> >>>>>>> 	or t1 == rbac_subj_type_file_exempt
> >>>>>>> 	or t2 == rbac_obj_type_file_exempt;
> >>>>>>>
> >>>>>>> Is this too coarse?  Do we want to break it down into read and write
> >>>>>>> rather than just exempt?
> >>>>>>>
> >>>>>>> Unfortunately this necessitates some kernel and userspace changes:
> >>>>>>>
> >>>>>>> Roles aren't respected on objects in the kernel.  So if you create a
> >>>>>>> file in a directory that has the role staff_r, the file will have an
> >>>>>>> object_r role instead of staff_r.
> >>>>>>>
> >>>>>>> Login programs and newrole will have to be changed to set the role on
> >>>>>>> the terminal.
> >>>>>>>
> >>>>>>> The above example rule utilizes a role attribute, which doesn't exist.
> >>>>>>> In the absence of role attributes, role dominance can be used, but its
> >>>>>>> unclear if the dominance code works, since no one uses it.
> >>>>>>>
> >>>>>>> Genhomedircon may need to be updated.
> >>>>>>>
> >>>>>>> Tools such as audit2allow will need more audit2why-like support and
> >>>>>>> policy info to fix RBAC denials (a general constraints usability issue).
> >>>>>>>
> >>>>>>> Comments?
> >>>>>>>
> >>>>>> As has been stated before, I am not interested in separation of the
> >>>>>> homedir based on Role, since this will prevent shared homedirs on
> >>>>>> machines where the same user has different roles.  Also makes testing of
> >>>>>> homedir roles difficult since changing a role requires a full relabel of
> >>>>>> the homedir.  Labeling of the /root directory should be static and not
> >>>>>> related to user or role, because domains often want read/write access to
> >>>>>> the root directory and dontauditing this becomes complex if this changes
> >>>>>> based on semanage rules.
> >>>>>>
> >>>>>> service XYZ start in /root will almost always generate a search of the
> >>>>>> /root directory.
> >>>>>>
> >>>>>> Currently Fedora labeling on the homedir is user_home_t or
> >>>>>> user_mozilla_home_t, Ie everything user_* So switching this to
> >>>>>> mozilla_home_t or home_t would be fine.
> >>>>> As before, I don't believe any of this would force anyone to separate
> >>>>> files based on role; it would be driven by policy configuration and
> >>>>> using object_r pervasively would continue to work fine.  It would just
> >>>>> offer the ability to provide such separation based on role if so
> >>>>> configured, and it would drop the use of derived types to achieve such
> >>>>> separation.
> >>>>>
> >>>>> If you aren't going to separate files based on role though, you may want
> >>>>> to think about how to protect roles against influence by other roles so
> >>>>> that e.g. user_r or staff_r cannot inject commands to be run by sysadm_r
> >>>>> into dotfiles.  DAC will help you with user-based separation (somewhat),
> >>>>> but there is still the case where you have a user who is authorized for
> >>>>> staff_r and sysadm_r who logs in initially in staff_r and later switches
> >>>>> to sysadm_r.  There you have consider the potential of a flawed or
> >>>>> malicious program run while in staff_r trying to inject commands to be
> >>>>> run in sysadm_r, all running under the same user identity.
> >>>>>
> >>>> I label /root admin_home_t and don't allow any confined role to write to
> >>>> it.  I have sysadm_r but have written before that I think it is a waste
> >>>> of time, and prefer to just use unconfined_r.
> >>>>
> >>>> My view of the world is that you have a "login" role and you have an
> >>>> "admin" role.  On my machine this is staff_r and unconfined_r, respectively.
> >>> Right, but whether unconfined_r or sysadm_r, the question is how to
> >>> protect the more-privileged role (unconfined_r in your case) from
> >>> influence by the less-privileged login role (staff_r) when they both
> >>> operate under the same DAC uid and thus share the same set of dotfiles.
> >>> The per-role types or roles on home directory files are one mechanism
> >>> for achieving that protection.  Another way would be to polyinstantiate
> >>> the home directories by role.  Another way that relies on DAC-only would
> >>> be to create a dedicated (pseudo) user account for each role with its
> >>> own home directory and "safe" set of dotfiles and switch to that account
> >>> when switching roles.
> >>>
> >> But you are assuming the UID does not change.   Since I look at the
> >> world as Two Roles,  One Role when I am normal user and another role
> >> when I am root.   I don't have this problem.  I don't want users using
> >> newrole,  I want them to use sudo.  So unconfined_t or webadm_t when
> >> UID==root, staff_t when UID=dwalsh.  newrole is just a complexity that
> >> most users do not understand.    Since a confined application can not
> >> read by default the directories of the user, the user will not be able
> >> to effect the confined domain.
> > 
> > That's essentially the last case (create a dedicated pseudo user account
> > for each role with its own home directory) simplified to two-roles-only.
> > But I think you'll eventually find two-roles-only to be too limiting
> > (and certainly not sufficient for RBAC for organizations).
> > 
> But I would argue this is exactly why RBAC has never caught on, because
> administrators and users do not think of themselves as Roles, they run
> applications.  The only roles an administrator of Unix systems
> understands and his login role and his admin role.  He is not going to
> want to run commands to Switch Roles other than Sudo, which my mechanism
> fully supports.  But imagining him switching roles while root or while a
> user is way too complicated.

It doesn't have to be too complicated, and it is actually quite natural
as a model for organizations.

In any event, all I am saying is that there has to be a mechanism for
protecting the role against influence by less privileged roles, and if
you want to use separate user accounts (which is what you are doing
here) to achieve that protection as far as the filesystem is concerned
(while still using SELinux for role process isolation), then that is
certainly an option.  But doing it via primary user accounts is less
helpful than introducing pseudo user accounts dedicated to the
particular role, I think, as we want to preserve user accountability
while acting in a given role.  This btw is the Solaris model for roles -
they are pseudo user accounts that cannot be directly logged into, only
assumable via su.

> We have had a hard time convincing users to Leave SELinux on, now we
> want to start adding new complexities, that have nothing to do with the
> way they are used to working.  Seems to be a lot of work for little
> benefit for the masses.

Well, first, as you know, from what we've seen, the majority of Fedora
users now seem to be leaving SELinux enabled as they now have the tools
they need to recognize and solve the most common problems.

I'm not sure why you think we're adding complexity here; Chris is merely
migrating an existing mechanism for supporting role-based separation in
the filesystem (via derived types) to a new mechanism (directly based on
roles).  And you just want to use neither of those mechanisms, which is
your option, instead choosing to use a DAC-based mechanism.  Nothing
Chris is doing makes your job any harder AFAICS.

Meanwhile, there is real use of RBAC in organizations; you might want to
look over some of the resources on:
http://csrc.nist.gov/groups/SNS/rbac/

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
