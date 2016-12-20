From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, sgrubb@redhat.com
Subject: [PATCH v2 2/2] selinux: default to security isid in sel_make_bools()
 if no sid is found
Date: Tue, 20 Dec 2016 01:28:47 +0000
Message-Id: <61a07062f6ba9f90e3235160644f3b5e62439173.1482195891.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1482195891.git.gary.tierney@gmx.com>
References: <20161219160041.GB5359@workstation>
 <cover.1482195891.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1482195891.git.gary.tierney@gmx.com>
References: <20161219160041.GB5359@workstation>
 <cover.1482195891.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use SECINITSID_SECURITY as the default SID for booleans which don't have
a matching SID returned from security_genfs_sid(), also update the
error message to a warning which matches this.

This prevents the policy failing to load (and consequently the system
failing to boot) when there is no default genfscon statement matched for
the selinuxfs in the new policy.

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 security/selinux/selinuxfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e667c34..616a8d2 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1308,9 +1308,9 @@ static int sel_make_bools(void)
 		isec = (struct inode_security_struct *)inode->i_security;
 		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
 		if (ret) {
-			pr_err("SELinux: failed to lookup sid for %s\n", page);
-			goto out;
-
+			pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
+					   page);
+			sid = SECINITSID_SECURITY;
 		}
 
 		isec->sid = sid;
-- 
2.7.4
