Message-ID: <43ABDF45.7020900@cornell.edu>
Date: Fri, 23 Dec 2005 06:28:05 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Commit numbers for ro database calls
Content-Type: multipart/mixed;
 boundary="------------040303070709070404010904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040303070709070404010904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This should make Joshua happy... return commit numbers on all ro 
operations. This does not return commit numbers on rw operations, which 
is consistent with what the modules code does (I think...).

Next we should take advantage of commit numbers to only re-read the 
cache on ro calls when the commit number has changed.

----
I don't like how dependency on semanage_store.c is creeping into database.c.
(but it was there to begin with - active_lock, and so on...) - might 
need to reorganize some of this later..



--------------040303070709070404010904
Content-Type: text/x-patch;
 name="libsemanage6.commit_numbers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage6.commit_numbers.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database.c new/libsemanage/src/database.c
--- old/libsemanage/src/database.c	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/database.c	2005-12-23 06:14:15.000000000 -0500
@@ -45,14 +45,18 @@ static int enter_ro(
 	return STATUS_ERR;
 }
 
-static inline void exit_ro(
+static inline int exit_ro(
 	semanage_handle_t* handle,
 	dbase_config_t* dconfig) {
 
+	int commit_num = semanage_get_commit_number(handle);
+
 	if (!handle->is_in_transaction) {
 		semanage_release_active_lock(handle);
 		dconfig->dtable->drop_cache(dconfig->dbase);
 	}
+
+	return commit_num;
 }
 
 static int enter_rw(
@@ -150,8 +154,7 @@ int dbase_query (
 		return STATUS_ERR;
 	}
 
-	exit_ro(handle, dconfig);
-	return STATUS_SUCCESS;
+	return exit_ro(handle, dconfig);
 }
 
 int dbase_exists (
@@ -168,8 +171,7 @@ int dbase_exists (
 		return STATUS_ERR;
 	}
 
-	exit_ro(handle, dconfig);
-	return STATUS_SUCCESS;
+	return exit_ro(handle, dconfig);
 }
 
 int dbase_count (
@@ -185,8 +187,7 @@ int dbase_count (
 		return STATUS_ERR;
 	}
 
-	exit_ro(handle, dconfig);
-	return STATUS_SUCCESS;
+	return exit_ro(handle, dconfig);
 }
 
 int dbase_iterate(
@@ -203,8 +204,7 @@ int dbase_iterate(
 		return STATUS_ERR;
 	}
 
-	exit_ro(handle, dconfig);
-	return STATUS_SUCCESS;
+	return exit_ro(handle, dconfig);
 }
 
 int dbase_list (
@@ -221,6 +221,5 @@ int dbase_list (
 		return STATUS_ERR;
 	}
 
-	exit_ro(handle, dconfig);
-	return STATUS_SUCCESS;
+	return exit_ro(handle, dconfig);
 }

--------------040303070709070404010904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
