Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6HevGE005890
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 12:40:57 -0500
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6HeAiG011912
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 17:40:12 GMT
Message-Id: <20061106173949.973049020@tresys.com>>
References: <20061106173814.457967976@tresys.com>>
Date: Mon, 06 Nov 2006 12:38:17 -0500
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] SELinux: ensure keys constant in hashtab_search
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Makes the key argument passed into hashtab_search and all the functions it calls constant. These functions include hash table function pointers hash_value and keycmp. The only implementations of these currently are symhash and symcmp, which do not modify the key. The key parameter should never be changed by any of these, so it should be const. This is necessary to allow calling these functions with keys found in kernel object class and permission definitions.

Signed-off-by: Chad Sellers <csellers@tresys.com>

---
 security/selinux/ss/hashtab.c |    6 +++---
 security/selinux/ss/hashtab.h |   10 +++++-----
 security/selinux/ss/symtab.c  |    8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6-discovery/security/selinux/ss/hashtab.c
===================================================================
--- linux-2.6-discovery.orig/security/selinux/ss/hashtab.c
+++ linux-2.6-discovery/security/selinux/ss/hashtab.c
@@ -8,8 +8,8 @@
 #include <linux/errno.h>
 #include "hashtab.h"
 
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
-                               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
+struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
+                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
                                u32 size)
 {
 	struct hashtab *p;
@@ -71,7 +71,7 @@ int hashtab_insert(struct hashtab *h, vo
 	return 0;
 }
 
-void *hashtab_search(struct hashtab *h, void *key)
+void *hashtab_search(struct hashtab *h, const void *key)
 {
 	u32 hvalue;
 	struct hashtab_node *cur;
Index: linux-2.6-discovery/security/selinux/ss/hashtab.h
===================================================================
--- linux-2.6-discovery.orig/security/selinux/ss/hashtab.h
+++ linux-2.6-discovery/security/selinux/ss/hashtab.h
@@ -22,9 +22,9 @@ struct hashtab {
 	struct hashtab_node **htable;	/* hash table */
 	u32 size;			/* number of slots in hash table */
 	u32 nel;			/* number of elements in hash table */
-	u32 (*hash_value)(struct hashtab *h, void *key);
+	u32 (*hash_value)(struct hashtab *h, const void *key);
 					/* hash function */
-	int (*keycmp)(struct hashtab *h, void *key1, void *key2);
+	int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
 					/* key comparison function */
 };
 
@@ -39,8 +39,8 @@ struct hashtab_info {
  * Returns NULL if insufficent space is available or
  * the new hash table otherwise.
  */
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
-                               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
+struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
+                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
                                u32 size);
 
 /*
@@ -59,7 +59,7 @@ int hashtab_insert(struct hashtab *h, vo
  * Returns NULL if no entry has the specified key or
  * the datum of the entry otherwise.
  */
-void *hashtab_search(struct hashtab *h, void *k);
+void *hashtab_search(struct hashtab *h, const void *k);
 
 /*
  * Destroys the specified hash table.
Index: linux-2.6-discovery/security/selinux/ss/symtab.c
===================================================================
--- linux-2.6-discovery.orig/security/selinux/ss/symtab.c
+++ linux-2.6-discovery/security/selinux/ss/symtab.c
@@ -9,9 +9,9 @@
 #include <linux/errno.h>
 #include "symtab.h"
 
-static unsigned int symhash(struct hashtab *h, void *key)
+static unsigned int symhash(struct hashtab *h, const void *key)
 {
-	char *p, *keyp;
+	const char *p, *keyp;
 	unsigned int size;
 	unsigned int val;
 
@@ -23,9 +23,9 @@ static unsigned int symhash(struct hasht
 	return val & (h->size - 1);
 }
 
-static int symcmp(struct hashtab *h, void *key1, void *key2)
+static int symcmp(struct hashtab *h, const void *key1, const void *key2)
 {
-	char *keyp1, *keyp2;
+	const char *keyp1, *keyp2;
 
 	keyp1 = key1;
 	keyp2 = key2;

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
