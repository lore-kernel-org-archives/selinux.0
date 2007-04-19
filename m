Subject: [PATCH -trunk][RFC] setsebool: only use libsemanage for persistent
	boolean changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 14:36:04 -0400
Message-Id: <1177007764.27654.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While the optimizations I introduced for libsemanage helped somewhat in reducing the
extraneous work done by setsebool for transient boolean changes, there were still a lot
of files that were unnecessarily created or modified due to the entire transactional model of
libsemanage, and I couldn't see a clean way of fixing that.  In retrospect, while libsemanage
needs to understand active booleans in order to affect persistent changes (due to boolean
preservation on reloads), setsebool should just apply active boolean changes directly via libselinux.
And with the dropped setlocaldefs support, we can require managed policy for persistent boolean
changes.

Change setsebool to only use libsemanage for persistent boolean changes.
Temporal/transient boolean changes are directly performed via libselinux.
Persistent boolean changes for unmanaged policy are no longer supported
due to the dropped setlocaldefs support.

---

 policycoreutils/setsebool/setsebool.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)


Index: trunk/policycoreutils/setsebool/setsebool.c
===================================================================
--- trunk/policycoreutils/setsebool/setsebool.c	(revision 2356)
+++ trunk/policycoreutils/setsebool/setsebool.c	(working copy)
@@ -73,12 +73,12 @@
 	return rc;
 }
 
-/* Apply boolean changes to policy via libselinux */
+/* Apply temporal boolean changes to policy via libselinux */
 static int selinux_set_boolean_list(size_t boolcnt,
-				    SELboolean * boollist, int perm)
+				    SELboolean * boollist)
 {
 
-	if (security_set_boolean_list(boolcnt, boollist, perm)) {
+	if (security_set_boolean_list(boolcnt, boollist, 0)) {
 		if (errno == ENOENT)
 			fprintf(stderr, "Could not change active booleans: "
 				"Invalid boolean\n");
@@ -91,9 +91,9 @@
 	return 0;
 }
 
-/* Apply (permanent) boolean changes to policy via libsemanage */
+/* Apply permanent boolean changes to policy via libsemanage */
 static int semanage_set_boolean_list(size_t boolcnt,
-				     SELboolean * boollist, int perm)
+				     SELboolean * boollist)
 {
 
 	size_t j;
@@ -115,9 +115,9 @@
 		goto err;
 
 	} else if (managed == 0) {
-		if (selinux_set_boolean_list(boolcnt, boollist, perm) < 0)
-			goto err;
-		goto out;
+		fprintf(stderr,
+			"Cannot set persistent booleans without managed policy.\n");
+		goto err;
 	}
 
 	if (semanage_connect(handle) < 0)
@@ -140,8 +140,7 @@
 		if (semanage_bool_key_extract(handle, boolean, &bool_key) < 0)
 			goto err;
 
-		if (perm
-		    && semanage_bool_modify_local(handle, bool_key,
+		if (semanage_bool_modify_local(handle, bool_key,
 						  boolean) < 0)
 			goto err;
 
@@ -224,8 +223,13 @@
 		*value_ptr = '=';
 	}
 
-	if (semanage_set_boolean_list(boolcnt, vallist, permanent) < 0)
-		goto err;
+	if (permanent) {
+		if (semanage_set_boolean_list(boolcnt, vallist) < 0)
+			goto err;
+	} else {
+		if (selinux_set_boolean_list(boolcnt, vallist) < 0)
+			goto err;
+	}
 
 	/* Now log what was done */
 	pwd = getpwuid(getuid());

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
