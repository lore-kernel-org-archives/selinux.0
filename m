Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FCVxI4017402
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 08:31:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4FCVoVG014893
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:31:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h4FCVnL9014890 for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:31:49 GMT
Subject: Re: Process Transition
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@netgps.net
Cc: selinux@tycho.nsa.gov, Frank Mayer <mayerf@tresys.com>
In-Reply-To: <Pine.LNX.4.33.0305141431210.16852-100000@GPS1.NETPGS.NET>
References: <Pine.LNX.4.33.0305141431210.16852-100000@GPS1.NETPGS.NET>
Content-Type: text/plain
Message-Id: <1053001902.4729.657.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 May 2003 08:31:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-05-14 at 16:06, selinux@netgps.net wrote:
> Upon booting the LSM kernel in permissive mode, I get many access denied 
> messages as the init process runs (as well as some other processes that 
> run at boot).

Which LSM kernel are you using?  The one from the NSA SELinux web site? 
Or the sourceforge CVS tree?  Or Russell Coker or Brian May's packages
for Debian?  Or from the public LSM BitKeeper trees?

Does your "LSM kernel" also include the separate SELinux-specific
patch?  Does lsm-2.4/init/main.c include the call to selinux_init()?

> avc:  denied  { transition } for  pid=1 comm=swapper path=/sbin/init /
> dev=08 :01 ino=229436 scontext=system_u:system_r:kernel_t /
> tcontext=system_u:system_r:init_t tclass=process
> 
> I have the following line in the policy.conf (post make install-src 
> install, of course):
> 
> allow kernel_t init_t:process transition;

I don't see why this permission would fail, given that the above rule is
included.  There is no change in user identity or role on this
transition, so neither the constraints nor the role allow rules are
relevant, just the TE rule.

Make sure that your binary policy corresponds to your policy.conf, i.e.
recompile it with checkpolicy.  You can also run checkpolicy -d -b on
the binary policy file and query it to see whether a given permission is
included in it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
