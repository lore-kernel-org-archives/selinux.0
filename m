Subject: [PATCH -trunk][RFC] libsemanage: some optimizations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 14:27:28 -0400
Message-Id: <1177007248.27654.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From the earlier discussion of why setsebool was doing so much work even when
only setting active booleans, I experimented with the two optimizations below.
I have since concluded that setsebool should not use semanage at all for non-persistent
boolean changes (see next patch), but I still think these may be helpful in reducing
extraneous work there.

Two optimizations for libsemanage:
- do not set all booleans upon commit, only those whose values have changed,
- only install the sandbox upon commit if something was rebuilt

---

 libsemanage/src/booleans_activedb.c |   17 +++++++++++++----
 libsemanage/src/direct_api.c        |    4 +++-
 2 files changed, 16 insertions(+), 5 deletions(-)


Index: trunk/libsemanage/src/booleans_activedb.c
===================================================================
--- trunk/libsemanage/src/booleans_activedb.c	(revision 2356)
+++ trunk/libsemanage/src/booleans_activedb.c	(working copy)
@@ -92,8 +92,10 @@
 {
 
 	SELboolean *blist = NULL;
+	const char *name;
 	unsigned int bcount = 0;
 	unsigned int i;
+	int curvalue, newvalue;
 
 	/* Allocate a sufficiently large array */
 	blist = malloc(sizeof(SELboolean) * count);
@@ -102,11 +104,18 @@
 
 	/* Populate array */
 	for (i = 0; i < count; i++) {
-		blist[i].name = strdup(semanage_bool_get_name(booleans[i]));
+		name = semanage_bool_get_name(booleans[i]);
+		if (!name)
+			goto omem;	
+		newvalue = semanage_bool_get_value(booleans[i]);
+		curvalue = security_get_boolean_active(name);
+		if (newvalue == curvalue)
+			continue;
+		blist[bcount].name = strdup(name);
+		if (blist[bcount].name == NULL)
+			goto omem;
+		blist[bcount].value = newvalue;
 		bcount++;
-		if (blist[i].name == NULL)
-			goto omem;
-		blist[i].value = semanage_bool_get_value(booleans[i]);
 	}
 
 	/* Commit */
Index: trunk/libsemanage/src/direct_api.c
===================================================================
--- trunk/libsemanage/src/direct_api.c	(revision 2356)
+++ trunk/libsemanage/src/direct_api.c	(working copy)
@@ -699,7 +699,9 @@
 	if (retval < 0)
 		goto cleanup;
 
-	retval = semanage_install_sandbox(sh);
+	if (sh->do_rebuild || modified) {
+		retval = semanage_install_sandbox(sh);
+	}
 
       cleanup:
 	for (i = 0; mod_filenames != NULL && i < num_modfiles; i++) {

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
