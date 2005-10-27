Message-ID: <4360F1DF.2030103@cornell.edu>
Date: Thu, 27 Oct 2005 11:27:27 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: "Ivan Gyurdiev <ivg2@cornell.edu>" <selinux@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>, Chad Sellers <csellers@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [ SEMANAGE ] Implement dbase_file_set, fix memleak
References: <43601468.60508@cornell.edu> <4360E189.2010304@tresys.com> <4360E87D.6030504@cornell.edu> <4360E94D.7040101@cornell.edu> <4360EACD.80008@cornell.edu> <4360EE32.9040706@cornell.edu>
In-Reply-To: <4360EE32.9040706@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------080300070001070305030601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080300070001070305030601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

... (back on-list)
>
> Conclusion:
> - should be safe to uncomment all the code (in theory :)
Here... (but the other things mentioned still need to be addressed).

Changes:
- enable some things for testing: semanage users, seusers, booleans.





--------------080300070001070305030601
Content-Type: text/x-patch;
 name="libsemanage.enable_dbase1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.enable_dbase1.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/include/semanage/semanage.h new/libsemanage/include/semanage/semanage.h
--- old/libsemanage/include/semanage/semanage.h	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/include/semanage/semanage.h	2005-10-27 11:18:46.000000000 -0400
@@ -25,4 +25,26 @@
 #include <semanage/modules.h>
 #include <semanage/debug.h>
 
+/* Records */
+#include <semanage/boolean_record.h>
+#include <semanage/user_record.h>
+#include <semanage/seuser_record.h>
+#if 0
+#include <semanage/iface_record.h>
+#include <semanage/port_record.h>
+#endif
+
+/* Dbase */
+#include <semanage/booleans_local.h>
+#include <semanage/booleans_policy.h>
+#include <semanage/users_local.h>
+#include <semanage/users_policy.h>
+#include <semanage/seusers.h>
+#if 0
+#include <semanage/ports_local.h>
+#include <semanage/ports_policy.h>
+#include <semanage/interfaces_local.h>
+#include <semanage/interfaces_policy.h>
+#endif
+
 #endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-27 10:49:39.000000000 -0400
@@ -349,11 +349,9 @@ static int semanage_direct_commit(semana
 	if (semanage_verify_kernel(sh) != 0)
 		goto cleanup;
 
-#if 0
 	/* Commit changes to components */
 	if (semanage_commit_components(sh) < 0)
 		goto cleanup;
-#endif
 
 	retval = semanage_install_sandbox(sh);
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/libsemanage.map	2005-10-27 11:22:53.000000000 -0400
@@ -9,5 +9,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload;
+	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
   local: *;
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/src/semanage_store.c	2005-10-25 22:06:48.000000000 -0400
@@ -1351,7 +1351,6 @@ int semanage_expand_sandbox(semanage_han
 		goto cleanup;
 	}
 
-#if 0
 	dbase_policydb_attach(sh, semanage_user_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(sh, semanage_port_dbase_policy(sh)->dbase, out);
 	dbase_policydb_attach(sh, semanage_iface_dbase_policy(sh)->dbase, out);
@@ -1368,7 +1367,6 @@ int semanage_expand_sandbox(semanage_han
 		ERR(sh, "Unable to merge local modifications into policy.");
 		goto cleanup;
 	}
-#endif
 
 	if ((kernel_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;

--------------080300070001070305030601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
