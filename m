Message-ID: <43CD6266.9060709@cornell.edu>
Date: Tue, 17 Jan 2006 14:32:22 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Only do read locking in direct case
Content-Type: multipart/mixed;
 boundary="------------030505000100060407030709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030505000100060407030709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pserver shouldn't do locking, and it will go through those same 
functions....
Pserver does locking on the server side, where the resource to be locked 
is located, not on the client side.




--------------030505000100060407030709
Content-Type: text/x-patch;
 name="libsemanage.no_pserver_locking.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.no_pserver_locking.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2006-01-17 09:11:06.000000000 -0700
+++ new/libsemanage/src/database.c	2006-01-17 14:28:26.000000000 -0700
@@ -2,6 +2,7 @@
 
 #include <semanage/handle.h>
 #include "semanage_store.h"
+#include "semanage_conf.h"
 #include "database.h"
 #include "debug.h"
 
@@ -28,7 +29,9 @@ static int enter_ro(
 	if (assert_init(handle, dconfig) < 0)
 		goto err;
 
-	if (!handle->is_in_transaction) {
+	if (!handle->is_in_transaction &&
+	     handle->conf->store_type == SEMANAGE_CON_DIRECT) {
+
 		if (semanage_get_active_lock(handle) < 0) {
 			ERR(handle, "could not get the active lock");
 			goto err;
@@ -51,7 +54,8 @@ static inline int exit_ro(
 
 	int commit_num = handle->funcs->get_serial(handle); 
 
-	if (!handle->is_in_transaction) 
+	if (!handle->is_in_transaction && 
+	     handle->conf->store_type == SEMANAGE_CON_DIRECT) 
 		semanage_release_active_lock(handle);
 
 	return commit_num;

--------------030505000100060407030709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
