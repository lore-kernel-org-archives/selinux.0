Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l11I00xP012017
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 13:00:00 -0500
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l11I13TB021549
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 18:01:03 GMT
From: Jim Meyering <jim@meyering.net>
To: bug-coreutils@gnu.org
Cc: selinux@tycho.nsa.gov
Subject: coreutils: selinux is nearly ready: status
Date: Thu, 01 Feb 2007 19:00:30 +0100
Message-ID: <87y7nh4v29.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been spending little bits of time over the last few months getting
coreutils' SELinux into shape.  These changes started off based on Red
Hat patches from six months ago.  Initially it was all in a mercurial
repository based on a snapshot of coreutils CVS.  Then coreutils
development switched to git, and only recently have I merged most of
the hg-based deltas into the new repository.  It's on a branch named
"selinux".

Here is the current state:

  http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=shortlog;h=selinux

Here are some of the remaining tasks:

  - add runcon (should be quick)
  - add many more SELinux-specific tests
  - fix at least one test (tests/cp/cp-a-selinux is in-progress
      and known to fail -- but I know a couple ways to fix it)
  - documentation
  - make sure that any newer selinux-related changes from Red Hat
      (or any other distribution) are included

To checkout a copy, do this: (checked out repo size: 54MB)

  $ git-clone git://git.sv.gnu.org/coreutils
  $ cd coreutils
  $ git-fetch git://git.sv.gnu.org/coreutils selinux:my-selinux
  $ git-checkout my-selinux

Comments welcome.

Jim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
