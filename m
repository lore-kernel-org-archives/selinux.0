Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DJHqbX032165
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 15:17:52 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] libsepol/cil: Fixes to neverallow and bounds checking
Date: Wed, 13 Apr 2016 15:19:14 -0400
Message-Id: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dan Walsh found a bug that resulted in a seg fault while working on docker policy.
Steve Smalley was able to reproduce and find out where it was occuring in secilc.

This patch set fixes that bug and makes other improvements in the bounds and
neverallow checking.

James Carter (3):
  libsepol/cil: Fixed bug in cil_type_match_any()
  libsepol/cil: Improve type bounds check reporting
  libsepol/cil: Cleanup neverallow checking and fail if bounds checking
    fails

 libsepol/cil/src/cil_binary.c | 74 +++++++++++++++++++++++--------------------
 libsepol/cil/src/cil_find.c   |  6 +++-
 2 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.5.5
