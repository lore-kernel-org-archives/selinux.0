Message-ID: <4ACCF117.4060807@tycho.nsa.gov>
Date: Wed, 07 Oct 2009 15:50:47 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: raw string_to_class/string_to_av_perm variants
References: <4ACCE820.4080007@tycho.nsa.gov>
In-Reply-To: <4ACCE820.4080007@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for remapping classes and permissions on policy 
reload.  This is accomplished by separating the code that computes the 
"real" kernel class and permission values into a helper function, 
mapping_compute().  This function is called both from 
selinux_set_mapping() when the user specifies a new mapping, and from 
the netlink code when a policyload notification is received.  The 
function now builds up a temporary mapping and swaps it in rather than 
working on the active mapping in place.

Issue: There is a race condition in which old class and permission 
values may arrive from userspace after a kernel policyload has taken 
place.  Fixing this would require a string interface to the kernel, or 
some kind of transaction support.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

  avc_internal.c |   17 +++++++
  mapping.c      |  130 +++++++++++++++++++++++++++++++++++++++++++--------------
  mapping.h      |   10 ++++
  3 files changed, 126 insertions(+), 31 deletions(-)


diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 8372f52..2c54a92 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -22,6 +22,7 @@
  #include "callbacks.h"
  #include "selinux_netlink.h"
  #include "avc_internal.h"
+#include "mapping.h"

  #ifndef NETLINK_SELINUX
  #define NETLINK_SELINUX 7
@@ -180,6 +181,8 @@ static int avc_netlink_process(char *buf)
  		avc_log(SELINUX_INFO,
  			"%s:  received policyload notice (seqno=%d)\n",
  			avc_prefix, msg->seqno);
+
+		/* Flush the AVC */
  		rc = avc_ss_reset(msg->seqno);
  		if (rc<  0) {
  			avc_log(SELINUX_ERROR,
@@ -187,6 +190,20 @@ static int avc_netlink_process(char *buf)
  				avc_prefix, rc, errno);
  			return rc;
  		}
+
+		/* Flush any cached class/permission values */
+		flush_class_cache();
+
+		/* Recompute any mapped classes/permissions */
+		rc = mapping_recompute();
+		if (rc<  0) {
+			avc_log(SELINUX_ERROR,
+				"%s:  mapping reset returned %d (errno %d)\n",
+				avc_prefix, rc, errno);
+			return rc;
+		}
+
+		/* Call callback for users */
  		rc = selinux_netlink_policyload(msg->seqno);
  		if (rc<  0)
  			return rc;
diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index f9858ce..eb99eb3 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -6,6 +6,7 @@
  #include<stdio.h>
  #include<stdlib.h>
  #include<stdarg.h>
+#include<string.h>
  #include<assert.h>
  #include<selinux/selinux.h>
  #include<selinux/avc.h>
@@ -17,12 +18,85 @@

  struct selinux_mapping {
  	security_class_t value; /* real, kernel value */
+	char *name;
  	unsigned num_perms;
  	access_vector_t perms[sizeof(access_vector_t) * 8];
+	char *names[sizeof(access_vector_t) * 8];
  };

