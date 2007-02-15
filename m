Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1171568111.4569.7.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171476502.20576.35.camel@sgc.columbia.tresys.com>
	 <1171547734.2891.16.camel@desk.netwosix.org>
	 <1171564867.32574.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1171568111.4569.7.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 14:48:53 -0500
Message-Id: <1171568933.32574.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 20:35 +0100, Vincenzo Ciaglia wrote:
> Il giorno gio, 15/02/2007 alle 13.41 -0500, Stephen Smalley ha scritto:
> 
> > If you boot your kernel with init=/bin/bash and try to manually mount
> > selinuxfs on /selinux, does it work?
> 
> I don't know i still haven't tried but i think isn't a good idea to
> manually mount the selinuxfs. Like i said it will be a public-use
> gnu/linux distribution for networking and security related works. Even
> if could be used from expert and skilled users i think that this
> solution is really too uncomfortable, don't you?

I'm not suggesting it for production use, just to independently check on
your ability to mount selinuxfs, since you said that init seems to be
failing at that point.

> However i also tried to add this line to my "/etc/rc" script:
> 
> /bin/mount -t selinuxfs /selinux
> 
> But nothing happened.

Should be:
	mount -t selinuxfs none /selinux

But doing it from init=/bin/bash will be closer to what init experiences
than from your rc scripts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
