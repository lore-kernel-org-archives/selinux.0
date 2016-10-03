Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93BjHAW010596
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 07:45:17 -0400
Received: from workstation.home ([86.151.246.244]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LsOsW-1atk0222jA-0121lI for
 <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 13:45:14 +0200
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 0/1] libsepol/cil: create role/user caches for context
 validation
Date: Mon,  3 Oct 2016 12:44:49 +0100
Message-Id: <cover.1475494730.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch sets up the role/user caches used in context_is_valid() when a cildb
is compiled to a binary policy.  Previously, it seems like these would only
available when a binary policy had been loaded from file as opposed to rebuilt
from source.

Gary Tierney (1):
  libsepol/cil: create user and role caches when building binary policy

 libsepol/cil/src/cil_binary.c              | 13 +++++++++++++
 libsepol/include/sepol/policydb/policydb.h |  8 ++++++++
 2 files changed, 21 insertions(+)

-- 
2.4.11
