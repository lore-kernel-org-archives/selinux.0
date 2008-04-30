Message-ID: <4818637C.30108@redhat.com>
Date: Wed, 30 Apr 2008 08:18:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: refpolicy roles / RBAC separation RFC
References: <1209484450.6110.47.camel@gorn>  <48175B0A.4080800@redhat.com> <1209496821.25678.249.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1209496821.25678.249.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2008-04-29 at 13:29 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Christopher J. PeBenito wrote:
>>> For those interested all of the user roles have been separated out into
>>> individual modules in a new roles refpolicy layer, in refpolicy trunk.
>>> This should enable interested users to add and remove roles more easily.
>>> Each of the user roles has a module named after it (e.g., sysadm module
>>> for sysadm_r), except user_r, which has a name unprivuser, since its not
>>> possible to use "user" as a module name since it is a policy keyword.
>>>
>>> Next we will be doing an experiment attempting to use the SELinux RBAC
>>> functionality to separate users instead of SELinux TE.  What this means
>>> is that the role field will start being used more substantially than it
>>> currently is.  In a nutshell, this means that all user objects will have
>>> the user's role rather than object_r.  Then the separate types will be
>>> collapsed into one type where possible.  This will result in per-role
>>> types (e.g., user_mozilla_t, staff_mozilla_t) collapsing too
>>> (mozilla_t).
>>>
>>> So for example, all of the home directory types will be collapsed into
>>> home_t and home_dir_t.  This results in /root having the context
>>> root:sysadm_r:home_dir_t.
>>>
>>> My current idea for RBAC rules is to group object classes in RBAC
>>> constraints similar to the current MLS constraints (e.g. file classes
>>> together, network classes together).  The basic RBAC rule will be:
>>>
>>> constrain { dir file ... } { getattr read write .... }
>>> 	r1 == r2
>>> 	or r1 == system_r
>>> 	or r2 == object_r
>>> 	or r1 == rbac_subj_role_file_exempt
>>> 	or r2 == rbac_obj_role_file_exempt
>>> 	or t1 == rbac_subj_type_file_exempt
>>> 	or t2 == rbac_obj_type_file_exempt;
>>>
>>> Is this too coarse?  Do we want to break it down into read and write
>>> rather than just exempt?
>>>
>>> Unfortunately this necessitates some kernel and userspace changes:
>>>
>>> Roles aren't respected on objects in the kernel.  So if you create a
>>> file in a directory that has the role staff_r, the file will have an
>>> object_r role instead of staff_r.
>>>
>>> Login programs and newrole will have to be changed to set the role on
>>> the terminal.
>>>
>>> The above example rule utilizes a role attribute, which doesn't exist.
>>> In the absence of role attributes, role dominance can be used, but its
>>> unclear if the dominance code works, since no one uses it.
>>>
>>> Genhomedircon may need to be updated.
>>>
>>> Tools such as audit2allow will need more audit2why-like support and
>>> policy info to fix RBAC denials (a general constraints usability issue).
>>>
>>> Comments?
>>>
>> As has been stated before, I am not interested in separation of the
>> homedir based on Role, since this will prevent shared homedirs on
>> machines where the same user has different roles.  Also makes testing of
>> homedir roles difficult since changing a role requires a full relabel of
>> the homedir.  Labeling of the /root directory should be static and not
>> related to user or role, because domains often want read/write access to
>> the root directory and dontauditing this becomes complex if this changes
>> based on semanage rules.
>>
>> service XYZ start in /root will almost always generate a search of the
>> /root directory.
>>
>> Currently Fedora labeling on the homedir is user_home_t or
>> user_mozilla_home_t, Ie everything user_* So switching this to
>> mozilla_home_t or home_t would be fine.
> 
> As before, I don't believe any of this would force anyone to separate
> files based on role; it would be driven by policy configuration and
> using object_r pervasively would continue to work fine.  It would just
> offer the ability to provide such separation based on role if so
> configured, and it would drop the use of derived types to achieve such
> separation.
> 
> If you aren't going to separate files based on role though, you may want
> to think about how to protect roles against influence by other roles so
> that e.g. user_r or staff_r cannot inject commands to be run by sysadm_r
> into dotfiles.  DAC will help you with user-based separation (somewhat),
> but there is still the case where you have a user who is authorized for
> staff_r and sysadm_r who logs in initially in staff_r and later switches
> to sysadm_r.  There you have consider the potential of a flawed or
> malicious program run while in staff_r trying to inject commands to be
> run in sysadm_r, all running under the same user identity.
> 

I label /root admin_home_t and don't allow any confined role to write to
it.  I have sysadm_r but have written before that I think it is a waste
of time, and prefer to just use unconfined_r.

My view of the world is that you have a "login" role and you have an
"admin" role.  On my machine this is staff_r and unconfined_r, respectively.

If I want to run a confined role say webadm_r, I would not allow
webadm_r to touch any files in /root, so I don't see that I need
protection.  Similarly webadm_r can not touch entries in the Homedir so
it can not attack other roles.  If you need to create an admin role
which administrates more then one confined domain, then you would
generate a new admin role or enhance an existing admin role.  For
example if you want to allow the webadm_r:webadm_t to be able to admin
mysql,  you simply create a policy module with

mysql_admin(webadm_t, webadm_r, { webadm_devpts_t webadm_tty_device_t })

Or you create a brand new admin module with

policy_module(myadm, 1.0)

userdom_base_user_template(myadm)
allow myadm_t self:capability { dac_override dac_read_search kill
sys_ptrace sys_nice };

apache_admin(myadm_t, myadm_r,  { myadm_devpts_t myadm_tty_device_t })
mysql_admin(myadm_t, myadm_r,  { myadm_devpts_t myadm_tty_device_t })

gen_require(`
        type staff_t;
')
allow staff_t myadm_t:process transition;
allow myadm_t staff_t:dir getattr;


We need to keep it this simple, or only Consultants will ever be able to
use this stuff.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgYY3wACgkQrlYvE4MpobMekQCcDcsUwL2YM4t/MzkH07qDlRbS
gdcAoJ2GbnSCqrioDU5LXRB6Amvoyl06
=tyy7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
