From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 0/2] Enable direct compare of policy file with kernel policy
Date: Wed, 23 Nov 2016 12:11:27 -0500
Message-Id: <1479921089-11519-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

To date we have been unable to directly compare a policy file, 
e.g. /etc/selinux/targeted/policy/policy.30, with the kernel policy,
i.e. /sys/fs/selinux/policy, due to non-semantic differences in
the two policy images (e.g. ordering issues).  sediff can be used
to compare the two, but sediff is incomplete in its coverage and
is necessarily less efficient than a simple cmp of two files.
These two commits make it possible to directly compare a policy
file with a kernel policy after normalizing them both through
checkpolicy, ala:

checkpolicy -M -b /etc/selinux/targeted/policy/policy.30 -o policy.1
checkpolicy -M -b /sys/fs/selinux/policy -o policy.2
cmp policy.1 policy.2

Caveat:  Un-tested with Android policy; might still differ on xperms
ordering issues.

Stephen Smalley (2):
  libsepol: do not write object_r types to policy file
  libsepol,checkpolicy: convert rangetrans and filenametrans to hashtabs

 checkpolicy/policy_define.c                |  57 +++---
 checkpolicy/test/dispol.c                  |  36 +++-
 libsepol/cil/src/cil_binary.c              |  79 +++++---
 libsepol/include/sepol/policydb/context.h  |  40 ++++
 libsepol/include/sepol/policydb/policydb.h |  18 +-
 libsepol/src/expand.c                      | 152 ++++++++-------
 libsepol/src/mls.c                         |  52 +++--
 libsepol/src/policydb.c                    | 293 +++++++++++++++++++----------
 libsepol/src/write.c                       | 205 +++++++++++++-------
 9 files changed, 607 insertions(+), 325 deletions(-)

-- 
2.7.4
