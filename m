Message-ID: <483A9137.5050509@ak.jp.nec.com>
Date: Mon, 26 May 2008 19:30:15 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com, sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: add support for /contexts/postgresql_contexts
Content-Type: multipart/mixed;
 boundary="------------010104020202050008030801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010104020202050008030801
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

The attached patch enables to obtain the default security context of newly
created database, defined at /etc/selinux/*/contexts/postgresql_contexts .

The format is as follows:
--------
#
# Config file for SE-PostgreSQL
#
# <domain of client>  <type of newly created database>
unconfined_t    sepgsql_db_t
*               sepgsql_db_t
--------

'*' means default security context, if given key is not matched for any entry.

This API requires the security context of client as a key, and it returns
a security context to be attached for a newly created database.
It has a type field defined in the right-hand of config file, and inherits
user and lower-range field of given security context as a key.

e.g)
selabel_lookup(sehandle, &context, "user_u:user_r:user_t:s0", 0);
returns "user_u:object_r:sepgsql_db_t:s0".

This patch is implemented based on the previous discussion at:
  http://marc.info/?l=selinux&m=120999566809541&w=2

Thanks,

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 include/selinux/label.h   |    2
 include/selinux/selinux.h |    1
 src/file_path_suffixes.h  |    1
 src/label.c               |   20 +++-
 src/label_internal.h      |    4
 src/label_pgsql.c         |  209 ++++++++++++++++++++++++++++++++++++++++++++++
 src/selinux_config.c      |    9 +
 src/selinux_internal.h    |    1
 8 files changed, 243 insertions(+), 4 deletions(-)
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------010104020202050008030801
Content-Type: text/x-patch;
 name="libselinux-add-pgsql-label.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-add-pgsql-label.patch"

Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 2883)
+++ libselinux/include/selinux/label.h	(working copy)
@@ -29,6 +29,8 @@
 #define SELABEL_CTX_MEDIA	1
 /* x contexts */
 #define SELABEL_CTX_X		2
