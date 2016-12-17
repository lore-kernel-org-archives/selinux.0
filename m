From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, sds@tycho.nsa.gov, Gary Tierney <gary.tierney@gmx.com>
Subject: [PATCH 2/2] selinux: default to security isid in sel_make_bools() if
 no sid is found
Date: Sat, 17 Dec 2016 20:48:39 +0000
Message-Id: <1482007719-14313-3-git-send-email-gary.tierney@gmx.com>
In-Reply-To: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
References: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use SECINITSID_SECURITY as the default SID for booleans which don't have
a matching SID returned from security_genfs_sid().

This prevents the policy failing to load (and consequently the system
failing to boot) when there is no default genfscon statement matched for
the selinuxfs in the new policy.

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 security/selinux/selinuxfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 2139cc7..c282150 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1312,10 +1312,10 @@ static int sel_make_bools(void)
 		isec = (struct inode_security_struct *)inode->i_security;
 		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
 		if (ret) {
-			pr_warn_ratelimited("SELinux: %s: failed to lookup sid for %s\n",
+			pr_warn_ratelimited("SELinux: %s: no sid found, defaulting to security isid for %s\n",
 					   __func__, page);
-			goto out;
 
+			sid = SECINITSID_SECURITY;
 		}
 
 		isec->sid = sid;
-- 
2.7.4
