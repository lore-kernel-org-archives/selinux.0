Message-ID: <4367083D.50101@cornell.edu>
Date: Tue, 01 Nov 2005 01:16:29 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add parse/print error messages
References: <4366D804.7030301@cornell.edu>
In-Reply-To: <4366D804.7030301@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------020305020906020705080100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020305020906020705080100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan Gyurdiev wrote:
> Add parse/print error messages, and pass handle down to parse_utils. 
> It's pretty verbose right now - I have to figure out a better way to 
> do error reporting... However, lots of messages is better than no 
> messages, so I suggest patch is merged - messages can be sorted out 
> later.
>
I think I sent the install_seusers patch twice. Reattached...



--------------020305020906020705080100
Content-Type: text/x-patch;
 name="libsemanage.parse_messages.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.parse_messages.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-10-31 21:36:10.000000000 -0500
@@ -27,12 +27,11 @@ static int bool_print(
 	int value = semanage_bool_get_value(boolean);
 
 	if (fprintf(str, "%s=%d\n", name, value) < 0) {
-		/* FIXME: handle error */
+		ERR(handle, "error writing boolean %s to stream", name);
 		return STATUS_ERR;
 	}
 
 	return STATUS_SUCCESS;
-	handle = NULL;
 }
 
 static int bool_parse(
@@ -43,13 +42,13 @@ static int bool_parse(
 	int value = 0;
 	char* str = NULL;
 
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
 	if (!info->ptr)
 		goto last;
 
 	/* Extract name */
-	if (parse_fetch_string_until(info, &str, '=') < 0)
+	if (parse_fetch_string_until(handle, info, &str, '=') < 0)
 		goto err;
 	
 	if (semanage_bool_set_name(handle, boolean, str) < 0) 
@@ -57,19 +56,19 @@ static int bool_parse(
 	free(str);
 	str = NULL;
 
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(info) < 0)
+	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
-	if (parse_assert_ch(info, '=') < 0)
+	if (parse_assert_ch(handle, info, '=') < 0)
 		goto err;
-	if (parse_skip_space(info) < 0) 
+	if (parse_skip_space(handle, info) < 0) 
 		goto err;
-	if (parse_assert_noeof(info)  < 0)
+	if (parse_assert_noeof(handle, info)  < 0)
 		goto err;
 
 	/* Extract value */
-	if (parse_fetch_string(info, &str) < 0)
+	if (parse_fetch_string(handle, info, &str) < 0)
 		goto err;
 
 	if (isdigit(*str)) {
@@ -104,7 +103,8 @@ static int bool_parse(
 	return STATUS_NODATA;
 
         err:
-	/* FIXME: handle error */
+	ERR(handle, "parse error (%s: %u):\n%s",
+		info->filename, info->lineno, info->orig_line);
 	free(str);
 	parse_dispose_line(info);
 	return STATUS_ERR;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-10-31 21:39:16.000000000 -0500
@@ -100,10 +100,10 @@ static int dbase_file_cache(
 	if (construct_filename(handle, dbase, &fname) < 0)
 		goto err;
 
-	if (parse_init(fname, NULL, &parse_info) < 0) 
+	if (parse_init(handle, fname, NULL, &parse_info) < 0) 
 		goto err;
 
-	if (parse_open(parse_info) < 0)
+	if (parse_open(handle, parse_info) < 0)
                 goto err;
 
 	/* Main processing loop */
@@ -140,7 +140,7 @@ static int dbase_file_cache(
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: handle failure */
+	ERR(handle, "could not cache file database");
 	dbase->rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-31 20:01:36.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-10-31 21:39:51.000000000 -0500
@@ -108,8 +108,7 @@ static int dbase_policydb_cache(
 	return STATUS_SUCCESS;
 
 	err:
-	ERR(handle, "unable to cache policy database from %s", fname);
-
+	ERR(handle, "could not cache policy database");
 	if (fp)
 		fclose(fp);
 	sepol_policydb_free(policydb);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsemanage/src/parse_utils.c	2005-10-31 21:43:25.000000000 -0500
@@ -4,10 +4,12 @@
 #include <string.h>
 #include <stdlib.h>
 #include <ctype.h>
+#include <semanage/handle.h>
 #include "parse_utils.h"
 #include "debug.h"
 
 int parse_init(
+	semanage_handle_t* handle,
 	const char* filename,
 	void* parse_arg,
 	parse_info_t** info) {
@@ -16,7 +18,7 @@ int parse_init(
 		(parse_info_t*) malloc(sizeof(parse_info_t));
 		
 	if (!tmp_info) {
-		/* FIXME: handle error condition */
+		ERR(handle, "out of memory, could not allocate parse structure");
 		return STATUS_ERR;
 	}
 
@@ -32,17 +34,22 @@ int parse_init(
 	return STATUS_SUCCESS;
 }
 
-void parse_release(parse_info_t* info) {
+void parse_release(
+	parse_info_t* info) {
+
 	parse_close(info);
 	parse_dispose_line(info);
 	free(info);
 }
 
-int parse_open(parse_info_t* info) {
+int parse_open(
+	semanage_handle_t* handle, 
+	parse_info_t* info) {
 	
 	info->file_stream = fopen(info->filename, "r");
 	if (!info->file_stream && (errno != ENOENT)) {
-		/* FIXME: handle error condition */
+		ERR(handle, "could not open file %s: %s",
+			info->filename, strerror(errno));
 		return STATUS_ERR;
 	}
 	if (info->file_stream)
@@ -72,7 +79,10 @@ void parse_dispose_line(parse_info_t* in
         info->ptr = NULL;
 }
 
-int parse_skip_space(parse_info_t* info) {
+int parse_skip_space(
+	semanage_handle_t* handle, 
+	parse_info_t* info) {
+
 	size_t len = 0;
 	int lineno = info->lineno;
 	char* buffer = NULL;
@@ -130,44 +140,52 @@ int parse_skip_space(parse_info_t* info)
 	return STATUS_SUCCESS;
 
 	omem:
-	/* DEBUG(__FUNCTION__, "out of memory\n"); */
+	ERR(handle, "out of memory, could not allocate buffer");
 	free(buffer);
 	return STATUS_ERR;
 }
 
-int parse_assert_noeof(parse_info_t* info) {
+int parse_assert_noeof(
+	semanage_handle_t* handle,
+	parse_info_t* info) {
+
 	if (!info->ptr) {
-		/* DEBUG(__FUNCTION__, "unexpected end of file\n"); */
+		ERR(handle, "unexpected end of file");
 		return STATUS_ERR;
 	}
 
 	return STATUS_SUCCESS;
 }
 
-int parse_assert_space(parse_info_t* info) {
+int parse_assert_space(
+	semanage_handle_t* handle, 
+	parse_info_t* info) {
+
 	if (!isspace(*(info->ptr))) {
-		/* DEBUG(__FUNCTION__, "malformed line %u in %s: \n%s\n",
-			info->lineno, info->filename, info->orig_line); */
+		ERR(handle, "missing whitespace (%s: %u):\n%s",
+			info->filename, info->lineno, info->orig_line);
 		return STATUS_ERR;
 	}
 
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		return STATUS_ERR;
 
 	return STATUS_SUCCESS;
 }
 
 
-int parse_assert_ch(parse_info_t* info, const char ch) {
-	if (parse_assert_noeof(info) < 0)
+int parse_assert_ch(
+	semanage_handle_t* handle,
+	parse_info_t* info, 
+	const char ch) {
+
+	if (parse_assert_noeof(handle, info) < 0)
 		return STATUS_ERR;
 
 	if (*(info->ptr) != ch) {
-		/* DEBUG(__FUNCTION__, "malformed line %u, char %u,"
-			" in %s: \n%s\n expected character \'%c\', but "
-			"found \'%c\'\n",
-			info->lineno, (info->ptr - info->working_copy),
-			info->filename, info->orig_line, ch, *(info->ptr)); */
+		ERR(handle, "expected character \'%c\', but found \'%c\' "
+			"(%s: %u):\n%s", ch, *(info->ptr), info->filename,
+			info->lineno, info->orig_line);
 		return STATUS_ERR;
 	}
 
@@ -176,16 +194,18 @@ int parse_assert_ch(parse_info_t* info, 
 	return STATUS_SUCCESS;
 }
 
-int parse_assert_str(parse_info_t* info, const char* assert_str) {
+int parse_assert_str(
+	semanage_handle_t* handle,
+	parse_info_t* info, 
+	const char* assert_str) {
 
-	if (parse_assert_noeof(info) < 0)
+	if (parse_assert_noeof(handle, info) < 0)
 		return STATUS_ERR;
 
 	if (strncmp(info->ptr, assert_str, strlen(assert_str))) {
-		/* DEBUG(__FUNCTION__, "malformed line %u in %s: \n%s\n"
-		"expected string \"%s\", but found \"%s\"\n",
-		info->lineno, info->filename, info->orig_line, assert_str,
-		info->ptr); */
+		ERR(handle, "experted string \"%s\", but found \"%s\" "
+			"(%s: %u):\n%s", assert_str, info->ptr, 
+			info->filename, info->lineno, info->orig_line);
 
 		return STATUS_ERR;
 	}
@@ -212,7 +232,10 @@ int parse_optional_str(parse_info_t* inf
 	}
 }
 
-char* parse_filter_space_until(parse_info_t* info, const char* substr) {
+char* parse_filter_space_until(
+	semanage_handle_t* handle, 
+	parse_info_t* info, 
+	const char* substr) {
 
 	char* buffer = NULL, *wr, *tmp;
 	int len = strlen(substr);
@@ -237,9 +260,9 @@ char* parse_filter_space_until(parse_inf
 		}
 		info->ptr++;
 
-		if (parse_skip_space(info) < 0)
+		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info) < 0)
+		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 
 	} while(!strncasecmp(info->ptr, substr, len));
@@ -255,7 +278,7 @@ char* parse_filter_space_until(parse_inf
 	return buffer;
 
 	omem:
-	/* DEBUG(__FUNCTION__, "out of memory\n"); */
+	ERR(handle, "out of memory, could not allocate buffer");
 
 	err:
 	free(buffer);
@@ -263,6 +286,7 @@ char* parse_filter_space_until(parse_inf
 }
 
 int parse_fetch_string(
+	semanage_handle_t* handle,
 	parse_info_t* info, 
 	char** str) {
 
@@ -276,13 +300,15 @@ int parse_fetch_string(
 	}
 
 	if (len == 0) {
-		/* FIXME: handle error */
+		ERR(handle, "expected non-empty string, but did not "
+			"find one (%s: %u):\n%s", info->filename, info->lineno,
+			info->orig_line);
 		return STATUS_ERR;
 	}
 		
 	tmp_str = (char*) malloc(len + 1);
 	if (!tmp_str) {
-		/* FIXME: handle error */
+		ERR(handle, "out of memory, could not allocate string");
 		return STATUS_ERR;	
 	}
 	
@@ -293,6 +319,7 @@ int parse_fetch_string(
 }
 
 int parse_fetch_string_until(
+	semanage_handle_t* handle,
 	parse_info_t* info, 
 	char** str, 
 	char delim) {
@@ -308,13 +335,15 @@ int parse_fetch_string_until(
         }
 
 	if (len == 0) {
-		/* FIXME: handle error */
+		ERR(handle, "expected non-empty string, but did not "
+			"find one (%s: %u):\n%s", info->filename, info->lineno,
+			info->orig_line);
 		return STATUS_ERR;
 	}
 
 	tmp_str = (char*) malloc(len + 1);
 	if (!tmp_str) {
-		/* FIXME: handle error */
+		ERR(handle, "out of memory, could not allocate string");
 		return STATUS_ERR;
 	}
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.h new/libsemanage/src/parse_utils.h
--- old/libsemanage/src/parse_utils.h	2005-10-25 09:06:53.000000000 -0400
+++ new/libsemanage/src/parse_utils.h	2005-10-31 21:37:18.000000000 -0500
@@ -2,6 +2,7 @@
 #define _SEMANAGE_PARSE_UTILS_INTERNAL_H_
 
 #include <stdio.h>
+#include <semanage/handle.h>
 
 typedef struct parse_info {
 	unsigned int lineno;    /* Current line number */
@@ -17,6 +18,7 @@ typedef struct parse_info {
 
 /* Initialize structure */
 extern int parse_init(
+	semanage_handle_t* handle,
 	const char* filename, 
 	void* parse_arg, 
 	parse_info_t** info);
@@ -27,6 +29,7 @@ extern void parse_release(
 
 /* Open file */
 extern int parse_open(
+	semanage_handle_t* handle,
 	parse_info_t* info);
 
 /* Close file */
@@ -39,20 +42,24 @@ extern void parse_dispose_line(
 
 /* Skip all whitespace and comments */
 extern int parse_skip_space(
+	semanage_handle_t* handle,
 	parse_info_t* info);
 
 /* Throw an error if we're at the EOF */
 extern int parse_assert_noeof(
+	semanage_handle_t* handle,
 	parse_info_t* info);
 	
 /* Throw an error if no whitespace follows,
  * otherwise eat the whitespace */
 extern int parse_assert_space(
+	semanage_handle_t* handle,
 	parse_info_t* info);
 
 /* Throw an error if the specified character 
  * does not follow, otherwise eat that character */
 extern int parse_assert_ch(
+	semanage_handle_t* handle,
 	parse_info_t* info, 
 	const char ch);
 
@@ -60,6 +67,7 @@ extern int parse_assert_ch(
  * does not follow is not found, otherwise
  * eat the string */
 extern int parse_assert_str(
+	semanage_handle_t* handle,
 	parse_info_t* info, 
 	const char* assert_str);
 
@@ -80,12 +88,14 @@ extern int parse_optional_str(
  * at which point return the buffered string.
  * This function will work on multiple lines */
 extern char* parse_filter_space_until(
+	semanage_handle_t* handle,
 	parse_info_t* info,
 	const char* substr);
 
 /* Extract the next string (delimited by 
  * whitespace), and move the read pointer past it */
 extern int parse_fetch_string(
+	semanage_handle_t* handle,
 	parse_info_t* info,
 	char** str_ptr);
 
@@ -93,6 +103,7 @@ extern int parse_fetch_string(
  * the specified character, or whitespace), and move the 
  * read pointer past it */
 extern int parse_fetch_string_until(
+	semanage_handle_t* handle,
 	parse_info_t* info,
 	char** str_ptr,
 	char delim);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-10-31 21:13:34.000000000 -0500
@@ -92,10 +92,10 @@ int semanage_base_merge_components(
 		load_arg.mode   = components[i].mode;
 
 		/* Must invoke cache function first */
-		if (from->dtable->cache(handle, from->dbase) < 0)
+		if (from->dtable->cache(handle, from->dbase) < 0) 
 			goto err;
 
-		if (to->dtable->cache(handle, to->dbase) < 0)
+		if (to->dtable->cache(handle, to->dbase) < 0) 
 			goto err;
 		
 		/* Now iterate */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-10-31 20:01:36.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-10-31 21:33:59.000000000 -0500
@@ -65,7 +65,7 @@ static int port_parse(
 	char* context = NULL;
 	semanage_context_t* con = NULL;
 
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
 	if (!info->ptr)
 		goto last;
@@ -114,7 +114,8 @@ static int port_parse(
 	return STATUS_NODATA;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "parse error (%s: %u):\n%s",
+		info->filename, info->lineno, info->orig_line);
 	free(proto);
 	free(context);
 	semanage_context_free(con);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-10-31 21:36:49.000000000 -0500
@@ -38,8 +38,7 @@ static int seuser_print(
 	return STATUS_SUCCESS;
 
 	err:
-	handle = NULL;
-	/* FIXME: handle error */
+	ERR(handle, "error writing seuser %s to stream", name);
 	return STATUS_ERR;
 }
 
@@ -50,32 +49,32 @@ static int seuser_parse(
 
 	char* str = NULL;
 
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
 	if (!info->ptr)
 		goto last;
 
 	/* Extract name */
-	if (parse_fetch_string_until(info, &str, ':') < 0)
+	if (parse_fetch_string_until(handle, info, &str, ':') < 0)
 		goto err;
 	if (semanage_seuser_set_name(handle, seuser, str) < 0)
 		goto err;
 	free(str);
 	str = NULL;
 
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(info) < 0)
+	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
-	if (parse_assert_ch(info, ':') < 0)
+	if (parse_assert_ch(handle, info, ':') < 0)
 		goto err;
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(info)  < 0)
+	if (parse_assert_noeof(handle, info)  < 0)
 		goto err;
 
 	/* Extract sename */
-	if (parse_fetch_string_until(info, &str, ':') < 0)
+	if (parse_fetch_string_until(handle, info, &str, ':') < 0)
 		goto err;
 	if (semanage_seuser_set_sename(handle, seuser, str) < 0)
 		goto err;
@@ -83,19 +82,19 @@ static int seuser_parse(
 	str = NULL;
 
 	if (is_selinux_mls_enabled()) {
-		if (parse_skip_space(info) < 0)
+		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info) < 0)
+		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
-		if (parse_assert_ch(info, ':') < 0)
+		if (parse_assert_ch(handle, info, ':') < 0)
 			goto err;
-		if (parse_skip_space(info) < 0)
+		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info)  < 0)
+		if (parse_assert_noeof(handle, info)  < 0)
 			goto err;
 
 		/* NOTE: does not allow spaces/multiline */
-		if (parse_fetch_string(info, &str) < 0)
+		if (parse_fetch_string(handle, info, &str) < 0)
 			goto err;
 
 		if (semanage_seuser_set_mlsrange(handle, seuser, str) <  0)
@@ -111,7 +110,8 @@ static int seuser_parse(
 	return STATUS_NODATA;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "parse error (%s: %u):\n%s", 
+		info->filename, info->lineno, info->orig_line);
 	free(str);
 	parse_dispose_line(info);
 	return STATUS_ERR;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-31 20:01:36.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-10-31 21:33:44.000000000 -0500
@@ -73,22 +73,22 @@ static int user_parse(
 	char* start;
 	char* name_str = NULL;
 
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
 	if (!info->ptr)
 		goto last;
 
 	/* Parse user header */
-	if (parse_assert_str(info, "user") < 0)
+	if (parse_assert_str(handle, info, "user") < 0)
 		goto err;
 
-	if (parse_assert_space(info) < 0)
+	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(info) < 0)
+	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
 
 	/* Parse user name */
-	if (parse_fetch_string(info, &name_str) < 0)
+	if (parse_fetch_string(handle, info, &name_str) < 0)
 		goto err;
 
 	if (semanage_user_set_name(handle, user, name_str) < 0) {
@@ -97,15 +97,15 @@ static int user_parse(
 	}
 	free(name_str);
 
-	if (parse_assert_space(info) < 0)
+	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(info) < 0)
+	if (parse_assert_noeof(handle, info) < 0)
                 goto err;
-	if (parse_assert_str(info, "roles") < 0)
+	if (parse_assert_str(handle, info, "roles") < 0)
 		goto err;
-	if (parse_assert_space(info) < 0)
+	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(info) < 0)
+	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
 
 	islist = (parse_optional_ch(info,'{') != STATUS_NODATA);
@@ -114,9 +114,9 @@ static int user_parse(
 	do {
 		char delim;
 
-		if (parse_skip_space(info) < 0)
+		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info) < 0)
+		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 
 		start = info->ptr;
@@ -142,9 +142,9 @@ static int user_parse(
 				goto err;
 		}
 
-		if (parse_skip_space(info) < 0)
+		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info) < 0)
+		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 
 		if (parse_optional_ch(info,';') != STATUS_NODATA)
@@ -159,18 +159,18 @@ static int user_parse(
 	if (is_selinux_mls_enabled()) {
 
 		/* Parse level header */
-		if (parse_skip_space(info) < 0)
+		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info) < 0)
+		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 		if (parse_optional_str(info, "level") != STATUS_NODATA)
 			goto semicolon;
-		if (parse_assert_space(info) < 0)
+		if (parse_assert_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info) < 0)
+		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 
-		mls = parse_filter_space_until(info, "range");
+		mls = parse_filter_space_until(handle, info, "range");
 		if (!mls)
 			goto err;
 		if (semanage_user_set_mlslevel(handle, user, mls) < 0)
@@ -178,15 +178,15 @@ static int user_parse(
 		free(mls);
 
 		/* Parse range header */
-		if (parse_assert_str(info, "range") < 0)
+		if (parse_assert_str(handle, info, "range") < 0)
                        goto err;
 
-		if (parse_assert_space(info) < 0)
+		if (parse_assert_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(info) < 0)
+		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 
-		mls = parse_filter_space_until(info, ";");
+		mls = parse_filter_space_until(handle, info, ";");
 		if (!mls)
 			goto err;
 		if (semanage_user_set_mlsrange(handle, user, mls) < 0)
@@ -196,11 +196,11 @@ static int user_parse(
 
 	/* Check for semicolon */
 	semicolon:
-	if (parse_skip_space(info) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(info) < 0)
+	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
-	if (parse_assert_ch(info,';') < 0)
+	if (parse_assert_ch(handle, info,';') < 0)
 		goto err;
 
 	skip_semicolon:
@@ -211,7 +211,8 @@ static int user_parse(
 	return STATUS_NODATA;
 
 	err:
-	/* FIXME: handle error */
+	ERR(handle, "parse error (%s: %u):\n%s",
+		info->filename, info->lineno, info->orig_line);
 	free(mls);
 	parse_dispose_line(info);
 	return STATUS_ERR;

--------------020305020906020705080100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
