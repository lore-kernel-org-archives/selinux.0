Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0ICMYIi019179
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 07:22:34 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0ICMbY7019583
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 12:22:37 GMT
Subject: Re: lots of execmem failures with 2.6.10
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Manoj Srivastava <manoj.srivastava@stdc.com>
In-Reply-To: <20050116015332.GA9811@yggdrasil.localdomain>
References: <20050112112630.GA12730@yggdrasil.localdomain>
	 <1105541256.22495.57.camel@moss-spartans.epoch.ncsc.mil>
	 <20050113030755.GA24828@yggdrasil.localdomain>
	 <20050116015332.GA9811@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1106050532.18274.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 07:15:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-01-15 at 20:53, Greg Norris wrote:
> I've built a SELinux-enabled coreutils 5.2.1 package for Debian, and I'm
> happy to report that it does indeed resolve my issue.  I want to do a
> bit more testing before making the package generally available (I just
> rebooted to 2.6.10 about 15 minutes ago), but I'll upload it either
> tomorrow or Monday if no show-stoppers turn up.

Good, glad to hear it.  BTW, when/if people get around to submitting
SELinux userland patches for inclusion in Debian (or upstream, for
packages that have upstream maintainers), please recheck against the
latest SELinux patches in the public Fedora CVS tree to see whether
anything has changed there.  See http://cvs.fedora.redhat.com/core.shtml
for information about the public Fedora CVS tree.  Note also that not
all SELinux-related changes are patches in that tree, as some SELinux
functionality has been folded into the base packages, e.g. libuser,
logrotate, passwd, prelink, glibc, rpm, initscripts, ...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
