Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03IvdXf022736
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 13:57:39 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03Iuaqa022042
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 18:56:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EFB8B61B04
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:57:34 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20080-02 for <selinux@tycho.nsa.gov>;
	Wed, 4 Jan 2006 05:57:34 +1100 (EST)
Received: from temp.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3A7EA61B01
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:57:34 +1100 (EST)
Received: from temp (temp [127.0.0.1])
	by temp.coker.com.au (Postfix) with ESMTP id 3B1E1C7F9A
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:57:33 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: libsemanage performance patch
Date: Wed, 4 Jan 2006 05:57:20 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cksuDkit569yEt/"
Message-Id: <200601040557.32435.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_cksuDkit569yEt/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Optimised string and FILE * operations in libsemanage.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_cksuDkit569yEt/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="libsemanage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="libsemanage.diff"

diff -rup libsemanage-1.5.3/src.orig/database_file.c libsemanage-1.5.3/src/database_file.c
--- libsemanage-1.5.3/src.orig/database_file.c	2005-12-15 06:16:51.000000000 +1100
+++ libsemanage-1.5.3/src/database_file.c	2006-01-01 18:50:36.000000000 +1100
@@ -7,6 +7,8 @@ typedef struct dbase_file dbase_t;
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <stdio.h>
+#include <stdio_ext.h>
 #include "debug.h"
 #include "handle.h"
 #include "parse_utils.h"
@@ -202,6 +204,7 @@ static int dbase_file_flush(
 			fname, strerror(errno));
 		goto err;
 	}
