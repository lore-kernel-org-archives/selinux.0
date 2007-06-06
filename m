Message-ID: <4666FE38.4060401@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 14:34:32 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 2/2] libselinux: class and permission mapping support (try
 2)
References: <4666D5E6.508@tycho.nsa.gov> <1181148038.17617.25.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1181148038.17617.25.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch includes the internal map and unmap functions and
the changes to the selinuxfs interfaces to make it work.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 compute_av.c      |    8 ++-
 compute_create.c  |    5 +-
 compute_member.c  |    5 +-
 compute_relabel.c |    5 +-
 mapping.h         |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 stringrep.c       |   17 +++++--
 6 files changed, 148 insertions(+), 13 deletions(-)

Index: libselinux/src/mapping.h
===================================================================
--- libselinux/src/mapping.h	(revision 0)
+++ libselinux/src/mapping.h	(revision 0)
@@ -0,0 +1,121 @@
+/*
+ * This file describes the class and permission mappings used to 
+ * hide the kernel numbers from userspace by allowing userspace object
+ * managers to specify a list of classes and permissions.
+ */
+#ifndef _SELINUX_MAPPING_H_
+#define _SELINUX_MAPPING_H_
+
+#include <assert.h>
+#include <selinux/selinux.h>
+
+struct selinux_mapping {
+	security_class_t value; /* real, kernel value */
+	unsigned num_perms;
+	access_vector_t perms[sizeof(access_vector_t) * 8];
+};
+
+extern struct selinux_mapping *current_mapping;
+extern security_class_t current_mapping_size;
+
+/*
+ * Get real, kernel values from mapped values
+ */
+
+static inline security_class_t
+unmap_class(security_class_t tclass)
+{
+	if (tclass < current_mapping_size)
+		return current_mapping[tclass].value;
+
+	assert(current_mapping_size == 0);
+	return tclass;
+}
+
+static inline access_vector_t
+unmap_perm(security_class_t tclass, access_vector_t tperm)
+{
+	if (tclass < current_mapping_size) {
+		unsigned i;
+		access_vector_t kperm = 0;
+
+		for (i=0; i<current_mapping[tclass].num_perms; i++)
+			if (tperm & (1<<i)) {
+				kperm |= current_mapping[tclass].perms[i];
+				tperm &= ~(1<<i);
+			}
+		assert(tperm == 0);
+		return kperm;
+	}
+
+	assert(current_mapping_size == 0);
+	return tperm;
+}
+
+/*
+ * Get mapped values from real, kernel values
+ */
+
+static inline security_class_t
+map_class(security_class_t kclass)
+{
+	security_class_t i;
+
+	for (i=0; i<current_mapping_size; i++)
+		if (current_mapping[i].value == kclass)
+			return i;
+
+	assert(current_mapping_size == 0);
+	return kclass;
+}
+
+static inline access_vector_t
+map_perm(security_class_t tclass, access_vector_t kperm)
+{
+	if (tclass < current_mapping_size) {
+		unsigned i;
+		access_vector_t tperm = 0;
+
+		for (i=0; i<current_mapping[tclass].num_perms; i++)
+			if (kperm & current_mapping[tclass].perms[i]) {
+				tperm |= 1<<i;
+				kperm &= ~current_mapping[tclass].perms[i];
+			}
+		assert(kperm == 0);
+		return tperm;
+	}
+
+	assert(current_mapping_size == 0);
+	return kperm;
+}
+
+static inline void
+map_decision(security_class_t tclass, struct av_decision *avd)
+{
+	if (tclass < current_mapping_size) {
+		unsigned i;
+		access_vector_t result;
+
+		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
+			if (avd->allowed & current_mapping[tclass].perms[i])
+				result |= 1<<i;
+		avd->allowed = result;
+
+		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
+			if (avd->decided & current_mapping[tclass].perms[i])
+				result |= 1<<i;
+		avd->decided = result;
+
+		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
+			if (avd->auditallow & current_mapping[tclass].perms[i])
+				result |= 1<<i;
+		avd->auditallow = result;
+
+		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
+			if (avd->auditdeny & current_mapping[tclass].perms[i])
+				result |= 1<<i;
+		avd->auditdeny = result;
+	}
+}
+
+#endif				/* _SELINUX_MAPPING_H_ */
Index: libselinux/src/stringrep.c
===================================================================
--- libselinux/src/stringrep.c	(revision 2464)
+++ libselinux/src/stringrep.c	(working copy)
@@ -11,6 +11,7 @@
 #include <selinux/flask.h>
 #include <selinux/av_permissions.h>
 #include "selinux_internal.h"
