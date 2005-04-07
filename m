Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37H4fue027641
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 13:04:41 -0400 (EDT)
Subject: Re: I am attempting to add a secadm_r
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <425553ED.1040703@redhat.com>
References: <425553ED.1040703@redhat.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 12:54:00 -0400
Message-Id: <1112892841.27110.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-07 at 11:38 -0400, Daniel J Walsh wrote:
> Any ways trying a simple experiment I have added the following  roles
> 
> role secadm_r types sysadm_t
> role secadm_r types checkpolicy_t
> role secadm_r types newrole_t
> 
> And I add secadm_r as a "root" role in the users file.

Normally, to add a new user role, you would add the following lines to
domains/user.te:
	full_user_role(secadm)
This will define both a secadm_r role and a secadm_t domain, along with
associated types.  Then you can replace role and domain transitions for
sysadm with corresponding ones in the specific program domains like
checkpolicy, load_policy, setfiles, restorecon, etc so that secadm can
enter those domains but sysadm cannot.

> Now when I try to newrole from root:sysadm_r:sysadm_t to 
> root:secadm_r:sysadm_t

newrole transitions are typically authorized by the role_tty_type_change
() macro in domains/user.te.  This sets up the role allow rules and
type_change roles for the transition.

> I get a process transition failure
> 
> from
> 
> root:sysadm_r:newrole_t to root:secadm_r:sysadm_t.
> 
> What am I missing?
> 
> the
> allow newrole_t sysadm_t:process transition;
> 
> rule exists

You likely lack an 'allow sysadm_r secadm_r;' rule for the role
transition.  This would normally be covered by the role_tty_type_change
macro.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
