Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov
In-Reply-To: <1171645465.32574.206.camel@moss-spartans.epoch.ncsc.mil>
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
Content-Type: text/plain
Date: Fri, 16 Feb 2007 18:52:15 +0100
Message-Id: <1171648335.9290.25.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno ven, 16/02/2007 alle 12.04 -0500, Stephen Smalley ha scritto:

> Note however that you do need to build newrole on a system with
> pam-devel or equivalent installed, as the Makefile looks
> for /usr/include/security/pam_appl.h and disables PAM support if it
> isn't present.

Done! I just recompiled the policycoreutils after i rebuilt shadow and
pam and:

# id -Z
root:sysadm_r:sysadm_t
# newrole -r sysadm_r
Authenticating root.
Password: 
# id -Z
root:sysadm_r:sysadm_t

Can i assign to the user "root" the staff_r:staff_t, so i can force him
to "newrole -r sysadm_r" to make something on the system? Do i have to
edit the "$policy/users/local.users" ?

Unfortunately i still have to solve some problem with pam here:

# useradd -m test
useradd: PAM authentication failed

Just going crazy, today :)

Thank you!

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
