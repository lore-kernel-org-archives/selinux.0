Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0F0OeiZ004925
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 19:24:40 -0500
From: John Brooks <john.brooks@jolla.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 0/3] Improve check_assertions performance through hash
 tweaks
Date: Wed, 14 Jan 2015 17:24:00 -0700
Message-Id: <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Updated to not override environment with -O2, improved readability of the hash
implementation, and restored avtab_alloc's behavior of allocating a fraction of
the expected number of elements as buckets for better efficiency in small hashes.

John Brooks (3):
  Build libsepol with -O2
  Use a better hash function for libsepol's avtab
  Tweak avtab hash table parameters for better performance

 libsepol/include/sepol/policydb/avtab.h |  7 ++---
 libsepol/src/Makefile                   |  2 +-
 libsepol/src/avtab.c                    | 45 ++++++++++++++++++++++++++++-----
 3 files changed, 44 insertions(+), 10 deletions(-)

-- 
1.9.3
