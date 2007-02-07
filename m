Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17H9Dgu024092
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 12:09:13 -0500
Received: from tex.courtesan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17HAJf5009538
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 17:10:20 GMT
Received: from tex.courtesan.com (smmsp@localhost [127.0.0.1])
	by tex.courtesan.com (8.14.0/8.13.8) with ESMTP id l17HA1p6013246
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 12:10:01 -0500 (EST)
Date: Wed, 7 Feb 2007 12:10:01 -0500 (EST)
Message-Id: <200702071710.l17HA1WA014028@tex.courtesan.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
From: Todd.Miller@sparta.com
Subject: PATCH: libselinux-1.34.0 bit type usage
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

libselinux uses a mix of bit type styles: BSD-style (u_XXint_t), Linux
kernel style (uXX), and C99 (uintXX_t).  The following patch makes
things consistent by replacing use of BSD and Linux kernel styles with
the standard C99 bit types from stdint.h.  Most files included stdint.h
already.

 - todd

diff -ur libselinux-1.34.0.DIST/include/selinux/avc.h libselinux-1.34.0/include/selinux/avc.h
--- libselinux-1.34.0.DIST/include/selinux/avc.h	2006-10-17 10:02:07.000000000 -0400
+++ libselinux-1.34.0/include/selinux/avc.h	2007-02-07 12:00:35.000000000 -0500
@@ -304,11 +304,11 @@
  * -%1 if insufficient memory exists to add the callback.
  */
 	int avc_add_callback(int (*callback)
-			      (u_int32_t event, security_id_t ssid,
+			      (uint32_t event, security_id_t ssid,
 			       security_id_t tsid, security_class_t tclass,
 			       access_vector_t perms,
 			       access_vector_t * out_retained),
-			     u_int32_t events, security_id_t ssid,
+			     uint32_t events, security_id_t ssid,
 			     security_id_t tsid, security_class_t tclass,
 			     access_vector_t perms);
 
diff -ur libselinux-1.34.0.DIST/man/man3/avc_add_callback.3 libselinux-1.34.0/man/man3/avc_add_callback.3
--- libselinux-1.34.0.DIST/man/man3/avc_add_callback.3	2007-01-18 10:13:15.000000000 -0500
+++ libselinux-1.34.0/man/man3/avc_add_callback.3	2007-02-07 12:00:18.000000000 -0500
@@ -9,7 +9,7 @@
 .br
 .B #include <selinux/avc.h>
 .sp
-.BI "int avc_add_callback(int (*" callback ")(u_int32_t " event , 
+.BI "int avc_add_callback(int (*" callback ")(uint32_t " event , 
 .in +\w'int avc_add_callback(int (*callback)('u
 .BI "security_id_t " ssid ,
 .br
@@ -22,7 +22,7 @@
 .BI "access_vector_t *" out_retained "),"
 .in
 .in +\w'int avc_add_callback('u
-.BI "u_int32_t " events ", security_id_t " ssid , 
+.BI "uint32_t " events ", security_id_t " ssid , 
 .br
 .BI "security_id_t " tsid ", security_class_t " tclass ,
 .br
diff -ur libselinux-1.34.0.DIST/src/avc.c libselinux-1.34.0/src/avc.c
--- libselinux-1.34.0.DIST/src/avc.c	2006-10-17 10:02:07.000000000 -0400
+++ libselinux-1.34.0/src/avc.c	2007-02-07 11:58:28.000000000 -0500
@@ -49,9 +49,9 @@
 	}
 };
 static const struct av_perm_to_string {
-	u16 tclass;
-	u16 nameidx;
-	u32 value;
+	uint16_t tclass;
+	uint16_t nameidx;
+	uint32_t value;
 } av_perm_to_string[] = {
 #define S_(c, v, s) { c, offsetof(union av_perm_to_string_data, L1(__LINE__)), v },
 #include "av_perm_to_string.h"
@@ -77,7 +77,7 @@
 #undef  S_
 	}
 };
