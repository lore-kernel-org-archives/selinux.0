Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3JEOYFH005142
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 10:24:34 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/6] ibsepol/cil: Add high-level language line marking support
Date: Tue, 19 Apr 2016 10:25:59 -0400
Message-Id: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
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
 libsepol/cil/src/cil_lexer.l       |  14 +-
 libsepol/cil/src/cil_parser.c      | 245 ++++++++++++++++++++++++++-----
 libsepol/cil/src/cil_resolve_ast.c |  51 +++----
 libsepol/cil/src/cil_tree.c        |  86 ++++++++++-
 libsepol/cil/src/cil_tree.h        |   6 +-
 libsepol/cil/src/cil_verify.c      |  83 +++++------
 libsepol/src/module_to_cil.c       |   8 +
 16 files changed, 568 insertions(+), 330 deletions(-)

-- 
2.5.5
