Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA546CXZ000013
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 23:06:14 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA546CKf005750
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 04:06:12 GMT
Subject: Re: Updated SELinux Release
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
In-Reply-To: <20041104131544.GC5461@lkcl.net>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
	 <1099534538.3875.6.camel@nexus.verbum.private>
	 <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
	 <20041104131544.GC5461@lkcl.net>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 23:06:06 -0500
Message-Id: <1099627566.25416.6.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 13:15 +0000, Luke Kenneth Casson Leighton wrote:

>  default: no.

Why not on by default, with a targeted policy, for everyone?  SELinux's
flexibility allows one to easily turn it off for specific services.
There's a lot of value in preventing a compromised or misconfigured
syslogd or portmap daemon from destroying your system.  Not to mention
Apache; with the stronger version of can_network, the Slapper worm would
have been stopped in its tracks (no outbound port 80 access).
Additionally, I'm working on securing some high-risk software using the
targeted policy; something that would be difficult to impossible to do
without SELinux.

The entire point of SELinux is to bring strong, flexible mandatory
access control to a mainstream operating system (Linux).  If it's not
enabled by default, and limited to the few of us on this mailing list,
what's the point?  Why don't we just run say EROS (http://www.eros-
os.org/) instead?  A: Because what makes SELinux interesting is that it
can run all of our legacy software.  By not shipping it on everywhere,
we're not tapping that ability.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
