Message-ID: <4B0DBDF2.5050601@ak.jp.nec.com>
Date: Thu, 26 Nov 2009 08:29:54 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp>
In-Reply-To: <4B07F64B.1070407@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------000800020900050506020904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000800020900050506020904
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

KaiGai Kohei wrote:
> Eamon Walsh wrote:
>> On 11/19/2009 03:21 AM, KaiGai Kohei wrote:
>>> This patch allows selabel_*() interfaces to provide an expected security context
>>> for the given database object identified by its name and object class.
>>> It is necessary to implement a feature something like the restorecon on databases.
>> The patch is whitespace damaged, can you re-send it as a text attachment.
>>
> 
> Does the attached one still damaged?
> 
Sorry, my careless misses. It didn't attach the patch body.

The attached one contains the patch with tab-indents.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------000800020900050506020904
Content-Type: text/x-patch;
 name="libselinux-selabel-sepgsql.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-selabel-sepgsql.patch"

This patch allows selabel_*() interfaces to provide an expected security context
for the given database object identified by its name and object class.
It is necessary to implement a feature something like the restorecon on databases.

The specfile shall be described as follows:
  ------------------------
  #
  # The specfile for database objects
  # (for SE-PostgreSQL)
  #
  # <object class> <object name> <security context>
  #
  db_database     *               system_u:object_r:sepgsql_db_t:s0

  db_schema       *.pg_catalog    system_u:obejct_r:sepgsql_sys_schema_t:s0
  db_schema       *.*             system_u:object_r:sepgsql_schema_t:s0

  db_table        *.pg_catalog.*  system_u:object_r:sepgsql_sysobj_t:s0
  db_table        *.*.*           system_u:object_r:sepgsql_table_t:s0
  ------------------------

- All the characters after the '#' are ignored.
- Wildcards ('*' and '?') are available.
- It returns the first match security context.

Note that hierarchy of the namespace of database objects depends on RDBMS.
So, author of the specfile needs to write correct patterns which are suitable
for the target RDBMS. The patched selabel_*() interfaces don't have any
heuristics for the namespace hierarchy to be suitable for widespread RDBMSs.
In the case of SE-PgSQL, when we lookup an expected security context for the
'my_table' table in the 'public' schema and 'postgres' database, the caller
shall provide 'postgres.public.my_table' as a key.

In the default, it tries to read a specfile which maps database objects and security
context from the /etc/selinux/$POLICYTYPE/contexts/sepgsql_contexts.
Note that when another RDBMS uses this interface, it needs to give an explicit
SELABEL_OPT_PATH option on the selabel_open().

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

--
 include/selinux/label.h               |   11 +
 include/selinux/selinux.h             |    1
 man/man3/selabel_open.3               |   10 -
 man/man3/selinux_binary_policy_path.3 |    4
 man/man5/selabel_db.5                 |   93 +++++++++
 src/file_path_suffixes.h              |    1
 src/label.c                           |    3
 src/label_db.c                        |  334 ++++++++++++++++++++++++++++++++++
 src/label_internal.h                  |    2
 src/selinux_config.c                  |    9
 src/selinux_internal.h                |    1
 11 files changed, 464 insertions(+), 5 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 82f4e13..5e93c75 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -29,6 +29,8 @@ struct selabel_handle;
 #define SELABEL_CTX_MEDIA	1
 /* x contexts */
 #define SELABEL_CTX_X		2
+/* db objects */
+#define SELABEL_CTX_DB		3
 
 /*
  * Available options
@@ -116,6 +118,15 @@ void selabel_stats(struct selabel_handle *handle);
 #define SELABEL_X_POLYPROP	6
 #define SELABEL_X_POLYSELN	7
 
+/* DB backend */
+#define SELABEL_DB_DATABASE	1
+#define SELABEL_DB_SCHEMA	2
+#define SELABEL_DB_TABLE	3
+#define SELABEL_DB_COLUMN	4
+#define SELABEL_DB_TUPLE	5
+#define SELABEL_DB_PROCEDURE	6
+#define SELABEL_DB_SEQUENCE	7
+#define SELABEL_DB_BLOB		8
 
 #ifdef __cplusplus
 }
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index cacb3cb..834a1ee 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -487,6 +487,7 @@ extern const char *selinux_media_context_path(void);
 extern const char *selinux_virtual_domain_context_path(void);
 extern const char *selinux_virtual_image_context_path(void);
 extern const char *selinux_x_context_path(void);
