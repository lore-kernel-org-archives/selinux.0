Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8OGXLJq027529
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2013 12:33:21 -0400
Subject: [selinux-testsuite RFC PATCH 0/4] selinux-testsuite patches
To: serge@hallyn.com
From: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 24 Sep 2013 12:33:15 -0400
Message-ID: <20130924162401.27393.70353.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a small patchset I put together this morning to get the SELinux
testsuite running on my Rawhide system which was current as of a few
minutes ago.  You can pull from here if you are so inclined:

 * git://git.infradead.org/users/pcmoore/selinux_testsuite
 * http://git.infradead.org/users/pcmoore/selinux_testsuite

The only patch that is really necessary is 1/4, the change to
test_global.te.  At this point I haven't really looked closely enough at
the tests to see if it is correct, but it at least builds and the tests
all run to completion without failure.  The other three patches are
basically just style/formatting tweaks I did while working on the fix in
1/4.  Feel free to do with them what you will.

Comments are always welcome.  I'm hoping to start running this against
the upstream bits on a regular basis.

---

Paul Moore (4):
      test_policy: test_global.te fix for Fedora Rawhide (Sept 24th, 2013)
      test_policy: general Makefile cleanup
      test_policy: use RHEL instead of REDHAT in Makefile
      test_policy: create a "build" target


 policy/Makefile       |   85 ++++++++++++++++++++++++++++---------------------
 policy/test_global.te |    5 ++-
 2 files changed, 51 insertions(+), 39 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
