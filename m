Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5L1RIi003142
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 16:01:27 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5L1UF9010770
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 21:01:30 GMT
Subject: Re: Updated SELinux Release
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
In-Reply-To: <20041105155752.GC5565@lkcl.net>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
	 <1099534538.3875.6.camel@nexus.verbum.private>
	 <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
	 <20041104131544.GC5461@lkcl.net>
	 <1099627566.25416.6.camel@nexus.verbum.private>
	 <20041105102853.GA5565@lkcl.net>
	 <1099667461.25416.27.camel@nexus.verbum.private>
	 <20041105155752.GC5565@lkcl.net>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 16:01:04 -0500
Message-Id: <1099688464.4012.6.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 15:57 +0000, Luke Kenneth Casson Leighton wrote:

>  response 3: _is_ it the job of debian developers to dictate the minimum
>  acceptable security level?

It is absolutely Debian's job to provide a baseline level of security by
default.  Debian doesn't let you install a system by default without a
root password, or install a mail server that relays mail from any IP
address, etc.  You're encouraged to create a regular user account for
logins (IIRC).  Likewise, I think it should be part of the standard
Linux security practice to have SELinux enabled by default.  With the
targeted policy and all the flexibility it offers (e.g. just turn off
protection for Apache, keep protection for named/portmap/syslog etc on),
there's very little reason not to ship it on.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
