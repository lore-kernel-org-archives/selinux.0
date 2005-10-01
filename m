Message-ID: <433DEB43.1020605@cornell.edu>
Date: Fri, 30 Sep 2005 21:49:55 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEMANAGE ] Break up interfaces.h, implement parsing helpers
References: <433DA069.3090208@cornell.edu> <1128112109.12459.216.camel@moss-spartans.epoch.ncsc.mil> <433DA664.6040600@cornell.edu> <433DD618.1070508@cornell.edu>
In-Reply-To: <433DD618.1070508@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------080201080903020808080308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080201080903020808080308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's one more.

Patch redistributes interfaces.h back into database.h, database_file.h, 
database_direct.h.
I promise I'll stop moving functionality around now - I'm very happy 
with where it's at (for now :)

Moves parse stuff into parse_utils.[c,h]. Implement parsing helpers that 
will be used for  the user parser (and others). Testing?
It used to work (and pass valgrind) back when I was implementing it for 
libselinux and libsepol. Haven't tested it since then, but nothing's 
changed. Since nothing's using this code, I thought it'd be okay to 
merge - even if it has bugs (which it shouldn't). I'll do more testing 
when I get the rest of the framework set up, so I can read the files.






--------------080201080903020808080308
Content-Type: text/x-patch;
 name="libsemanage.redistribute.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.redistribute.diff"

diff -Naur libsemanage/src/database.c libsemanage.new/src/database.c
--- libsemanage/src/database.c	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/database.c	2005-09-30 20:47:59.000000000 -0400
@@ -2,7 +2,6 @@
 #include <stddef.h>
 #include "debug.h"
 #include "database.h"
-#include "interfaces.h"
 #include "handle.h"
 
 /* Initialize a database */
diff -Naur libsemanage/src/database_direct.c libsemanage.new/src/database_direct.c
--- libsemanage/src/database_direct.c	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/database_direct.c	2005-09-30 20:47:44.000000000 -0400
@@ -1,11 +1,10 @@
 struct dbase_direct_backend;
 typedef struct dbase_direct_backend dbase_backend_t;
-#define BACKEND_DEFINED
+#define DBASE_BACKEND_DEFINED
 
 #include <stdlib.h>
 #include <sepol/policydb.h>
 #include "database_direct.h"
-#include "interfaces.h"
 #include "debug.h"
 
 /* POLICY DIRECT backend */
diff -Naur libsemanage/src/database_direct.h libsemanage.new/src/database_direct.h
--- libsemanage/src/database_direct.h	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/database_direct.h	2005-09-30 21:29:42.000000000 -0400
@@ -1,12 +1,26 @@
 #ifndef _SEMANAGE_DATABASE_DIRECT_INTERNAL_H_
 #define _SEMANAGE_DATABASE_DIRECT_INTERNAL_H_
 
+#include <sepol/policydb.h>
 #include "database.h"
-#include "interfaces.h"
 
 struct dbase_direct_backend;
 typedef struct dbase_direct_backend dbase_direct_backend_t;
 
+/* POLICY DIRECT extension to RECORD interface - method table */
+typedef struct record_direct_table {
+
+	/* Load record into the policy database  */
+	int (*load) (policydb_t* policy, record_t* record);
+
+	/* Iterate over records */
+	int (*iterate) (
+		policydb_t* policydb,
+		int (*fn)(record_t* record, void* fn_arg),
+	void* arg);
+
+} record_direct_table_t;
+
 /* POLICY DIRECT backend - initialization */
 extern int dbase_direct_init(
 	const char* filename,
diff -Naur libsemanage/src/database_file.c libsemanage.new/src/database_file.c
--- libsemanage/src/database_file.c	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/database_file.c	2005-09-30 20:50:48.000000000 -0400
@@ -1,13 +1,10 @@
 struct dbase_file_backend;
 typedef struct dbase_file_backend dbase_backend_t;
-#define BACKEND_DEFINED
+#define DBASE_BACKEND_DEFINED
 
-#include <stdio.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <stdio_ext.h>
 #include "debug.h"
-#include "interfaces.h"
+#include "parse_utils.h"
 #include "database_file.h"
 
 /* FILE backend */ 
@@ -20,25 +17,6 @@
 	record_file_table_t* rftable;
 };
 
-static int dbase_file_open(parse_info_t* info) {
-
-	info->file_stream = fopen(info->filename, "r");
-	if (!info->file_stream && (errno != ENOENT)) {
-		/* FIXME: handle error condition */
-		return STATUS_ERR;
-	}
-	if (info->file_stream)
-		__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
-
-	return STATUS_SUCCESS;
-}
-
-static void dbase_file_close(parse_info_t* info) {
-	if (info->file_stream && (fclose(info->file_stream) < 0))
-		/* FIXME: handle error condition */
-	info->file_stream = NULL;
-}
-
 static int dbase_file_cache(
 	dbase_t* dbase,
 	dbase_file_backend_t* backend) {
@@ -57,7 +35,7 @@
 	parse_info.parse_arg = NULL;
 	/* FIXME: pass from caller? */
 
-	if (dbase_file_open(&parse_info) < 0)
+	if (parse_open(&parse_info) < 0)
                 goto err;
 
 	/* Main processing loop */
@@ -83,7 +61,7 @@
 
 	} while (pstatus != STATUS_NODATA);
 
-	dbase_file_close(&parse_info);
+	parse_close(&parse_info);
 	dbase->cached = 1;
 	dbase->cache_invalid = 0;
 	return STATUS_SUCCESS;
@@ -91,7 +69,7 @@
 	err:
 	/* FIXME: handle failure */
 	dbase->rtable->free(process_record);
-	dbase_file_close(&parse_info);
+	parse_close(&parse_info);
 	return STATUS_ERR;
 }
 
