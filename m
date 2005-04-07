Subject: Re: I am attempting to add a secadm_r
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1112892841.27110.52.camel@moss-spartans.epoch.ncsc.mil>
References: <425553ED.1040703@redhat.com>
	 <1112892841.27110.52.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 12:55:49 -0400
Message-Id: <1112892949.27110.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-07 at 12:54 -0400, Stephen Smalley wrote:
> Normally, to add a new user role, you would add the following lines to
> domains/user.te:
> 	full_user_role(secadm)
> This will define both a secadm_r role and a secadm_t domain, along with
> associated types.  Then you can replace role and domain transitions for
> sysadm with corresponding ones in the specific program domains like
> checkpolicy, load_policy, setfiles, restorecon, etc so that secadm can
> enter those domains but sysadm cannot.

Note btw that you will want this to be a tunable so that people can
still choose to have sysadm be all powerful if desired.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
