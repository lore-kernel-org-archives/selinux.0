Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VJoxrT015439
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 15:50:59 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VJovS3007637
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 19:50:58 GMT
Date: Tue, 31 Aug 2004 21:02:10 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Nigel Kukard <nkukard@lbsd.net>, linux-hotplug-devel@lists.sourceforge.net,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831200210.GH4375@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net> <20040831191809.GC4375@lkcl.net> <1093980403.8517.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093980403.8517.239.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 03:26:43PM -0400, Stephen Smalley wrote:
> On Tue, 2004-08-31 at 15:18, Luke Kenneth Casson Leighton wrote:
> >  i think we need the input of more experienced people than us to
> >  say why these associate things are needed.
> 
> It provides control over the set of files that can live in a given
> filesystem, based on their security types (equivalence classes).  As you
> are now creating device types in a different filesystem type, further
> allow rules are needed to allow that association.
> 
> >  a correct implementation of the
> >  hacked-together-relaxed-fscontext-hooks.c-patch results in an atomic
> >  operation (mount with a new context which would otherwise need to be
> >  achieved with two commands: mount followed by restorecon)
> 
> The more important issue is that fscontext= lets you set the superblock
> security context, not just the root directory context.  restorecon can't
> do that.
 
 ah.

 thanks for clarifying, steven.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
