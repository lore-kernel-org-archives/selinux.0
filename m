Message-ID: <435D9456.9070502@cornell.edu>
Date: Mon, 24 Oct 2005 22:11:34 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE 2 ] Booleans, parser fixes/improvements
Content-Type: multipart/mixed;
 boundary="------------090805010709000707050104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090805010709000707050104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch gets booleans working - well... sort of. They still aren't 
loaded right - I think it's because genbools goes and overrides them 
after my changes, which is not very nice. I suspect the semanage loading 
code is working just fine - I can see the file commit code working, at 
least.

Changes (2 stubs removed):
- implement boolean parse() function
- implement boolean print() function

Changes in the way booleans are parsed:
- strtol is used instead of atoi, for improved error detection
- boolean declaration can now be spread out on multiple lines and/or on 
the same line (or any combination) - it doesn't matter at all - it was 
just a lot easier to do it this way, because of the way my parser works.

Changes to the parser:
- added function parse_fetch_string_until, which is useful
- made all assert() functions eat the item that they assert on, which 
makes sense, and matches the header comments - this makes the user 
parser simpler, for example, and reduces possibility for error.

-  dropped perr_fatal - this was supposed to be a flag to allow us to 
skip records that do not parse. However, (1) it leaks the record 
skipped, (2) it is currently not passed down through the call stack, and 
most importantly, (3) I was assuming one record per line again, which is 
just not the case - implementing this feature in the general case looks 
really hard (if possible at all). So, all parse errors are fatal - this 
is probably the safer choice too.

======
There's still a memory leak which I can't find... but I will track it 
down eventually - I am now running all code through valgrind, and 
auditing for leaks.


--------------090805010709000707050104
Content-Type: text/x-patch;
 name="libsemanage.booleans.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.booleans.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/booleans_file.c	2005-10-24 21:56:21.000000000 -0400
@@ -20,24 +20,94 @@ typedef struct dbase_file dbase_t;
 #include "handle.h"
 
 static int bool_print(
-	semanage_bool_t* bool, 
+	semanage_bool_t* boolean, 
 	FILE* str) {
 
-	/* Stub */
-	bool = NULL;
-	str = NULL;
-	return STATUS_ERR;
+	const char* name = semanage_bool_get_name(boolean);
+	int value = semanage_bool_get_value(boolean);
+
+	if (fprintf(str, "%s=%d\n", name, value) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
 }
 
 static int bool_parse(
 	parse_info_t* info, 
-	semanage_bool_t* bool) {
+	semanage_bool_t* boolean) {
+	
+	int value = 0;
+	char* str = NULL;
 
-	/* Stub */
-	info = NULL;
-	bool = NULL;
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	/* Extract name */
+	if (parse_fetch_string_until(info, &str, '=') < 0)
+		goto err;
+	
+	if (semanage_bool_set_name(boolean, str) < 0) 
+		goto err;
+	free(str);
+	str = NULL;
+
+	if (parse_skip_space(info) < 0)
+		goto err;
+	if (parse_assert_noeof(info) < 0)
+		goto err;
+	
+	if (parse_assert_ch(info, '=') < 0)
+		goto err;
+
+	if (parse_skip_space(info) < 0) 
+		goto err;
+	if (parse_assert_noeof(info)  < 0)
+		goto err;
+
+	/* Extract value */
+	if (parse_fetch_string(info, &str) < 0)
+		goto err;
+
+	if (isdigit(*str)) {
+		char* test = NULL;
+		value = strtol(str, &test, 10);
+
+		if (*test != '\0') {
+			/* FIXME: handle error */
+			goto err;
+		} 
+	}
+	else if (!strcasecmp(str, "true"))
+		value = 1;
+	else if (!strcasecmp(str, "false"))
+		value = 0;
+	else {
+		/* FIXME: handle error */
+		goto err;
+	}
+	free(str);
+	str = NULL;
+
+	if (value != 0 && value != 1) {
+		/* FIXME: handle error */
+		goto err;
+	}
+	semanage_bool_set_value(boolean, value);
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
 	return STATUS_NODATA;
 
+        err:
+	/* FIXME: handle error */
+	free(str);
+	parse_dispose_line(info);
+	return STATUS_ERR;
 }
 
 /* BOOL RECORD: metod table (booleans_local.c) */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-24 12:32:56.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-24 21:56:02.000000000 -0400
@@ -84,9 +84,6 @@ static int dbase_file_cache(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	int perr_fatal = 0;
-	/* FIXME: pass from caller? */
-
 	record_t* process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
 
@@ -119,14 +116,10 @@ static int dbase_file_cache(
 		/* Parse record */
 		pstatus = dbase->rftable->parse(parse_info, process_record);
 
-		/* Parse error is fatal, exit */
-		if (perr_fatal && (pstatus < 0))
+		/* Parse error */
+		if (pstatus < 0)
 			goto err;
 
-		/* Parse error is not fatal */
-		else if (pstatus < 0)
-			continue;
-
 		/* End of file */
 		else if (pstatus == STATUS_NODATA) 
 			break;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-10-24 18:50:44.000000000 -0400
+++ new/libsemanage/src/parse_utils.c	2005-10-24 21:42:01.000000000 -0400
@@ -150,6 +150,10 @@ int parse_assert_space(parse_info_t* inf
 			info->lineno, info->filename, info->orig_line); */
 		return STATUS_ERR;
 	}
+
+	if (parse_skip_space(info) < 0)
+		return STATUS_ERR;
+
 	return STATUS_SUCCESS;
 }
 
@@ -167,6 +171,8 @@ int parse_assert_ch(parse_info_t* info, 
 		return STATUS_ERR;
 	}
 
+	info->ptr++;
+
 	return STATUS_SUCCESS;
 }
 
