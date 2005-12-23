Message-ID: <43AC8C90.20702@cornell.edu>
Date: Fri, 23 Dec 2005 18:47:28 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SETSEBOOL] Apply active booleans through libsemanage
Content-Type: multipart/mixed;
 boundary="------------030405080404080401080604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030405080404080401080604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch changes setsebool to apply active booleans via 
libsemanage. Libselinux is now only used in the fallback (non-managed) 
case... otherwise I could change setsebool not to use SELboolean as an 
intermediary structure, and to use semanage_bool_t directly.





--------------030405080404080401080604
Content-Type: text/x-patch;
 name="setsebool2.active_libsemanage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setsebool2.active_libsemanage.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/setsebool/setsebool.c new/policycoreutils/setsebool/setsebool.c
--- old/policycoreutils/setsebool/setsebool.c	2005-12-23 18:24:55.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.c	2005-12-23 18:41:12.000000000 -0500
@@ -10,6 +10,7 @@
 #include <selinux/selinux.h>
 #include <semanage/handle.h>
 #include <semanage/booleans_local.h>
+#include <semanage/booleans_active.h>
 #include <semanage/boolean_record.h>
 #include <errno.h>
 
@@ -95,11 +96,13 @@ static int selinux_set_boolean_list(
 /* Apply (permanent) boolean changes to policy via libsemanage */
 static int semanage_set_boolean_list(
 	size_t boolcnt, 
-	SELboolean *boollist) {
+	SELboolean *boollist,
+	int permanent) {
 
 	size_t j;
 	semanage_handle_t* handle = NULL;
 	semanage_bool_t* boolean = NULL;
+	semanage_bool_t* boolean2 = NULL;
 	semanage_bool_key_t* bool_key = NULL;
 	int managed;
 
@@ -139,7 +142,16 @@ static int semanage_set_boolean_list(
 		if (semanage_bool_key_extract(handle, boolean, &bool_key) < 0)
 			goto err;
 
-		if (semanage_bool_modify_local(handle, bool_key, boolean) < 0)
+		if (permanent) {
+			if (semanage_bool_clone(handle, boolean, &boolean2) < 0)
+				goto err;
+
+			if (semanage_bool_modify_local(handle, bool_key, boolean2) < 0)
+				goto err;
+			boolean2 = NULL;
+		} 
+
+		if (semanage_bool_set_active(handle, bool_key, boolean) < 0)
 			goto err;
 
 		semanage_bool_key_free(bool_key);
@@ -153,9 +165,6 @@ static int semanage_set_boolean_list(
 
 	semanage_disconnect(handle);
 
-	if (selinux_set_boolean_list(boolcnt, boollist, 0))
-		goto err;
-
         out:
 	semanage_handle_destroy(handle);
 	return 0;
@@ -163,6 +172,7 @@ static int semanage_set_boolean_list(
 	err:
 	semanage_bool_key_free(bool_key);
 	semanage_bool_free(boolean);
+	semanage_bool_free(boolean2);
 	semanage_handle_destroy(handle);
 	fprintf(stderr, "Could not change policy booleans\n");
 	return -1;
@@ -217,14 +227,8 @@ int setbool(char **list, size_t start, s
 		*value_ptr = '=';
 	} 
 
-	if (permanent) {
-		if (semanage_set_boolean_list(boolcnt, vallist) < 0)
-			goto err;
-
-	} else {
-		if (selinux_set_boolean_list(boolcnt, vallist, 0) < 0)
-			goto err;
-	}
+	if (semanage_set_boolean_list(boolcnt, vallist, permanent) < 0)
+		goto err;
 
 	/* Now log what was done */
 	pwd = getpwuid(getuid());

--------------030405080404080401080604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
