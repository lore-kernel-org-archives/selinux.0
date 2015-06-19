Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5JIJ8qY006185
 for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2015 14:19:08 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 00/10 v3] Improve libsepol and CIL neverallow and bounds
 checking
Date: Fri, 19 Jun 2015 14:19:06 -0400
Message-Id: <1434737956-17932-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

V3 fixes the following issues:
 - Patch 02/10 added more detail to commit message.
 - Patch 02/10 changed label from "out" to "oom".
 - Patch 03/10 fixed whitespace problem.
 - Patch 04/10 removed unused parameter in bounds_expand_parent_rules() and bounds_not_covered(), and added unused attribute to parameter in bounds_check_type_callback().
 - Patch 06/10 fixed whitespace problem.
 - Patch 07/10 initialize type_value_to_cil, class_value_to_cil, and perm_value_to_cil to NULL.
 - Patch 07/10 check for NULL value after calloc for perm_value_to_cil[i].
 - Patch 08/10 removed unused parameter in cil_classperms_from_sepol() and cil_avrule_from_sepol().
 - Patch 08/10 use unsigned instead of int for loop index in cil_classperms_from_sepol().

V2 fixes the following issues:
 - Patch 02/10 uses ebitmap_cpy() instead of individual ebitmap_set_bit() calls.
 - Patch 03/10 just the offending permissions are reported during neverallow checking.
 - Patch 03/10 checks and handles failure on ebitmap_and() calls.
 - Patch 03/10 removes some of the duplicated logic between checking and reporting.
 - Patch 05/10 uses the newly added ebitmap_match_any() function instead of its own.
 - Patch 05/10 ignores macros and abstract blocks when walking the AST. If in the 
future there are other users of cil_find.c, then we can make this functionality 
configureable then.

This patch set refactors libsepol's neverallow and bounds checking, refactors CIL's
neverallow checking, and adds bounds checking to CIL.

It also results in improved memory usage and speed. With a test policy.conf derived
from Refpolicy with typebounds statements added (but no violations of neverallow
rules or type bounds) the following improvements are seen:
Before: 9,605M of memory and 22.5 sec.
Now   :   125M of memory and  2.1 sec.
(Memory usage as reported by valgrind)

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

 libsepol/cil/src/cil.c                      |   3 +-
 libsepol/cil/src/cil_binary.c               | 700 ++++++++++++++-----
 libsepol/cil/src/cil_binary.h               |   8 +-
 libsepol/cil/src/cil_find.c                 | 305 +++++++++
 libsepol/cil/src/cil_find.h                 |  39 ++
 libsepol/cil/src/cil_internal.h             |   2 +
 libsepol/cil/src/cil_post.c                 |  26 +-
 libsepol/include/sepol/policydb/ebitmap.h   |   1 +
 libsepol/include/sepol/policydb/hierarchy.h |  11 +
 libsepol/include/sepol/policydb/policydb.h  |   2 +-
 libsepol/src/assertion.c                    | 272 +++++---
 libsepol/src/ebitmap.c                      |  22 +
 libsepol/src/expand.c                       |  24 +-
 libsepol/src/hierarchy.c                    | 996 +++++++++++++++++-----------
 libsepol/src/policydb.c                     |   4 +
 secilc/test/bounds.cil                      | 241 +++++++
 secilc/test/neverallow.cil                  |  79 +++
 17 files changed, 2077 insertions(+), 658 deletions(-)
 create mode 100644 libsepol/cil/src/cil_find.c
 create mode 100644 libsepol/cil/src/cil_find.h
 create mode 100644 secilc/test/bounds.cil
 create mode 100644 secilc/test/neverallow.cil

-- 
1.9.3
