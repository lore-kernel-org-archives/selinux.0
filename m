Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2U8LYVg030983
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 04:21:35 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2U8LXRp013494
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 08:21:33 GMT
Message-ID: <49D08105.2090607@ak.jp.nec.com>
Date: Mon, 30 Mar 2009 17:21:25 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Andy Warner <warner@rubix.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com> <49D018A3.2090304@ak.jp.nec.com>
In-Reply-To: <49D018A3.2090304@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------000501060204030903010905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000501060204030903010905
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

KaiGai Kohei wrote:
> My preference is the later one:
>   TYPE_TRANSITION <subject context> <server context> : <class> <new context>;
> 
> In addition, an idea of configuration file can be considerable to set up
> the default context of database objects, though I considered it is not
> necessary in the past discussion.
> If a user want to work the database server process as an unconfined domain,
> like a legacy "disable_xxxx_trans" boolean doing, the <server context> as
> the target of TYPE_TRANSITION breaks all the correct labeling.
> 
> If we have a /etc/selinux/$POLICYTYPE/contexts/db_{sepgsql|rubix}, as follows,
> it can be used to specify the default context of special purpose database
> object such as schemas to store temporary database objects, not only the
> context of database as the root of type transition.
> ------------
> database    *             system_u:object_r:sepgsql_db_t:s0
> schema      pg_temp_*     system_u:object_r:sepgsql_temp_schema_t:s0
>   :             :            :
> ------------
> 
> The libselinux has selabel_lookup(3) interface to implement them
> for various kind of objects.

The attached patch is a proof of the concept.
It adds the forth backend of selabel_lookup(3) interface.

Under the enhancement, we should the following rules to determine what
security context is assigned on the newly created database object.

1. An explicitly specified security context by users.
   e.g)  CREATE TABLE t (a int, b text)
             SECURITY_LABEL = 'system_u:object_r:sepgsql_table_t:SystemHigh';

2. A matched entry in the configuration file which can be lookup up
   by selabel_lookup(3).
   e.g)  schema  pg_temp_*  system_u:object_r:sepgsql_temp_schema_t:s0
                 ^^^^^^^^^ --> if the new object name and type are matched.

3. The result of security_compute_av() or avc_compute_create() which can
   return the result of TYPE_TRANSITION rules.

The second step is newly suggested in this patch.
Needless to say, the determinded security context has to be checked
by the security policy.

> One concern is performance hit. If we need to open/lookup/close the file
> for each INSERT statement, its pain will be unacceptable.

This patch does not support db_tuple class, because of headach in performance
and its characteristic that database tuples have no name to identify itself.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------000501060204030903010905
Content-Type: text/x-patch;
 name="libselinux-database-label-lookup.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-database-label-lookup.1.patch"

 libselinux/include/selinux/label.h   |   10 ++
 libselinux/include/selinux/selinux.h |    1 +
 libselinux/src/file_path_suffixes.h  |    1 +
 libselinux/src/label.c               |    3 +-
 libselinux/src/label_db.c            |  207 ++++++++++++++++++++++++++++++++++
 libselinux/src/label_internal.h      |    2 +
 libselinux/src/selinux_config.c      |   10 ++-
 libselinux/src/selinux_internal.h    |    1 +
 8 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 82f4e13..e167508 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -29,6 +29,8 @@ struct selabel_handle;
 #define SELABEL_CTX_MEDIA	1
 /* x contexts */
 #define SELABEL_CTX_X		2
+/* database contexts */
+#define SELABEL_CTX_DB		3
 
 /*
  * Available options
@@ -116,6 +118,14 @@ void selabel_stats(struct selabel_handle *handle);
 #define SELABEL_X_POLYPROP	6
 #define SELABEL_X_POLYSELN	7
 
+/* Database backend */
+#define SELABEL_DB_DATABASE	1
+#define SELABEL_DB_CATALOG	2
+#define SELABEL_DB_SCHEMA	3
+#define SELABEL_DB_TABLE	4
+#define SELABEL_DB_COLUMN	5
+#define SELABEL_DB_PROCEDURE	6
+#define SELABEL_DB_SEQUENCE	7
 
 #ifdef __cplusplus
 }
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fab083e..8d60b40 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -460,6 +460,7 @@ extern const char *selinux_file_context_local_path(void);
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_x_context_path(void);
+extern const char *selinux_db_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_path(void);
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index 8d207c9..30c613d 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -20,3 +20,4 @@ S_(BINPOLICY, "/policy/policy")
     S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
     S_(X_CONTEXTS, "/contexts/x_contexts")
     S_(COLORS, "/secolor.conf")