-static struct selinux_mapping *current_mapping = NULL;
-static security_class_t current_mapping_size = 0;
+static struct selinux_mapping *current_mapping;
+static int current_mapping_size;
+
+/*
+ * Mapping recompute functions
+ */
+
+static void
+mapping_free(struct selinux_mapping *map, int size, int free_strings)
+{
+	int i;
+	unsigned j;
+
+	if (free_strings)
+		for (i = 0; i<  size; i++) {
+			free(map[i].name);
+			for (j = 0; j<  map[i].num_perms; j++)
+				free(map[i].names[j]);
+		}
+
+	free(map);
+}
+
+static int
+mapping_compute(struct selinux_mapping *map, int size, int free_strings)
+{
+	struct selinux_mapping *old_mapping;
+	int old_mapping_size, i;
+	unsigned k;
+
+	/* Find the real, kernel values for the names */
+	for (i = 1; i<  size; i++) {
+		map[i].value = string_to_security_class_raw(map[i].name);
+		if (!map[i].value)
+			return -1;
+
+		for (k = 0; k<  map[i].num_perms; k++) {
+			if (!map[i].names[k])
+				continue;
+			map[i].perms[k] = string_to_av_perm_raw(
+				map[i].value, map[i].names[k]);
+			if (!map[i].perms[k])
+				return -1;
+		}
+	}
+
+	/* Switch in the new mapping */
+	old_mapping_size = current_mapping_size;
+	old_mapping = current_mapping;
+	current_mapping_size = size;
+	current_mapping = map;
+	mapping_free(old_mapping, old_mapping_size, free_strings);
+	return 0;
+}
+
+int
+mapping_recompute(void)
+{
+	struct selinux_mapping *copy;
+	size_t size;
+
+	size = current_mapping_size * sizeof(struct selinux_mapping);
+	if (size == 0)
+		return 0;
+
+	/* Not a deep copy - we keep the old class and perm names */
+	copy = malloc(size);
+	if (!copy)
+		return -1;
+	memcpy(copy, current_mapping, size);
+
+	return mapping_compute(copy, current_mapping_size, 0);
+}

  /*
   * Mapping setting function
@@ -31,40 +105,34 @@ static security_class_t current_mapping_size = 0;
  int
  selinux_set_mapping(struct security_class_mapping *map)
  {
-	size_t size = sizeof(struct selinux_mapping);
-	security_class_t i, j;
+	struct selinux_mapping *new_mapping;
+	int new_size, i, j;
  	unsigned k;

-	free(current_mapping);
-	current_mapping = NULL;
-	current_mapping_size = 0;
-
-	if (avc_reset()<  0)
-		goto err;
-
  	/* Find number of classes in the input mapping */
  	if (!map) {
  		errno = EINVAL;
-		goto err;
+		return -1;
  	}
  	i = 0;
  	while (map[i].name)
  		i++;

  	/* Allocate space for the class records, plus one for class zero */
-	current_mapping = (struct selinux_mapping *)calloc(++i, size);
-	if (!current_mapping)
-		goto err;
+	new_size = i + 1;
+	new_mapping = calloc(new_size, sizeof(struct selinux_mapping));
+	if (!new_mapping)
+		return -1;

-	/* Store the raw class and permission values */
+	/* Store the class and permission names */
  	j = 0;
  	while (map[j].name) {
  		struct security_class_mapping *p_in = map + (j++);
-		struct selinux_mapping *p_out = current_mapping + j;
+		struct selinux_mapping *p_out = new_mapping + j;

-		p_out->value = string_to_security_class(p_in->name);
-		if (!p_out->value)
-			goto err2;
+		p_out->name = strdup(p_in->name);
+		if (!p_out->name)
+			goto err;

  		k = 0;
  		while (p_in->perms&&  p_in->perms[k]) {
@@ -73,23 +141,23 @@ selinux_set_mapping(struct security_class_mapping *map)
  				k++;
  				continue;
  			}
-			p_out->perms[k] = string_to_av_perm(p_out->value,
-							    p_in->perms[k]);
-			if (!p_out->perms[k])
-				goto err2;
+			p_out->names[k] = strdup(p_in->perms[k]);
+			if (!p_out->names[k])
+				goto err;
  			k++;
  		}
  		p_out->num_perms = k;
  	}

-	/* Set the mapping size here so the above lookups are "raw" */
-	current_mapping_size = i;
-	return 0;
-err2:
-	free(current_mapping);
-	current_mapping = NULL;
-	current_mapping_size = 0;
+	/* Flush the AVC */
+	if (avc_reset()<  0)
+		goto err;
+
+	/* Set up the mapping */
+	if (mapping_compute(new_mapping, new_size, 1) == 0)
+		return 0;
  err:
+	mapping_free(new_mapping, new_size, 1);
  	return -1;
  }

diff --git a/libselinux/src/mapping.h b/libselinux/src/mapping.h
index b9e9c44..34d94eb 100644
--- a/libselinux/src/mapping.h
+++ b/libselinux/src/mapping.h
@@ -42,6 +42,16 @@ map_perm(security_class_t tclass, access_vector_t kperm);
  extern void
  map_decision(security_class_t tclass, struct av_decision *avd);

+/*
+ * Recompute mapping on policy load
+ */
+
+extern void
+flush_class_cache(void) hidden;
+
+extern int
+mapping_recompute(void) hidden;
+
  /*mapping is not used for embedded build*/
  #ifdef DISABLE_AVC
  #define unmap_perm(x,y) y



-- 
Eamon Walsh<ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