@@ -256,7 +262,10 @@ char* parse_filter_space_until(parse_inf
 	return NULL;
 }
 
-int parse_fetch_string(parse_info_t* info, char** str) {
+int parse_fetch_string(
+	parse_info_t* info, 
+	char** str) {
+
 	char* start = info->ptr;
 	int len = 0;
 	char* tmp_str = NULL;
@@ -276,4 +285,31 @@ int parse_fetch_string(parse_info_t* inf
 	*(tmp_str + len)= '\0';
 	*str = tmp_str;
 	return STATUS_SUCCESS;
+}
+
+int parse_fetch_string_until(
+	parse_info_t* info, 
+	char** str, 
+	char delim) {
+
+	char* start = info->ptr;
+	int len = 0;
+	char* tmp_str = NULL;
+
+	while (*(info->ptr) && !isspace(*(info->ptr)) &&
+	      (*(info->ptr) != delim)) {
+		info->ptr++;
+		len ++;
+        }
+
+	tmp_str = (char*) malloc(len + 1);
+	if (!tmp_str) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	strncpy(tmp_str, start, len);
+	*(tmp_str + len)= '\0';
+	*str = tmp_str;
+	return STATUS_SUCCESS;
 } 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/parse_utils.h new/libsemanage/src/parse_utils.h
--- old/libsemanage/src/parse_utils.h	2005-10-24 18:50:44.000000000 -0400
+++ new/libsemanage/src/parse_utils.h	2005-10-24 21:39:03.000000000 -0400
@@ -45,18 +45,20 @@ extern int parse_skip_space(
 extern int parse_assert_noeof(
 	parse_info_t* info);
 	
-/* Throw an error if no whitespace follows */
+/* Throw an error if no whitespace follows,
+ * otherwise eat the whitespace */
 extern int parse_assert_space(
 	parse_info_t* info);
 
 /* Throw an error if the specified character 
- * does not follow  */
+ * does not follow, otherwise eat that character */
 extern int parse_assert_ch(
 	parse_info_t* info, 
 	const char ch);
 
 /* Throw an error if the specified string 
- * does not follow is not found */
+ * does not follow is not found, otherwise
+ * eat the string */
 extern int parse_assert_str(
 	parse_info_t* info, 
 	const char* assert_str);
@@ -75,16 +77,24 @@ extern int parse_optional_str(
 
 /* Buffer a string, filtering all 
  * whitespace, until substring is encountered,
- * at which point return the buffered string */ 
+ * at which point return the buffered string.
+ * This function will work on multiple lines */
 extern char* parse_filter_space_until(
 	parse_info_t* info,
 	const char* substr);
 
 /* Extract the next string (delimited by 
- * whitespace), and move the read pointer past it. */
-
+ * whitespace), and move the read pointer past it */
 extern int parse_fetch_string(
 	parse_info_t* info,
 	char** str_ptr);
 
+/* Extract the next string (delimited by 
+ * the specified character, or whitespace), and move the 
+ * read pointer past it */
+extern int parse_fetch_string_until(
+	parse_info_t* info,
+	char** str_ptr,
+	char delim);
+
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-24 18:50:44.000000000 -0400
+++ new/libsemanage/src/users_file.c	2005-10-24 21:45:55.000000000 -0400
@@ -83,8 +83,6 @@ static int user_parse(
 
 	if (parse_assert_space(info) < 0)
 		goto err;
-	if (parse_skip_space(info) < 0)
-		goto err;
 	if (parse_assert_noeof(info) < 0)
 		goto err;
 
@@ -100,8 +98,6 @@ static int user_parse(
 
 	if (parse_assert_space(info) < 0)
 		goto err;
-	if (parse_skip_space(info) < 0)
-		goto err;
 	if (parse_assert_noeof(info) < 0)
                 goto err;
 
@@ -111,8 +107,6 @@ static int user_parse(
 
 	if (parse_assert_space(info) < 0)
 		goto err;
-	if (parse_skip_space(info) < 0)
-		goto err;
 	if (parse_assert_noeof(info) < 0)
 		goto err;
 
@@ -177,8 +171,6 @@ static int user_parse(
 
 		if (parse_assert_space(info) < 0)
 			goto err;
-		if (parse_skip_space(info) < 0)
-			goto err;
 		if (parse_assert_noeof(info) < 0)
 			goto err;
 
@@ -195,8 +187,6 @@ static int user_parse(
 
 		if (parse_assert_space(info) < 0)
 			goto err;
-		if (parse_skip_space(info) < 0)
-			goto err;
 		if (parse_assert_noeof(info) < 0)
 			goto err;
 
@@ -217,8 +207,6 @@ static int user_parse(
 	if (parse_assert_ch(info,';') < 0)
 		goto err;
 
-	info->ptr++;
-
 	skip_semicolon:
 	return STATUS_SUCCESS;
 

--------------090805010709000707050104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
