Message-ID: <435422E6.8090807@cornell.edu>
Date: Mon, 17 Oct 2005 18:17:10 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Acquire/release read lock in databases
Content-Type: multipart/mixed;
 boundary="------------030801050203080605040004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030801050203080605040004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The read lock needs to be fixed, which is why this code was commented 
out in the first place. However, I think Joshua will submit a patch for 
that, so..uncomment this code to provide locking for database read-only 
functions. The locking is supposed to provide safety against 
simultaneous commit. It also serializes readers as a side effect.



--------------030801050203080605040004
Content-Type: text/x-patch;
 name="libsemanage.read_lock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.read_lock.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_direct.c new/libsemanage/src/database_direct.c
--- old/libsemanage/src/database_direct.c	2005-10-13 13:08:35.000000000 -0400
+++ new/libsemanage/src/database_direct.c	2005-10-17 18:12:06.000000000 -0400
@@ -160,10 +160,10 @@ static int enter_ro(
 		return STATUS_ERR;
 	}
 	
-	//if (semanage_handle_get_read_lock(handle) < 0) {
-	//	/* FIXME: handle error */
-	//	return STATUS_ERR;
-	//}
+	if (semanage_get_read_lock(handle) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
 
 	if (dbase_direct_cache(handle, dbase) < 0) {
 		/* FIXME: handle error */
@@ -177,7 +177,7 @@ static inline void exit_ro(
 	semanage_handle_t* handle,
 	dbase_direct_t* dbase) {
 
-	//semanage_release_read_lock(handle);
+	semanage_release_read_lock(handle);
 	dbase_direct_drop_cache(handle, dbase);
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-13 13:08:35.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-17 18:12:31.000000000 -0400
@@ -218,10 +218,10 @@ static int enter_ro(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	//if (semanage_handle_get_read_lock(handle) < 0) {
-	//	/* FIXME: handle error */
-	//	return STATUS_ERR;
-	//}
+	if (semanage_get_read_lock(handle) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
 
 	if (dbase_file_cache(handle, dbase) < 0) {
 		/* FIXME: handle error */
@@ -235,7 +235,7 @@ static inline void exit_ro(
 	semanage_handle_t* handle,
 	dbase_file_t* dbase) {
 
-	//semanage_release_read_lock(handle);
+	semanage_release_read_lock(handle);
 	dbase_file_drop_cache(handle, dbase);
 }
 

--------------030801050203080605040004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
