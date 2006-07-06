Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k66KkS5l026590
	for <selinux@tycho.nsa.gov>; Thu, 6 Jul 2006 16:46:28 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k66KkOec026375
	for <selinux@tycho.nsa.gov>; Thu, 6 Jul 2006 20:46:26 GMT
Date: Thu, 6 Jul 2006 16:51:04 -0400
From: Caleb Case <ccase@tresys.com>
Message-Id: <200607062051.k66Kp4ck012466@localhost.localdomain>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: Read-only FS [1/2]
Cc: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Changed semanage_store_access_check for the purpose of supporting read-only filesystems on read operations.  Lock files are first checked for reading.  If reading fails and the lock file exists, then we error.  If reading fails and the lock file does not exist, then we check for write permissions in the lock file's directory so that it may be created.

In semanage_get_lock, if a lock file cannot be opened, then we attempt to create it.  lockf calls were converted to flock calls.  lockf does not work when locking on read-only files.

In semanage_get_active_lock and semanage_get_trans_lock, the saved file descriptor was being overwritten even in the case where obtaining the lock failed.  This prevented unlocking the file if you attempted to relock a file that was already locked by you.  We now return immediatly if the lock is available (instead of attempting to lock on it again).
	 
--- trunk/libsemanage/src/semanage_store.c	2006-07-03 10:32:22.000000000 -0400
+++ rofs/libsemanage/src/semanage_store.c	2006-07-05 06:21:28.000000000 -0400
@@ -48,6 +48,7 @@ typedef struct dbase_policydb dbase_t;
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/file.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -358,8 +359,8 @@ int semanage_create_store(semanage_handl
 }
 
 /* returns <0 if the active store cannot be read or doesn't exist
- * 0 if the store exists but the lock file cannot be written to
- * SEMANAGE_CAN_READ if the store can be read and the lock file written to
+ * 0 if the store exists but the lock file cannot be accessed 
+ * SEMANAGE_CAN_READ if the store can be read and the lock file used
  * SEMANAGE_CAN_WRITE if the modules directory and binary policy dir can be written to
  */
 int semanage_store_access_check(semanage_handle_t * sh)
@@ -376,10 +377,20 @@ int semanage_store_access_check(semanage
 	 * so now we return 0 to indicate no error */
 	rc = 0;
 
-	/* read/write access on lock file required for reading */
+	/* read access on lock file required for locking
+	 * write access necessary if the lock file does not exist
+	 */
 	path = semanage_files[SEMANAGE_READ_LOCK];
-	if (access(path, R_OK | W_OK) != 0)
-		goto out;
+	if (access(path, R_OK) != 0) {
+		if (access(path, F_OK) == 0) {
+			goto out;
+		}
+
+		path = semanage_files[SEMANAGE_ROOT];
+		if (access(path, R_OK | W_OK | X_OK) != 0) {
+			goto out;
+		}
+	}
 
 	/* everything needed for reading has been checked */
 	rc = SEMANAGE_CAN_READ;
@@ -1229,12 +1240,14 @@ static int semanage_get_lock(semanage_ha
 	struct timeval origtime, curtime;
 	int got_lock = 0;
 
-	if ((fd =
-	     open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
-		  S_IRUSR | S_IWUSR)) == -1) {
-		ERR(sh, "Could not open direct %s at %s.", lock_name,
-		    lock_file);
-		return -1;
+	if ((fd = open(lock_file, O_RDONLY)) == -1) {
+		if ((fd =
+		     open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
+			  S_IRUSR | S_IWUSR)) == -1) {
+			ERR(sh, "Could not open direct %s at %s.", lock_name,
+			    lock_file);
+			return -1;
+		}
 	}
 	if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
 		ERR(sh, "Could not set close-on-exec for %s at %s.", lock_name,
@@ -1253,7 +1266,7 @@ static int semanage_get_lock(semanage_ha
 	do {
 		curtime.tv_sec = 1;
 		curtime.tv_usec = 0;
-		if (lockf(fd, F_TLOCK, 0) == 0) {
+		if (flock(fd, LOCK_EX | LOCK_NB) == 0) {
 			got_lock = 1;
 			break;
 		} else if (errno != EAGAIN) {
@@ -1294,6 +1307,9 @@ int semanage_get_trans_lock(semanage_han
 {
 	const char *lock_file = semanage_files[SEMANAGE_TRANS_LOCK];
 
+	if (sh->u.direct.translock_file_fd >= 0)
+		return 0;
+
 	sh->u.direct.translock_file_fd =
 	    semanage_get_lock(sh, "transaction lock", lock_file);
 	if (sh->u.direct.translock_file_fd >= 0) {
@@ -1314,6 +1330,9 @@ int semanage_get_active_lock(semanage_ha
 {
 	const char *lock_file = semanage_files[SEMANAGE_READ_LOCK];
 
+	if (sh->u.direct.activelock_file_fd >= 0)
+		return 0;
+
 	sh->u.direct.activelock_file_fd =
 	    semanage_get_lock(sh, "read lock", lock_file);
 	if (sh->u.direct.activelock_file_fd >= 0) {
@@ -1328,7 +1347,7 @@ int semanage_get_active_lock(semanage_ha
 void semanage_release_trans_lock(semanage_handle_t * sh)
 {
 	if (sh->u.direct.translock_file_fd >= 0) {
-		lockf(sh->u.direct.translock_file_fd, F_ULOCK, 0);
+		flock(sh->u.direct.translock_file_fd, LOCK_UN);
 		close(sh->u.direct.translock_file_fd);
 		sh->u.direct.translock_file_fd = -1;
 	}
@@ -1339,7 +1358,7 @@ void semanage_release_trans_lock(semanag
 void semanage_release_active_lock(semanage_handle_t * sh)
 {
 	if (sh->u.direct.activelock_file_fd >= 0) {
-		lockf(sh->u.direct.activelock_file_fd, F_ULOCK, 0);
+		flock(sh->u.direct.activelock_file_fd, LOCK_UN);
 		close(sh->u.direct.activelock_file_fd);
 		sh->u.direct.activelock_file_fd = -1;
 	}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
