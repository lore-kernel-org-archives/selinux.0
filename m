Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RDclrT001745
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 09:38:47 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6RDcHmJ012192
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 13:38:17 GMT
Subject: Re: file_contexts patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
References: <20040716201531.GB4940@obadja.jmh.mhn.de>
	 <200407170802.08072.russell@coker.com.au>
	 <20040716224252.GD4940@obadja.jmh.mhn.de>
	 <200407171159.00489.russell@coker.com.au>
	 <20040717195326.GA16762@bern.cip.ifi.lmu.de>
	 <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1090935483.2448.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 27 Jul 2004 09:38:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-07-26 at 16:25, Stephen Smalley wrote:
> Would it be better to make the distro a tunable (e.g.
> policy/tunables/distro.te) and use ifdef's in the individual .te files
> and .fc files for the distro-specific changes to a given domain?  I'd
> particularly like to see all of the RedHat-specific changes moved from
> rpm.{te,fc} into something that is clearly specific to RedHat.

Note that in addition to reviewing the contents of rpm.te and rpm.fc for
RedHat-specific customizations, this change would require reviewing all
uses of ifdef(`rpm.te') throughout the various .te files, as some of
those conditional blocks are for RedHat-specific customizations while
others are for rules that should always be included when the rpm domain
is enabled in the policy (and thus should still be included for other
rpm-using distros).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
