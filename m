Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KJWUWt022363
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 15:32:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KJWI0p029798
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 19:32:18 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
	by jazzswing.ncsc.mil  with ESMTP id h9KJWHr7029792
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 19:32:17 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id B8B86170021
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:46:22 +0200 (CEST)
Date: Mon, 20 Oct 2003 21:32:59 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: [Patch]  checkpolicy
Message-ID: <20031020193259.GE3579@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


- use unsigned int instead of unsigned long as bit specifier
files: ebitmap.{c,h}

Joerg


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=checkpolicy-2

Index: ebitmap.c
===================================================================
--- ebitmap.c	(.../upstream/current/checkpolicy)	(revision 13)
+++ ebitmap.c	(.../trunk/checkpolicy)	(revision 13)
@@ -139,7 +139,7 @@
 }
 
 
-int ebitmap_get_bit(ebitmap_t * e, unsigned long bit)
+int ebitmap_get_bit(ebitmap_t * e, unsigned int bit)
 {
 	ebitmap_node_t *n;
 
@@ -162,7 +162,7 @@
 }
 
 
-int ebitmap_set_bit(ebitmap_t * e, unsigned long bit, int value)
+int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 {
 	ebitmap_node_t *n, *prev, *new;
 
@@ -269,7 +269,7 @@
 	count = le32_to_cpu(buf[2]);
 
 	if (mapsize != MAPSIZE) {
-		printk("security: ebitmap: map size %d does not match my size %d (high bit was %d)\n", mapsize, MAPSIZE, e->highbit);
+		printk("security: ebitmap: map size %d does not match my size %zu (high bit was %d)\n", mapsize, MAPSIZE, e->highbit);
 		goto out;
 	}
 	if (!e->highbit) {
@@ -277,7 +277,7 @@
 		goto ok;
 	}
 	if (e->highbit & (MAPSIZE - 1)) {
-		printk("security: ebitmap: high bit (%d) is not a multiple of the map size (%d)\n", e->highbit, MAPSIZE);
+		printk("security: ebitmap: high bit (%d) is not a multiple of the map size (%zu)\n", e->highbit, MAPSIZE);
 		goto bad;
 	}
 	l = NULL;
@@ -298,11 +298,11 @@
 		n->startbit = le32_to_cpu(buf[0]);
 
 		if (n->startbit & (MAPSIZE - 1)) {
-			printk("security: ebitmap start bit (%d) is not a multiple of the map size (%d)\n", n->startbit, MAPSIZE);
+			printk("security: ebitmap start bit (%d) is not a multiple of the map size (%zu)\n", n->startbit, MAPSIZE);
 			goto bad_free;
 		}
 		if (n->startbit > (e->highbit - MAPSIZE)) {
-			printk("security: ebitmap start bit (%d) is beyond the end of the bitmap (%d)\n", n->startbit, (e->highbit - MAPSIZE));
+			printk("security: ebitmap start bit (%d) is beyond the end of the bitmap (%zu)\n", n->startbit, (e->highbit - MAPSIZE));
 			goto bad_free;
 		}
 		buf = next_entry(fp, sizeof(__u64));
Index: ebitmap.h
===================================================================
--- ebitmap.h	(.../upstream/current/checkpolicy)	(revision 13)
+++ ebitmap.h	(.../trunk/checkpolicy)	(revision 13)
@@ -46,8 +46,8 @@
 int ebitmap_or(ebitmap_t * dst, ebitmap_t * e1, ebitmap_t * e2);
 int ebitmap_cpy(ebitmap_t * dst, ebitmap_t * src);
 int ebitmap_contains(ebitmap_t * e1, ebitmap_t * e2);
-int ebitmap_get_bit(ebitmap_t * e, unsigned long bit);
-int ebitmap_set_bit(ebitmap_t * e, unsigned long bit, int value);
+int ebitmap_get_bit(ebitmap_t * e, unsigned int bit);
+int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
 void ebitmap_destroy(ebitmap_t * e);
 int ebitmap_read(ebitmap_t * e, void * fp);
 

--uAKRQypu60I7Lcqm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
