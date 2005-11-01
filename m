Message-ID: <4366EE1B.1060303@cornell.edu>
Date: Mon, 31 Oct 2005 23:24:59 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Fix MLS parsing of users
Content-Type: multipart/mixed;
 boundary="------------030709080009040506080205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030709080009040506080205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Okay, I hadn't really tested MLS users very well. This patch corrects 
that oversight, and makes commit() pass on an MLS/MCS enabled system.

Changes:

- parse_filter_space_until is hopelessly broken - there's at least 2 
segfault bugs in it - delete the whole function, and handle MLS for 
users the same way I handle it for seusers - disallow multiline and 
spaces. This whole approach of looking for the "range" substring at the 
end is wrong in the first place, and genusers shouldn't be using it. 
Maybe I'll implement this properly in the future, but right now it 
doesn't seem too important - will keep MLS without spaces on a single line.

- the check whether "level" is present is backwards - fix it





--------------030709080009040506080205
Content-Type: text/x-patch;
 name="libsepol.fix_mls_users.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.fix_mls_users.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-10-31 22:31:55.000000000 -0500
+++ new/libsemanage/src/parse_utils.c	2005-10-31 23:04:25.000000000 -0500
@@ -151,7 +151,8 @@ int parse_assert_noeof(
 	parse_info_t* info) {
 
 	if (!info->ptr) {
-		ERR(handle, "unexpected end of file");
+		ERR(handle, "unexpected end of file (%s: %u)",
+			info->filename, info->lineno);
 		return STATUS_ERR;
 	}
 
@@ -233,59 +234,6 @@ int parse_optional_str(parse_info_t* inf
 	}
 }
 
-char* parse_filter_space_until(
-	semanage_handle_t* handle, 
-	parse_info_t* info, 
-	const char* substr) {
-
-	char* buffer = NULL, *wr, *tmp;
-	int len = strlen(substr);
-	int used = 0;
-	int csize = 0;
-
-	wr = buffer;
-	do {
-		/* If content is not a space, copy to buffer */
-		if (!isspace(info->ptr)) {
-
-			/* If we're out of space, increase by 15 */
-			if (used + 1 >= csize) {
-				csize += 15;
-				tmp = realloc(buffer, csize);
-				if (!tmp)
-					goto omem;
-				buffer = tmp;
-			}
-			*wr++ = *info->ptr;
-			used++;
-		}
-		info->ptr++;
-
-		if (parse_skip_space(handle, info) < 0)
-			goto err;
-		if (parse_assert_noeof(handle, info) < 0)
-			goto err;
-
-	} while(!strncasecmp(info->ptr, substr, len));
-
-	if (!buffer) {
-		buffer = malloc(1);
-		if (!buffer)
-			goto omem;
-	}
-
-	*wr = '\0';
-
-	return buffer;
-
-	omem:
-	ERR(handle, "out of memory, could not allocate buffer");
-
-	err:
-	free(buffer);
-	return NULL;
-}
-
 int parse_fetch_string(
 	semanage_handle_t* handle,
 	parse_info_t* info, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.h new/libsemanage/src/parse_utils.h
--- old/libsemanage/src/parse_utils.h	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/parse_utils.h	2005-10-31 22:53:40.000000000 -0500
@@ -83,15 +83,6 @@ extern int parse_optional_str(
 	parse_info_t* info, 
 	const char* str);
 
-/* Buffer a string, filtering all 
- * whitespace, until substring is encountered,
- * at which point return the buffered string.
- * This function will work on multiple lines */
-extern char* parse_filter_space_until(
-	semanage_handle_t* handle,
-	parse_info_t* info,
-	const char* substr);
-
 /* Extract the next string (delimited by 
  * whitespace), and move the read pointer past it */
 extern int parse_fetch_string(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/users_file.c new/libsemanage/src/users_file.c
--- old/libsemanage/src/users_file.c	2005-10-31 22:31:56.000000000 -0500
+++ new/libsemanage/src/users_file.c	2005-10-31 23:04:38.000000000 -0500
@@ -70,7 +70,7 @@ static int user_parse(
 	semanage_user_t* user) {
 
 	int islist = 0;
-	char* mls = NULL;
+	char* str = NULL;
 	char* start;
 	char* name_str = NULL;
 
@@ -164,35 +164,39 @@ static int user_parse(
 			goto err;
 		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
-		if (parse_optional_str(info, "level") != STATUS_NODATA)
+		if (parse_optional_str(info, "level") == STATUS_NODATA)
 			goto semicolon;
 		if (parse_assert_space(handle, info) < 0)
 			goto err;
 		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 
-		mls = parse_filter_space_until(handle, info, "range");
-		if (!mls)
+		/* NOTE: does not allow spaces/multiline */
+		if (parse_fetch_string(handle, info, &str) < 0)
 			goto err;
-		if (semanage_user_set_mlslevel(handle, user, mls) < 0)
+		if (semanage_user_set_mlslevel(handle, user, str) < 0)
 			goto err;
-		free(mls);
+		free(str);
+		str = NULL;
 
 		/* Parse range header */
+		if (parse_assert_space(handle, info) < 0)
+			goto err;
 		if (parse_assert_str(handle, info, "range") < 0)
-                       goto err;
-
+			goto err;
 		if (parse_assert_space(handle, info) < 0)
 			goto err;
 		if (parse_assert_noeof(handle, info) < 0)
 			goto err;
 
-		mls = parse_filter_space_until(handle, info, ";");
-		if (!mls)
+		/* NOTE: does not allow spaces/multiline */
+		if (parse_fetch_string_until(handle, info, &str, ';') < 0)
 			goto err;
-		if (semanage_user_set_mlsrange(handle, user, mls) < 0)
+		if (semanage_user_set_mlsrange(handle, user, str) < 0)
 			goto err;
-		free(mls);
+
+		free(str);
+		str = NULL;
 	}
 
 	/* Check for semicolon */
@@ -213,7 +217,7 @@ static int user_parse(
 
 	err:
 	ERR(handle, "could not parse user record");
-	free(mls);
+	free(str);
 	parse_dispose_line(info);
 	return STATUS_ERR;
 }

--------------030709080009040506080205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
