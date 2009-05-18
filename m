Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IIGCMo030090
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:16:12 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IIGIup018961
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 18:16:19 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIGAU8007834
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:16:10 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4IIGAgZ008285
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:16:10 -0400
Received: from localhost.localdomain (vpn-10-81.bos.redhat.com [10.16.10.81])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIG9fN002953
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:16:09 -0400
Message-ID: <4A11A5EC.9000904@redhat.com>
Date: Mon, 18 May 2009 14:16:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SELinux context patch
Content-Type: multipart/mixed;
 boundary="------------070100050309000902000709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070100050309000902000709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds context files for virtual_domain and virtual_image, 
these are both being used to locat the default context to be executed by 
svirt.

I also included the subs patch which I submitted before.  This patch 
allows us to substitute prefixes to matchpathcon.

So we can say /export/home == /home

and

/web == /var/www

--------------070100050309000902000709
Content-Type: text/plain;
 name="libselinux_context.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_context.patch"

--- nsalibselinux/src/selinux_config.c	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.81/src/selinux_config.c	2009-05-18 14:04:07.000000000 -0400
@@ -40,7 +40,10 @@
 #define SECURETTY_TYPES   18
 #define X_CONTEXTS        19
 #define COLORS            20
-#define NEL               21
+#define VIRTUAL_DOMAIN    21
+#define VIRTUAL_IMAGE     22
+#define FILE_CONTEXT_SUBS 23
+#define NEL               24
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -391,3 +394,24 @@
 }
 
 hidden_def(selinux_x_context_path)
+
+const char *selinux_virtual_domain_context_path()
+{
+	return get_path(VIRTUAL_DOMAIN);
+}
+
+hidden_def(selinux_virtual_domain_context_path)
+
+const char *selinux_virtual_image_context_path()
+{
+	return get_path(VIRTUAL_IMAGE);
+}
+
+hidden_def(selinux_virtual_image_context_path)
+
+const char * selinux_file_context_subs_path(void) {
+	return get_path(FILE_CONTEXT_SUBS);
+}
+
+hidden_def(selinux_file_context_subs_path)
+
--- nsalibselinux/include/selinux/selinux.h	2009-04-08 09:06:23.000000000 -0400
+++ libselinux-2.0.81/include/selinux/selinux.h	2009-05-18 14:04:07.000000000 -0400
@@ -481,8 +481,11 @@
 extern const char *selinux_file_context_path(void);
 extern const char *selinux_file_context_homedir_path(void);
 extern const char *selinux_file_context_local_path(void);
+extern const char *selinux_file_context_subs_path(void);
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
+extern const char *selinux_virtual_domain_context_path(void);
+extern const char *selinux_virtual_image_context_path(void);
 extern const char *selinux_x_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
--- nsalibselinux/src/file_path_suffixes.h	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.81/src/file_path_suffixes.h	2009-05-18 14:04:07.000000000 -0400
@@ -20,3 +20,6 @@
     S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
     S_(X_CONTEXTS, "/contexts/x_contexts")
     S_(COLORS, "/secolor.conf")
+    S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
+    S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
+    S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
--- nsalibselinux/src/selinux_internal.h	2009-04-08 09:06:23.000000000 -0400
+++ libselinux-2.0.81/src/selinux_internal.h	2009-05-18 14:04:07.000000000 -0400
@@ -59,9 +59,12 @@
     hidden_proto(selinux_securetty_types_path)
     hidden_proto(selinux_failsafe_context_path)
     hidden_proto(selinux_removable_context_path)
+    hidden_proto(selinux_virtual_domain_context_path)
+    hidden_proto(selinux_virtual_image_context_path)
     hidden_proto(selinux_file_context_path)
     hidden_proto(selinux_file_context_homedir_path)
     hidden_proto(selinux_file_context_local_path)
+    hidden_proto(selinux_file_context_subs_path)
     hidden_proto(selinux_netfilter_context_path)
     hidden_proto(selinux_homedir_context_path)
     hidden_proto(selinux_user_contexts_path)