+extern const char *selinux_sepgsql_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_path(void);
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index 1af2ec0..8674e37 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -72,15 +72,19 @@ Note that an invalid context may not be treated as an error unless it is actuall
 .TP
 .B SELABEL_CTX_FILE
 File contexts backend, described in 
-.BR selabel_file (3).
+.BR selabel_file (5).
 .TP
 .B SELABEL_CTX_MEDIA
 Media contexts backend, described in 
-.BR selabel_media (3).
+.BR selabel_media (5).
 .TP
 .B SELABEL_CTX_X
 X Windows contexts backend, described in 
-.BR selabel_x (3).
+.BR selabel_x (5).
+.TP
+.B SELABEL_CTX_DB
+Database objects contexts backend, described in
+.BR selabel_db (5).
 
 .SH "RETURN VALUE"
 A non-NULL handle value is returned on success.  On error, NULL is returned and
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 2a4a653..850a89e 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -29,6 +29,8 @@ extern const char *selinux_usersconf_path(void);
 
 extern const char *selinux_x_context_path(void);
 
+extern const char *selinux_sepgsql_context_path(void);
+
 extern const char *selinux_file_context_path(void);
 
 extern const char *selinux_media_context_path(void);
@@ -66,6 +68,8 @@ selinux_usersconf_path() - file containing mapping between Linux Users and SELin
 .sp
 selinux_x_context_path() - file containing configuration for XSELinux extension
 .sp
+selinux_sepgsql_context_path() - file containing configuration for SE-PostgreSQL
+.sp
 selinux_netfilter_context_path - default netfilter context 
 .sp
 selinux_file_context_path() - default sysstem file contexts configuration
diff --git a/libselinux/man/man5/selabel_db.5 b/libselinux/man/man5/selabel_db.5
new file mode 100644
index 0000000..b699f39
--- /dev/null
+++ b/libselinux/man/man5/selabel_db.5
@@ -0,0 +1,93 @@
+.\" Hey Emacs! This file is -*- nroff -*- source.
+.\"
+.\" Author: KaiGai Kohei <kaigai@ak.jp.nec.com> 2009
+.TH "selabel_db" "5" "22 Nov 2009" "" "SELinux API documentation"
+.SH "NAME"
+selabel_db \- userspace SELinux labeling interface: DB objects contexts backend.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+
+.B #include <selinux/label.h>
+.sp
+.BI "int selabel_lookup(struct selabel_handle *" hnd ,
+.in +\w'int selabel_lookup('u
+.BI "security_context_t *" context ,
+
+.BI "const char *" object_name ", int " object_type ");"
+
+.SH "DESCRIPTION"
+The DB contexts backend maps from a pair of object name and class into security contexts. It is used to find the appropriate context for database objects when relabeling a certain database.
+
+The
+.I object_name
+should be fully qualified name using the hierarchy of database objects.
+For example, the
+.B pg_class
+table in the
+.B postgres
+database and
+.B pg_catalog
+schema should be qualified as
+.B postgres.pg_catalog.pg_class .
+
+The
+.I object_type
+argument should be set to one of the following values:
+.TP
+.B SELABEL_DB_DATABASE
+The
+.I object_name
+argument specifies the name of a database itself, such as "postgres".
+.TP
+.B SELABEL_DB_SCHEMA
+The
+.I object_name
+argument specifies the name of a schema object, such as "postgres.public".
+.TP
+.B SELABEL_DB_TABLE
+The
+.I object_name
+argument specifies the name of a table object, such as "postgres.public.my_table"
+.TP
+.B SELABEL_DB_COLUMN
+The
+.I object_name
+argument specifies the name of a column object, such as "postgres.public.my_table.user_id"
+.TP
+.B SELABEL_DB_TUPLE
+The
+.I object_name
+argument specifies the name of a table object which contains the tuples to be relabeled, such as "postgresql.public.my_table". Note that we have no way to identify individual tuple objects, except for WHERE clause on DML statements, because it has no name.
+.TP
+.B SELABEL_DB_PROCEDURE
+The
+.I object_name
+argument specifies the name of a procedure object, such as "postgres.public.my_func". Note that we don't support to lookup individual security contexts for each procedures which have same name but different arguments.
+.TP
+.B SELABEL_DB_SEQUENCE
+The
+.I object_name
+argument specifies the name of a sequence object, such as "postgres.public.my_seq".
+.TP
+.B SELABEL_DB_BLOB
+The
+.I object_name
+argument specifies the name of a large object, such as "postgres.16308".
+Note that a large object does not have its name, so it is identified by its identifier value.
+
+.SH "OPTIONS"
+In addition to the global options described in 
+.BR selabel_open (3),
+this backend recognizes the following options:
+
+.TP
+.B SELABEL_OPT_PATH
+A non-null value for this option specifies a path to a file that will be opened in lieu of the standard DB contexts file.
+It tries to open the specfile designed for SE-PostgreSQL in the default, so if another RDBMS uses this interface, it needs to give an explicit specfile designed for the RDBMS.
+
+.SH "SEE ALSO"
+.BR selabel_open (3),
+.BR selabel_lookup (3),
+.BR selabel_stats (3),
+.BR selinux (8)
+
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index eada232..ccf43e1 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -23,3 +23,4 @@ S_(BINPOLICY, "/policy/policy")
     S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
     S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
     S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
