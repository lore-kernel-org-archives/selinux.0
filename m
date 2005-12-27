Message-ID: <43B0AADA.5090300@cornell.edu>
Date: Mon, 26 Dec 2005 21:45:46 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Flip traversal order for llist iterate/list operations
Content-Type: multipart/mixed;
 boundary="------------070104070201060601050100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070104070201060601050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch flips the order for the linked list traversal in 
iterate()/list().
This is an implementation fix, which makes ports added later take 
precedence over ports added earlier.
That's because ports are added to the policydb in the iterate() order.

I'm not quite happy with this - I want the property above to be 
guaranteed in the specification of add() - things added later should 
take precedence over things added earlier (if ordering is a factor). To 
do that, I want the specification for iterate()/list() to guarantee 
traversal in the order things were added in (which is something that 
you'd usually expect iterate() to do). This is now true for anything 
backed in a file. It's also true for libsepol users. It's true trivially 
for libsepol booleans, because you can't add new libsepol booleans. 
However, it is *not* true for libsepol interfaces, and ports, where the 
list is traversed backwards. There iterate() works exactly the opposite 
way. It's a singly linked list, unfortunately. (the ocontext list..)




--------------070104070201060601050100
Content-Type: text/x-patch;
 name="libsemanage12.llist_traversal_order.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage12.llist_traversal_order.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2005-12-23 01:01:49.000000000 -0500
+++ new/libsemanage/src/database_llist.c	2005-12-26 19:35:16.000000000 -0500
@@ -237,7 +237,7 @@ hidden int dbase_llist_iterate(
 	int rc;
 	cache_entry_t* ptr;
 
-	for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+	for (ptr = dbase->cache_tail; ptr != NULL; ptr = ptr->prev) {
 
 		rc = fn(ptr->data, arg);
 		if (rc < 0) 
@@ -307,7 +307,7 @@ hidden int dbase_llist_list(
 		if (tmp_records == NULL)
 			goto omem;
 
-		for (ptr = dbase->cache; ptr != NULL; ptr = ptr->next) {
+		for (ptr = dbase->cache_tail; ptr != NULL; ptr = ptr->prev) {
 			if (dbase->rtable->clone(handle, 
 				ptr->data, &tmp_records[i]) < 0)
 				goto err;

--------------070104070201060601050100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
