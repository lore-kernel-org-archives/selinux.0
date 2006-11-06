Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6HevVf005881
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 12:40:57 -0500
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6HdKPI000491
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 17:39:21 GMT
Message-Id: <20061106173949.705221428@tresys.com>>
References: <20061106173814.457967976@tresys.com>>
Date: Mon, 06 Nov 2006 12:38:16 -0500
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] SELinux: export object class and permission definitions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Moves the definition of the 3 structs containing object class and permission definitions from avc.c to avc_ss.h so that the security server can access them for validation on policy load. This also adds a new struct type, defined_classes_perms_t, suitable for allowing the security server to access these data structures from the avc.

Signed-off-by: Chad Sellers <csellers@tresys.com>

---
 security/selinux/avc.c            |   23 +++++++++++------------
 security/selinux/include/avc_ss.h |   24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 12 deletions(-)

Index: linux-2.6-discovery/security/selinux/avc.c
===================================================================
--- linux-2.6-discovery.orig/security/selinux/avc.c
+++ linux-2.6-discovery/security/selinux/avc.c
@@ -32,12 +32,7 @@
 #include "avc.h"
 #include "avc_ss.h"
 
-static const struct av_perm_to_string
-{
-  u16 tclass;
-  u32 value;
-  const char *name;
-} av_perm_to_string[] = {
+static const struct av_perm_to_string av_perm_to_string[] = {
 #define S_(c, v, s) { c, v, s },
 #include "av_perm_to_string.h"
 #undef S_
@@ -57,17 +52,21 @@ static const char *class_to_string[] = {
 #undef TE_
 #undef S_
 
-static const struct av_inherit
-{
-    u16 tclass;
-    const char **common_pts;
-    u32 common_base;
-} av_inherit[] = {
+static const struct av_inherit av_inherit[] = {
 #define S_(c, i, b) { c, common_##i##_perm_to_string, b },
 #include "av_inherit.h"
 #undef S_
 };
 
+const struct selinux_class_perm selinux_class_perm = {
+	av_perm_to_string,
+	ARRAY_SIZE(av_perm_to_string),
+	class_to_string,
+	ARRAY_SIZE(class_to_string),
+	av_inherit,
+	ARRAY_SIZE(av_inherit)
+};
+
 #define AVC_CACHE_SLOTS			512
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
Index: linux-2.6-discovery/security/selinux/include/avc_ss.h
===================================================================
--- linux-2.6-discovery.orig/security/selinux/include/avc_ss.h
+++ linux-2.6-discovery/security/selinux/include/avc_ss.h
@@ -10,5 +10,29 @@
 
 int avc_ss_reset(u32 seqno);
 
+struct av_perm_to_string
+{
+	u16 tclass;
+	u32 value;
+	const char *name;
+};
+
+struct av_inherit
+{
+	u16 tclass;
+	const char **common_pts;
+	u32 common_base;
+};
+
+struct selinux_class_perm
+{
+	const struct av_perm_to_string *av_perm_to_string;
+	u32 av_pts_len;
+	const char **class_to_string;
+	u32 cts_len;
+	const struct av_inherit *av_inherit;
+	u32 av_inherit_len;
+};
+
 #endif /* _SELINUX_AVC_SS_H_ */
 

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
