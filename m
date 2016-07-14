From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, jeffv@google.com,
 William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] selinux: print leading 0x on ioctlcmd audits
Date: Thu, 14 Jul 2016 12:29:22 -0700
Message-Id: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

From: William Roberts <william.c.roberts@intel.com>

ioctlcmd is currently printing hex numbers, but their is no leading
0x. Thus things like ioctlcmd=1234 are misleading, as the base is
not evident.

Correct this by adding 0x as a prefix, so ioctlcmd=1234 becomes ioctlcmd=0x1234.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 security/lsm_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index cccbf30..82e4dbb 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -257,7 +257,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
 
-		audit_log_format(ab, " ioctlcmd=%hx", a->u.op->cmd);
+		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
 		break;
 	}
 	case LSM_AUDIT_DATA_DENTRY: {
-- 
1.9.1
