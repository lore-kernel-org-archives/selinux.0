From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 07/13] SELinux: avtab.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:28 -0400
Message-Id: <12085547141160-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547141335-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
 <12085547141335-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes avtab.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
locateion of { around struct and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/ss/avtab.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 260a06b..9e66263 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -6,15 +6,15 @@
 
 /* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
- * 	Added conditional policy language extensions
+ *	Added conditional policy language extensions
  *
  * Copyright (C) 2003 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
+ *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  *
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
- * 	Tuned number of hash slots for avtab to reduce memory usage
+ *	Tuned number of hash slots for avtab to reduce memory usage
  */
 
 #include <linux/kernel.h>
@@ -33,10 +33,10 @@ static inline int avtab_hash(struct avtab_key *keyp, u16 mask)
 
 static struct avtab_node*
 avtab_insert_node(struct avtab *h, int hvalue,
-		  struct avtab_node * prev, struct avtab_node * cur,
+		  struct avtab_node *prev, struct avtab_node *cur,
 		  struct avtab_key *key, struct avtab_datum *datum)
 {
-	struct avtab_node * newnode;
+	struct avtab_node *newnode;
 	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
 	if (newnode == NULL)
 		return NULL;
@@ -84,7 +84,7 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
 	}
 
 	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
-	if(!newnode)
+	if (!newnode)
 		return -ENOMEM;
 
 	return 0;
@@ -95,7 +95,7 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
  * It also returns a pointer to the node inserted.
  */
 struct avtab_node *
-avtab_insert_nonunique(struct avtab * h, struct avtab_key * key, struct avtab_datum * datum)
+avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
@@ -326,7 +326,7 @@ static uint16_t spec_order[] = {
 };
 
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
-	            int (*insertf)(struct avtab *a, struct avtab_key *k,
+		    int (*insertf)(struct avtab *a, struct avtab_key *k,
 				   struct avtab_datum *d, void *p),
 		    void *p)
 {
@@ -398,7 +398,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 				key.specified = spec_order[i] | enabled;
 				datum.data = le32_to_cpu(buf32[items++]);
 				rc = insertf(a, &key, &datum, p);
-				if (rc) return rc;
+				if (rc)
+					return rc;
 			}
 		}
 
@@ -512,5 +513,5 @@ void avtab_cache_init(void)
 
 void avtab_cache_destroy(void)
 {
-	kmem_cache_destroy (avtab_node_cachep);
+	kmem_cache_destroy(avtab_node_cachep);
 }
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
