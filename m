Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CG1tqh001174
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 12:01:56 -0400
Received: by iebmu5 with SMTP id mu5so27275838ieb.1
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 09:01:53 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] security: lsm_audit: add ioctl specific auditing
Date: Fri, 12 Jun 2015 09:01:42 -0700
Message-Id: <1434124902-12427-1-git-send-email-jeffv@google.com>
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 sds@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add information about ioctl calls to the LSM audit data. Log the
file path and command number.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 include/linux/lsm_audit.h |  7 +++++++
 security/lsm_audit.c      | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 1cc89e9..ffb9c9d 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -40,6 +40,11 @@ struct lsm_network_audit {
 	} fam;
 };
 
+struct lsm_ioctlop_audit {
+	struct path path;
+	u16 cmd;
+};
+
 /* Auxiliary data to use in generating the audit record. */
 struct common_audit_data {
 	char type;
@@ -53,6 +58,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_KMOD	8
 #define LSM_AUDIT_DATA_INODE	9
 #define LSM_AUDIT_DATA_DENTRY	10
+#define LSM_AUDIT_DATA_IOCTL_OP	11
 	union 	{
 		struct path path;
 		struct dentry *dentry;
@@ -68,6 +74,7 @@ struct common_audit_data {
 		} key_struct;
 #endif
 		char *kmod_name;
+		struct lsm_ioctlop_audit *op;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 1d34277..9f6c649 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -245,6 +245,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		}
 		break;
 	}
+	case LSM_AUDIT_DATA_IOCTL_OP: {
+		struct inode *inode;
+
+		audit_log_d_path(ab, " path=", &a->u.op->path);
+
+		inode = a->u.op->path.dentry->d_inode;
+		if (inode) {
+			audit_log_format(ab, " dev=");
+			audit_log_untrustedstring(ab, inode->i_sb->s_id);
+			audit_log_format(ab, " ino=%lu", inode->i_ino);
+		}
+
+		audit_log_format(ab, " ioctlcmd=%hx", a->u.op->cmd);
+		break;
+	}
 	case LSM_AUDIT_DATA_DENTRY: {
 		struct inode *inode;
 
-- 
2.2.0.rc0.207.ga3a616c