+	__fsetlocking(str, FSETLOCKING_BYCALLER);
 
 	for (ptr = dbase->cache_tail; ptr != NULL; ptr = ptr->prev) {
 		if (dbase->rftable->print(handle, ptr->data, str) < 0)
diff -rup libsemanage-1.5.3/src.orig/database_policydb.c libsemanage-1.5.3/src/database_policydb.c
--- libsemanage-1.5.3/src.orig/database_policydb.c	2005-12-15 06:16:51.000000000 +1100
+++ libsemanage-1.5.3/src/database_policydb.c	2006-01-01 19:25:18.000000000 +1100
@@ -7,6 +7,7 @@ typedef struct dbase_policydb dbase_t;
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <errno.h>
 
 #include <sepol/policydb.h>
@@ -87,6 +88,7 @@ static int dbase_policydb_cache(
 	
 	/* If the file was opened successfully, read a policydb */
 	if (fp != NULL) {
+		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		if (sepol_policy_file_create(&pf) < 0) {
 			ERR(handle, "could not create policy file object");
 			goto err;
diff -rup libsemanage-1.5.3/src.orig/direct_api.c libsemanage-1.5.3/src/direct_api.c
--- libsemanage-1.5.3/src.orig/direct_api.c	2005-12-15 06:16:51.000000000 +1100
+++ libsemanage-1.5.3/src/direct_api.c	2006-01-01 18:06:17.000000000 +1100
@@ -24,6 +24,7 @@
 #include <assert.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -305,6 +306,7 @@ static int semanage_write_module(semanag
 		ERR(sh, "Could not open %s for writing.", filename);
 		return -1;
 	}
+	__fsetlocking(outfile, FSETLOCKING_BYCALLER);
 	sepol_policy_file_set_fp(pf, outfile);
 	sepol_policy_file_set_handle(pf, sh->sepolh);
 	retval = sepol_module_package_write(package, pf);
@@ -575,6 +577,7 @@ static int semanage_direct_list(semanage
 			 * report it */
 			continue;
 		}
+		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		sepol_policy_file_set_fp(pf, fp);
 		if (sepol_module_package_info(pf, &type, &name, &version)) {
 			fclose(fp);
diff -rup libsemanage-1.5.3/src.orig/parse_utils.c libsemanage-1.5.3/src/parse_utils.c
--- libsemanage-1.5.3/src.orig/parse_utils.c	2005-12-15 06:16:51.000000000 +1100
+++ libsemanage-1.5.3/src/parse_utils.c	2006-01-02 19:24:13.000000000 +1100
@@ -86,7 +86,8 @@ int parse_skip_space(
 	semanage_handle_t* handle, 
 	parse_info_t* info) {
 
-	size_t len = 0;
+	size_t buf_len = 0;
+	ssize_t len;
 	int lineno = info->lineno;
 	char* buffer = NULL;
 	char* ptr;
@@ -102,12 +103,11 @@ int parse_skip_space(
 	parse_dispose_line(info);
 
 	while (info->file_stream &&
-		(getline(&buffer, &len, info->file_stream) > 0)) {
+		((len = getline(&buffer, &buf_len, info->file_stream)) > 0)) {
 
 		lineno++;
 
 		/* Eat newline, preceding whitespace */
-		len = strlen(buffer);
 		if (buffer[len - 1] == '\n')
 			buffer[len - 1] = '\0';
 
@@ -116,10 +116,7 @@ int parse_skip_space(
 			ptr++;
 
 		/* Skip comments and blank lines */
-		if (!(*ptr) || *ptr == '#')
-			goto next;
-
-		else {
+		if ((*ptr) && *ptr != '#') {
 			char* tmp = strdup(buffer);
 			if (!tmp)
 				goto omem;
@@ -131,10 +128,6 @@ int parse_skip_space(
 
 			return STATUS_SUCCESS;
 		}
-
-		next:
-		free(buffer);
-		buffer = NULL;
 	}
 
 	free(buffer);
@@ -206,10 +199,12 @@ int parse_assert_str(
 	parse_info_t* info, 
 	const char* assert_str) {
 
+	size_t len = strlen(assert_str);
+
 	if (parse_assert_noeof(handle, info) < 0)
 		return STATUS_ERR;
 
-	if (strncmp(info->ptr, assert_str, strlen(assert_str))) {
+	if (strncmp(info->ptr, assert_str, len)) {
 		ERR(handle, "experted string \"%s\", but found \"%s\" "
 			"(%s: %u):\n%s", assert_str, info->ptr, 
 			info->filename, info->lineno, info->orig_line);
@@ -217,7 +212,7 @@ int parse_assert_str(
 		return STATUS_ERR;
 	}
 
-	info->ptr += strlen(assert_str);
+	info->ptr += len;
 	return STATUS_SUCCESS;
 }
 
@@ -231,10 +226,12 @@ int parse_optional_ch(parse_info_t* info
 }
 
 int parse_optional_str(parse_info_t* info, const char* str) {
-	if (info->ptr && strncmp(info->ptr, str, strlen(str)))
+	size_t len = strlen(str);
+
+	if (info->ptr && strncmp(info->ptr, str, len))
 		return STATUS_NODATA;
 	else {
-		info->ptr += strlen(str);
+		info->ptr += len;
 		return STATUS_SUCCESS;
 	}
 }
diff -rup libsemanage-1.5.3/src.orig/semanage_store.c libsemanage-1.5.3/src/semanage_store.c
--- libsemanage-1.5.3/src.orig/semanage_store.c	2005-12-15 06:16:51.000000000 +1100
+++ libsemanage-1.5.3/src/semanage_store.c	2006-01-02 19:18:57.000000000 +1100
@@ -44,6 +44,7 @@ typedef struct dbase_policydb dbase_t;
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -287,16 +288,9 @@ int semanage_create_store(semanage_handl
 
 /* Callback used by scandir() to select files. */
 static int semanage_filename_select(const struct dirent *d) {
-	int len;
-
-	/* For some reason XFS doesn't set d_type so we actually have
-	 * to use stat() to decide if it's a directory or not :(
-	 */
-	len = strlen(d->d_name);
-	if (len == 1 && d->d_name[0] == '.')
-		return 0;
-	if (len == 2 && d->d_name[0] == '.' &&
-	    d->d_name[1] == '.')
+	if (d->d_name[0] == '.'
+		  && (d->d_name[1] == '\0'
+		   || (d->d_name[1] == '.' && d->d_name[2] == '\0')))
 		return 0;
 	return 1;
 }
@@ -831,9 +825,9 @@ int semanage_split_fc(semanage_handle_t 
 		return -1;
 	}
 
-	while (fgets(buf, PATH_MAX, file_con)) {
-		if (strstr(buf, "HOME_DIR") ||
-		    strstr(buf, "HOME_ROOT") ||
+	while (fgets_unlocked(buf, PATH_MAX, file_con)) {
+		if (strncmp(buf, "HOME_DIR", 8) ||
+		    strncmp(buf, "HOME_ROOT", 9) ||
 		    strstr(buf, "ROLE")) {
 			/* This contains one of the template variables, write it to homedir.template */
 			if (write(hd, buf, strnlen(buf, PATH_MAX)) == 0) {
@@ -1267,6 +1261,7 @@ static int semanage_load_module(semanage
 		ERR(sh, "Could not open module file %s for reading.", filename);
 		goto cleanup;
 	}
+	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 	sepol_policy_file_set_fp(pf, fp);
 	sepol_policy_file_set_handle(pf, sh->sepolh);
 	if (sepol_module_package_read(*package, pf, 0) == -1) {
@@ -1402,6 +1397,7 @@ int semanage_expand_sandbox(semanage_han
  		ERR(sh, "Could not open kernel policy %s for writing.", kernel_filename);
 		goto cleanup;
 	}
+	__fsetlocking(outfile, FSETLOCKING_BYCALLER);
 	if (sepol_policy_file_create(&pf)) {
  		ERR(sh, "Out of memory!");
 		goto cleanup;

--Boundary-00=_cksuDkit569yEt/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
