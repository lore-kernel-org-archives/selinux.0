Subject: Re: I am attempting to add a secadm_r
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <42558933.7050605@redhat.com>
References: <425553ED.1040703@redhat.com>
	 <1112892841.27110.52.camel@moss-spartans.epoch.ncsc.mil>
	 <1112893854.27110.66.camel@moss-spartans.epoch.ncsc.mil>
	 <42558933.7050605@redhat.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 15:37:00 -0400
Message-Id: <1112902620.27110.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-07 at 15:25 -0400, Daniel J Walsh wrote:
> Ok, this is the point I was trying to understand.  I was hoping I could 
> define a role without defining
> an initial type.  I was hoping for secadm_r:sysadm_t or 
> secadm_r:staff_t.  Forcing a new initial type,
> seems a little touch.  This causes the creation of new roles to be more 
> difficult. 
> 
> I would have thought you could define a staff_t and then depending on 
> which roles they were currently
> under, which domains they could reach.
> 
> So staff_r:staff_t can not add users.
> But useradd_r:staff_t can.

That doesn't really work, because the process-to-object permissions are
primarily determined based on the TE rules, so a staff_r:staff_t process
can control a useradd_r:staff_t process (unless you start adding a lot
of constraints over permissions based on roles).  Further, in this
particular case, as I understand it, you truly want a real user role,
not just a specialized pseudo role for particular programs, because you
want to be able to assign secadm to one person and sysadm to another
person, and have them fully separated from one another, not just one
person switching back and forth via newrole or invoking a program in a
role via sudo or userhelper. 

> I would want to eliminate the su transition to sysadm_r:sysadm_t and 
> force say a staff user to
> newrole -r secadm_r
> 
> and become secadm_r:staff_t and then su and be able to do the 
> checkpolicy/load_policy type stuff.

The su pam_selinux integration makes this a bit harder too, as we want
to convey uid 0 / Linux capabilities to the process without forcing them
to a single SELinux user identity.  Of course, as I noted to Luke, you
could have multiple /etc/passwd accounts with uid 0 and map the
usernames to different roles in policy/users.

> If I do full_user_role I get alot more privs then I necessarily want.

You can certainly create a stripped down version of full_user_role that
is much more minimal in its permissions, but you still need a distinct
initial domain for the role to protect it from subversion by other
roles.
  
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