+/* pgsql database contexts */
+#define SELABEL_CTX_PGSQL	3
 
 /*
  * Available options
Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2883)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -460,6 +460,7 @@
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_x_context_path(void);
+extern const char *selinux_pgsql_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_path(void);
Index: libselinux/src/file_path_suffixes.h
===================================================================
--- libselinux/src/file_path_suffixes.h	(revision 2883)
+++ libselinux/src/file_path_suffixes.h	(working copy)
@@ -19,3 +19,4 @@
     S_(FILE_CONTEXTS_HOMEDIR, "/contexts/files/file_contexts.homedirs")
     S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
     S_(X_CONTEXTS, "/contexts/x_contexts")
+    S_(PGSQL_CONTEXTS, "/contexts/postgresql_contexts")
Index: libselinux/src/label_pgsql.c
===================================================================
--- libselinux/src/label_pgsql.c	(revision 0)
+++ libselinux/src/label_pgsql.c	(revision 0)
@@ -0,0 +1,209 @@
+/*
+ * Media contexts backend for SE-PostgreSQL database contexts
+ *
+ * Author: KaiGai Kohei <kaigai@ak.jp.nec.com>
+ */
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include "callbacks.h"
+#include "label_internal.h"
+
+typedef struct pgsql_entry {
+	struct pgsql_entry *next;
+	char *key, *type;
+} pgsql_entry;
+
+static void pgsql_close(struct selabel_handle *h)
+{
+	pgsql_entry *entry, *next_entry;
+
+	for (entry = h->data; entry != NULL; entry = next_entry) {
+		next_entry = entry->next;
+
+		if (entry->key)
+			free(entry->key);
+		free(entry->type);
+		free(entry);
+	}
+	h->data = NULL;
+}
+
+static struct selabel_lookup_rec *pgsql_lookup(struct selabel_handle *h,
+					       const char *key, int type)
+{
+	struct selabel_lookup_rec *lr;
+	pgsql_entry *head = h->data;
+	pgsql_entry *entry, *default_entry = NULL;
+	security_context_t context;
+	char *user, *role, *domain, *range;
+
+	if (type != 0) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	/* pick up user's domain */
+	if (selinux_trans_to_raw_context((security_context_t)key, &context) < 0)
+		return NULL;
+
+	user = strtok(context, ":");
+	role = strtok(NULL, ":");
+	domain = strtok(NULL, ":");
+	range = strtok(NULL, "-");
+
+	for (entry = head; entry != NULL; entry = entry->next) {
+		if (!entry->key) {
+			default_entry = entry;
+			continue;
+		}
+		if (!strcmp(domain, entry->key))
+			goto found;
+	}
+	/* not found */
+	if (!default_entry) {
+		errno = ENOENT;
+		goto error0;
+	}
+	entry = default_entry;
+
+found:
+	lr = malloc(sizeof(struct selabel_lookup_rec));
+	if (!lr)
+		goto error0;
+
+	lr->ctx_raw = malloc(strlen(user) + sizeof("object_r") + strlen(entry->type) + 4
+			     + (!range ? 0 : strlen(range)));
+	if (!lr->ctx_raw)
+		goto error1;
+
+	if (!range) {
+		sprintf(lr->ctx_raw, "%s:object_r:%s", user, entry->type);
+	} else {
+		sprintf(lr->ctx_raw, "%s:object_r:%s:%s", user, entry->type, range);
+	}
+
+	if (security_check_context_raw(lr->ctx_raw) < 0)
+		goto error2;
+
+	freecon(context);
+
+	return lr;
+
+error2:
+	free(lr->ctx_raw);
+error1:
+	free(lr);
+error0:
+	freecon(context);
+	return NULL;
+}
+
+static void pgsql_lookup_post(struct selabel_handle *h,
+			      struct selabel_lookup_rec *lr)
+{
+	h = h;	/* to kill compiler warnings */
+
+	free(lr->ctx_raw);
+	if (lr->ctx_trans)
+		free(lr->ctx_trans);
+	free(lr);
+}
+
+static void pgsql_stats(struct selabel_handle *h)
+{
+	pgsql_entry *entry, *head = h->data;
+	unsigned int count;
+	int has_default = 0;
+
+	for (count=0, entry = head; entry != NULL; count++, entry = entry->next) {
+		if (!entry->key)
+			has_default = 1;
+	}
+
+	selinux_log(SELINUX_INFO, "%u entries%s\n",
+		    count,
+		    has_default ? " has default type," : "");
+}
+
+pgsql_entry *read_a_line(FILE *filp)
+{
+	pgsql_entry *entry;
+	char buffer[4096];
+	char *ptr, *key, *type;
+	int items;
+
+retry:
+	ptr = fgets(buffer, sizeof(buffer), filp);
+	if (!ptr)
+		return NULL;
+
+	/* skip comment line */
+	while (isspace(*ptr))
+		ptr++;
+	if (*ptr == '#' || *ptr == '\0')
+		goto retry;
+
+	items = sscanf(ptr, "%as %as", &key, &type);
+	if (items < 2) {
+		if (items > 0)
+			free(key);
+		goto retry;
+	}
+
+	/* make a pgsql_entry */
+	entry = malloc(sizeof(pgsql_entry));
+	if (!entry) {
+		free(key);
+		free(type);
+		return NULL;
+	}
+	memset(entry, 0, sizeof(pgsql_entry));
+
+	if (!strcmp(key, "*")) {
+		free(key);
+		key = NULL;	/* default */
+	}
+
+	entry->key = key;
+	entry->type = type;
+
+	return entry;
+}
+
+int selabel_pgsql_init(struct selabel_handle *rec,
+		       struct selinux_opt *opts,
+		       unsigned int nopts)
+{
+	FILE *filp;
+	const char *path = NULL;
+	pgsql_entry *entry, *head = NULL;
+
+	/* parse options */
+	while (nopts--) {
+		if (opts[nopts].type == SELABEL_OPT_PATH)
+			path = opts[nopts].value;
+	}
+
+	/* open the specified file */
+	if (!path)
+		path = selinux_pgsql_context_path();
+	filp = fopen(path, "rb");
+	if (!filp)
+		return -1;
+
+	while ((entry = read_a_line(filp)) != NULL) {
+		entry->next = head;
+		head = entry;
+	}
+	fclose(filp);
+
+	rec->data = head;
+	rec->func_close	      = pgsql_close;
+	rec->func_lookup      = pgsql_lookup;
+	rec->func_lookup_post = pgsql_lookup_post;
+	rec->func_stats       = pgsql_stats;
+
+	return 0;
+}
Index: libselinux/src/selinux_internal.h
===================================================================
--- libselinux/src/selinux_internal.h	(revision 2883)
+++ libselinux/src/selinux_internal.h	(working copy)
@@ -66,6 +66,7 @@
     hidden_proto(selinux_customizable_types_path)
     hidden_proto(selinux_media_context_path)
     hidden_proto(selinux_x_context_path)
