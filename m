Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S2rarT007218
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 22:53:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6S2rXup026664
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 02:53:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: file_contexts patch
Date: Wed, 28 Jul 2004 12:53:21 +1000
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil> <1090935483.2448.71.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1090935483.2448.71.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407281253.21580.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Jul 2004 23:38, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Mon, 2004-07-26 at 16:25, Stephen Smalley wrote:
> > Would it be better to make the distro a tunable (e.g.
> > policy/tunables/distro.te) and use ifdef's in the individual .te files
> > and .fc files for the distro-specific changes to a given domain?  I'd
> > particularly like to see all of the RedHat-specific changes moved from
> > rpm.{te,fc} into something that is clearly specific to RedHat.
>
> Note that in addition to reviewing the contents of rpm.te and rpm.fc for
> RedHat-specific customizations, this change would require reviewing all
> uses of ifdef(`rpm.te') throughout the various .te files, as some of
> those conditional blocks are for RedHat-specific customizations while
> others are for rules that should always be included when the rpm domain
> is enabled in the policy (and thus should still be included for other
> rpm-using distros).

Almost all instances of ifdef(`rpm.te' are for Red Hat specific issues, it's 
probably best to just globally change such ifdef's to check for red_hat or 
whatever the new macro will be and then change back anything that seems 
necessary after testing on SUSE.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
