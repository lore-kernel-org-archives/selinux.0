Message-ID: <4368D8EC.3020700@cornell.edu>
Date: Wed, 02 Nov 2005 10:19:08 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE 3 ] Push assert_noeof into parse_utils, fix bug
Content-Type: multipart/mixed;
 boundary="------------090806060305070308060802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090806060305070308060802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
- fix whitespace bug in interfaces.print, introduced by a last second 
change that I did not test
- more verbose messages on invalid context, indicating where the error 
occured
(Yes, this all way too verbose, but right now I want to focus on 
reporting all the necessary information to locate the problem - in the 
future I can focus on reporting _only_ the necessary information to 
locate the problem).

- push assert_noeof into all the parse utils not handling this case, and 
pull it out of the individual parsers, making them shorter, and simpler: 
add to parse_assert_space, parse_optional_str, parse_fetch_string, and 
parse_fetch_int (via parse_fetch_string).



--------------090806060305070308060802
Content-Type: text/x-patch;
 name="libsemanage.move_assert.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.move_assert.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-11-02 02:04:33.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-11-02 10:02:44.000000000 -0500
@@ -60,16 +60,12 @@ static int bool_parse(
 	/* Assert = */
 	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_assert_ch(handle, info, '=') < 0)
 		goto err;
 
 	/* Extract value */
 	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_optional_str(info, "true") != STATUS_NODATA) 
 		value = 1;
 	else if (parse_optional_str(info, "TRUE") != STATUS_NODATA)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-11-02 02:32:30.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-11-02 10:11:04.000000000 -0500
