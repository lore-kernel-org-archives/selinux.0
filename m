Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DDZls5026768
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 09:35:47 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <13450.1150204888@warthog.cambridge.redhat.com> 
References: <13450.1150204888@warthog.cambridge.redhat.com>  <1150144497.4754.5.camel@moss-tarheels.epoch.ncsc.mil> 
To: David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
        sds@epoch.ncsc.mil, jmorris@redhat.com
Subject: Re: [PATCH] keys: randomize key serial numbers 
Date: Tue, 13 Jun 2006 14:35:44 +0100
Message-ID: <14647.1150205744@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> How about the attached patch?

And, of course, I should try compiling and running the kernel before sending
the patch.

Try this instead.

David

---
warthog>diffstat -p1 /tmp/key-random.diff 
 security/keys/key.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b6061fa..adf4206 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -15,11 +15,11 @@ #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/workqueue.h>
+#include <linux/random.h>
 #include <linux/err.h>
 #include "internal.h"
 
 static kmem_cache_t	*key_jar;
-static key_serial_t	key_serial_next = 3;
 struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
 DEFINE_SPINLOCK(key_serial_lock);
 
@@ -169,22 +169,23 @@ static void __init __key_insert_serial(s
 /*****************************************************************************/
 /*
  * assign a key the next unique serial number
- * - we work through all the serial numbers between 2 and 2^31-1 in turn and
- *   then wrap
+ * - these are assigned randomly to avoid security issues through covert
+ *   channel problems
  */
 static inline void key_alloc_serial(struct key *key)
 {
 	struct rb_node *parent, **p;
 	struct key *xkey;
 
-	spin_lock(&key_serial_lock);
-
-	/* propose a likely serial number and look for a hole for it in the
+	/* propose a random serial number and look for a hole for it in the
 	 * serial number tree */
-	key->serial = key_serial_next;
-	if (key->serial < 3)
-		key->serial = 3;
-	key_serial_next = key->serial + 1;
+	do {
+		get_random_bytes(&key->serial, sizeof(key->serial));
+
+		key->serial >>= 1; /* negative numbers are not permitted */
+	} while (key->serial < 3);
+
+	spin_lock(&key_serial_lock);
 
 	parent = NULL;
 	p = &key_serial_tree.rb_node;
@@ -204,12 +205,11 @@ static inline void key_alloc_serial(stru
 
 	/* we found a key with the proposed serial number - walk the tree from
 	 * that point looking for the next unused serial number */
- serial_exists:
+serial_exists:
 	for (;;) {
-		key->serial = key_serial_next;
+		key->serial++;
 		if (key->serial < 2)
 			key->serial = 2;
-		key_serial_next = key->serial + 1;
 
 		if (!parent->rb_parent)
 			p = &key_serial_tree.rb_node;
@@ -228,7 +228,7 @@ static inline void key_alloc_serial(stru
 	}
 
 	/* we've found a suitable hole - arrange for this key to occupy it */
- insert_here:
+insert_here:
 	rb_link_node(&key->serial_node, parent, p);
 	rb_insert_color(&key->serial_node, &key_serial_tree);
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
