Message-ID: <43CD44F0.3090805@cornell.edu>
Date: Tue, 17 Jan 2006 12:26:40 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Fix memory leak in cache error path
Content-Type: multipart/mixed;
 boundary="------------080700040303040506010709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080700040303040506010709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The llist-based cache() implementations leak memory in the error path - 
fix that...



--------------080700040303040506010709
Content-Type: text/x-patch;
 name="libsemanage.cache_err_memory_leak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.cache_err_memory_leak.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database_activedb.c new/libsemanage/src/database_activedb.c
--- old/libsemanage/src/database_activedb.c	2006-01-17 09:11:06.000000000 -0700
+++ new/libsemanage/src/database_activedb.c	2006-01-17 12:15:44.000000000 -0700
@@ -44,7 +44,10 @@ static int dbase_activedb_cache(
 	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
 
+	/* Update cache serial */
 	dbase_llist_cache_init(&dbase->llist);
+	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
+		goto err;
 
 	/* Fetch the entire list */
 	if (ratable->read_list(handle, &records, &rcount) < 0)
@@ -57,10 +60,6 @@ static int dbase_activedb_cache(
 		rtable->free(records[i]);
 	}
 
-	/* Update cache serial */
-	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
-		goto err;
-
 	free(records);
 	return STATUS_SUCCESS;
 
@@ -68,6 +67,7 @@ static int dbase_activedb_cache(
 	ERR(handle, "could not cache active database");
 	for (; i < rcount; i++)
 		rtable->free(records[i]);
+	dbase_llist_drop_cache(&dbase->llist);
 	free(records);
 	return STATUS_ERR;
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2006-01-17 11:40:12.000000000 -0700
+++ new/libsemanage/src/database_file.c	2006-01-17 12:16:19.000000000 -0700
@@ -76,7 +76,10 @@ static int dbase_file_cache(
 	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
 
+	/* Update cache serial */
 	dbase_llist_cache_init(&dbase->llist);
+	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
+		goto err;
 
 	if (construct_filename(handle, dbase, &fname) < 0)
 		goto err;
@@ -115,10 +118,6 @@ static int dbase_file_cache(
 
 	} while (pstatus != STATUS_NODATA);
 
-	/* Update cache serial */
-	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
-		goto err;
-
 	rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
@@ -130,6 +129,7 @@ static int dbase_file_cache(
 	rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
+	dbase_llist_drop_cache(&dbase->llist);
 	free(fname);
 	return STATUS_ERR;
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/database_join.c new/libsemanage/src/database_join.c
--- old/libsemanage/src/database_join.c	2006-01-17 09:11:06.000000000 -0700
+++ new/libsemanage/src/database_join.c	2006-01-17 12:16:58.000000000 -0700
@@ -58,7 +58,10 @@ static int dbase_join_cache(
 	if (!dbase_llist_needs_resync(handle, &dbase->llist))
 		return STATUS_SUCCESS;
 	
+	/* Update cache serial */
 	dbase_llist_cache_init(&dbase->llist);
+	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
+		goto err;
 
 	/* First cache any child dbase, which must
 	 * be the first thing done when calling dbase
@@ -157,6 +160,7 @@ static int dbase_join_cache(
 	free(records2);
 	rtable->key_free(rkey);
 	rtable->free(record);
+	dbase_llist_drop_cache(&dbase->llist);
 	return STATUS_ERR;
 }
 

--------------080700040303040506010709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
