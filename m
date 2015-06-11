Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5BIQkGG029974
 for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2015 14:26:46 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 00/10] Improve libsepol and CIL neverallow and bounds checking
Date: Thu, 11 Jun 2015 14:26:37 -0400
Message-Id: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch set refactors libsepol's neverallow and bounds checking, refactors CIL's
neverallow checking, and adds bounds checking to CIL.

It also results in improved memory usage and speed. With a test policy.conf derived
from Refpolicy with typebounds statements added (but no violations of neverallow
rules or type bounds) the following improvements are seen:
Before: 9,605M of memory and 22.5 sec.
Now   :   125M of memory and  2.1 sec.

In addition to adding bounds checking to CIL. This patch set also improves the error
reporting for neverallow rule violations and CIL will now report all violations
instead of stopping at the first one.

James Carter (10):
  libsepol: Add new ebitmap function named ebitmap_match_any()
  libsepol: Treat types like an attribute in the attr_type_map.
  libsepol: Refactored neverallow checking.
  libsepol: Refactored bounds (hierarchy) checking code
  libsepol/cil: Add function to search the CIL AST for an AV rule.
  libsepol/cil: Refactored CIL neverallow checking and reporting.
  libsepol/cil: Track number of classes and number of types and
    attributes.
  libsepol/cil: Add CIL bounds checking and reporting.
  secilc: Add a CIL policy file to test neverallow checking.
  secilc: Add a CIL policy file to test bounds checking.

 libsepol/cil/src/cil.c                      |    3 +-
 libsepol/cil/src/cil_binary.c               |  684 +++++++++++++-----
 libsepol/cil/src/cil_binary.h               |    8 +-
 libsepol/cil/src/cil_find.c                 |  281 ++++++++
 libsepol/cil/src/cil_find.h                 |   39 ++
 libsepol/cil/src/cil_internal.h             |    2 +
 libsepol/cil/src/cil_post.c                 |   26 +-
 libsepol/include/sepol/policydb/ebitmap.h   |    1 +
 libsepol/include/sepol/policydb/hierarchy.h |   11 +
 libsepol/include/sepol/policydb/policydb.h  |    2 +-
 libsepol/src/assertion.c                    |  225 +++---
 libsepol/src/ebitmap.c                      |   22 +
 libsepol/src/expand.c                       |   26 +-
 libsepol/src/hierarchy.c                    | 1000 +++++++++++++++++----------
 libsepol/src/policydb.c                     |    4 +
 secilc/test/bounds.cil                      |  241 +++++++
 secilc/test/neverallow.cil                  |   79 +++
 17 files changed, 1994 insertions(+), 660 deletions(-)
 create mode 100644 libsepol/cil/src/cil_find.c
 create mode 100644 libsepol/cil/src/cil_find.h
 create mode 100644 secilc/test/bounds.cil
 create mode 100644 secilc/test/neverallow.cil

-- 
1.9.3
