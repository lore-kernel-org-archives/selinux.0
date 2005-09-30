Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U31HNs023666
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:01:17 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U2tZA9013007
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 02:55:36 GMT
Message-ID: <433CAB46.7090709@cornell.edu>
Date: Thu, 29 Sep 2005 23:04:38 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 5/9 ] [ SEMANAGE ] Change database to singly-linked list
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------040405070601040606020802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040405070601040606020802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes the previously doubly-linked list in database.c to a 
singly-linked list, which is sufficient.

--------------040405070601040606020802
Content-Type: text/x-patch;
 name="libsemanage.04.dbase_single_link.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.04.dbase_single_link.diff"

diff -Naur libsemanage/src/database.c libsemanage.new2/src/database.c
--- libsemanage/src/database.c	2005-09-29 17:54:40.000000000 -0400
+++ libsemanage.new2/src/database.c	2005-09-29 18:03:08.000000000 -0400
@@ -12,7 +12,6 @@
 /* Representation of the database once loaded in memory */
 typedef struct cache_entry {
 	record_t data;
-	struct cache_entry* prev;
 	struct cache_entry* next;
 } cache_entry_t;
 
@@ -98,10 +97,7 @@
 	if (entry == NULL)
 		goto omem;
 	entry->data = data;
-	entry->prev = NULL;
 	entry->next = dbase->cache;
-	if (dbase->cache != NULL)
-		dbase->cache->prev = entry;
 	dbase->cache = entry;
 	dbase->cache_sz++;
 
@@ -267,29 +263,26 @@
 	dbase_t* dbase,
 	record_key_t key) {
 
-	cache_entry_t* entry;
-	int status;
+	cache_entry_t *ptr, *prev = NULL;
 
 	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	status = dbase_cache_locate(dbase, key, &entry);
-	if (status < 0)
-		goto err;
-	
-	else if (status != STATUS_NODATA) {
-		if (entry->next != NULL)
-			entry->next->prev = entry->prev;
-
-		if (entry->prev != NULL)
-			entry->prev->next = entry->next;
+	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+		if (! dbase->rtable->compare(ptr->data, key)) {
+			if (prev != NULL)
+				prev->next = ptr->next;
+			else
+				dbase->cache = ptr->next;
+
+			dbase->rtable->free(ptr->data);
+			dbase->cache_sz--;
+			free(ptr);
+			return STATUS_SUCCESS;
+		}
 		else
-			dbase->cache = entry->next;
-
-		dbase->rtable->free(entry->data);
-		dbase->cache_sz--;
-		free(entry);
-	}
+			prev = ptr;
+        }
 
 	return STATUS_SUCCESS;
 	err:

--------------040405070601040606020802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
