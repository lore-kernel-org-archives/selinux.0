Subject: Re: [patch] libsemanage, semodule:  Improve error reporting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1190226580.25863.82.camel@moss-spartans.epoch.ncsc.mil>
References: <1190226580.25863.82.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 16:48:58 -0400
Message-Id: <1190234938.25863.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A follow-up patch based on some more testing of the first one, applies
on top.

Clear errno in several locations when we are ignoring a non-fatal
error in libsemanage, so that we do not end up reporting it upon
a later ERR() call for another reason.

---

 src/direct_api.c     |    1 +
 src/semanage_store.c |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

Index: libsemanage/src/direct_api.c
===================================================================
--- libsemanage/src/direct_api.c	(revision 2572)
+++ libsemanage/src/direct_api.c	(working copy)
@@ -540,6 +540,7 @@
 			 * checking is done because this is likely to fail because
 			 * the file does not exist - which is not an error. */
 			unlink(linked_filename);
+			errno = 0;
 		}
 
 		/* ==================== File-backed ================== */
Index: libsemanage/src/semanage_store.c
===================================================================
--- libsemanage/src/semanage_store.c	(revision 2572)
+++ libsemanage/src/semanage_store.c	(working copy)
@@ -574,6 +574,7 @@
 			ERR(sh, "Error scanning directory %s.", sandbox);
 			return -1;
 		}
+		errno = 0;
 	} else {
 		/* remove the old sandbox */
 		if (semanage_remove_directory(sandbox) != 0) {
@@ -1096,6 +1097,7 @@
 		    store_fc_loc);
 		goto cleanup;
 	}
+	errno = 0;
 
 	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
 	if (semanage_copy_file
@@ -1105,6 +1107,7 @@
 		    store_seusers);
 		goto cleanup;
 	}
+	errno = 0;
 
 	snprintf(store_nc, PATH_MAX, "%s%s", storepath, running_nc);
 	if (semanage_copy_file(active_nc, store_nc, sh->conf->file_mode) == -1
@@ -1112,6 +1115,7 @@
 		ERR(sh, "Could not copy %s to %s.", active_nc, store_nc);
 		goto cleanup;
 	}
+	errno = 0;
 
 	if (!sh->do_reload)
 		goto skip_reload;
@@ -1133,8 +1137,10 @@
 			goto skip_reload;
 		}
 	} else if (errno == ENOENT &&
-		   strcmp(really_active_store, storepath) != 0)
+		   strcmp(really_active_store, storepath) != 0) {
+		errno = 0;
 		goto skip_reload;
+	}
 
 	if (semanage_reload_policy(sh)) {
 		goto cleanup;
@@ -1470,6 +1476,7 @@
 		if (errno == ENOENT) {
 			/* the commit number file does not exist yet,
 			 * so assume that the number is 0 */
+			errno = 0;
 			return 0;
 		} else {
 			ERR(sh, "Could not open commit number file %s.",

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
