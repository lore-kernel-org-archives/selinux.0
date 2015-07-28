Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6SGcvuu012730
 for <selinux@tycho.nsa.gov>; Tue, 28 Jul 2015 12:38:58 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH 0/3] Add support for extracting modules
Date: Tue, 28 Jul 2015 12:38:30 -0400
Message-ID: <1438101513-37783-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patchset adds support for extracting modules from the module store as hll
or cil to the current working directory. This also adds a function to the
libsemanage API to extract modules and fixes a memory leak discovered while
implementing this functionality.

Yuli Khodorkovskiy (3):
  libsemanage: Add ability to extract modules
  libsemanage: Fix null pointer dereference in
    semanage_module_key_destroy
  policycoreutils/semodule: update semodule to allow extracting modules

 libsemanage/include/semanage/modules.h |  17 ++
 libsemanage/src/direct_api.c           | 310 ++++++++++++++++++++++-----------
 libsemanage/src/libsemanage.map        |   1 +
 libsemanage/src/modules.c              |  23 ++-
 libsemanage/src/policy.h               |   8 +
 libsemanage/src/semanageswig_python.i  |   5 +
 policycoreutils/semodule/semodule.8    |  14 ++
 policycoreutils/semodule/semodule.c    | 131 +++++++++++++-
 8 files changed, 401 insertions(+), 108 deletions(-)

-- 
1.9.3
