Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1171569528.4569.9.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1171569528.4569.9.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 15:03:44 -0500
Message-Id: <1171569824.32574.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 20:58 +0100, Vincenzo Ciaglia wrote:
> Il giorno gio, 15/02/2007 alle 14.31 -0500, Stephen Smalley ha scritto:
> > SELINUXTYPE=targeted
> > 
> > And your policy is installed
> > under /etc/selinux/targeted/policy/policy.xx?
> 
> Ops...hh no. Here my error. My policy is under
> /etc/selinux/netwosix/policy/policy.21

Ok.  SELINUXTYPE= is just the name where your policy is located; it
doesn't have to mean anything about the actual kind of policy (although
conventionally we use "targeted", "strict", "mls", etc to indicate the
kind of policy too.)

> So i rebooted and:
> 
> # dmesg | grep selinux
> selinux_register_security:  Registering secondary module capability
> SELinux: initialized (dev selinuxfs, type selinuxfs), uses
> genfs_contexts

You actually wanted to grep for "SELinux" (capitalization) or grep -i,
but that's ok.  Although I thought Eric was going to kill or at least
silence by default many of those messages.

> # sestatus 
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 21
> Policy from config file:        netwosix
> 
> Finally it works! Thank you very much! :)

Good.  Of course, since it is permissive, it isn't enforcing anything
yet, just logging what would be denied.  Did you label your filesystems
yet?

> Now i can start working on policies.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
