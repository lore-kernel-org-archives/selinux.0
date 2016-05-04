Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u44KdQa0014889
 for <selinux@tycho.nsa.gov>; Wed, 4 May 2016 16:39:26 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/6 v2] libsepol/cil: Add high-level language line marking
 support
Date: Wed,  4 May 2016 16:41:00 -0400
Message-Id: <1462394466-25076-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch set adds support for tracking original file and line numbers for better
error reporting when a high-level language is translated into CIL. It then uses
that support to provide better error reporting for neverallow rules after
generating CIL with checkpolicy or checkmodule. (Unfortunately, the original line
number information is not saved in the pp file, so there is no benefit for policy
modules.)

Changes in V2:
- Only ";;*" at the beginning of a line indicates an HL line mark.
- When cil_tree_get_next_path() encounters a call or blockinherit it will
continue searching the AST from the associated macro or block.

James Carter (6):
  libsepol/cil: Add high-level language line marking support
  libsepol/cil: Store CIL filename in parse tree and AST
  libsepol/cil: Add cil_tree_log() and supporting functions
  libsepol/cil: Replace cil_log() calls with cil_tree_log()
  libsepol/cil: Remove path field from cil_tree_node struct
  libsepol: When generating CIL use HLL line mark for neverallows

 libsepol/cil/src/cil.c             |  22 ++-
 libsepol/cil/src/cil_binary.c      |  45 +++---
 libsepol/cil/src/cil_build_ast.c   | 294 +++++++++++++++----------------------
 libsepol/cil/src/cil_build_ast.h   |   2 +
 libsepol/cil/src/cil_copy_ast.c    |  24 ++-
 libsepol/cil/src/cil_flavor.h      |   1 +
 libsepol/cil/src/cil_fqn.c         |   2 +-
 libsepol/cil/src/cil_internal.h    |   9 ++
 libsepol/cil/src/cil_lexer.h       |   6 +-
 libsepol/cil/src/cil_lexer.l       |  15 +-
 libsepol/cil/src/cil_parser.c      | 259 +++++++++++++++++++++++++++-----
 libsepol/cil/src/cil_resolve_ast.c |  51 +++----
 libsepol/cil/src/cil_tree.c        |  96 +++++++++++-
 libsepol/cil/src/cil_tree.h        |   6 +-
 libsepol/cil/src/cil_verify.c      |  83 +++++------
 libsepol/src/module_to_cil.c       |   8 +
 16 files changed, 590 insertions(+), 333 deletions(-)

-- 
2.5.5