+    S_(DB_CONTEXTS, "/contexts/db_contexts")
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index f7418d6..1a7b13c 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -20,7 +20,8 @@ typedef int (*selabel_initfunc)(struct selabel_handle *rec,
 static selabel_initfunc initfuncs[] = {
 	&selabel_file_init,
 	&selabel_media_init,
-	&selabel_x_init
+	&selabel_x_init,
+	&selabel_db_init,
 };
 
 /*
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index e69de29..974770b 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -0,0 +1,207 @@
+/*
+ * Media contexts backend for Database contexts
+ *
+ * Author: KaiGai Kohei <kaigai@ak.jp.nec.com>
+ */
+#include <sys/stat.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fnmatch.h>
+#include "callbacks.h"
+#include "label_internal.h"
+
+struct dbctx_entry {
+	struct dbctx_entry *next;
+
+	int type;
+	struct selabel_lookup_rec lr;
+	char *key;
+
+	int matches;
+};
+
+static void selabel_db_close(struct selabel_handle *rec)
+{
+	struct dbctx_entry *entry = rec->data;
+	struct dbctx_entry *next;
+
+	while (entry != NULL) {
+		next = entry->next;
+		free(entry->key);
+		free(entry->lr.ctx_raw);
+		free(entry->lr.ctx_trans);
+		entry = next;
+	}
+}
+
+static struct selabel_lookup_rec *
+selabel_db_lookup(struct selabel_handle *rec, const char *key, int type)
+{
+	struct dbctx_entry *entry = rec->data;
+
+	while (entry != NULL) {
+		if (entry->type == type &&
+		    !fnmatch(entry->key, key, 0)) {
+			entry->matches++;
+                        return &entry->lr;
+		}
+		entry = entry->next;
+	}
+
+	return NULL;
+}
+
+static int process_line(struct selabel_handle *rec, struct dbctx_entry **tail,
+			char *line_buf, const char *path, unsigned lineno)
+{
+	struct dbctx_entry *entry;
+	char *type, *key, *context;
+	int items;
+
+	/* Skip empty lines */
+	while (isspace(*line_buf))
+		line_buf++;
+	if (*line_buf == '#' || *line_buf == '\0')
+		return 0;
+
+	/* Read <type> <key> <context> pair */
+	entry = malloc(sizeof(struct dbctx_entry));
+	if (!entry)
+		return -1;
+	memset(entry, 0, sizeof(struct dbctx_entry));
+
+	items = sscanf(line_buf, "%as %as %as", &type, &key, &context);
+	if (items < 3) {
+		selinux_log(SELINUX_WARNING,
+			    "%s:  line %d is missing fields, skipping\n",
+			    path, lineno);
+		free(entry);
+		if (items > 0)
+			free(type);
+		if (items > 1)
+			free(key);
+		return 0;
+	}
+
+	if (!strcmp(type, "database"))
+		entry->type = SELABEL_DB_DATABASE;
+	else if (!strcmp(type, "catalog"))
+		entry->type = SELABEL_DB_CATALOG;
+	else if (!strcmp(type, "schema"))
+		entry->type = SELABEL_DB_SCHEMA;
+	else if (!strcmp(type, "table"))
+		entry->type = SELABEL_DB_TABLE;
+	else if (!strcmp(type, "column"))
+		entry->type = SELABEL_DB_COLUMN;
+	else if (!strcmp(type, "procedure"))
+		entry->type = SELABEL_DB_PROCEDURE;
+	else if (!strcmp(type, "sequence"))
+		entry->type = SELABEL_DB_SEQUENCE;
+	else {
+		selinux_log(SELINUX_WARNING,
+			    "%s:  line %d has invalid object type %s\n",
+			    path, lineno, type);
+		free(type);
+		free(key);
+		free(context);
+		return 0;
+	}
+	entry->next = NULL;
+	entry->key = key;
+	entry->lr.ctx_raw = context;
+	free(type);
+
+	if (*tail == NULL)
+		rec->data = entry;
+	else
+		(*tail)->next = entry;
+	*tail = entry;
+
+	return 0;
+}
+
+static int selabel_db_open(struct selabel_handle *rec,
+			   struct selinux_opt *opts, unsigned nopts)
+{
+	FILE *filp;
+	const char *path = NULL;
+	char *line_buf = NULL;
+	size_t line_len = 0;
+	struct dbctx_entry *tail = NULL;
+	struct stat sb;
+	int status = -1;
+	int lineno = 0;
+
+	/* Process arguments */
+	while (nopts--) {
+		switch (opts[nopts].type) {
+		case SELABEL_OPT_PATH:
+			path = opts[nopts].value;
+			break;
+		}
+
+	}
+
+	/* Open the specification file */
+	if (!path)
+		path = selinux_db_context_path();
+	if ((filp = fopen(path, "r")) == NULL)
+		return -1;
+	__fsetlocking(filp, FSETLOCKING_BYCALLER);
+
+	if (fstat(fileno(filp), &sb) < 0)
+		goto out;
+	if (!S_ISREG(sb.st_mode)) {
+		errno = EINVAL;
+		goto out;
+	}
+
+	/* Read specfile */
+	while (getline(&line_buf, &line_len, filp) > 0)
+	{
+		lineno++;
+
+		if (process_line(rec, &tail, line_buf, path, lineno))
+		{
+			/* release all the list */
+			selabel_db_close(rec);
+			free(line_buf);
+			goto out;
+		}
+	}
+	free(line_buf);
+
+	status = 0;
+out:
+	fclose(filp);
+	return status;
+}
+
+static void selabel_db_stats(struct selabel_handle *rec)
+{
+	struct dbctx_entry *entry;
+	int count =0, total = 0;
+
+	entry = rec->data;
+	while (entry != NULL) {
+		count++;
+		total += entry->matches;
+	}
+
+	selinux_log(SELINUX_INFO, "%u entries, %u matches made\n",
+		    count, total);
+}
+
+int selabel_db_init(struct selabel_handle *rec,
+		    struct selinux_opt *opts, unsigned nopts)
+{
+	rec->data = NULL;
+	rec->func_close = &selabel_db_close;
+	rec->func_lookup = &selabel_db_lookup;
+	rec->func_stats = &selabel_db_stats;
+
+	return selabel_db_open(rec, opts, nopts);
+}
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 27a1f06..0f3a3d9 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -23,6 +23,8 @@ int selabel_media_init(struct selabel_handle *rec, struct selinux_opt *opts,
 		      unsigned nopts) hidden;
 int selabel_x_init(struct selabel_handle *rec, struct selinux_opt *opts,
 		   unsigned nopts) hidden;
+int selabel_db_init(struct selabel_handle *rec, struct selinux_opt *opts,
+		    unsigned nopts) hidden;
 
 /*
  * Labeling internal structures
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index dec5426..8870dc8 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -40,7 +40,8 @@
 #define SECURETTY_TYPES   18
 #define X_CONTEXTS        19
 #define COLORS            20
-#define NEL               21
+#define DB_CONTEXTS       21
+#define NEL               22
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -391,3 +392,10 @@ const char *selinux_x_context_path()
 }
 
 hidden_def(selinux_x_context_path)
+
+const char *selinux_db_context_path()
+{
+	return get_path(DB_CONTEXTS);
+}
+
+hidden_def(selinux_db_context_path)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 8b4c6d4..d0e5191 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -66,6 +66,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(selinux_customizable_types_path)
     hidden_proto(selinux_media_context_path)
     hidden_proto(selinux_x_context_path)
+    hidden_proto(selinux_db_context_path)
     hidden_proto(selinux_path)
     hidden_proto(selinux_check_passwd_access)
     hidden_proto(selinux_check_securetty_context)

--------------000501060204030903010905
Content-Type: text/plain;
 name="dblabel.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dblabel.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmlu
Zy5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHNlbGludXgvc2VsaW51eC5oPgoj
aW5jbHVkZSA8c2VsaW51eC9sYWJlbC5oPgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKewogICAgc2VjdXJpdHlfY29udGV4dF90IGNvbnRleHQ7CiAgICBzdHJ1Y3Qgc2Vs
YWJlbF9oYW5kbGUgKmhuZDsKICAgIGNvbnN0IGNoYXIgKnR5cGVuYW1lOwogICAgY29uc3Qg
Y2hhciAqa2V5d29yZDsKICAgIGludCB0eXBlOwoKICAgIGlmICghYXJndlsxXSB8fCAhYXJn
dlsyXSkgewoJZnByaW50ZihzdGRlcnIsICJ1c2FnZTogJXMgPHR5cGU+IDxrZXk+XG4iLCBh
cmd2WzBdKTsKCXJldHVybiAxOwogICAgfQoKICAgIHR5cGVuYW1lID0gYXJndlsxXTsKICAg
IGtleXdvcmQgPSBhcmd2WzJdOwoKICAgIGlmICghc3RyY21wKHR5cGVuYW1lLCAiZGF0YWJh
c2UiKSkKCXR5cGUgPSBTRUxBQkVMX0RCX0RBVEFCQVNFOwogICAgZWxzZSBpZiAoIXN0cmNt
cCh0eXBlbmFtZSwgImNhdGFsb2ciKSkKCXR5cGUgPSBTRUxBQkVMX0RCX0NBVEFMT0c7CiAg
ICBlbHNlIGlmICghc3RyY21wKHR5cGVuYW1lLCAic2NoZW1hIikpCgl0eXBlID0gU0VMQUJF
TF9EQl9TQ0hFTUE7CiAgICBlbHNlIGlmICghc3RyY21wKHR5cGVuYW1lLCAidGFibGUiKSkK
CXR5cGUgPSBTRUxBQkVMX0RCX1RBQkxFOwogICAgZWxzZSBpZiAoIXN0cmNtcCh0eXBlbmFt
ZSwgImNvbHVtbiIpKQoJdHlwZSA9IFNFTEFCRUxfREJfQ09MVU1OOwogICAgZWxzZSBpZiAo
IXN0cmNtcCh0eXBlbmFtZSwgInByb2NlZHVyZSIpKQoJdHlwZSA9IFNFTEFCRUxfREJfUFJP
Q0VEVVJFOwogICAgZWxzZSBpZiAoIXN0cmNtcCh0eXBlbmFtZSwgInNlcXVlbmNlIikpCgl0
eXBlID0gU0VMQUJFTF9EQl9TRVFVRU5DRTsKICAgIGVsc2UgewoJZnByaW50ZihzdGRlcnIs
ICJpbnZhbGlkIG9iamVjdCB0eXBlOiAlc1xuIiwgYXJndlsxXSk7CglyZXR1cm4gMTsKICAg
IH0KCiAgICBobmQgPSBzZWxhYmVsX29wZW4oU0VMQUJFTF9DVFhfREIsIE5VTEwsIDApOwog
ICAgaWYgKCFobmQpIHsKCWZwcmludGYoc3RkZXJyLCAic2VsYWJlbF9vcGVuIGZhaWxlZCA6
ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwoJcmV0dXJuIDE7CiAgICB9CgogICAgaWYgKHNl
bGFiZWxfbG9va3VwKGhuZCwgJmNvbnRleHQsIGtleXdvcmQsIHR5cGUpIDwgMCkKCXByaW50
ZigiTm8gdmFsaWQgY29udGV4dCBmb3IgKCVzLCVzKVxuIiwgdHlwZW5hbWUsIGtleXdvcmQp
OwogICAgZWxzZQoJcHJpbnRmKCJsb29rdXA6ICVzIGZvciAoJXMsJXMpXG4iLCBjb250ZXh0
LCB0eXBlbmFtZSwga2V5d29yZCk7CgogICAgc2VsYWJlbF9jbG9zZShobmQpOwp9Cg==
--------------000501060204030903010905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
