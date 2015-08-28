Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7SJ050d032260
 for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2015 15:00:05 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 0/3] Add CIL extended avrule & ioctl whitelist support
Date: Fri, 28 Aug 2015 14:59:43 -0400
Message-ID: <1440788386-17637-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Patchset adds CIL ioctl whitelist support and documentation, as well as fixes
memory leak discovered while examining existing ioctl support.

Steve Lawrence (3):
  libsepol: fix memory leak when destroying avtab containing extended avrules
  libsepol/cil: add ioctl whitelist support
  secilc: Add documentation for allowx, auditallowx, dontauditx, and permissionx

 libsepol/cil/src/cil.c                             |  63 +++-
 libsepol/cil/src/cil_binary.c                      | 360 ++++++++++++++++++++-
 libsepol/cil/src/cil_build_ast.c                   | 175 ++++++++++
 libsepol/cil/src/cil_build_ast.h                   |   4 +
 libsepol/cil/src/cil_copy_ast.c                    |  59 ++++
 libsepol/cil/src/cil_flavor.h                      |   2 +
 libsepol/cil/src/cil_internal.h                    |  28 ++
 libsepol/cil/src/cil_post.c                        | 144 ++++++++-
 libsepol/cil/src/cil_resolve_ast.c                 |  79 +++++
 libsepol/cil/src/cil_verify.c                      |   4 +-
 libsepol/src/avtab.c                               |   4 +
 secilc/docs/cil_access_vector_rules.xml            | 172 ++++++++++
 .../docs/cil_class_and_permission_statements.xml   |  95 ++++++
 secilc/docs/cil_container_statements.xml           |  23 +-
 14 files changed, 1186 insertions(+), 26 deletions(-)

-- 
2.4.3
