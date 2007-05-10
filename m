Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l4AKC2ua016184
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 16:12:02 -0400
Subject: [RFC][PATCH] libselinux: Namespacing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 10 May 2007 16:12:02 -0400
Message-Id: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

libselinux presently lacks proper namespacing of its functions.  This
patch is just for comment on an approach to gradually fixing that
problem, starting with just a trivial example for a single function.
The idea is to switch over the real function to being properly
namespaced, provide an alias under the old name in the symbol table for
binary compatibility, and make the old name a macro in the public
headers that expands to the new name so that source rebuilds against the
new library will start using the new name.  Then at some point in the
future, we drop the old name macro from the source API, forcing an
update to external sources to build against newer headers, while leaving
the alias present in the symbol table as long as we need compatibility
with existing binaries.  Thoughts?

Index: policyrep/libselinux/include/selinux/selinux.h
===================================================================
--- policyrep/libselinux/include/selinux/selinux.h	(revision 2435)
+++ policyrep/libselinux/include/selinux/selinux.h	(working copy)
@@ -16,7 +16,8 @@
 	typedef char *security_context_t;
 
 /* Free the memory allocated for a context by any of the below get* calls. */
-	extern void freecon(security_context_t con);
+	extern void selinux_freecon(security_context_t con);
+#define freecon(c) selinux_freecon(c)
 
 /* Free the memory allocated for a context array by security_compute_user. */
 	extern void freeconary(security_context_t * con);
Index: policyrep/libselinux/src/freecon.c
===================================================================
--- policyrep/libselinux/src/freecon.c	(revision 2435)
+++ policyrep/libselinux/src/freecon.c	(working copy)
@@ -3,9 +3,12 @@
 #include <stdlib.h>
 #include <errno.h>
 
-void freecon(security_context_t con)
+void selinux_freecon(security_context_t con)
 {
 	free(con);
 }
 
-hidden_def(freecon)
+asm(".symver selinux_freecon, freecon@@");
+
+hidden_def(selinux_freecon)
+
Index: policyrep/libselinux/src/selinux_internal.h
===================================================================
--- policyrep/libselinux/src/selinux_internal.h	(revision 2435)
+++ policyrep/libselinux/src/selinux_internal.h	(working copy)
@@ -24,7 +24,7 @@
     hidden_proto(security_compute_relabel_raw)
     hidden_proto(is_selinux_enabled)
     hidden_proto(is_selinux_mls_enabled)
-    hidden_proto(freecon)
+    hidden_proto(selinux_freecon)
     hidden_proto(freeconary)
     hidden_proto(getprevcon)
     hidden_proto(getprevcon_raw)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
