Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t97N8oRv016009
 for <selinux@tycho.nsa.gov>; Wed, 7 Oct 2015 19:08:50 -0400
Subject: [RFC PATCH v3 3/5] lsm: add support for auditing kdbus service names
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>
Date: Wed, 07 Oct 2015 19:08:35 -0400
Message-ID: <20151007230835.7823.5818.stgit@localhost>
In-Reply-To: <20151007230615.7823.74519.stgit@localhost>
References: <20151007230615.7823.74519.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The kdbus service names will be recorded using 'service', similar to
the existing dbus audit records.

Signed-off-by: Paul Moore <pmoore@redhat.com>

---
ChangeLog:
- v3
 * Ported to the 4.3-rc4 based kdbus tree
- v2
 * Initial draft
---
 include/linux/lsm_audit.h |    2 ++
 security/lsm_audit.c      |    4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index ffb9c9d..d6a656f 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -59,6 +59,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_INODE	9
 #define LSM_AUDIT_DATA_DENTRY	10
 #define LSM_AUDIT_DATA_IOCTL_OP	11
+#define LSM_AUDIT_DATA_KDBUS	12
 	union 	{
 		struct path path;
 		struct dentry *dentry;
@@ -75,6 +76,7 @@ struct common_audit_data {
 #endif
 		char *kmod_name;
 		struct lsm_ioctlop_audit *op;
+		const char *kdbus_name;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index cccbf30..0a3dc1b 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -397,6 +397,10 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		audit_log_format(ab, " kmod=");
 		audit_log_untrustedstring(ab, a->u.kmod_name);
 		break;
+	case LSM_AUDIT_DATA_KDBUS:
+		audit_log_format(ab, " service=");
+		audit_log_untrustedstring(ab, a->u.kdbus_name);
+		break;
 	} /* switch (a->type) */
 }
 
