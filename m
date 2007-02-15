Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1171564867.32574.45.camel@moss-spartans.epoch.ncsc.mil>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171476502.20576.35.camel@sgc.columbia.tresys.com>
	 <1171547734.2891.16.camel@desk.netwosix.org>
	 <1171564867.32574.45.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 20:35:11 +0100
Message-Id: <1171568111.4569.7.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno gio, 15/02/2007 alle 13.41 -0500, Stephen Smalley ha scritto:

> If you boot your kernel with init=/bin/bash and try to manually mount
> selinuxfs on /selinux, does it work?

I don't know i still haven't tried but i think isn't a good idea to
manually mount the selinuxfs. Like i said it will be a public-use
gnu/linux distribution for networking and security related works. Even
if could be used from expert and skilled users i think that this
solution is really too uncomfortable, don't you?

However i also tried to add this line to my "/etc/rc" script:

/bin/mount -t selinuxfs /selinux

But nothing happened.


-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
