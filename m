Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6UDY2rT027063
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 09:34:02 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6UDY1AP010068
	for <selinux@tycho.nsa.gov>; Fri, 30 Jul 2004 13:34:01 GMT
Subject: Re: file_contexts patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200407281253.21580.russell@coker.com.au>
References: <20040716201531.GB4940@obadja.jmh.mhn.de>
	 <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1090935483.2448.71.camel@moss-spartans.epoch.ncsc.mil>
	 <200407281253.21580.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091194396.21245.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 30 Jul 2004 09:33:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-07-27 at 22:53, Russell Coker wrote:
> Almost all instances of ifdef(`rpm.te' are for Red Hat specific issues, it's 
> probably best to just globally change such ifdef's to check for red_hat or 
> whatever the new macro will be and then change back anything that seems 
> necessary after testing on SUSE.

Ok, I've replaced ifdef's for rpm.te and dpkg.te with ifdefs for the new
distro tunables that can be defined in tunables/distro.te, and have also
adjusted rpm.fc to use these distro tunables and moved the
RedHat-specific inetd-related entries to inetd.fc, wrapped with an
ifdef(`redhat').  So I would suggest breaking up suse.te and suse.fc
among the individual domain .te and .fc files, and wrapping with
ifdef(`suse').  Naturally, anything from suse.te that might be generally
applicable to other distros should be considered for inclusion outside
of any ifdef.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