-static const u16 class_to_string[] = {
+static const uint16_t class_to_string[] = {
 #define S_(s) offsetof(union class_to_string_data, L1(__LINE__)),
 #include "class_to_string.h"
 #undef  S_
@@ -112,7 +112,7 @@
 	struct {
 #define TB_(s) struct {
 #define TE_(s) } s##_part;
-#define S_(s) u16 L1(__LINE__)
+#define S_(s) uint16_t L1(__LINE__)
 #define L1(l) L2(l)
 #define L2(l) field_##l;
 #include "common_perm_to_string.h"
@@ -122,7 +122,7 @@
 #undef L1
 #undef L2
 	};
-	u16 data[0];
+	uint16_t data[0];
 } common_perm_to_string = {
 	{
 #define TB_(s) {
@@ -140,11 +140,11 @@
 };
 
 static const struct av_inherit {
-	u16 tclass;
-	u16 common_pts_idx;
-	u32 common_base;
+	uint16_t tclass;
+	uint16_t common_pts_idx;
+	uint32_t common_base;
 } av_inherit[] = {
-#define S_(c, i, b) { c, offsetof(union common_perm_to_string, common_##i##_perm_to_string_part)/sizeof(u16), b },
+#define S_(c, i, b) { c, offsetof(union common_perm_to_string, common_##i##_perm_to_string_part)/sizeof(uint16_t), b },
 #include "av_inherit.h"
 #undef S_
 };
@@ -168,17 +168,17 @@
 
 struct avc_cache {
 	struct avc_node *slots[AVC_CACHE_SLOTS];
-	u_int32_t lru_hint;	/* LRU hint for reclaim scan */
-	u_int32_t active_nodes;
-	u_int32_t latest_notif;	/* latest revocation notification */
+	uint32_t lru_hint;	/* LRU hint for reclaim scan */
+	uint32_t active_nodes;
+	uint32_t latest_notif;	/* latest revocation notification */
 };
 
 struct avc_callback_node {
-	int (*callback) (u_int32_t event, security_id_t ssid,
+	int (*callback) (uint32_t event, security_id_t ssid,
 			 security_id_t tsid,
 			 security_class_t tclass, access_vector_t perms,
 			 access_vector_t * out_retained);
-	u_int32_t events;
+	uint32_t events;
 	security_id_t ssid;
 	security_id_t tsid;
 	security_class_t tclass;
@@ -402,7 +402,7 @@
 {
 	struct avc_node *prev, *cur;
 	int try;
-	u_int32_t hvalue;
+	uint32_t hvalue;
 
 	hvalue = avc_cache.lru_hint;
 	for (try = 0; try < 2; try++) {
@@ -795,8 +795,8 @@
  */
 static void avc_dump_av(security_class_t tclass, access_vector_t av)
 {
-	const u16 *common_pts_idx = 0;
-	u_int32_t common_base = 0, perm;
+	const uint16_t *common_pts_idx = 0;
+	uint32_t common_base = 0, perm;
 	unsigned int i, i2;
 
 	if (av == 0) {
@@ -1006,12 +1006,12 @@
 	return rc;
 }
 
-int avc_add_callback(int (*callback) (u_int32_t event, security_id_t ssid,
+int avc_add_callback(int (*callback) (uint32_t event, security_id_t ssid,
 				      security_id_t tsid,
 				      security_class_t tclass,
 				      access_vector_t perms,
 				      access_vector_t * out_retained),
-		     u_int32_t events, security_id_t ssid,
+		     uint32_t events, security_id_t ssid,
 		     security_id_t tsid,
 		     security_class_t tclass, access_vector_t perms)
 {
@@ -1041,7 +1041,7 @@
 	return (x == y || x == SECSID_WILD || y == SECSID_WILD);
 }
 
-static inline void avc_update_node(u_int32_t event, struct avc_node *node,
+static inline void avc_update_node(uint32_t event, struct avc_node *node,
 				   access_vector_t perms)
 {
 	switch (event) {
@@ -1067,7 +1067,7 @@
 	}
 }
 
-static int avc_update_cache(u_int32_t event, security_id_t ssid,
+static int avc_update_cache(uint32_t event, security_id_t ssid,
 			    security_id_t tsid, security_class_t tclass,
 			    access_vector_t perms)
 {
@@ -1105,10 +1105,10 @@
  * This should not be called directly; use the individual event
  * functions instead.
  */
-static int avc_control(u_int32_t event, security_id_t ssid,
+static int avc_control(uint32_t event, security_id_t ssid,
 		       security_id_t tsid, security_class_t tclass,
 		       access_vector_t perms,
-		       u_int32_t seqno, access_vector_t * out_retained)
+		       uint32_t seqno, access_vector_t * out_retained)
 {
 	struct avc_callback_node *c;
 	access_vector_t tretained = 0, cretained = 0;
@@ -1167,7 +1167,7 @@
  */
 int avc_ss_grant(security_id_t ssid, security_id_t tsid,
 		 security_class_t tclass, access_vector_t perms,
-		 u_int32_t seqno)
+		 uint32_t seqno)
 {
 	return avc_control(AVC_CALLBACK_GRANT,
 			   ssid, tsid, tclass, perms, seqno, 0);
@@ -1188,7 +1188,7 @@
  */
 int avc_ss_try_revoke(security_id_t ssid, security_id_t tsid,
 		      security_class_t tclass,
-		      access_vector_t perms, u_int32_t seqno,
+		      access_vector_t perms, uint32_t seqno,
 		      access_vector_t * out_retained)
 {
 	return avc_control(AVC_CALLBACK_TRY_REVOKE,
@@ -1208,7 +1208,7 @@
  */
 int avc_ss_revoke(security_id_t ssid, security_id_t tsid,
 		  security_class_t tclass, access_vector_t perms,
-		  u_int32_t seqno)
+		  uint32_t seqno)
 {
 	return avc_control(AVC_CALLBACK_REVOKE,
 			   ssid, tsid, tclass, perms, seqno, 0);
@@ -1218,7 +1218,7 @@
  * avc_ss_reset - Flush the cache and revalidate migrated permissions.
  * @seqno: policy sequence number
  */
-int avc_ss_reset(u_int32_t seqno)
+int avc_ss_reset(uint32_t seqno)
 {
 	int rc;
 
@@ -1243,7 +1243,7 @@
  */
 int avc_ss_set_auditallow(security_id_t ssid, security_id_t tsid,
 			  security_class_t tclass, access_vector_t perms,
-			  u_int32_t seqno, u_int32_t enable)
+			  uint32_t seqno, uint32_t enable)
 {
 	if (enable)
 		return avc_control(AVC_CALLBACK_AUDITALLOW_ENABLE,
@@ -1264,7 +1264,7 @@
  */
 int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 			 security_class_t tclass, access_vector_t perms,
-			 u_int32_t seqno, u_int32_t enable)
+			 uint32_t seqno, uint32_t enable)
 {
 	if (enable)
 		return avc_control(AVC_CALLBACK_AUDITDENY_ENABLE,
@@ -1303,7 +1303,7 @@
 
 access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 {
-	const u16 *common_pts_idx = 0;
+	const uint16_t *common_pts_idx = 0;
 	access_vector_t perm, common_base = 0;
 	unsigned int i;
 
@@ -1340,7 +1340,7 @@
 
 void print_access_vector(security_class_t tclass, access_vector_t av)
 {
-	const u16 *common_pts_idx = 0;
+	const uint16_t *common_pts_idx = 0;
 	access_vector_t common_base = 0;
 	unsigned int i, i2, perm;
 
diff -ur libselinux-1.34.0.DIST/src/avc_internal.c libselinux-1.34.0/src/avc_internal.c
--- libselinux-1.34.0.DIST/src/avc_internal.c	2006-06-29 14:21:03.000000000 -0400
+++ libselinux-1.34.0/src/avc_internal.c	2007-02-07 11:59:19.000000000 -0500
@@ -11,12 +11,12 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <asm/types.h>
 #include <linux/netlink.h>
 #include "selinux_netlink.h"
 #include "avc_internal.h"
diff -ur libselinux-1.34.0.DIST/src/avc_internal.h libselinux-1.34.0/src/avc_internal.h
--- libselinux-1.34.0.DIST/src/avc_internal.h	2006-06-29 14:21:03.000000000 -0400
+++ libselinux-1.34.0/src/avc_internal.h	2007-02-07 11:58:28.000000000 -0500
@@ -15,10 +15,6 @@
 #include <selinux/avc.h>
 #include "dso.h"
 
-typedef u_int32_t u32;
-typedef u_int16_t u16;
-typedef u_int8_t u8;
-
 /* SID reference counter manipulation */
 static inline int sid_inc_refcnt(security_id_t sid)
 {
@@ -164,21 +160,21 @@
 /* internal callbacks */
 int avc_ss_grant(security_id_t ssid, security_id_t tsid,
 		 security_class_t tclass, access_vector_t perms,
-		 u_int32_t seqno) hidden;
+		 uint32_t seqno) hidden;
 int avc_ss_try_revoke(security_id_t ssid, security_id_t tsid,
 		      security_class_t tclass,
-		      access_vector_t perms, u_int32_t seqno,
+		      access_vector_t perms, uint32_t seqno,
 		      access_vector_t * out_retained) hidden;
 int avc_ss_revoke(security_id_t ssid, security_id_t tsid,
 		  security_class_t tclass, access_vector_t perms,
-		  u_int32_t seqno) hidden;
-int avc_ss_reset(u_int32_t seqno) hidden;
+		  uint32_t seqno) hidden;
+int avc_ss_reset(uint32_t seqno) hidden;
 int avc_ss_set_auditallow(security_id_t ssid, security_id_t tsid,
 			  security_class_t tclass, access_vector_t perms,
-			  u_int32_t seqno, u_int32_t enable) hidden;
+			  uint32_t seqno, uint32_t enable) hidden;
 int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
 			 security_class_t tclass, access_vector_t perms,
-			 u_int32_t seqno, u_int32_t enable) hidden;
+			 uint32_t seqno, uint32_t enable) hidden;
 
 /* netlink kernel message code */
 extern int avc_netlink_trouble hidden;
diff -ur libselinux-1.34.0.DIST/src/avc_sidtab.c libselinux-1.34.0/src/avc_sidtab.c
--- libselinux-1.34.0.DIST/src/avc_sidtab.c	2006-06-29 14:21:03.000000000 -0400
+++ libselinux-1.34.0/src/avc_sidtab.c	2007-02-07 11:58:28.000000000 -0500
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <string.h>
 #include "selinux_internal.h"
 #include <selinux/avc.h>
diff -ur libselinux-1.34.0.DIST/src/selinux_netlink.h libselinux-1.34.0/src/selinux_netlink.h
--- libselinux-1.34.0.DIST/src/selinux_netlink.h	2006-06-29 14:21:05.000000000 -0400
+++ libselinux-1.34.0/src/selinux_netlink.h	2007-02-07 11:58:28.000000000 -0500
@@ -25,7 +25,7 @@
 };
 
 struct selnl_msg_policyload {
-	u_int32_t seqno;
+	uint32_t seqno;
 };
 
 #endif				/* _LINUX_SELINUX_NETLINK_H */

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