+#include "mapping.h"
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
@@ -151,12 +152,12 @@
 	if (isdigit(s[0])) {
 		val = atoi(s);
 		if (val > 0 && val < NCLASSES)
-			return val;
+			return map_class(val);
 	} else {
 		for (val = 0; val < NCLASSES; val++) {
 			if (strcmp(s, (class_to_string_data.str
 				       + class_to_string[val])) == 0)
-				return val;
+				return map_class(val);
 		}
 	}
 
@@ -169,9 +170,10 @@
 	const uint16_t *common_pts_idx = 0;
 	access_vector_t perm, common_base = 0;
 	unsigned int i;
+	security_class_t kclass = unmap_class(tclass);
 
 	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
-		if (av_inherit[i].tclass == tclass) {
+		if (av_inherit[i].tclass == kclass) {
 			common_pts_idx =
 			    &common_perm_to_string.data[av_inherit[i].
 							common_pts_idx];
@@ -186,13 +188,13 @@
 		if (strcmp
 		    (s,
 		     common_perm_to_string_data.str + common_pts_idx[i]) == 0)
-			return perm;
+			return map_perm(tclass, perm);
 		perm <<= 1;
 		i++;
 	}
 
 	for (i = 0; i < NVECTORS; i++) {
-		if ((av_perm_to_string[i].tclass == tclass) &&
+		if ((av_perm_to_string[i].tclass == kclass) &&
 		    (strcmp(s, (av_perm_to_string_data.str
 				+ av_perm_to_string[i].nameidx)) == 0))
 			return av_perm_to_string[i].value;
@@ -204,6 +206,8 @@
 
 const char *security_class_to_string(security_class_t tclass)
 {
+	tclass = unmap_class(tclass);
+
 	if (tclass > 0 && tclass < NCLASSES)
 		return class_to_string_data.str + class_to_string[tclass];
 
@@ -218,6 +222,9 @@
 	access_vector_t common_base = 0;
 	unsigned int i;
 
+	av = unmap_perm(tclass, av);
+	tclass = unmap_class(tclass);
+
 	if (!av)
 		return NULL;
 
Index: libselinux/src/compute_av.c
===================================================================
--- libselinux/src/compute_av.c	(revision 2464)
+++ libselinux/src/compute_av.c	(working copy)
@@ -5,9 +5,10 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
+#include <limits.h>
 #include "selinux_internal.h"
 #include "policy.h"
-#include <limits.h>
+#include "mapping.h"
 
 int security_compute_av_raw(security_context_t scon,
 			    security_context_t tcon,
@@ -36,7 +37,8 @@
 		goto out;
 	}
 
-	snprintf(buf, len, "%s %s %hu %x", scon, tcon, tclass, requested);
+	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
+		 unmap_class(tclass), unmap_perm(tclass, requested));
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
@@ -54,6 +56,8 @@
 		goto out2;
 	}
 
+	map_decision(tclass, avd);
+
 	ret = 0;
       out2:
 	free(buf);
Index: libselinux/src/compute_create.c
===================================================================
--- libselinux/src/compute_create.c	(revision 2464)
+++ libselinux/src/compute_create.c	(working copy)
@@ -5,9 +5,10 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
+#include <limits.h>
 #include "selinux_internal.h"
 #include "policy.h"
-#include <limits.h>
+#include "mapping.h"
 
 int security_compute_create_raw(security_context_t scon,
 				security_context_t tcon,
@@ -35,7 +36,7 @@
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
+	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
Index: libselinux/src/compute_member.c
===================================================================
--- libselinux/src/compute_member.c	(revision 2464)
+++ libselinux/src/compute_member.c	(working copy)
@@ -5,9 +5,10 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
+#include <limits.h>
 #include "selinux_internal.h"
 #include "policy.h"
-#include <limits.h>
+#include "mapping.h"
 
 int security_compute_member_raw(security_context_t scon,
 				security_context_t tcon,
@@ -35,7 +36,7 @@
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
+	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
Index: libselinux/src/compute_relabel.c
===================================================================
--- libselinux/src/compute_relabel.c	(revision 2464)
+++ libselinux/src/compute_relabel.c	(working copy)
@@ -5,9 +5,10 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
+#include <limits.h>
 #include "selinux_internal.h"
 #include "policy.h"
-#include <limits.h>
+#include "mapping.h"
 
 int security_compute_relabel_raw(security_context_t scon,
 				 security_context_t tcon,
@@ -35,7 +36,7 @@
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
+	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