+    S_(SEPGSQL_CONTEXTS, "/contexts/sepgsql_contexts")
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index cea3c43..020b803 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -22,7 +22,8 @@ typedef int (*selabel_initfunc)(struct selabel_handle *rec,
 static selabel_initfunc initfuncs[] = {
 	&selabel_file_init,
 	&selabel_media_init,
-	&selabel_x_init
+	&selabel_x_init,
+	&selabel_db_init,
 };
 
 typedef struct selabel_sub {
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
new file mode 100644
index 0000000..fa41b59
--- /dev/null
+++ b/libselinux/src/label_db.c
@@ -0,0 +1,334 @@
+/*
+ * Media contexts backend for DB objects
+ *
+ * Author: KaiGai Kohei <kaigai@ak.jp.nec.com>
+ */
+
+#include <sys/stat.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <fnmatch.h>
+#include "callbacks.h"
+#include "label_internal.h"
+
+/*
+ * Regular database object's security context interface
+ * 
+ * It provides applications a regular security context for the given
+ * database objects. The pair of object's name and a security context
+ * are described in the specfile. In the default, it shall be stored
+ * in the /etc/selinux/$POLICYTYPE/contexts/sepgsql_contexts .
+ * (It assumes SE-PostgreSQL in the default. For other RDBMS, use the
+ * SELABEL_OPT_PATH option to specify different specfile.)
+ *
+ * Each line has the following format:
+ *   <object class> <object name/identifier> <security context>
+ *
+ * For example:
+ * ----------------------------------------
+ * #
+ * # It is an example specfile for database obejcts
+ * #
+ * db_database  template1           system_u:object_r:sepgsql_db_t:s0
+ *
+ * db_schema    *.pg_catalog        system_u:object_r:sepgsql_sys_schema_t:s0
+ *
+ * db_table     *.pg_catalog.*	    system_u:object_r:sepgsql_sysobj_t:s0
+ * db_column    *.pg_catalog.*.*    system_u:object_r:sepgsql_sysobj_t:s0
+ * ----------------------------------------
+ *
+ * All the characters after the '#' are dealt as comments.
+ *
+ * The first token is object class. SELABEL_DB_* declared in label.h are
+ * corresponding to a certain database object.
+ *
+ * The object name/identifier is compared to the given key.
+ * A database object can have its own namespace hierarchy.
+ * In the case of SE-PgSQL, database is the top level object, and schema
+ * is deployed just under a database. A schema can contains various kind
+ * of objects, such as tables, procedures and so on.
+ * Thus, when we lookup an expected security context for a table of
+ * "pg_class", it is necessary to assume selabel_lookup() is called with 
+ * "postgres.pg_catalog.pg_class", not just a "pg_class".
+ *
+ * Wildcards ('*' or '?') are available on the patterns, so if you want
+ * to match a table within any schema, you should set '*' on the upper
+ * namespaces of the table.
+ *
+ * The structure of namespace depends on RDBMS.
+ * For example, Trusted-RUBIX has an idea of "catalog" which performs
+ * as a namespace between a database and individual schemas. In this
+ * case, a table has upper three layers.
+ */
+
+/*
+ * spec_t : It holds a pair of a key and an expected security context
+ */
+typedef struct spec {
+	struct selabel_lookup_rec lr;
+	char	       *key;
+	int		type;
+	int		matches;
+} spec_t;
+
+/*
+ * catalog_t : An array of spec_t
+ */
+typedef struct catalog {
+	unsigned int	nspec;	/* number of specs in use */
+	unsigned int	limit;	/* physical limitation of specs[] */
+	spec_t		specs[0];
+} catalog_t;
+
+/*
+ * Helper function to parse a line read from the specfile
+ */
+static int
+process_line(const char *path, char *line_buf, unsigned int line_num,
+	     catalog_t *catalog)
+{
+	spec_t	       *spec = &catalog->specs[catalog->nspec];
+	char	       *type, *key, *context, *temp;
+	int		items;
+
+	/* Cut off comments */
+	temp = strchr(line_buf, '#');
+	if (temp)
+		*temp = '\0';
+
+	/*
+	 * Every entry must have the following format
+	 *   <object class> <object name> <security context>
+	 */
+	type = key = context = temp = NULL;
+	items = sscanf(line_buf, "%as %as %as %as",
+		       &type, &key, &context, &temp);
+	if (items != 3) {
+		if (items > 0)
+			selinux_log(SELINUX_WARNING,
+				    "%s:  line %d has invalid format, skipped",
+				    path, line_num);
+		goto skip;
+	}
+
+	/*
+	 * Set up individual spec entry
+	 */
+	memset(spec, 0, sizeof(spec_t));
+
+	if (!strcmp(type, "db_database"))
+		spec->type = SELABEL_DB_DATABASE;
+	else if (!strcmp(type, "db_schema"))
+		spec->type = SELABEL_DB_SCHEMA;
+	else if (!strcmp(type, "db_table"))
+		spec->type = SELABEL_DB_TABLE;
+	else if (!strcmp(type, "db_column"))
+		spec->type = SELABEL_DB_COLUMN;
+	else if (!strcmp(type, "db_tuple"))
+		spec->type = SELABEL_DB_TUPLE;
+	else if (!strcmp(type, "db_procedure"))
+		spec->type = SELABEL_DB_PROCEDURE;
+	else if (!strcmp(type, "db_sequence"))
+		spec->type = SELABEL_DB_SEQUENCE;
+	else if (!strcmp(type, "db_blob"))
+		spec->type = SELABEL_DB_BLOB;
+	else {
+		selinux_log(SELINUX_WARNING,
+			    "%s:  line %d has invalid object type %s\n",
+			    path, line_num, type);
+		goto skip;
+	}
+
+	free(type);
+	spec->key = key;
+	spec->lr.ctx_raw = context;
+
+	catalog->nspec++;
+
+	return 0;
+
+skip:
+	free(type);
+	free(key);
+	free(context);
+	free(temp);
+
+	return 0;
+}
+
+/*
+ * selabel_close() handler
+ */
+static void
+db_close(struct selabel_handle *rec)
+{
+	catalog_t      *catalog = (catalog_t *)rec->data;
+	spec_t	       *spec;
+	unsigned int	i;
+
+	for (i = 0; i < catalog->nspec; i++) {
+		spec = &catalog->specs[i];
+		free(spec->key);
+		free(spec->lr.ctx_raw);
+		free(spec->lr.ctx_trans);
+	}
+	free(catalog);
+}
+
+/*
+ * selabel_lookup() handler
+ */
+static struct selabel_lookup_rec *
+db_lookup(struct selabel_handle *rec, const char *key, int type)
+{
+	catalog_t      *catalog = (catalog_t *)rec->data;
+	spec_t	       *spec;
+	unsigned int	i;
+
+	for (i = 0; i < catalog->nspec; i++) {
+		spec = &catalog->specs[i];
+
+		if (spec->type != type)
+			continue;
+		if (!fnmatch(spec->key, key, 0)) {
+			spec->matches++;
+
+			return &spec->lr;
+		}
+	}
+
+	/* No found */
+	errno = ENOENT;
+	return NULL;
+}
+
+/*
+ * selabel_stats() handler
+ */
+static void
+db_stats(struct selabel_handle *rec)
+{
+	catalog_t      *catalog = (catalog_t *)rec->data;
+	unsigned int	i, total = 0;
+
+	for (i = 0; i < catalog->nspec; i++)
+		total += catalog->specs[i].matches;
+
+	selinux_log(SELINUX_INFO, "%u entries, %u matches made\n",
+		    catalog->nspec, total);
+}
+
+/*
+ * selabel_open() handler
+ */
+static catalog_t *
+db_init(struct selinux_opt *opts, unsigned nopts)
+{
+	catalog_t      *catalog;
+	FILE	       *filp;
+	const char     *path = NULL;
+	char	       *line_buf = NULL;
+	size_t		line_len = 0;
+	unsigned int	line_num = 0;
+	unsigned int	i;
+
+	/*
+	 * Initialize catalog data structure
+	 */
+	catalog = malloc(sizeof(catalog_t) + 32 * sizeof(spec_t));
+	if (!catalog)
+		return NULL;
+	catalog->limit = 32;
+	catalog->nspec = 0;
+
+	/*
+	 * Process arguments
+	 *
+	 * SELABEL_OPT_PATH:
+	 *   It allows to specify an alternative specification file instead of
+	 *   the default one. If RDBMS is not SE-PostgreSQL, it may need to
+	 *   specify an explicit specfile for database objects.
+	 */
+	while (nopts--) {
+		switch (opts[nopts].type) {
+		case SELABEL_OPT_PATH:
+			path = opts[nopts].value;
+			break;
+		}
+	}
+
+	/*
+	 * Open the specification file
+	 */
+	if (!path)
+		path = selinux_sepgsql_context_path();
+
+	if ((filp = fopen(path, "rb")) == NULL) {
+		free(catalog);
+		return NULL;
+	}
+
+	/*
+	 * Parse for each lines
+	 */
+	while (getline(&line_buf, &line_len, filp) > 0) {
+		/*
+		 * Expand catalog array, if necessary
+		 */
+		if (catalog->limit == catalog->nspec) {
+			size_t		length;
+			unsigned int	new_limit = 2 * catalog->limit;
+			catalog_t      *new_catalog;
+
+			length = sizeof(catalog_t)
+				+ new_limit * sizeof(spec_t);
+			new_catalog = realloc(catalog, length);
+			if (!new_catalog)
+				goto out_error;
+
+			catalog = new_catalog;
+			catalog->limit = new_limit;
+		}
+
+		/*
+		 * Parse a line
+		 */
+		if (process_line(path, line_buf, ++line_num, catalog) < 0)
+			goto out_error;
+	}
+	free(line_buf);
+
+	fclose(filp);
+
+	return catalog;
+
+out_error:
+	for (i = 0; i < catalog->nspec; i++) {
+		spec_t	       *spec = &catalog->specs[i];
+
+		free(spec->key);
+		free(spec->lr.ctx_raw);
+		free(spec->lr.ctx_trans);
+	}
+	free(catalog);
+
+	return NULL;
+}
+
+/*
+ * Initialize selabel_handle and load the entries of specfile
+ */
+int selabel_db_init(struct selabel_handle *rec,
+		    struct selinux_opt *opts, unsigned nopts)
+{
+	rec->func_close = &db_close;
+	rec->func_lookup = &db_lookup;
+	rec->func_stats = &db_stats;
+	rec->data = db_init(opts, nopts);
+
+	return !rec->data ? -1 : 0;
+}
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 27a1f06..99af93e 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -23,6 +23,8 @@ int selabel_media_init(struct selabel_handle *rec, struct selinux_opt *opts,
 		      unsigned nopts) hidden;
 int selabel_x_init(struct selabel_handle *rec, struct selinux_opt *opts,
 		   unsigned nopts) hidden;
+int selabel_db_init(struct selabel_handle *rec,
+		    struct selinux_opt *opts, unsigned nopts) hidden;
 
 /*
  * Labeling internal structures
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 7e588cc..e040959 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -44,7 +44,8 @@
 #define VIRTUAL_DOMAIN    21
 #define VIRTUAL_IMAGE     22
 #define FILE_CONTEXT_SUBS 23
-#define NEL               24
+#define SEPGSQL_CONTEXTS  24
+#define NEL               25
 
 /* Part of one-time lazy init */
 static pthread_once_t once = PTHREAD_ONCE_INIT;
@@ -422,3 +423,9 @@ const char * selinux_file_context_subs_path(void) {
 
 hidden_def(selinux_file_context_subs_path)
 
+const char *selinux_sepgsql_context_path()
+{
+	return get_path(SEPGSQL_CONTEXTS);
+}
+
+hidden_def(selinux_sepgsql_context_path)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 88b6bd6..24ef21a 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -73,6 +73,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(selinux_customizable_types_path)
     hidden_proto(selinux_media_context_path)
     hidden_proto(selinux_x_context_path)
+    hidden_proto(selinux_sepgsql_context_path)
     hidden_proto(selinux_path)
     hidden_proto(selinux_check_passwd_access)
     hidden_proto(selinux_check_securetty_context)

--------------000800020900050506020904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
