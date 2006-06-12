Subject: [PATCH] keys: randomize key serial numbers
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@epoch.ncsc.mil,
        jmorris@redhat.com
Content-Type: text/plain
Date: Mon, 12 Jun 2006 16:34:57 -0400
Message-Id: <1150144497.4754.5.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch causes key_alloc_serial to generate key serial numbers randomly.
This is necessary to prevent covert channels, since the serial number namespace
is globally shared between all tasks, regardless of their context.  For more
background, see the "General security concerns with the key subsystem" thread.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Modify key_alloc_serial to select key serial numbers randomly.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 key.c |   41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

--- linux-2.6.17-rc6-mm1.orig/security/keys/key.c	2006-06-08 09:41:50.000000000 -0400
+++ linux-2.6.17-rc6-mm1.rnd/security/keys/key.c	2006-06-12 16:24:24.000000000 -0400
@@ -20,7 +20,6 @@
 #include "internal.h"
 
 static kmem_cache_t	*key_jar;
-static key_serial_t	key_serial_next = 3;
 struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
 DEFINE_SPINLOCK(key_serial_lock);
 
@@ -170,8 +169,7 @@ static void __init __key_insert_serial(s
 /*****************************************************************************/
 /*
  * assign a key the next unique serial number
- * - we work through all the serial numbers between 2 and 2^31-1 in turn and
- *   then wrap
+ * - to prevent covert channels, we randomize these numbers
  */
 static inline void key_alloc_serial(struct key *key)
 {
@@ -180,12 +178,14 @@ static inline void key_alloc_serial(stru
 
 	spin_lock(&key_serial_lock);
 
-	/* propose a likely serial number and look for a hole for it in the
+serial_exists:
+	/* propose a random serial number and look for a hole for it in the
 	 * serial number tree */
-	key->serial = key_serial_next;
+	get_random_bytes(&key->serial, sizeof(key->serial));
+	/* eliminate negative numbers: */
+	key->serial &= ~(1 << 31);
 	if (key->serial < 3)
-		key->serial = 3;
-	key_serial_next = key->serial + 1;
+		goto serial_exists;
 
 	parent = NULL;
 	p = &key_serial_tree.rb_node;
@@ -201,35 +201,8 @@ static inline void key_alloc_serial(stru
 		else
 			goto serial_exists;
 	}
-	goto insert_here;
-
-	/* we found a key with the proposed serial number - walk the tree from
-	 * that point looking for the next unused serial number */
- serial_exists:
-	for (;;) {
-		key->serial = key_serial_next;
-		if (key->serial < 2)
-			key->serial = 2;
-		key_serial_next = key->serial + 1;
-
-		if (!rb_parent(parent))
-			p = &key_serial_tree.rb_node;
-		else if (rb_parent(parent)->rb_left == parent)
-			p = &(rb_parent(parent)->rb_left);
-		else
-			p = &(rb_parent(parent)->rb_right);
-
-		parent = rb_next(parent);
-		if (!parent)
-			break;
-
-		xkey = rb_entry(parent, struct key, serial_node);
-		if (key->serial < xkey->serial)
-			goto insert_here;
-	}
 
 	/* we've found a suitable hole - arrange for this key to occupy it */
- insert_here:
 	rb_link_node(&key->serial_node, parent, p);
 	rb_insert_color(&key->serial_node, &key_serial_tree);
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