+    hidden_proto(selinux_pgsql_context_path)
     hidden_proto(selinux_path)
     hidden_proto(selinux_check_passwd_access)
     hidden_proto(selinux_check_securetty_context)
Index: libselinux/src/selinux_config.c
===================================================================
--- libselinux/src/selinux_config.c	(revision 2883)
+++ libselinux/src/selinux_config.c	(working copy)
@@ -39,7 +39,8 @@
 #define FILE_CONTEXTS_LOCAL 17
 #define SECURETTY_TYPES   18
 #define X_CONTEXTS        19
-#define NEL               20
+#define PGSQL_CONTEXTS    20
+#define NEL               21
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -383,3 +384,9 @@
 }
 
 hidden_def(selinux_x_context_path)
+
+const char *selinux_pgsql_context_path()
+{
+	return get_path(PGSQL_CONTEXTS);
+}
+hidden_def(selinux_pgsql_context_path);
Index: libselinux/src/label.c
===================================================================
--- libselinux/src/label.c	(revision 2883)
+++ libselinux/src/label.c	(working copy)
@@ -20,7 +20,8 @@
 static selabel_initfunc initfuncs[] = {
 	&selabel_file_init,
 	&selabel_media_init,
-	&selabel_x_init
+	&selabel_x_init,
+	&selabel_pgsql_init,
 };
 
 /*
@@ -84,6 +85,13 @@
 	return rec;
 }
 
+static void selabel_lookup_post_common(struct selabel_handle *rec,
+				       struct selabel_lookup_rec *lr)
+{
+	if (rec->func_lookup_post)
+		rec->func_lookup_post(rec, lr);
+}
+
 static struct selabel_lookup_rec *
 selabel_lookup_common(struct selabel_handle *rec, int translating,
 		      const char *key, int type)
@@ -92,12 +100,16 @@
 	if (!lr)
 		return NULL;
 
-	if (compat_validate(rec, lr, "file_contexts", 0))
+	if (compat_validate(rec, lr, "file_contexts", 0)) {
+		selabel_lookup_post_common(rec, lr);
 		return NULL;
+	}
 
 	if (translating && !lr->ctx_trans &&
-	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
+	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans)) {
+		selabel_lookup_post_common(rec, lr);
 		return NULL;
+	}
 
 	return lr;
 }
@@ -112,6 +124,7 @@
 		return -1;
 
 	*con = strdup(lr->ctx_trans);
+	selabel_lookup_post_common(rec, lr);
 	return *con ? 0 : -1;
 }
 
@@ -125,6 +138,7 @@
 		return -1;
 
 	*con = strdup(lr->ctx_raw);
+	selabel_lookup_post_common(rec, lr);
 	return *con ? 0 : -1;
 }
 
Index: libselinux/src/label_internal.h
===================================================================
--- libselinux/src/label_internal.h	(revision 2883)
+++ libselinux/src/label_internal.h	(working copy)
@@ -23,6 +23,8 @@
 		      unsigned nopts) hidden;
 int selabel_x_init(struct selabel_handle *rec, struct selinux_opt *opts,
 		   unsigned nopts) hidden;
+int selabel_pgsql_init(struct selabel_handle *rec, struct selinux_opt *opts,
+		       unsigned nopts) hidden;
 
 /*
  * Labeling internal structures
@@ -41,6 +43,8 @@
 	/* labeling operations */
 	struct selabel_lookup_rec *(*func_lookup) (struct selabel_handle *h,
 						   const char *key, int type);
+	void (*func_lookup_post) (struct selabel_handle *h,
+				  struct selabel_lookup_rec *lr);
 	void (*func_close) (struct selabel_handle *h);
 	void (*func_stats) (struct selabel_handle *h);
 

--------------010104020202050008030801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
