Message-ID: <43694616.3000002@cornell.edu>
Date: Wed, 02 Nov 2005 18:04:54 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE 4 ] Order-preserving file dbase
Content-Type: multipart/mixed;
 boundary="------------000206090109020205060001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000206090109020205060001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch restores the doubly-linked list that I got rid of earlier, 
and uses it to implement order-preserving flush() operation. The records 
are printed out in the order in which they're read in. Additions go at 
the end of the file, and queries are executed starting at the end of the 
file, and progressing up. This gets us closer to solving The Port Problem.


--------------000206090109020205060001
Content-Type: text/x-patch;
 name="libsemanage.file_preserve_order.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.file_preserve_order.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-11-01 16:25:47.000000000 -0500
+++ new/libsemanage/src/database_file.c	2005-11-02 17:59:33.000000000 -0500
@@ -14,6 +14,7 @@ typedef struct dbase_file dbase_t;
 /* Representation of the database once loaded in memory */
 typedef struct cache_entry {
 	record_t* data;
+	struct cache_entry* prev;
 	struct cache_entry* next;
 } cache_entry_t;
 
@@ -31,6 +32,8 @@ struct dbase_file {
 
 	/* In-memory representation (cache) */
 	cache_entry_t* cache;
+	cache_entry_t* cache_tail;
+
 	size_t cache_sz;
 	int cached;
 	int modified;
@@ -60,21 +63,28 @@ static int construct_filename(
 
 
 /* Helper for adding records to the cache */
-static int dbase_file_cache_add(
+static int dbase_file_cache_prepend(
 	semanage_handle_t* handle, 
 	dbase_file_t* dbase,
 	record_t* data) {
 
+	/* Initialize */
 	cache_entry_t* entry =
 		(cache_entry_t*) malloc(sizeof (cache_entry_t));
-
 	if (entry == NULL)
 		goto omem;
 	entry->data = data;
+	entry->prev = NULL;
 	entry->next = dbase->cache;
+
+	/* Link */
+	if (dbase->cache != NULL)
+		dbase->cache->prev = entry;
+	if (dbase->cache_tail == NULL)
+		dbase->cache_tail = entry;
 	dbase->cache = entry;
-	dbase->cache_sz++;
 
+	dbase->cache_sz++;
         return STATUS_SUCCESS;
 
         omem:
@@ -98,6 +108,7 @@ static int dbase_file_cache(
 
 	dbase->cache_sz = 0;
 	dbase->cache = NULL;
+	dbase->cache_tail = NULL;
 
 	if (construct_filename(handle, dbase, &fname) < 0)
 		goto err;
@@ -127,7 +138,7 @@ static int dbase_file_cache(
 			break;
 
 		/* Add record to list */
-		if (dbase_file_cache_add(handle, dbase, process_record) < 0)
+		if (dbase_file_cache_prepend(handle, dbase, process_record) < 0)
 			goto err;
 		process_record = NULL;
 
@@ -192,7 +203,7 @@ static int dbase_file_flush(
 		goto err;
 	}
 
-	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+	for (ptr = dbase->cache_tail; ptr != NULL; ptr = ptr->prev) {
 		if (dbase->rftable->print(handle, ptr->data, str) < 0)
 			goto err;
 	}
@@ -254,6 +265,7 @@ int dbase_file_init(
 	tmp_dbase->rtable = rtable;
 	tmp_dbase->rftable = rftable;
 	tmp_dbase->cache = NULL;
+	tmp_dbase->cache_tail = NULL;
 	tmp_dbase->cache_sz = 0;
 	tmp_dbase->cached = 0;
 	tmp_dbase->modified = 0;
@@ -316,7 +328,7 @@ static int dbase_file_add(
 		goto err;
 	}
 
-	if (dbase_file_cache_add(handle, dbase, data) < 0)
+	if (dbase_file_cache_prepend(handle, dbase, data) < 0)
 		goto err;
 
 	dbase->modified = 1;
@@ -370,7 +382,7 @@ static int dbase_file_modify(
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA) {
-		if (dbase_file_cache_add(handle, dbase, data) < 0)
+		if (dbase_file_cache_prepend(handle, dbase, data) < 0)
 			goto err;
 	}
 	else {
@@ -460,6 +472,11 @@ static int dbase_file_del(
 			else
 				dbase->cache = ptr->next;
 
+			if (ptr->next != NULL)
+				ptr->next->prev = ptr->prev;
+			else
+				dbase->cache_tail = ptr->prev;
+
 			dbase->rtable->free(ptr->data);
 			dbase->cache_sz--;
 			free(ptr);
@@ -494,7 +511,6 @@ static int dbase_file_list(
 			goto omem;
 
 		for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
-
 			if (dbase->rtable->clone(handle, 
 				ptr->data, &tmp_records[i]) < 0)
 				goto err;

--------------000206090109020205060001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
