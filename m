Message-ID: <4666D5E6.508@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 11:42:30 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 1/2] libselinux: class and permission mapping support
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

This patch includes the interface and implementation of the
mapping set function.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/selinux.h |    8 +++++
 src/mapping.c             |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2464)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -280,6 +280,14 @@
 /* Commit the pending values for the booleans */
 extern int security_commit_booleans(void);
 
+/* Userspace class mapping support */
+struct security_class_mapping {
+	const char *name;
+	const char *perms[sizeof(access_vector_t) * 8 + 1];
+};
+
+int selinux_set_mapping(struct security_class_mapping *map);
+
 /* Common helpers */
 
 /* Convert between security class values and string names */
Index: libselinux/src/mapping.c
===================================================================
--- libselinux/src/mapping.c	(revision 0)
+++ libselinux/src/mapping.c	(revision 0)
@@ -0,0 +1,67 @@
+/*
+ * Class and permission mappings.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <selinux/selinux.h>
+#include "mapping.h"
+
+/* class and permission mappings */
+struct selinux_mapping *current_mapping = NULL;
+security_class_t current_mapping_size = 0;
+
+/* mapping setting function */
+int
+selinux_set_mapping(struct security_class_mapping *map)
+{
+	size_t size = sizeof(struct selinux_mapping);
+	security_class_t i, j;
+	unsigned k;
+
+	free(current_mapping);
+	current_mapping = NULL;
+	current_mapping_size = 0;
+
+	/* Find number of classes in the input mapping plus one */
+	i = 1;
+	while (map && map[i-1].name)
+		i++;
+
+	/* Allocate space for the class records */
+	current_mapping = (struct selinux_mapping *)calloc(i, size);
+	if (!current_mapping)
+		goto err;
+
+	/* Store the raw class and permission values */
+	j = 0;
+	while (map && map[j].name) {
+		struct security_class_mapping *p_in = map + (j++);
+		struct selinux_mapping *p_out = current_mapping + j;
+
+		p_out->value = string_to_security_class(p_in->name);
+		if (!p_out->value)
+			goto err2;
+
+		k = 0;
+		while (p_in->perms && p_in->perms[k]) {
+			p_out->perms[k] = string_to_av_perm(p_out->value,
+							    p_in->perms[k]);
+			if (!p_out->perms[k])
+				goto err2;
+			k++;
+		}
+		p_out->num_perms = k;
+	}
+
+	/* Set the mapping size here so the above lookups are "raw" */
+	current_mapping_size = i;
+	return 0;
+err2:
+	free(current_mapping);
+	current_mapping = NULL;
+	current_mapping_size = 0;
+err:
+	return -1;
+}

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
