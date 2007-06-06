Message-ID: <4666D65B.3030202@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 11:44:27 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 2/2] libselinux: class and permission mapping support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This provides support for userspace object managers to register a
mapping of class and permission values.  After the mapping is
registered all libselinux functions that take a security class
or permission value must be provided with mapped values instead
of the "real," kernel values.

Changes from the original interface proposal: No selinux_init()
function, just a straight set_mapping() function.  Also, to
simplify things the incoming mapping does not include explicit
values; the classes and permissions are numbered implicitly by
their ordering.  NULL strings are used to terminate the lists.

Tested with X server, no problems encountered.

This patch includes the internal map and unmap functions and
the changes to the selinuxfs interfaces to make it work.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 compute_av.c      |    8 ++-
 compute_create.c  |    5 +-
 compute_member.c  |    5 +-
 compute_relabel.c |    5 +-
 mapping.h         |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 8 deletions(-)

Index: libselinux/src/mapping.h
===================================================================
--- libselinux/src/mapping.h	(revision 0)
+++ libselinux/src/mapping.h	(revision 0)
@@ -0,0 +1,110 @@
+/*
+ * This file describes the class and permission mappings used to 
+ * hide the kernel numbers from userspace by allowing userspace object
+ * managers to specify a list of classes and permissions.
+ */
+#ifndef _SELINUX_MAPPING_H_
+#define _SELINUX_MAPPING_H_
+
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
+			if (tperm & (1<<i))
+				kperm |= current_mapping[tclass].perms[i];
+		return kperm;
+	}
+
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
+			if (kperm & current_mapping[tclass].perms[i])
+				tperm |= 1<<i;
+		return tperm;
+	}
+
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


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
