Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov
In-Reply-To: <1171644283.9290.16.camel@desk.netwosix.org>
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
Content-Type: text/plain
Date: Fri, 16 Feb 2007 12:04:25 -0500
Message-Id: <1171645465.32574.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-16 at 17:44 +0100, Vincenzo Ciaglia wrote:
> Il giorno ven, 16/02/2007 alle 10.13 -0500, Stephen Smalley ha scritto:
> 
> > Likely an issue with your pam, but I haven't looked at your packages
> > yet.
> 
> Could be a policycoreutils problem too?

If it were only newrole failing, then yes.  But you showed useradd
failing too, which isn't provided or affected by policycoreutils.

Note however that you do need to build newrole on a system with
pam-devel or equivalent installed, as the Makefile looks
for /usr/include/security/pam_appl.h and disables PAM support if it
isn't present.

And if you want audit and/or namespace support, you need to build
newrole with the appropriate options.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
