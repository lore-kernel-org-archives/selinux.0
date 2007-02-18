Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1IBoPgk012815
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 06:50:25 -0500
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1IBpeXX019723
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 11:51:40 GMT
From: Jim Meyering <jim@meyering.net>
To: bug-coreutils@gnu.org
Cc: selinux@tycho.nsa.gov, bug-gnulib@gnu.org
Subject: coreutils plans, test release coming soon, then stable, then selinux
Date: Sun, 18 Feb 2007 12:51:10 +0100
Message-ID: <87odnru1jl.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just made another snapshot.
Changes since the previous one are from gnulib
and from using autoconf-2.61a rather than 2.61.
Both bring bug fixes.

  http://meyering.net/cu/coreutils-6.7-dirty.tar.gz
  http://meyering.net/cu/coreutils-6.7-dirty.tar.gz.sig
aka
  http://meyering.net/cu/coreutils-6.7-ss-2007-02-18.11.26.56+0.tar.gz
  http://meyering.net/cu/coreutils-6.7-ss-2007-02-18.11.26.56+0.tar.gz.sig

I expect to release coreutils-6.8 (not called "stable", but not
particularly "unstable" either) soon.  Then, soon (i.e. a week)
afterwards, I want to make a stable 6.9 release.

Once 6.9 is out, I'll merge all of the SELinux changes from
the branch and make another test release.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
