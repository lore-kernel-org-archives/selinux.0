Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 20:58:48 +0100
Message-Id: <1171569528.4569.9.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno gio, 15/02/2007 alle 14.31 -0500, Stephen Smalley ha scritto:
> SELINUXTYPE=targeted
> 
> And your policy is installed
> under /etc/selinux/targeted/policy/policy.xx?

Ops...hh no. Here my error. My policy is under
/etc/selinux/netwosix/policy/policy.21

So i rebooted and:

# dmesg | grep selinux
selinux_register_security:  Registering secondary module capability
SELinux: initialized (dev selinuxfs, type selinuxfs), uses
genfs_contexts
# sestatus 
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 21
Policy from config file:        netwosix

Finally it works! Thank you very much! :)

Now i can start working on policies.

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