--- nsalibselinux/src/label.c	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.81/src/label.c	2009-05-18 14:04:07.000000000 -0400
@@ -5,10 +5,12 @@
  */
 
 #include <sys/types.h>
+#include <ctype.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <selinux/selinux.h>
 #include "callbacks.h"
 #include "label_internal.h"
 
@@ -23,6 +25,96 @@
 	&selabel_x_init
 };
 
+typedef struct selabel_sub {
+	char *src;
+	int slen;
+	char *dst;
+	struct selabel_sub *next;
+} SELABELSUB;
+
+SELABELSUB *selabelsublist = NULL;
+
+static void selabel_subs_fini(void)
+{
+	SELABELSUB *ptr = selabelsublist;
+	SELABELSUB *next = NULL;
+	while (ptr) {
+		next = ptr->next;
+		free(ptr->src);
+		free(ptr->dst);
+		free(ptr);
+		ptr = next;
+	}
+	selabelsublist = NULL;
+}
+
+static char *selabel_sub(const char *src) 
+{
+	char *dst = NULL;
+	SELABELSUB *ptr = selabelsublist;
+	while (ptr) {
+		if (strncmp(src, ptr->src, ptr->slen) == 0 ) {
+			if (src[ptr->slen] == '/' || 
+			    src[ptr->slen] == 0) {
+				asprintf(&dst, "%s%s", ptr->dst, &src[ptr->slen]);
+				return dst;
+			}
+		}
+		ptr = ptr->next;
+	}
+	return NULL;
+}
+
+static int selabel_subs_init(void)
+{
+	char buf[1024];
+	FILE *cfg = fopen(selinux_file_context_subs_path(), "r");
+	if (cfg) {
+		while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
+			char *ptr = NULL;
+			char *src = buf;
+			char *dst = NULL;
+
+			while (*src && isspace(*src))
+				src++;
+			if (src[0] == '#') continue;
+			ptr = src;
+			while (*ptr && ! isspace(*ptr))
+				ptr++;
+			*ptr++ = 0;
+			if (! *src) continue;
+
+			dst = ptr;
+			while (*dst && isspace(*dst))
+				dst++;
+			ptr=dst;
+			while (*ptr && ! isspace(*ptr))
+				ptr++;
+			*ptr=0;
+			if (! *dst) continue;
+
+			SELABELSUB *sub = (SELABELSUB*) malloc(sizeof(SELABELSUB));
+			if (! sub) return -1;
+			sub->src=strdup(src);
+			if (! sub->src) {
+				free(sub);
+				return -1;
+			}
+			sub->dst=strdup(dst);
+			if (! sub->dst) {
+				free(sub);
+				free(sub->src);
+				return -1;
+			}
+			sub->slen = strlen(src);
+			sub->next = selabelsublist;
+			selabelsublist = sub;
+		}
+		fclose(cfg);
+	}
+	return 0;
+}
+
 /*
  * Validation functions
  */
@@ -67,6 +159,8 @@
 		goto out;
 	}
 
+	selabel_subs_init();
+
 	rec = (struct selabel_handle *)malloc(sizeof(*rec));
 	if (!rec)
 		goto out;
@@ -88,7 +182,14 @@
 selabel_lookup_common(struct selabel_handle *rec, int translating,
 		      const char *key, int type)
 {
-	struct selabel_lookup_rec *lr = rec->func_lookup(rec, key, type);
+	struct selabel_lookup_rec *lr;
+	char *ptr = selabel_sub(key);
+	if (ptr) {
+		lr = rec->func_lookup(rec, ptr, type); 
+		free(ptr);
+	} else {
+		lr = rec->func_lookup(rec, key, type); 
+	}
 	if (!lr)
 		return NULL;
 
@@ -132,6 +233,8 @@
 {
 	rec->func_close(rec);
 	free(rec);
+
+	selabel_subs_fini();
 }
 
 void selabel_stats(struct selabel_handle *rec)

--------------070100050309000902000709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
