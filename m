Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DDLYLB026454
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 09:21:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1150144497.4754.5.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1150144497.4754.5.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@epoch.ncsc.mil,
        jmorris@redhat.com
Subject: Re: [PATCH] keys: randomize key serial numbers 
Date: Tue, 13 Jun 2006 14:21:28 +0100
Message-ID: <13450.1150204888@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> This patch causes key_alloc_serial to generate key serial numbers randomly.
> This is necessary to prevent covert channels, since the serial number
> namespace is globally shared between all tasks, regardless of their context.

I think the concept of "covert channels" needs to be explained better here.
I'm not sure what the problem is exactly that you're trying to fix.

> For more background, see the "General security concerns with the key
> subsystem" thread.

You need to say where this thread may be found.

>	get_random_bytes(&key->serial, sizeof(key->serial));

This might sleep, but you're inside a spinlock.  Is it possible that this
might sleep for a long time if the entropy pool is completely empty?  If so
then the docs need to be amended.

> +	/* eliminate negative numbers: */
> +	key->serial &= ~(1 << 31);

Can you return the lost bit of randomness to the entropy pool?  Perhaps
pretend you got an interrupt and call add_interrupt_randomness() on some IRQ
if the bit is set.

> -	goto insert_here;
> -
> -	/* we found a key with the proposed serial number - walk the tree from
> -	 * that point looking for the next unused serial number */
> - serial_exists:
> -	for (;;) {
> -		key->serial = key_serial_next;
> -		if (key->serial < 2)
> -			key->serial = 2;
> -		key_serial_next = key->serial + 1;
> -
> -		if (!rb_parent(parent))
> -			p = &key_serial_tree.rb_node;
> -		else if (rb_parent(parent)->rb_left == parent)
> -			p = &(rb_parent(parent)->rb_left);
> -		else
> -			p = &(rb_parent(parent)->rb_right);
> -
> -		parent = rb_next(parent);
> -		if (!parent)
> -			break;
> -
> -		xkey = rb_entry(parent, struct key, serial_node);
> -		if (key->serial < xkey->serial)
> -			goto insert_here;
> -	}

You don't place any limits on the amount of time you might spend looking for a
new key.  It's theoretically possible that you get hit after hit after hit and
just drain your entropy pool to the dregs without actually progressing.

Is it that bad if you select one random number to use as a starting point, and
then use the next hole higher than that number?  You could even use the wasted
bit of randomness (the serial number is pruned to be non-negative) to specify
search-up vs search-down.

How about the attached patch?

David

---
warthog>diffstat -p1 /tmp/key-random.diff 
 security/keys/key.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b6061fa..1044893 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -19,7 +19,6 @@ #include <linux/err.h>
 #include "internal.h"
 
 static kmem_cache_t	*key_jar;
-static key_serial_t	key_serial_next = 3;
 struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
 DEFINE_SPINLOCK(key_serial_lock);
 
@@ -169,22 +168,23 @@ static void __init __key_insert_serial(s
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
@@ -204,7 +204,7 @@ static inline void key_alloc_serial(stru
 
 	/* we found a key with the proposed serial number - walk the tree from
 	 * that point looking for the next unused serial number */
- serial_exists:
+serial_exists:
 	for (;;) {
 		key->serial = key_serial_next;
 		if (key->serial < 2)
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
