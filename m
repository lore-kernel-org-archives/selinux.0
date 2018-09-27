Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8RJHNLb000502
 for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2018 15:17:23 -0400
From: Casey Schaufler <casey.schaufler@intel.com>
To: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 casey.schaufler@intel.com, dave.hansen@intel.com,
 deneen.t.dock@intel.com, kristen@linux.intel.com, arjan@linux.intel.com
Date: Thu, 27 Sep 2018 12:17:20 -0700
Message-Id: <20180927191720.9480-1-casey.schaufler@intel.com>
In-Reply-To: <20180824224117.3356-1-casey.schaufler@intel.com>
References: <20180824224117.3356-1-casey.schaufler@intel.com>
Subject: [PATCH 6/5] capability: Repair sidechannel test in ptrace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>

The PTRACE_MODE_SCHED check erroniously returns 0 in
all cases. It should be returning -EPERM. This fixes
the logic to correct that error.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 security/commoncap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index e77457110d05..70a7e3d19c16 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -152,9 +152,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
-	if (mode & PTRACE_MODE_SCHED)
-		goto out;
-	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
+	if (!(mode & PTRACE_MODE_SCHED) &&
+	    ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
 	ret = -EPERM;
 out:
-- 
2.17.1
