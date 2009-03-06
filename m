Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n26KeIde027212
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 15:40:18 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n26KeG5Y012159
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 20:40:17 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n26KeGTD032593
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 15:40:16 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n26KeGMj001170
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 15:40:17 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n26KeGmd005363
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 15:40:16 -0500
Message-ID: <49B18A30.7080507@redhat.com>
Date: Fri, 06 Mar 2009 15:40:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Talking to Nalin today about the path substitution semanage problem,
 and he came up  with a great idea.
Content-Type: multipart/mixed;
 boundary="------------000700000300070701020705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000700000300070701020705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was thinking of mangling the file_context file with substitutions, but
he suggested that we do the substitution right in matchpathcon (selabel).

This would allow us to save hundreds of regular expressions and
eliminate some heavy coding in semanage.

Here is a patch to libselinux that will read the

/etc/selinux/targeted/contexts/files/file_contexts.subs
Looking for space separated names like

/myweb /var/www
/myspool /var/spool/mail

When matchpatchcon or selabel gets handed a path, like  /myweb/index.html

the code looks through the list of subsitutions and switches out /myweb
for /var/www

It hands the underlying code /var/www/index.html and gets the correct match.

With this type of functionality we can either get rid of genhomedircon
or allow it to just generate subs files that look like

/export/home /home
/usr/local/home /home

This has a side benefit of decreasing the size of regexs we need to compile.

I think there is little to no costs.  Other the strcmp on all paths
handed in times the number of substitutions.

What do you think?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmxijAACgkQrlYvE4MpobOJwwCglpslipw2U+wpy+vvryjgVpPX
JK0AoNlBwM8SrgGyev7ZDZasuNpZU8d/
=R3fm
-----END PGP SIGNATURE-----

--------------000700000300070701020705
Content-Type: text/plain;
 name="libselinux-subs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-subs.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-2.0.78/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2009-03-06 14:41:44.000000000 -0500
+++ libselinux-2.0.78/include/selinux/selinux.h	2009-03-06 15:25:30.000000000 -0500
@@ -457,6 +457,7 @@
 extern const char *selinux_file_context_path(void);
 extern const char *selinux_file_context_homedir_path(void);
 extern const char *selinux_file_context_local_path(void);
+extern const char *selinux_file_context_subs_path(void);
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_x_context_path(void);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-2.0.78/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.78/src/file_path_suffixes.h	2009-03-06 15:24:48.000000000 -0500
@@ -20,3 +20,4 @@
     S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
     S_(X_CONTEXTS, "/contexts/x_contexts")
     S_(COLORS, "/secolor.conf")
+    S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
diff --exclude-from=exclude -N -u -r nsalibselinux/src/label.c libselinux-2.0.78/src/label.c
--- nsalibselinux/src/label.c	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.78/src/label.c	2009-03-06 15:24:15.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-2.0.78/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.78/src/selinux_config.c	2009-03-06 15:26:50.000000000 -0500
@@ -40,7 +40,8 @@
 #define SECURETTY_TYPES   18
 #define X_CONTEXTS        19
 #define COLORS            20
-#define NEL               21
+#define FILE_CONTEXT_SUBS 21
+#define NEL               22
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -391,3 +392,10 @@
 }
 
 hidden_def(selinux_x_context_path)
+
+const char * selinux_file_context_subs_path(void) {
+	return get_path(FILE_CONTEXT_SUBS);
+}
+
+hidden_def(selinux_file_context_subs_path)
+
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-2.0.78/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.78/src/selinux_internal.h	2009-03-06 15:27:52.000000000 -0500
@@ -59,6 +59,7 @@
     hidden_proto(selinux_file_context_path)
     hidden_proto(selinux_file_context_homedir_path)
     hidden_proto(selinux_file_context_local_path)
+    hidden_proto(selinux_file_context_subs_path)
     hidden_proto(selinux_netfilter_context_path)
     hidden_proto(selinux_homedir_context_path)
     hidden_proto(selinux_user_contexts_path)

--------------000700000300070701020705
Content-Type: application/octet-stream;
 name="libselinux-subs.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-subs.patch.sig"

iEYEABECAAYFAkmxijAACgkQrlYvE4MpobMc+gCgsRwt/+CYmdUrmjI3TsIYjC04g9cAoIYP
womG9AvGx8ddv38mnkaJkXLt
--------------000700000300070701020705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
