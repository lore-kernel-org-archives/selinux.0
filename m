Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171571692.32574.119.camel@moss-spartans.epoch.ncsc.mil>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1171569528.4569.9.camel@desk.netwosix.org>
	 <1171569824.32574.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1171571029.4569.18.camel@desk.netwosix.org>
	 <1171571692.32574.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 21:42:48 +0100
Message-Id: <1171572168.5239.0.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno gio, 15/02/2007 alle 15.34 -0500, Stephen Smalley ha scritto:

> Targeted policy doesn't support user roles; it only confines specific
> programs, primarily focused on system services.  Strict policy is what
> you want if you need user roles.  In the future, we hope to reduce the
> divergence between them so that you can have a targeted system with some
> limited user roles.

Of course Netwosix will use "strict" policies. So i'm going to start
working on it.

I'll keep you updated.

Thank you,

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
