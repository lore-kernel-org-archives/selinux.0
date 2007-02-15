Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171567396.3579.4.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 14:31:25 -0500
Message-Id: <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 20:23 +0100, Vincenzo Ciaglia wrote:
> > With what contents?
> 
> # cat /etc/selinux/config
> # This file controls the state of SELinux on the system.
> # SELINUX= can take one of these three values:
> #       enforcing - SELinux security policy is enforced.
> #       permissive - SELinux prints warnings instead of enforcing.
> #       disabled - SELinux is fully disabled.
> SELINUX=permissive
> # SELINUXTYPE= type of policy in use. Possible values are:
> #       targeted - Only targeted network daemons are protected.
> #       strict - Full SELinux protection.
> SELINUXTYPE=targeted

And your policy is installed
under /etc/selinux/targeted/policy/policy.xx?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