diff -Naur libsemanage/src/database_file.h libsemanage.new/src/database_file.h
--- libsemanage/src/database_file.h	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/database_file.h	2005-09-30 20:51:37.000000000 -0400
@@ -1,12 +1,26 @@
 #ifndef _SEMANAGE_DATABASE_FILE_INTERNAL_H_
 #define _SEMANAGE_DATABASE_FILE_INTERNAL_H_
 
+#include <stdio.h>
 #include "database.h"
-#include "interfaces.h"
+#include "parse_utils.h"
 
 struct dbase_file_backend;
 typedef struct dbase_file_backend dbase_file_backend_t;
 
+/* FILE extension to RECORD interface - method table */
+typedef struct record_file_table {
+
+	/* Fill record structuure based on supplied parse info.
+	 * Parser must return STATUS_NODATA when EOF is encountered.
+	 * Parser must handle NULL file stream correctly */
+	int (*parse) (parse_info_t* info, record_t* record);
+
+	/* Print record to stream */
+	int (*print) (record_t* record, FILE* str);
+
+} record_file_table_t;
+
 /* FILE backend - initialization */
 extern int dbase_file_init(
 	const char* filename,
diff -Naur libsemanage/src/database.h libsemanage.new/src/database.h
--- libsemanage/src/database.h	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/database.h	2005-09-30 21:29:30.000000000 -0400
@@ -1,20 +1,25 @@
 #ifndef _SEMANAGE_DATABASE_H_
 #define _SEMANAGE_DATABASE_H_
 
-#ifndef RECORD_DEFINED
+#ifndef DBASE_RECORD_DEFINED
 typedef void* record_t;
 typedef void* record_key_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 #endif
 
-#ifndef BACKEND_DEFINED
+#ifndef DBASE_BACKEND_DEFINED
 typedef void* dbase_backend_t;
-#define BACKEND_DEFINED
+#define DBASE_BACKEND_DEFINED
 #endif
 
 #include <stddef.h>
 #include "handle.h"
-#include "interfaces.h"
+
+struct record_table;
+typedef struct record_table record_table_t;
+
+struct dbase_backend_table;
+typedef struct dbase_backend_table dbase_backend_table_t;
 
 /* ==========================================
    Internal representation of the database.
@@ -56,6 +61,48 @@
    API for use elsewhere:
   ======================================= */
 
+/* RECORD interface - method table */
+struct record_table {
+
+	/* Create a record */
+	int (*create) (record_t** rec);
+
+	/* Extract key from record */
+	int (*key_extract) (record_t* rec, record_key_t** key);
+
+	/* Free record key */
+	void (*key_free) (record_key_t* key);
+
+	/* Return 0 if record can be matched against key,
+	 * and 1 otherwise */
+	int (*compare) (record_t* rec, record_key_t* key);
+
+	/* Deep-copy clone of this record */
+	int (*clone) (record_t* rec, record_t** new_rec);
+
+	/* Deallocate record resources. Must
+	 * sucessfully handle NULL. */
+	void (*free) (record_t* rec);
+
+};
+
+/* DBASE_BACKEND interface - method table */
+struct dbase_backend_table {
+
+	/* Cache backend into dbase */
+	int (*cache) (dbase_t* dbase, dbase_backend_t* backend);
+
+	/* Flush dbase to backend */
+	int (*flush) (dbase_t* dbase, dbase_backend_t* backend);
+
+	/* Iterate over backend */
+	int (*iterate) (
+		dbase_backend_t* backend,
+		int (*fn)(record_t* record, void* fn_arg),
+		void* arg);
+
+};
+
 /* Initialize a database */
 extern int dbase_init(
 	record_table_t* rtable,
diff -Naur libsemanage/src/interfaces.h libsemanage.new/src/interfaces.h
--- libsemanage/src/interfaces.h	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/interfaces.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,105 +0,0 @@
-#ifndef _SEMANAGE_RECORD_FILE_H_
-#define _SEMANAGE_RECORD_FILE_H_
-
-/* The interfaces below are used for polymorphism */
-
-#ifndef RECORD_DEFINED
-typedef void* record_t;
-typedef void* record_key_t;
-#define RECORD_DEFINED
-#endif
-
-#ifndef BACKEND_DEFINED
-typedef void* dbase_backend_t;
-#define BACKEND_DEFINED
-#endif
-
-#include <stdio.h>
-#include <sepol/policydb.h>
-
-/* Circular dependency - can't include database.h */
-struct dbase;
-
-/* Structure available during parsing (created internally) */
-typedef struct parse_info {
-	/* Parser controlled */
-	/* Stub */
-
-	/* Engine-controlled */
-	const char* filename;   /* Input stream file name */
-	FILE* file_stream;      /* Input stream handle */
-
-	/* Caller supplied */
-	void* parse_arg;
-} parse_info_t;
-
-/* RECORD interface - method table */
-typedef struct record_table {
-
-	/* Create a record */
-	int (*create) (record_t** rec);
-
-	/* Extract key from record */
-	int (*key_extract) (record_t* rec, record_key_t** key);
-	
-	/* Free record key */
-	void (*key_free) (record_key_t* key);
-
-	/* Return 0 if record can be matched against key,
-	 * and 1 otherwise */
-	int (*compare) (record_t* rec, record_key_t* key);
-
-	/* Deep-copy clone of this record */
-	int (*clone) (record_t* rec, record_t** new_rec);
-
-	/* Deallocate record resources. Must
-	 * sucessfully handle NULL. */
-	void (*free) (record_t* rec);
-
-} record_table_t;
-
-/* FILE extension to RECORD interface - method table */
-typedef struct record_file_table {
-
-	/* Fill record structuure based on supplied parse info.
-	 * Parser must return STATUS_NODATA when EOF is encountered.
-	 * Parser must handle NULL file stream correctly */
-	int (*parse) (parse_info_t* info, record_t* record);
-
-	/* Print record to stream */
-	int (*print) (record_t* record, FILE* str);
-
-} record_file_table_t;
-
-/* POLICY DIRECT extension to RECORD interface - method table */
-typedef struct record_direct_table {
-
-	/* Load record into the policy database  */
-	int (*load) (policydb_t* policy, record_t* record); 
-
-	/* Iterate over records */
-	int (*iterate) (
-		policydb_t* policydb,
-		int (*fn)(record_t* record, void* fn_arg),
-		void* arg);
-
-} record_direct_table_t;
-
-/* DBASE_BACKEND interface - method table */
-typedef struct dbase_backend_table {
-
-	/* Cache backend into dbase */
-	int (*cache) (struct dbase* dbase, dbase_backend_t* backend);	
-
-	/* Flush dbase to backend */
-	int (*flush) (struct dbase* dbase, dbase_backend_t* backend);
-
-	/* Iterate over backend */
-	int (*iterate) (
-		dbase_backend_t* backend,
-		int (*fn)(record_t* record, void* fn_arg),
-		void* arg);
-
-} dbase_backend_table_t;
-
-#endif 
diff -Naur libsemanage/src/parse_utils.c libsemanage.new/src/parse_utils.c
--- libsemanage/src/parse_utils.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/parse_utils.c	2005-09-30 21:37:35.000000000 -0400
@@ -0,0 +1,268 @@
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include "parse_utils.h"
+#include "debug.h"
+
+int parse_init(
+	const char* filename,
+	void* parse_arg,
+	parse_info_t** info) {
+	
+	parse_info_t* tmp_info = 
+		(parse_info_t*) malloc(sizeof(parse_info_t));
+		
+	if (!tmp_info) {
+		/* FIXME: handle error condition */
+		return STATUS_ERR;
+	}
+
+	tmp_info->filename = filename;
+	tmp_info->file_stream = NULL;
+	tmp_info->working_copy = NULL;
+	tmp_info->orig_line = NULL;
+	tmp_info->ptr = NULL;
+	tmp_info->lineno = 0;
+	tmp_info->parse_arg = parse_arg;
+
+	*info = tmp_info;
+	return STATUS_SUCCESS;
+}
+
+void parse_release(parse_info_t* info) {
+	parse_close(info);
+	parse_dispose_line(info);
+	free(info);
+}
+
+int parse_open(parse_info_t* info) {
+	
+	info->file_stream = fopen(info->filename, "r");
+	if (!info->file_stream && (errno != ENOENT)) {
+		/* FIXME: handle error condition */
+		return STATUS_ERR;
+	}
+	if (info->file_stream)
+		__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
+
+	return STATUS_SUCCESS;
+}
+
+void parse_close(parse_info_t* info) {
+	if (info->file_stream && (fclose(info->file_stream) < 0)) {
+		/* FIXME: handle error condition */
+	}
+	info->file_stream = NULL;
+}
+
+void parse_dispose_line(parse_info_t* info) {
+	if (info->orig_line) {
+		free(info->orig_line);
+		info->orig_line = NULL;
+	}
+
+	if (info->working_copy) {
+		free(info->working_copy);
+		info->working_copy = NULL;
+	}
+
+        info->ptr = NULL;
+}
+
+int parse_skip_space(parse_info_t* info) {
+	size_t len = 0;
+	int lineno = info->lineno;
+	char* buffer = NULL;
+	char* ptr;
+
+	if (info->ptr) {
+		while (*(info->ptr) && isspace(*(info->ptr)))
+			info->ptr++;
+
+		if (*(info->ptr))
+			return STATUS_SUCCESS;
+	}
+
+	parse_dispose_line(info);
+
+	while (info->file_stream &&
+		(getline(&buffer, &len, info->file_stream) > 0)) {
+
+		lineno++;
+
+		/* Eat newline, preceding whitespace */
+		len = strlen(buffer);
+		if (buffer[len - 1] == '\n')
+			buffer[len - 1] = '\0';
+
+		ptr = buffer;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+
+		/* Skip comments and blank lines */
+		if (!(*ptr) || *ptr == '#')
+			goto next;
+
+		else {
+			char* tmp = strdup(buffer);
+			if (!tmp)
+				goto omem;
+
+			info -> lineno = lineno;
+			info -> working_copy = buffer;
+			info -> orig_line = tmp;
+			info -> ptr = ptr;
+
+			return STATUS_SUCCESS;
+		}
+
+		next:
+		free(buffer);
+		buffer = NULL;
+	}
+
+	free(buffer);
+	buffer = NULL;
+
+	return STATUS_SUCCESS;
+
+	omem:
+	/* DEBUG(__FUNCTION__, "out of memory\n"); */
+	free(buffer);
+	return STATUS_ERR;
+}
+
+int parse_assert_noeof(parse_info_t* info) {
+	if (!info->ptr) {
+		/* DEBUG(__FUNCTION__, "unexpected end of file\n"); */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int parse_assert_space(parse_info_t* info) {
+	if (!isspace(*(info->ptr))) {
+		/* DEBUG(__FUNCTION__, "malformed line %u in %s: \n%s\n",
+			info->lineno, info->filename, info->orig_line); */
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+
+int parse_assert_ch(parse_info_t* info, const char ch) {
+	if (parse_assert_noeof(info) < 0)
+		return STATUS_ERR;
+
+	if (*(info->ptr) != ch) {
+		/* DEBUG(__FUNCTION__, "malformed line %u, char %u,"
+			" in %s: \n%s\n expected character \'%c\', but "
+			"found \'%c\'\n",
+			info->lineno, (info->ptr - info->working_copy),
+			info->filename, info->orig_line, ch, *(info->ptr)); */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int parse_assert_str(parse_info_t* info, const char* assert_str) {
+
+	if (parse_assert_noeof(info) < 0)
+		return STATUS_ERR;
+
+	if (strncmp(info->ptr, assert_str, strlen(assert_str))) {
+		/* DEBUG(__FUNCTION__, "malformed line %u in %s: \n%s\n"
+		"expected string \"%s\", but found \"%s\"\n",
+		info->lineno, info->filename, info->orig_line, assert_str,
+		info->ptr); */
+
+		return STATUS_ERR;
+	}
+
+	info->ptr += strlen(assert_str);
+	return STATUS_SUCCESS;
+}
+
+int parse_optional_ch(parse_info_t* info, const char ch) {
+	if ((info->ptr) && (*(info->ptr) != ch))
+		return STATUS_NODATA;
+	else {
+		info->ptr++;
+		return STATUS_SUCCESS;
+	}
+}
+
+int parse_optional_str(parse_info_t* info, const char* str) {
+	if (strncmp(info->ptr, str, strlen(str)))
+		return STATUS_NODATA;
+	else {
+		info->ptr += strlen(str);
+		return STATUS_SUCCESS;
+	}
+}
+
+char* parse_filter_space_until(parse_info_t* info, const char* substr) {
+
+	char* buffer = NULL, *wr, *tmp;
+	int len = strlen(substr);
+	int used = 0;
+	int csize = 0;
+
+	wr = buffer;
+	do {
+		/* If content is not a space, copy to buffer */
+		if (!isspace(info->ptr)) {
+
+			/* If we're out of space, increase by 15 */
+			if (used + 1 >= csize) {
+				csize += 15;
+				tmp = realloc(buffer, csize);
+				if (!tmp)
+					goto omem;
+				buffer = tmp;
+			}
+			*wr++ = *info->ptr;
+			used++;
+		}
+		info->ptr++;
+
+		if (parse_skip_space(info) < 0)
+			goto err;
+		if (parse_assert_noeof(info) < 0)
+			goto err;
+
+	} while(!strncasecmp(info->ptr, substr, len));
+
+	if (!buffer) {
+		buffer = malloc(1);
+		if (!buffer)
+			goto omem;
+	}
+
+	*wr = '\0';
+
+	return buffer;
+
+	omem:
+	/* DEBUG(__FUNCTION__, "out of memory\n"); */
+
+	err:
+	free(buffer);
+	return NULL;
+}
+
+
+char* parse_fetch_string_inplace(parse_info_t* info) {
+	char* start = info->ptr;
+
+	while (*(info->ptr) && !isspace(*(info->ptr)))
+		info->ptr++;
+	*(info->ptr)++ = '\0';
+
+	return start;
+} 
diff -Naur libsemanage/src/parse_utils.h libsemanage.new/src/parse_utils.h
--- libsemanage/src/parse_utils.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/parse_utils.h	2005-09-30 21:27:31.000000000 -0400
@@ -0,0 +1,90 @@
+#ifndef _SEMANAGE_PARSE_UTILS_INTERNAL_H_
+#define _SEMANAGE_PARSE_UTILS_INTERNAL_H_
+
+#include <stdio.h>
+
+typedef struct parse_info {
+	unsigned int lineno;    /* Current line number */
+	char* orig_line;        /* Original copy of the line being parsed */
+	char* working_copy;     /* Working copy of the line being parsed */
+	char* ptr;              /* Current parsing location */
+
+	const char* filename;   /* Input stream file name */
+	FILE* file_stream;      /* Input stream handle */
+
+	void* parse_arg;        /* Caller supplied argument */
+} parse_info_t;
+
+/* Initialize structure */
+extern int parse_init(
+	const char* filename, 
+	void* parse_arg, 
+	parse_info_t** info);
+
+/* Release structure */
+extern void parse_release(
+	parse_info_t* info);
+
+/* Open file */
+extern int parse_open(
+	parse_info_t* info);
+
+/* Close file */
+extern void parse_close(
+	parse_info_t* info);
+
+/* Release resources for current line */
+extern void parse_dispose_line(
+	parse_info_t* info);
+
+/* Skip all whitespace and comments */
+extern int parse_skip_space(
+	parse_info_t* info);
+
+/* Throw an error if we're at the EOF */
+extern int parse_assert_noeof(
+	parse_info_t* info);
+	
+/* Throw an error if no whitespace follows */
+extern int parse_assert_space(
+	parse_info_t* info);
+
+/* Throw an error if the specified character 
+ * does not follow  */
+extern int parse_assert_ch(
+	parse_info_t* info, 
+	const char ch);
+
+/* Throw an error if the specified string 
+ * does not follow is not found */
+extern int parse_assert_str(
+	parse_info_t* info, 
+	const char* assert_str);
+
+/* Eat the optional character, if found,
+ * or return STATUS_NODATA */
+extern int parse_optional_ch(
+	parse_info_t* info, 
+	const char ch);
+
+/* Eat the optional string, if found,
+ * or return STATUS_NODATA */
+extern int parse_optional_str(
+	parse_info_t* info, 
+	const char* str);
+
+/* Buffer a string, filtering all 
+ * whitespace, until substring is encountered,
+ * at which point return the buffered string */ 
+extern char* parse_filter_space_until(
+	parse_info_t* info,
+	const char* substr);
+
+/* Extract the next string (delimited by 
+ * whitespace), and move the read pointer past it. 
+ * This string is overwritten when the next line 
+ * is read (inplace storage) */
+extern char* parse_fetch_string_inplace(
+	parse_info_t* info);
+
+#endif
diff -Naur libsemanage/src/ports.c libsemanage.new/src/ports.c
--- libsemanage/src/ports.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/ports.c	2005-09-30 20:48:31.000000000 -0400
@@ -6,14 +6,13 @@
 
 typedef semanage_port_key_t record_key_t;
 typedef semanage_port_t record_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
 #include <stdlib.h>
 #include <semanage/ports.h>
 #include "database.h"
 #include "handle.h"
-#include "interfaces.h"
 
 /* Port base functions */
 record_table_t SEMANAGE_PORT_RTABLE = {
diff -Naur libsemanage/src/ports_direct.c libsemanage.new/src/ports_direct.c
--- libsemanage/src/ports_direct.c	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/ports_direct.c	2005-09-30 20:47:33.000000000 -0400
@@ -5,18 +5,17 @@
 
 typedef sepol_port_t record_t;
 typedef sepol_port_key_t record_key_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 struct dbase_direct_backend;
 typedef struct dbase_direct_backend dbase_backend_t;
-#define BACKEND_DEFINED
+#define DBASE_BACKEND_DEFINED
 
 #include <stddef.h>
 #include <sepol/ports.h>
 #include <sepol/policydb.h>
 #include "ports_direct.h"
 #include "debug.h"
-#include "interfaces.h"
 #include "database_direct.h"
 
 /* PORT RECORD (SEPOL): method table (ports_policy.c) */
diff -Naur libsemanage/src/ports_file.c libsemanage.new/src/ports_file.c
--- libsemanage/src/ports_file.c	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/ports_file.c	2005-09-30 20:51:10.000000000 -0400
@@ -2,16 +2,16 @@
 
 typedef semanage_port_t record_t;
 typedef semanage_port_key_t record_key_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 struct dbase_file_backend;
 typedef struct dbase_file_backend dbase_backend_t;
-#define BACKEND_DEFINED
+#define DBASE_BACKEND_DEFINED
 
 #include <stdlib.h>
 #include <stdio.h>
-#include "interfaces.h"
 #include "database_file.h"
+#include "parse_utils.h"
 #include "debug.h"
 
 static int port_print(
diff -Naur libsemanage/src/ports_policy.c libsemanage.new/src/ports_policy.c
--- libsemanage/src/ports_policy.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/ports_policy.c	2005-09-30 20:47:05.000000000 -0400
@@ -6,14 +6,13 @@
 
 typedef sepol_port_key_t record_key_t;
 typedef sepol_port_t record_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 #include <semanage/port_record.h>
 #include <stddef.h>
 #include <stdlib.h>
 #include "handle.h"
 #include "database.h"
-#include "interfaces.h"
 #include "ports_policy.h"
 #include "debug.h"
 
diff -Naur libsemanage/src/record.h libsemanage.new/src/record.h
--- libsemanage/src/record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/record.h	2005-09-30 20:45:50.000000000 -0400
@@ -0,0 +1,35 @@
+#ifndef _SEMANAGE_RECORD_H_
+#define _SEMANAGE_RECORD_H_
+
+#ifndef RECORD_DEFINED
+typedef void* record_t;
+typedef void* record_key_t;
+#define RECORD_DEFINED
+#endif
+
+/* RECORD interface - method table */
+typedef struct record_table {
+
+	/* Create a record */
+	int (*create) (record_t** rec);
+
+	/* Extract key from record */
+	int (*key_extract) (record_t* rec, record_key_t** key);
+	
+	/* Free record key */
+	void (*key_free) (record_key_t* key);
+
+	/* Return 0 if record can be matched against key,
+	 * and 1 otherwise */
+	int (*compare) (record_t* rec, record_key_t* key);
+
+	/* Deep-copy clone of this record */
+	int (*clone) (record_t* rec, record_t** new_rec);
+
+	/* Deallocate record resources. Must
+	 * sucessfully handle NULL. */
+	void (*free) (record_t* rec);
+
+} record_table_t;
+
+#endif 
diff -Naur libsemanage/src/users.c libsemanage.new/src/users.c
--- libsemanage/src/users.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/users.c	2005-09-30 20:48:40.000000000 -0400
@@ -6,14 +6,13 @@
 
 typedef semanage_user_key_t record_key_t;
 typedef semanage_user_t record_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
 #include <stdlib.h>
 #include <semanage/users.h>
 #include "handle.h"
 #include "database.h"
-#include "interfaces.h"
 
 /* Record base functions */
 record_table_t SEMANAGE_USER_RTABLE = {
diff -Naur libsemanage/src/users_direct.c libsemanage.new/src/users_direct.c
--- libsemanage/src/users_direct.c	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/users_direct.c	2005-09-30 20:46:55.000000000 -0400
@@ -5,18 +5,17 @@
 
 typedef sepol_user_t record_t;
 typedef sepol_user_key_t record_key_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 struct dbase_direct_backend;
 typedef struct dbase_direct_backend dbase_backend_t;
-#define BACKEND_DEFINED
+#define DBASE_BACKEND_DEFINED
 
 #include <stddef.h>
 #include <sepol/users.h>
 #include <sepol/policydb.h>
 #include "users_direct.h"
 #include "debug.h"
-#include "interfaces.h"
 #include "database_direct.h"
 
 /* USER RECORD (SEPOL): method table (users_policy.c) */
diff -Naur libsemanage/src/users_file.c libsemanage.new/src/users_file.c
--- libsemanage/src/users_file.c	2005-09-30 21:38:51.000000000 -0400
+++ libsemanage.new/src/users_file.c	2005-09-30 20:51:28.000000000 -0400
@@ -2,16 +2,16 @@
 
 typedef semanage_user_t record_t;
 typedef semanage_user_key_t record_key_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 struct dbase_file_backend;
 typedef struct dbase_file_backend dbase_backend_t;
-#define BACKEND_DEFINED 
+#define DBASE_BACKEND_DEFINED 
 
 #include <stdlib.h>
 #include <stdio.h>
-#include "interfaces.h"
 #include "database_file.h"
+#include "parse_utils.h"
 #include "debug.h"
 
 static int user_print(
diff -Naur libsemanage/src/users_policy.c libsemanage.new/src/users_policy.c
--- libsemanage/src/users_policy.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/users_policy.c	2005-09-30 20:48:51.000000000 -0400
@@ -6,14 +6,13 @@
 
 typedef sepol_user_key_t record_key_t;
 typedef sepol_user_t record_t;
-#define RECORD_DEFINED
+#define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
 #include <stdlib.h>
 #include <semanage/user_record.h>
 #include "handle.h"
 #include "database.h"
-#include "interfaces.h"
 #include "users_policy.h"
 #include "debug.h"
 

--------------080201080903020808080308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
