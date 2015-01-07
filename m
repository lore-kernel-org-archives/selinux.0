Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t07M4B0f012792
 for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2015 17:04:11 -0500
From: John Brooks <john.brooks@jolla.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Improve check_assertions performance through hash tweaks
Date: Wed,  7 Jan 2015 15:03:38 -0700
Message-Id: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

These changes improve the performance of libsepol's avtab as used by
check_assertions, especially for large policies. On Fedora, this reduces
the time to check assertions from over an hour (I never finished!) to
about 3 minutes.

There is a lot more low-hanging performance fruit here, but this makes
a decent start - and it should allow these assertions to be enabled as
part of the policy build again.

John Brooks (3):
  Build libsepol with -O2
  Use a better hash function for libsepol's avtab
  Tweak avtab hash table parameters for better performance

 libsepol/include/sepol/policydb/avtab.h |  4 ++--
 libsepol/src/Makefile                   |  2 +-
 libsepol/src/avtab.c                    | 39 ++++++++++++++++++++++++++++-----
 3 files changed, 36 insertions(+), 9 deletions(-)

-- 
1.9.3
