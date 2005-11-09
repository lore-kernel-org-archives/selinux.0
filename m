Message-ID: <437181BA.6000806@cornell.edu>
Date: Tue, 08 Nov 2005 23:57:30 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SETSEBOOL ] Cleanup patch
Content-Type: multipart/mixed;
 boundary="------------060306050402030408000307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060306050402030408000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Error handling is different for libselinux interaction depending on -P. 
Fix that by adding a new helper function. Also add a newline and change 
some error messages. Recover the handle.h header #include (I don't think 
we should rely on the boolean headers to include it).






--------------060306050402030408000307
Content-Type: text/x-patch;
 name="setsebool.cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setsebool.cleanup.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/policycoreutils/setsebool/setsebool.c new/policycoreutils/setsebool/setsebool.c
--- old/policycoreutils/setsebool/setsebool.c	2005-11-08 23:11:21.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.c	2005-11-08 23:37:34.000000000 -0500
@@ -8,6 +8,7 @@
 #include <syslog.h>
 #include <pwd.h>
 #include <selinux/selinux.h>
+#include <semanage/handle.h>
 #include <semanage/booleans_local.h>
 #include <semanage/boolean_record.h>
 #include <errno.h>
@@ -72,8 +73,29 @@ int main(int argc, char **argv)
 	return rc;
 }
 
-/* Helper function: applies permanent changes to policy via libsemanage */
-int semanage_set_boolean_list(size_t boolcnt, SELboolean *boollist) {
+/* Apply boolean changes to policy via libselinux */
+static int selinux_set_boolean_list(
+	size_t boolcnt, 
+	SELboolean *boollist, 
+	int permanent) {
+
+	if (security_set_boolean_list(boolcnt, boollist, permanent)) {
+		if (errno == ENOENT)
+			fprintf(stderr, "Could not change active booleans: "
+				"Invalid boolean\n");
+		else if (errno)
+			perror("Could not change active booleans");
+	
+		return -1;
+	}
+	
+	return 0;
+}
+
+/* Apply (permanent) boolean changes to policy via libsemanage */
+static int semanage_set_boolean_list(
+	size_t boolcnt, 
+	SELboolean *boollist) {
 
 	size_t j;
 	semanage_handle_t* handle = NULL;
@@ -91,15 +113,10 @@ int semanage_set_boolean_list(size_t boo
 	if (managed < 0) {
 		fprintf(stderr, "Error when checking whether policy is managed\n"); 
 		goto err;
+
 	} else if (managed == 0) {
-		if (security_set_boolean_list(boolcnt, boollist, 1)) {
-			if (errno == ENOENT) 
-				fprintf(stderr, "Error setting boolean: "
-					"Invalid boolean\n");
-			else if (errno)
-				perror("Error setting booleans");
+		if (selinux_set_boolean_list(boolcnt, boollist, 1) < 0)
 			goto err;
-		}
 		goto out;
 	}
 
@@ -136,7 +153,7 @@ int semanage_set_boolean_list(size_t boo
 
 	semanage_disconnect(handle);
 
-	if (security_set_boolean_list(boolcnt, boollist, 0))
+	if (selinux_set_boolean_list(boolcnt, boollist, 0))
 		goto err;
 
         out:
@@ -147,7 +164,7 @@ int semanage_set_boolean_list(size_t boo
 	semanage_bool_key_free(bool_key);
 	semanage_bool_free(boolean);
 	semanage_handle_destroy(handle);
-	fprintf(stderr, "Could not apply permanent policy change");
+	fprintf(stderr, "Could not change policy booleans\n");
 	return -1;
 }
 
@@ -213,15 +230,8 @@ int setbool(char **list, size_t start, s
 			goto err;
 
 	} else {
-		if (security_set_boolean_list(boolcnt, vallist, 0)) {
-			if (errno == ENOENT) 
-				fprintf(stderr, "Error setting boolean: "
-					"Invalid boolean\n");
-			else if (errno)
-				perror("Error setting booleans");
-
-			goto err;			
-		}
+		if (selinux_set_boolean_list(boolcnt, vallist, 0) < 0)
+			goto err;
 	}
 
 	/* Now log what was done */

--------------060306050402030408000307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
