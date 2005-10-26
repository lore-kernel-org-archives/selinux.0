Message-ID: <43601468.60508@cornell.edu>
Date: Wed, 26 Oct 2005 19:42:32 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [ SEMANAGE ] Implement dbase_file_set, fix memleak
Content-Type: multipart/mixed;
 boundary="------------060605040208070704070603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060605040208070704070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
- implement dbase_file_set
- fix a memory leak in dbase_file_modify that I've been trying to find - 
there are no more leaks that I know of


=============
I'll be really busy until the middle of next week - not sure if I can 
get a many patches written.

A short TODO:
- interface: pass handle into sepol records, or implement status codes
- stub: implement interface parse/print
- stub: implement dbase_policydb_list
- fix: fix port key handling of modify() [ do not replace an entire 
range on weak match (not exact) ]
- improvement: track when the policy is modified, and do not rebuild on 
commit if it wasn't modified
- add error messages everywhere (and further propagate handle), and make 
sure they're user-friendly
- uncomment if0-ed code, add new semanage interfaces to semanage.h, and 
the map file

Not important at this time:
- stub: implement dbase_policydb_del    (not currently used)
- stub: implement dbase_policydb_flush  (not currently used)
- fix: users parser/genusers parser should not look for range substring 
- that's ambiguous
- fix: seusers parser should allow multiline MLS context with whitespace

--------------060605040208070704070603
Content-Type: text/x-patch;
 name="libsemanage.dbase_file_set.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.dbase_file_set.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_file.c new/libsemanage/src/database_file.c
--- old/libsemanage/src/database_file.c	2005-10-25 09:06:53.000000000 -0400
+++ new/libsemanage/src/database_file.c	2005-10-26 19:28:35.000000000 -0400
@@ -388,14 +388,26 @@ static int dbase_file_set(
 	record_key_t* key,
 	record_t* data) {
 
+	cache_entry_t* entry;
+	int status;
+
 	if (enter_rw(handle, dbase) < 0)
 		goto err;
 
-        /* Stub */
-        key = NULL;
-        data = NULL;
+	status = dbase_file_cache_locate(handle, dbase, key, &entry);
+	if (status < 0)
+		goto err;
+        if (status == STATUS_NODATA) {
+		/* FIXME: handle error */
+		goto err;
+	}
+	else {
+		dbase->rtable->free(entry->data);
+		entry->data = data;
+	}
+
 	dbase->modified = 1;
-        return STATUS_ERR;
+        return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle error */
@@ -422,8 +434,10 @@ static int dbase_file_modify(
 		if (dbase_file_cache_add(dbase, data) < 0)
 			goto err;
 	}
-	else
+	else {
+		dbase->rtable->free(entry->data);
 		entry->data = data;
+	}
 
 	dbase->modified = 1;
 	return STATUS_SUCCESS;

--------------060605040208070704070603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