@@ -34,7 +34,7 @@ static int iface_print(
 
 	if (semanage_context_to_string(handle, ifcon, &con_str) < 0)
 		goto err;
-	if (fprintf(str, "%s", con_str) < 0)
+	if (fprintf(str, "%s ", con_str) < 0)
 		goto err;
 	free(con_str);
 	con_str = NULL;
@@ -72,8 +72,6 @@ static int iface_parse(
 		goto err;
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 
 	/* Name */
 	if (parse_fetch_string(handle, info, &str, ' ') < 0)
@@ -86,12 +84,13 @@ static int iface_parse(
 	/* Interface context */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_fetch_string(handle, info, &str, ' ') < 0)
 		goto err;
-	if (semanage_context_from_string(handle, str, &con) < 0)
+	if (semanage_context_from_string(handle, str, &con) < 0) {
+		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
+			str, info->filename, info->lineno, info->orig_line);
 		goto err;
+	}
 	if (con == NULL) {
 		ERR(handle, "<<none>> context is not valid for "
 			"interfaces (%s: %u)\n%s", info->filename,
@@ -107,12 +106,13 @@ static int iface_parse(
 	/* Message context */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_fetch_string(handle, info, &str, ' ') < 0)
 		goto err;
-	if (semanage_context_from_string(handle, str, &con) < 0)
+	if (semanage_context_from_string(handle, str, &con) < 0) {
+		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
+			str, info->filename, info->lineno, info->orig_line);
 		goto err;
+	}
 	if (con == NULL) {
 		ERR(handle, "<<none>> context is not valid for "
 			"interfaces (%s: %u)\n%s", info->filename, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-11-02 02:04:33.000000000 -0500
+++ new/libsemanage/src/parse_utils.c	2005-11-02 10:00:03.000000000 -0500
@@ -163,6 +163,9 @@ int parse_assert_space(
 	semanage_handle_t* handle, 
 	parse_info_t* info) {
 
+	if (parse_assert_noeof(handle, info) < 0)
+ 		return STATUS_ERR;
+
 	if (*(info->ptr) && !isspace(*(info->ptr))) {
 		ERR(handle, "missing whitespace (%s: %u):\n%s",
 			info->filename, info->lineno, info->orig_line);
@@ -217,7 +220,7 @@ int parse_assert_str(
 }
 
 int parse_optional_ch(parse_info_t* info, const char ch) {
-	if ((info->ptr) && (*(info->ptr) != ch))
+	if (info->ptr && (*(info->ptr) != ch))
 		return STATUS_NODATA;
 	else {
 		info->ptr++;
@@ -226,7 +229,7 @@ int parse_optional_ch(parse_info_t* info
 }
 
 int parse_optional_str(parse_info_t* info, const char* str) {
-	if (strncmp(info->ptr, str, strlen(str)))
+	if (info->ptr && strncmp(info->ptr, str, strlen(str)))
 		return STATUS_NODATA;
 	else {
 		info->ptr += strlen(str);
@@ -281,6 +284,9 @@ int parse_fetch_string(
 	int len = 0;
 	char* tmp_str = NULL;
 
+	if (parse_assert_noeof(handle, info) < 0)
+		goto err;
+
 	while (*(info->ptr) && !isspace(*(info->ptr)) &&
 	      (*(info->ptr) != delim)) {
 		info->ptr++;
@@ -291,17 +297,21 @@ int parse_fetch_string(
 		ERR(handle, "expected non-empty string, but did not "
 			"find one (%s: %u):\n%s", info->filename, info->lineno,
 			info->orig_line);
-		return STATUS_ERR;
+			goto err;
 	}
 
 	tmp_str = (char*) malloc(len + 1);
 	if (!tmp_str) {
-		ERR(handle, "out of memory, could not allocate string");
-		return STATUS_ERR;
+		ERR(handle, "out of memory");
+		goto err;
 	}
 
 	strncpy(tmp_str, start, len);
 	*(tmp_str + len)= '\0';
 	*str = tmp_str;
 	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not fetch string value");
+	return STATUS_ERR;
 } 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-11-02 02:32:30.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-11-02 10:10:03.000000000 -0500
@@ -75,8 +75,6 @@ static int port_parse(
 		goto err;
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 
 	/* Protocol */
 	if (parse_fetch_string(handle, info, &str, ' ') < 0)
@@ -96,21 +94,15 @@ static int port_parse(
 	/* Range/Port */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_fetch_int(handle, info, &low, '-') < 0)
 		goto err;
 
 	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_optional_ch(info, '-') != STATUS_NODATA) {
 
 		if (parse_skip_space(handle, info) < 0)
 			goto err;	
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
 		if (parse_fetch_int(handle, info, &high, ' ') < 0)
 			goto err;
 		semanage_port_set_range(port, low, high);
@@ -121,12 +113,13 @@ static int port_parse(
         /* Port context */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_fetch_string(handle, info, &str, ' ') < 0)
 		goto err;
-	if (semanage_context_from_string(handle, str, &con) < 0)
+	if (semanage_context_from_string(handle, str, &con) < 0) {
+		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
+			str, info->filename, info->lineno, info->orig_line);
 		goto err;
+	}
 	if (con == NULL) {
 		ERR(handle, "<<none>> context is not valid "
 			"for ports (%s: %u):\n%s", info->filename, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-11-02 02:04:33.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-11-02 10:03:07.000000000 -0500
@@ -65,14 +65,10 @@ static int seuser_parse(
 
 	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_assert_ch(handle, info, ':') < 0)
 		goto err;
 	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info)  < 0)
-		goto err;
 
 	/* Extract sename */
 	if (parse_fetch_string(handle, info, &str, ':') < 0)
@@ -85,14 +81,10 @@ static int seuser_parse(
 	if (is_selinux_mls_enabled()) {
 		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
 		if (parse_assert_ch(handle, info, ':') < 0)
 			goto err;
 		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(handle, info)  < 0)
-			goto err;
 
 		/* NOTE: does not allow spaces/multiline */
 		if (parse_fetch_string(handle, info, &str, ' ') < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-11-02 02:04:33.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-11-02 10:01:27.000000000 -0500
@@ -82,11 +82,8 @@ static int user_parse(
 	/* Parse user header */
 	if (parse_assert_str(handle, info, "user") < 0)
 		goto err;
-
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 
 	/* Parse user name */
 	if (parse_fetch_string(handle, info, &name_str, ' ') < 0)
@@ -100,14 +97,10 @@ static int user_parse(
 
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-                goto err;
 	if (parse_assert_str(handle, info, "roles") < 0)
 		goto err;
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 
 	islist = (parse_optional_ch(info,'{') != STATUS_NODATA);
 
@@ -145,12 +138,8 @@ static int user_parse(
 
 		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
-
 		if (parse_optional_ch(info,';') != STATUS_NODATA)
 			goto skip_semicolon;
-
 		if (parse_optional_ch(info,'}') != STATUS_NODATA)
 			islist =0;
 
@@ -162,14 +151,10 @@ static int user_parse(
 		/* Parse level header */
 		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
 		if (parse_optional_str(info, "level") == STATUS_NODATA)
 			goto semicolon;
 		if (parse_assert_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
 
 		/* NOTE: does not allow spaces/multiline */
 		if (parse_fetch_string(handle, info, &str, ' ') < 0)
@@ -186,8 +171,6 @@ static int user_parse(
 			goto err;
 		if (parse_assert_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
 
 		/* NOTE: does not allow spaces/multiline */
 		if (parse_fetch_string(handle, info, &str, ';') < 0)
@@ -203,8 +186,6 @@ static int user_parse(
 	semicolon:
 	if (parse_skip_space(handle, info) < 0)
 		goto err;
-	if (parse_assert_noeof(handle, info) < 0)
-		goto err;
 	if (parse_assert_ch(handle, info,';') < 0)
 		goto err;
 

--------------090806060305070308060802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
