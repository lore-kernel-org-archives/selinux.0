From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu,  3 May 2018 14:48:41 -0400
Message-Id: <20180503184845.19790-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 0/4] Fix build warnings with gcc 8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I encountered a number of build warnings on the selinux userspace
using gcc 8, which is the default now in F28 and rawhide. This fixes
the ones that are treated as fatal errors by default.  There are still
known warnings due to the flex skeleton and something to do with the
python bindings, but those are not new.

Stephen Smalley (4):
  libsepol: remove unused function and type
  libselinux: fix build warning in save_booleans()
  libselinux: avcstat: fix build warning
  libselinux: audit2why: fix build warnings

 libselinux/src/audit2why.c                 | 2 +-
 libselinux/src/booleans.c                  | 4 +++-
 libselinux/utils/avcstat.c                 | 3 ++-
 libsepol/include/sepol/policydb/policydb.h | 3 ---
 libsepol/src/policydb.c                    | 8 --------
 5 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.14.3
