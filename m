Message-ID: <436865AC.1010500@cornell.edu>
Date: Wed, 02 Nov 2005 02:07:24 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Interfaces, more parser things
Content-Type: multipart/mixed;
 boundary="------------020008000809080809050709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020008000809080809050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:

- implement interface parse/print functions, and enable interfaces
- rewrite sscanf port parser using parse_utils - better error reporting, 
and now allows multiline
- simplify boolean parser using new parse_fetch_int helper

- Parser: remove parse_fetch_string.
- Parser: make parse_fetch_string_until the default (rename to 
parse_fetch_string). Pass ' ', when the delimiter shouldn't do anything.
- Parser: implement new helper parse_fetch_int.
- Parser: fix parse_assert_space to check for EOL (which is _not_ '\n' - 
it's '\0', at the end of the buffer).

Note: for some reason strtol doesn't seem to do what the manpage says, 
and does not set *endptr correctly on a string that begins with a number 
- need to investigate further.

Note: haven't really tested ports yet - but they're disabled right now...


--------------020008000809080809050709
Content-Type: text/x-patch;
 name="libsemanage.more_parse.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.more_parse.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/include/semanage/semanage.h	2005-11-02 01:38:21.000000000 -0500
@@ -29,8 +29,9 @@
 #include <semanage/boolean_record.h>
 #include <semanage/user_record.h>
 #include <semanage/seuser_record.h>
-#if 0
+#include <semanage/context_record.h>
 #include <semanage/iface_record.h>
+#if 0
 #include <semanage/port_record.h>
 #endif
 
@@ -43,8 +44,8 @@
 #if 0
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
+#endif
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
-#endif
 
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-11-01 16:25:47.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-11-02 01:10:55.000000000 -0500
@@ -49,7 +49,7 @@ static int bool_parse(
 		goto last;
 
 	/* Extract name */
-	if (parse_fetch_string_until(handle, info, &str, '=') < 0)
+	if (parse_fetch_string(handle, info, &str, '=') < 0)
 		goto err;
 	
 	if (semanage_bool_set_name(handle, boolean, str) < 0) 
@@ -57,49 +57,38 @@ static int bool_parse(
 	free(str);
 	str = NULL;
 
+	/* Assert = */
 	if (parse_skip_space(handle, info) < 0)
 		goto err;
 	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
 	if (parse_assert_ch(handle, info, '=') < 0)
 		goto err;
-	if (parse_skip_space(handle, info) < 0) 
-		goto err;
-	if (parse_assert_noeof(handle, info)  < 0)
-		goto err;
 
 	/* Extract value */
-	if (parse_fetch_string(handle, info, &str) < 0)
+	if (parse_skip_space(handle, info) < 0)
 		goto err;
-
-	if (isdigit(*str)) {
-		char* test = NULL;
-		value = strtol(str, &test, 10);
-
-		if (*test != '\0') {
-			ERR(handle, "could not parse numeric value for %s", 
-				semanage_bool_get_name(boolean));
-			goto err;
-		} 
-	}
-	else if (!strcasecmp(str, "true"))
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
+	if (parse_optional_str(info, "true") != STATUS_NODATA) 
+		value = 1;
+	else if (parse_optional_str(info, "TRUE") != STATUS_NODATA)
 		value = 1;
-	else if (!strcasecmp(str, "false"))
+	else if (parse_optional_str(info, "false") != STATUS_NODATA)
 		value = 0;
-	else {
-		ERR(handle, "invalid boolean value for %s: %s", 
-			semanage_bool_get_name(boolean), str);
+	else if (parse_optional_str(info, "FALSE") != STATUS_NODATA)
+		value = 0;
+	else if (parse_fetch_int(handle, info, &value, ' ') < 0)
 		goto err;
-	}
-	free(str);
-	str = NULL;
-
+	
 	if (value != 0 && value != 1) {
-		ERR(handle, "invalid boolean value for %s: %u", 
-			semanage_bool_get_name(boolean), value);
+		ERR(handle, "invalid boolean value for \"%s\": %u "
+			"(%s: %u)\n%s", semanage_bool_get_name(boolean),
+			value, info->filename, info->lineno, info->orig_line);
 		goto err;
 	}
 	semanage_bool_set_value(boolean, value);
+
 	return STATUS_SUCCESS;
 
 	last:
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-11-02 01:56:27.000000000 -0500
@@ -10,10 +10,9 @@ typedef struct dbase_file dbase_t;
 
 #include <stdlib.h>
 #include <stdio.h>
-#include <ctype.h>
-#include <string.h>
 #include <selinux/selinux.h>
 #include <semanage/handle.h>
+#include <semanage/context_record.h>
 #include "database_file.h"
 #include "interfaces_file.h"
 #include "parse_utils.h"
@@ -24,10 +23,36 @@ static int iface_print(
 	semanage_iface_t* iface, 
 	FILE* str) {
 
-	/* Stub */
-	handle = NULL;
-	iface = NULL;
-	str = NULL;
+	char* con_str = NULL;
+
+	const char* name = semanage_iface_get_name(iface);
+	semanage_context_t* ifcon = semanage_iface_get_ifcon(iface);
+	semanage_context_t* msgcon = semanage_iface_get_msgcon(iface);
+
+	if (fprintf(str, "netifcon %s ", name) < 0)
+		goto err;
+
+	con_str = semanage_context_to_string(handle, ifcon);
+	if (!con_str)
+		goto err;
+	if (fprintf(str, "%s", con_str) < 0)
+		goto err;
+	free(con_str);
+	con_str = NULL;
+
+	con_str = semanage_context_to_string(handle, msgcon);
+	if (!con_str)
+		goto err;
+	if (fprintf(str, "%s\n", con_str) < 0)
+		goto err;
+	free(con_str);
+	con_str = NULL;
+	
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not print interface %s to stream", name);
+	free(con_str);
 	return STATUS_ERR;
 }
 
@@ -36,11 +61,84 @@ static int iface_parse(
 	parse_info_t* info, 
 	semanage_iface_t* iface) {
 
-	/* Stub */
-	handle = NULL;
-	info = NULL;
-	iface = NULL;
+	char* str = NULL;
+	semanage_context_t* con = NULL;
+
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+	
+	/* Header */
+	if (parse_assert_str(handle, info, "netifcon") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
+
+	/* Name */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;		
+	if (semanage_iface_set_name(handle, iface, str)  < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	/* Interface context */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_context_from_string(handle, str, &con) < 0)
+		goto err;
+	if (con == NULL) {
+		ERR(handle, "<<none>> context is not valid for "
+			"interfaces (%s: %u)\n%s", info->filename,
+			info->lineno, info->orig_line);
+		goto err;
+	}
+	free(str);
+	str = NULL;
+
+	semanage_iface_set_ifcon(iface, con);
+	con = NULL;	
+
+	/* Message context */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_context_from_string(handle, str, &con) < 0)
+		goto err;
+	if (con == NULL) {
+		ERR(handle, "<<none>> context is not valid for "
+			"interfaces (%s: %u)\n%s", info->filename, 
+			info->lineno, info->orig_line);
+		goto err;
+	}
+	free(str);
+	str = NULL;
+	
+	semanage_iface_set_msgcon(iface, con);
+	con = NULL;
+
+	return STATUS_SUCCESS;
+
+	last:
+	parse_dispose_line(info);
 	return STATUS_NODATA;
+
+	err:
+	ERR(handle, "could not parse interface record");
+	free(str);
+	semanage_context_free(con);
+	parse_dispose_line(info);
+	return STATUS_ERR;
 }
 
 /* IFACE RECORD: metod table (iface_record.c) */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-10-27 15:27:03.000000000 -0400
+++ new/libsemanage/src/libsemanage.map	2005-11-02 01:38:03.000000000 -0500
@@ -10,5 +10,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
+	  semanage_iface_*; semanage_context_*;
   local: *;
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/parse_utils.c	2005-11-02 01:49:26.000000000 -0500
@@ -163,7 +163,7 @@ int parse_assert_space(
 	semanage_handle_t* handle, 
 	parse_info_t* info) {
 
-	if (!isspace(*(info->ptr))) {
+	if (*(info->ptr) && !isspace(*(info->ptr))) {
 		ERR(handle, "missing whitespace (%s: %u):\n%s",
 			info->filename, info->lineno, info->orig_line);
 		return STATUS_ERR;
@@ -234,40 +234,44 @@ int parse_optional_str(parse_info_t* inf
 	}
 }
 
-int parse_fetch_string(
+int parse_fetch_int(
 	semanage_handle_t* handle,
-	parse_info_t* info, 
-	char** str) {
+	parse_info_t* info,
+	int* num,
+	char delim) {
 
-	char* start = info->ptr;
-	int len = 0;
-	char* tmp_str = NULL;
+	char* str = NULL;
+	char* test = NULL;
+	int value = 0;
 
-	while (*(info->ptr) && !isspace(*(info->ptr))) {
-		info->ptr++;
-		len ++;
-	}
+	if (parse_fetch_string(handle, info, &str, delim) < 0)
+		goto err;
 
-	if (len == 0) {
-		ERR(handle, "expected non-empty string, but did not "
-			"find one (%s: %u):\n%s", info->filename, info->lineno,
-			info->orig_line);
-		return STATUS_ERR;
+	if (!isdigit((int) *str)) {
+		ERR(handle, "expected a numeric value: (%s: %u)\n%s",
+			info->filename, info->lineno, info->orig_line);
+		goto err;
 	}
-		
-	tmp_str = (char*) malloc(len + 1);
-	if (!tmp_str) {
-		ERR(handle, "out of memory, could not allocate string");
-		return STATUS_ERR;	
+
+	value = strtol(info->ptr, &test, 10);
+	if (*test != '\0') {
+		ERR(handle, "could not parse numeric value: %s (%s: %u)\n%s",
+			strerror(errno), info->filename, 
+			info->lineno, info->orig_line);
+		goto err;
 	}
-	
-	strncpy(tmp_str, start, len);
-	*(tmp_str + len)= '\0';
-	*str = tmp_str;
+
+	*num = value;
+	free(str);
 	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not fetch numeric value");
+	free(str);
+	return STATUS_ERR;
 }
 
-int parse_fetch_string_until(
+int parse_fetch_string(
 	semanage_handle_t* handle,
 	parse_info_t* info, 
 	char** str, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.h new/libsemanage/src/parse_utils.h
--- old/libsemanage/src/parse_utils.h	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/parse_utils.h	2005-11-02 01:01:16.000000000 -0500
@@ -83,17 +83,22 @@ extern int parse_optional_str(
 	parse_info_t* info, 
 	const char* str);
 
-/* Extract the next string (delimited by 
- * whitespace), and move the read pointer past it */
-extern int parse_fetch_string(
-	semanage_handle_t* handle,
+/* Extract the next integer, and move
+ * the read pointer past it. Stop if
+ * the optional character delim is encountered,
+ * or if whitespace/eof is encountered */
+int parse_fetch_int(
+	semanage_handle_t* hgandle,
 	parse_info_t* info,
-	char** str_ptr);
+	int* num,
+	char delim);
 
 /* Extract the next string (delimited by 
- * the specified character, or whitespace), and move the 
- * read pointer past it */
-extern int parse_fetch_string_until(
+ * whitespace), and move the read pointer past it.
+ * Stop of the optional character delim is encountered,
+ * or if whitespace/eof is encountered. Fail if the
+ * string is of length 0. */
+extern int parse_fetch_string(
 	semanage_handle_t* handle,
 	parse_info_t* info,
 	char** str_ptr,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-11-02 01:41:03.000000000 -0500
@@ -1,5 +1,4 @@
 #include <semanage/port_record.h>
-#include <semanage/context_record.h>
 
 typedef semanage_port_t record_t;
 typedef semanage_port_key_t record_key_t;
@@ -13,6 +12,7 @@ typedef struct dbase_file dbase_t;
 #include <stdio.h>
 #include <strings.h>
 #include <semanage/handle.h>
+#include <semanage/context_record.h>
 #include "database_file.h"
 #include "ports_file.h"
 #include "parse_utils.h"
@@ -62,9 +62,8 @@ static int port_parse(
 	parse_info_t* info, 
 	semanage_port_t* port) {
 
-	int low, high, items;
-	char* proto = NULL;
-	char* context = NULL;
+	int low, high;
+	char* str = NULL;
 	semanage_context_t* con = NULL;
 
 	if (parse_skip_space(handle, info) < 0)
@@ -72,45 +71,75 @@ static int port_parse(
 	if (!info->ptr)
 		goto last;
 
-	items = sscanf(info->ptr, "portcon %as %d - %d %as",
-			&proto, &low, &high, &context);
-	if (items != 4) {
-		free(proto);
-		free(context);
-		items = sscanf(info->ptr, "portcon %as %d %as", &proto, &low, &context);
-		if (items != 3) {
-			ERR(handle, "too many items on the line (%s: %u):\n%s",
-				info->filename, info->lineno, info->orig_line);
-			goto err;
-		}
-		semanage_port_set_port(port, low);
-	}
-	else semanage_port_set_range(port, low, high);
+	/* Header */
+	if (parse_assert_str(handle, info, "portcon") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
 
-	if (!strcasecmp(proto, "tcp"))
+	/* Protocol */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (!strcasecmp(str, "tcp"))
 		semanage_port_set_proto(port, SEMANAGE_PROTO_TCP);
-
-	else if (!strcasecmp(proto, "udp"))
+	else if (!strcasecmp(str, "udp"))
 		semanage_port_set_proto(port, SEMANAGE_PROTO_UDP);
-
 	else {
-		ERR(handle, "invalid protocol value for port range %u - %u: %s",
-			low, high, proto); 
+		ERR(handle, "invalid protocol \"%s\" (%s: %u):\n%s", str,
+				info->filename, info->lineno, info->orig_line);
 		goto err;
 	}
+	free(str);
+	str = NULL;
+
+	/* Range/Port */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
+	if (parse_fetch_int(handle, info, &low, '-') < 0)
+		goto err;
 
-	if (semanage_context_from_string(handle, context, &con) < 0)
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
+	if (parse_optional_ch(info, '-') != STATUS_NODATA) {
 
-	/* <<none>> is not allowed for ports */
-	if (!con)
+		if (parse_skip_space(handle, info) < 0)
+			goto err;	
+		if (parse_assert_noeof(handle, info) < 0)
+			goto err;
+		if (parse_fetch_int(handle, info, &high, ' ') < 0)
+			goto err;
+		semanage_port_set_range(port, low, high);
+	}
+	else 
+		semanage_port_set_port(port, low);
+
+        /* Port context */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_context_from_string(handle, str, &con) < 0)
 		goto err;
+	if (con == NULL) {
+		ERR(handle, "<<none>> context is not valid "
+			"for ports (%s: %u):\n%s", info->filename, 
+			info->lineno, info->orig_line);
+		goto err;
+	}
+	free(str);
+	str = NULL;
 
 	semanage_port_set_con(port, con);
 	con = NULL;
 
-	free(proto);
-	free(context);
 	return STATUS_SUCCESS;
 
 	last:
@@ -119,10 +148,8 @@ static int port_parse(
 
 	err:
 	ERR(handle, "could not parse port record");
-	free(proto);
-	free(context);
+	free(str);
 	semanage_context_free(con);
-
 	parse_dispose_line(info);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-11-02 00:45:47.000000000 -0500
@@ -56,7 +56,7 @@ static int seuser_parse(
 		goto last;
 
 	/* Extract name */
-	if (parse_fetch_string_until(handle, info, &str, ':') < 0)
+	if (parse_fetch_string(handle, info, &str, ':') < 0)
 		goto err;
 	if (semanage_seuser_set_name(handle, seuser, str) < 0)
 		goto err;
@@ -75,7 +75,7 @@ static int seuser_parse(
 		goto err;
 
 	/* Extract sename */
-	if (parse_fetch_string_until(handle, info, &str, ':') < 0)
+	if (parse_fetch_string(handle, info, &str, ':') < 0)
 		goto err;
 	if (semanage_seuser_set_sename(handle, seuser, str) < 0)
 		goto err;
@@ -95,7 +95,7 @@ static int seuser_parse(
 			goto err;
 
 		/* NOTE: does not allow spaces/multiline */
-		if (parse_fetch_string(handle, info, &str) < 0)
+		if (parse_fetch_string(handle, info, &str, ' ') < 0)
 			goto err;
 
 		if (semanage_seuser_set_mlsrange(handle, seuser, str) <  0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-11-01 16:25:48.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-11-02 00:45:21.000000000 -0500
@@ -89,7 +89,7 @@ static int user_parse(
 		goto err;
 
 	/* Parse user name */
-	if (parse_fetch_string(handle, info, &name_str) < 0)
+	if (parse_fetch_string(handle, info, &name_str, ' ') < 0)
 		goto err;
 
 	if (semanage_user_set_name(handle, user, name_str) < 0) {
@@ -172,7 +172,7 @@ static int user_parse(
 			goto err;
 
 		/* NOTE: does not allow spaces/multiline */
-		if (parse_fetch_string(handle, info, &str) < 0)
+		if (parse_fetch_string(handle, info, &str, ' ') < 0)
 			goto err;
 		if (semanage_user_set_mlslevel(handle, user, str) < 0)
 			goto err;
@@ -190,7 +190,7 @@ static int user_parse(
 			goto err;
 
 		/* NOTE: does not allow spaces/multiline */
-		if (parse_fetch_string_until(handle, info, &str, ';') < 0)
+		if (parse_fetch_string(handle, info, &str, ';') < 0)
 			goto err;
 		if (semanage_user_set_mlsrange(handle, user, str) < 0)
 			goto err;

--------------020008000809080809050709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
