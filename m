Subject: Re: MLS newrole avcs and polyinstantiation avcs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40712191017x3ea7989bxa94a934aa195c980@mail.gmail.com>
References: <cadfc0e40712191017x3ea7989bxa94a934aa195c980@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 13:34:40 -0500
Message-Id: <1198089280.19081.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-19 at 12:17 -0600, Xavier Toth wrote:
> I'm using newrole to run apps at level but am getting mls constraint
> related avcs like:
> 
> type=AVC msg=audit(1198086275.274:1836): avc:  denied  { transition }
> for  pid=4815 comm="newrole" path="/bin/bash" dev=dm-0 ino=14843920
> scontext=user_u:user_r:newrole_t:s0
> tcontext=user_u:user_r:user_t:s2:c0.c253,c255,c256 tclass=process
> 
> I have :
> ifdef(`enable_mls',`
>       mls_process_set_level(newrole_t)
> ')
> 
>  in my policy but it either isn't the right thing or isn't enough. Can
> anyone help with this?

You don't need the ifdef, and that is already in newrole.te.  It isn't
the issue though.

The constraint (which you can read in policy/mls) says that the high
level (aka clearance/max) of the old context must always dominate the
high level of the new context.  No exceptions.  Only the low level (aka
current level) of the process is allowed to change via newrole based on
mlsprocsetsl.

The expected usage is that you login with your low level set to the
desired acting level, and the high level set to your clearance, and then
newrole can be used to increase your acting level up to your clearance
but no further.

That becomes especially important when you consider that the SELinux
user as defined by the policy might be authorized for a larger range
than the Linux user, and seusers might be specifying a more restricted
range for the individual Linux user.  We need to ensure that the session
is bound by the high/max/clearance level set at login time based on the
Linux user's entry in seusers. 

> Also I have pam_namespace configured for newrole and am getting mls
> constraint avcs related to relabeling directories, for example:
> 
> type=AVC msg=audit(1198086274.884:1793): avc:  denied  { relabelto }
> for  pid=4815 comm="newrole" name="eb3ba083bd05d11d8c0e697ad725e391"
> dev=dm-0 ino=35323932 scontext=user_u:user_r:newrole_t:s0
> tcontext=user_u:object_r:user_home_t:s2:c0.c253,c255,c256 tclass=dir

Same issue here.

> 
> I have :
> files_poly_parent(user_home_t)
> files_poly_member(user_home_t)
> 
> in my policy but ...
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
