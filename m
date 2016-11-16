From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: [PATCH v2 1/2] policydb.h: use AVTAB macros to avoid duplications
Date: Wed, 16 Nov 2016 13:47:37 -0800
Message-Id: <1479332858-12948-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Rather than having multiple copies of the AVTAB and AVRULE
defines, consolidate them.

This makes it clear that AVRULE to AVTAB conversion no longer
need to occur.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/include/sepol/policydb/policydb.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index d99fcf4..77e46fb 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -258,20 +258,20 @@ typedef struct av_extended_perms {
 typedef struct avrule {
 /* these typedefs are almost exactly the same as those in avtab.h - they are
  * here because of the need to include neverallow and dontaudit messages */
-#define AVRULE_ALLOWED			0x0001
-#define AVRULE_AUDITALLOW		0x0002
-#define AVRULE_AUDITDENY		0x0004
+#define AVRULE_ALLOWED			AVTAB_ALLOWED
+#define AVRULE_AUDITALLOW		AVTAB_AUDITALLOW
+#define AVRULE_AUDITDENY		AVTAB_AUDITDENY
 #define AVRULE_DONTAUDIT		0x0008
-#define AVRULE_NEVERALLOW		0x0080
+#define AVRULE_NEVERALLOW		AVTAB_NEVERALLOW
 #define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
-#define AVRULE_TRANSITION		0x0010
-#define AVRULE_MEMBER			0x0020
-#define AVRULE_CHANGE			0x0040
+#define AVRULE_TRANSITION		AVTAB_TRANSITION
+#define AVRULE_MEMBER			AVTAB_MEMBER
+#define AVRULE_CHANGE			AVTAB_CHANGE
 #define AVRULE_TYPE       (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
-#define AVRULE_XPERMS_ALLOWED 		0x0100
-#define AVRULE_XPERMS_AUDITALLOW	0x0200
-#define AVRULE_XPERMS_DONTAUDIT		0x0400
-#define AVRULE_XPERMS_NEVERALLOW	0x0800
+#define AVRULE_XPERMS_ALLOWED 		AVTAB_XPERMS_ALLOWED
+#define AVRULE_XPERMS_AUDITALLOW	AVTAB_XPERMS_AUDITALLOW
+#define AVRULE_XPERMS_DONTAUDIT		AVTAB_XPERMS_DONTAUDIT
+#define AVRULE_XPERMS_NEVERALLOW	AVTAB_XPERMS_NEVERALLOW
 #define AVRULE_XPERMS	(AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW | \
 				AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_NEVERALLOW)
 	uint32_t specified;
-- 
2.7.4
