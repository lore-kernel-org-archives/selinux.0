Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov
In-Reply-To: <1171648335.9290.25.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1171569528.4569.9.camel@desk.netwosix.org>
	 <1171569824.32574.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1171571029.4569.18.camel@desk.netwosix.org>
	 <1171571692.32574.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1171572168.5239.0.camel@desk.netwosix.org>
	 <1171572980.18488.30.camel@localhost.localdomain>
	 <1171576059.5239.13.camel@desk.netwosix.org>
	 <1171628178.7911.5.camel@desk.netwosix.org>
	 <1171638783.32574.164.camel@moss-spartans.epoch.ncsc.mil>
	 <1171644283.9290.16.camel@desk.netwosix.org>
	 <1171645465.32574.206.camel@moss-spartans.epoch.ncsc.mil>
	 <1171648335.9290.25.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 12:55:59 -0500
Message-Id: <1171648559.32574.220.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-16 at 18:52 +0100, Vincenzo Ciaglia wrote:
> Il giorno ven, 16/02/2007 alle 12.04 -0500, Stephen Smalley ha scritto:
> 
> > Note however that you do need to build newrole on a system with
> > pam-devel or equivalent installed, as the Makefile looks
> > for /usr/include/security/pam_appl.h and disables PAM support if it
> > isn't present.
> 
> Done! I just recompiled the policycoreutils after i rebuilt shadow and
> pam and:
> 
> # id -Z
> root:sysadm_r:sysadm_t
> # newrole -r sysadm_r
> Authenticating root.
> Password: 
> # id -Z
> root:sysadm_r:sysadm_t

Not too exciting since you were already in sysadm_r to start with.

> Can i assign to the user "root" the staff_r:staff_t, so i can force him
> to "newrole -r sysadm_r" to make something on the system? Do i have to
> edit the "$policy/users/local.users" ?

If in enforcing mode and the ssh_sysadm_login boolean is off, this
should already be the case for ssh logins.  You can also adjust the
ordering in $policy/contexts/users/root (root-specific) or
$policy/contexts/default_contexts (system-wide defaults).  First field
of each line is the context of the daemon process (e.g. sshd), remainder
of the line is a list of partial contexts in the preferred ordering of
selection.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
