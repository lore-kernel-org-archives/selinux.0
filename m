Message-Id: <200404211605.i3LG5FJx018074@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'James Morris'" <jmorris@redhat.com>,
   "'Russell Coker'" <russell@coker.com.au>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Wed, 21 Apr 2004 12:05:45 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00E8_01C42798.F9FC24A0"
In-Reply-To: <Xine.LNX.4.44.0404141553580.21808-100000@thoron.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00E8_01C42798.F9FC24A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > I think that the issue with performance is kernel memory use.  Currently
> for
> > FC2T2 we have 7M policydb files which roughly equates to 7M of kernel
> memory
> > reserved, which has a huge impact on older hardware!  Most of this is
> due to
> > compiling in support for every .te file.
> 
> I think it's worse than this.  It looks like we're using about 40 bytes of
> kernel memory for each rule, and with almost 300,000 rules, it's more like
> 12MB (for i386).
> 
> Making better use of kernel memory is on my todo list.
> 

I dug up two simple patches that I did a while back for the conditional
policy work that makes the avtab size configurable. It won't help much, but
it allows for a smaller conditional avtab on the assumption that there will
be fewer conditional rules. I also had a patch to make the hashing perform
slightly better which helped when using a smaller number of buckets, but I
can't find that. These patches are against on older checkpolicy and linux
2.6.1, but they are trivial enough to port if you think they are useful.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> 
> - James
> --
> James Morris
> <jmorris@redhat.com>
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

------=_NextPart_000_00E8_01C42798.F9FC24A0
Content-Type: application/octet-stream;
	name="conditional-avtab-selinux-usr-1-15-2004.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="conditional-avtab-selinux-usr-1-15-2004.patch"

diff -Nru a/selinux-usr/checkpolicy/avtab.c =
b/selinux-usr/checkpolicy/avtab.c=0A=
--- a/selinux-usr/checkpolicy/avtab.c	Thu Jan 15 16:22:45 2004=0A=
+++ b/selinux-usr/checkpolicy/avtab.c	Thu Jan 15 16:22:45 2004=0A=
@@ -20,11 +20,11 @@=0A=
 #include "avtab.h"=0A=
 #include "policydb.h"=0A=
 =0A=
-#define AVTAB_HASH(keyp) \=0A=
+#define AVTAB_HASH(keyp, mask) \=0A=
 ((keyp->target_class + \=0A=
  (keyp->target_type << 2) + \=0A=
  (keyp->source_type << 9)) & \=0A=
- AVTAB_HASH_MASK)=0A=
+ mask)=0A=
 =0A=
 static avtab_ptr_t =0A=
    avtab_insert_node(avtab_t *h, int hvalue, avtab_ptr_t prev, =
avtab_ptr_t cur, avtab_key_t *key, avtab_datum_t *datum)=0A=
@@ -58,7 +58,7 @@=0A=
 	if (!h)=0A=
 		return -ENOMEM;=0A=
 =0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (prev =3D NULL, cur =3D h->htable[hvalue];=0A=
 	     cur;=0A=
 	     prev =3D cur, cur =3D cur->next) {=0A=
@@ -97,7 +97,7 @@=0A=
 =0A=
 	if (!h)=0A=
 		return NULL;=0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (prev =3D NULL, cur =3D h->htable[hvalue];=0A=
 	     cur;=0A=
 	     prev =3D cur, cur =3D cur->next) {=0A=
@@ -152,7 +152,7 @@=0A=
 	if (!h)=0A=
 		return NULL;=0A=
 =0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (cur =3D h->htable[hvalue]; cur; cur =3D cur->next) {=0A=
 		if (key->source_type =3D=3D cur->key.source_type && =0A=
 		    key->target_type =3D=3D cur->key.target_type &&=0A=
@@ -186,7 +186,7 @@=0A=
 	if (!h)=0A=
 		return NULL;=0A=
 =0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (cur =3D h->htable[hvalue]; cur; cur =3D cur->next) {=0A=
 		if (key->source_type =3D=3D cur->key.source_type && =0A=
 		    key->target_type =3D=3D cur->key.target_type &&=0A=
@@ -244,7 +244,7 @@=0A=
 	if (!h)=0A=
 		return;=0A=
 =0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++) {=0A=
+	for (i =3D 0; i < h->size; i++) {=0A=
 		cur =3D h->htable[i];=0A=
 		while (cur !=3D NULL) {=0A=
 			temp =3D cur;=0A=
@@ -270,7 +270,7 @@=0A=
 	if (!h)=0A=
 		return 0;=0A=
 =0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++) {=0A=
+	for (i =3D 0; i < h->size; i++) {=0A=
 		cur =3D h->htable[i];=0A=
 		while (cur !=3D NULL) {=0A=
 			ret =3D apply(&cur->key, &cur->datum, args);=0A=
@@ -283,14 +283,17 @@=0A=
 }=0A=
 =0A=
 =0A=
-int avtab_init(avtab_t * h)=0A=
+int avtab_init(avtab_t * h, __u32 bits)=0A=
 {=0A=
 	int i;=0A=
 =0A=
-	h->htable =3D kmalloc(sizeof(avtab_ptr_t)*AVTAB_SIZE,GFP_KERNEL);=0A=
+	h->size =3D 1 << bits;=0A=
+	h->mask =3D h->size - 1;=0A=
+=0A=
+	h->htable =3D kmalloc(sizeof(avtab_ptr_t)*h->size,GFP_KERNEL);=0A=
 	if (!h->htable)=0A=
 		return -1;=0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++)=0A=
+	for (i =3D 0; i < h->size; i++)=0A=
 		h->htable[i] =3D (avtab_ptr_t) NULL;=0A=
 	h->nel =3D 0;=0A=
 	return 0;=0A=
@@ -305,7 +308,7 @@=0A=
 =0A=
 	slots_used =3D 0;=0A=
 	max_chain_len =3D 0;=0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++) {=0A=
+	for (i =3D 0; i < h->size; i++) {=0A=
 		cur =3D h->htable[i];=0A=
 		if (cur) {=0A=
 			slots_used++;=0A=
@@ -321,7 +324,7 @@=0A=
 	}=0A=
 =0A=
 	printk("%s:  %d entries and %d/%d buckets used, longest chain length =
%d\n",=0A=
-	       tag, h->nel, slots_used, AVTAB_SIZE, max_chain_len);=0A=
+	       tag, h->nel, slots_used, h->size, max_chain_len);=0A=
 }=0A=
 =0A=
 int avtab_read_item(void *fp, avtab_datum_t *avdatum, avtab_key_t =
*avkey)=0A=
diff -Nru a/selinux-usr/checkpolicy/avtab.h =
b/selinux-usr/checkpolicy/avtab.h=0A=
--- a/selinux-usr/checkpolicy/avtab.h	Thu Jan 15 16:22:45 2004=0A=
+++ b/selinux-usr/checkpolicy/avtab.h	Thu Jan 15 16:22:45 2004=0A=
@@ -61,11 +61,13 @@=0A=
 };=0A=
 =0A=
 typedef struct avtab {=0A=
+	__u32 size;=0A=
+	__u64 mask;=0A=
 	avtab_ptr_t *htable;=0A=
 	__u32 nel;	/* number of elements */=0A=
 } avtab_t;=0A=
 =0A=
-int avtab_init(avtab_t *);=0A=
+int avtab_init(avtab_t *h, __u32 bits);=0A=
 =0A=
 int avtab_insert(avtab_t * h, avtab_key_t * k, avtab_datum_t * d);=0A=
 =0A=
@@ -93,12 +95,6 @@=0A=
 avtab_ptr_t avtab_search_node(avtab_t * h, avtab_key_t * key, int =
specified);=0A=
 =0A=
 avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);=0A=
-=0A=
-#define AVTAB_HASH_BITS 15=0A=
-#define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)=0A=
-#define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)=0A=
-=0A=
-#define AVTAB_SIZE AVTAB_HASH_BUCKETS=0A=
 =0A=
 #endif	/* _AVTAB_H_ */=0A=
 =0A=
diff -Nru a/selinux-usr/checkpolicy/conditional.c =
b/selinux-usr/checkpolicy/conditional.c=0A=
--- a/selinux-usr/checkpolicy/conditional.c	Thu Jan 15 16:22:45 2004=0A=
+++ b/selinux-usr/checkpolicy/conditional.c	Thu Jan 15 16:22:45 2004=0A=
@@ -351,7 +351,7 @@=0A=
 {=0A=
 	p->bool_val_to_struct =3D NULL;=0A=
 	p->cond_list =3D NULL;=0A=
-	if (avtab_init(&p->te_cond_avtab))=0A=
+	if (avtab_init(&p->te_cond_avtab, 8))=0A=
 		return -1;=0A=
 =0A=
 	return 0;=0A=
diff -Nru a/selinux-usr/checkpolicy/policydb.c =
b/selinux-usr/checkpolicy/policydb.c=0A=
--- a/selinux-usr/checkpolicy/policydb.c	Thu Jan 15 16:22:45 2004=0A=
+++ b/selinux-usr/checkpolicy/policydb.c	Thu Jan 15 16:22:45 2004=0A=
@@ -100,7 +100,7 @@=0A=
 			goto out_free_symtab;=0A=
 	}=0A=
 =0A=
-	rc =3D avtab_init(&p->te_avtab);=0A=
+	rc =3D avtab_init(&p->te_avtab, 15);=0A=
 	if (rc)=0A=
 		goto out_free_symtab;=0A=
 =0A=
diff -Nru a/selinux-usr/checkpolicy/write.c =
b/selinux-usr/checkpolicy/write.c=0A=
--- a/selinux-usr/checkpolicy/write.c	Thu Jan 15 16:22:45 2004=0A=
+++ b/selinux-usr/checkpolicy/write.c	Thu Jan 15 16:22:45 2004=0A=
@@ -105,7 +105,7 @@=0A=
 	if (items !=3D 1)=0A=
 		return -1;=0A=
 =0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++) {=0A=
+	for (i =3D 0; i < a->size; i++) {=0A=
 		for (cur =3D a->htable[i]; cur; cur =3D cur->next) {=0A=
 			if (avtab_write_item(cur, fp))=0A=
 			    return -1;=0A=

------=_NextPart_000_00E8_01C42798.F9FC24A0
Content-Type: application/octet-stream;
	name="conditional-avtab-linux-2.6-1-15-2004.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="conditional-avtab-linux-2.6-1-15-2004.patch"

diff -Nru a/linux-2.6/security/selinux/ss/avtab.c =
b/linux-2.6/security/selinux/ss/avtab.c=0A=
--- a/linux-2.6/security/selinux/ss/avtab.c	Thu Jan 15 16:22:31 2004=0A=
+++ b/linux-2.6/security/selinux/ss/avtab.c	Thu Jan 15 16:22:31 2004=0A=
@@ -22,11 +22,11 @@=0A=
 #include "avtab.h"=0A=
 #include "policydb.h"=0A=
 =0A=
-#define AVTAB_HASH(keyp) \=0A=
+#define AVTAB_HASH(keyp, mask) \=0A=
 ((keyp->target_class + \=0A=
  (keyp->target_type << 2) + \=0A=
  (keyp->source_type << 9)) & \=0A=
- AVTAB_HASH_MASK)=0A=
+ mask)=0A=
 =0A=
 static struct avtab_node*=0A=
 avtab_insert_node(struct avtab *h, int hvalue, struct avtab_node * =
prev, struct avtab_node * cur,=0A=
@@ -59,7 +59,7 @@=0A=
 	if (!h)=0A=
 		return -EINVAL;=0A=
 =0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (prev =3D NULL, cur =3D h->htable[hvalue];=0A=
 	     cur;=0A=
 	     prev =3D cur, cur =3D cur->next) {=0A=
@@ -98,7 +98,7 @@=0A=
 =0A=
 	if (!h)=0A=
 		return NULL;=0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (prev =3D NULL, cur =3D h->htable[hvalue];=0A=
 	     cur;=0A=
 	     prev =3D cur, cur =3D cur->next) {=0A=
@@ -130,7 +130,7 @@=0A=
 	if (!h)=0A=
 		return NULL;=0A=
 =0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (cur =3D h->htable[hvalue]; cur; cur =3D cur->next) {=0A=
 		if (key->source_type =3D=3D cur->key.source_type &&=0A=
 		    key->target_type =3D=3D cur->key.target_type &&=0A=
@@ -164,7 +164,7 @@=0A=
 	if (!h)=0A=
 		return NULL;=0A=
 =0A=
-	hvalue =3D AVTAB_HASH(key);=0A=
+	hvalue =3D AVTAB_HASH(key, h->mask);=0A=
 	for (cur =3D h->htable[hvalue]; cur; cur =3D cur->next) {=0A=
 		if (key->source_type =3D=3D cur->key.source_type && =0A=
 		    key->target_type =3D=3D cur->key.target_type &&=0A=
@@ -221,7 +221,7 @@=0A=
 	if (!h)=0A=
 		return;=0A=
 =0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++) {=0A=
+	for (i =3D 0; i < h->size; i++) {=0A=
 		cur =3D h->htable[i];=0A=
 		while (cur !=3D NULL) {=0A=
 			temp =3D cur;=0A=
@@ -246,7 +246,7 @@=0A=
 	if (!h)=0A=
 		return 0;=0A=
 =0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++) {=0A=
+	for (i =3D 0; i < h->size; i++) {=0A=
 		cur =3D h->htable[i];=0A=
 		while (cur !=3D NULL) {=0A=
 			ret =3D apply(&cur->key, &cur->datum, args);=0A=
@@ -258,14 +258,17 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-int avtab_init(struct avtab *h)=0A=
+int avtab_init(struct avtab *h, u32 bits)=0A=
 {=0A=
 	int i;=0A=
 =0A=
-	h->htable =3D vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);=0A=
+	h->size =3D 1 << bits;=0A=
+	h->mask =3D h->size - 1;=0A=
+=0A=
+	h->htable =3D vmalloc(sizeof(*(h->htable)) * h->size);=0A=
 	if (!h->htable)=0A=
 		return -ENOMEM;=0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++)=0A=
+	for (i =3D 0; i < h->size; i++)=0A=
 		h->htable[i] =3D NULL;=0A=
 	h->nel =3D 0;=0A=
 	return 0;=0A=
@@ -278,7 +281,7 @@=0A=
 =0A=
 	slots_used =3D 0;=0A=
 	max_chain_len =3D 0;=0A=
-	for (i =3D 0; i < AVTAB_SIZE; i++) {=0A=
+	for (i =3D 0; i < h->size; i++) {=0A=
 		cur =3D h->htable[i];=0A=
 		if (cur) {=0A=
 			slots_used++;=0A=
@@ -294,7 +297,7 @@=0A=
 	}=0A=
 =0A=
 	printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest "=0A=
-	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,=0A=
+	       "chain length %d\n", tag, h->nel, slots_used, h->size,=0A=
 	       max_chain_len);=0A=
 }=0A=
 =0A=
diff -Nru a/linux-2.6/security/selinux/ss/avtab.h =
b/linux-2.6/security/selinux/ss/avtab.h=0A=
--- a/linux-2.6/security/selinux/ss/avtab.h	Thu Jan 15 16:22:31 2004=0A=
+++ b/linux-2.6/security/selinux/ss/avtab.h	Thu Jan 15 16:22:31 2004=0A=
@@ -53,11 +53,13 @@=0A=
 };=0A=
 =0A=
 struct avtab {=0A=
+	u32 size;=0A=
+	u32 mask; =0A=
 	struct avtab_node **htable;=0A=
 	u32 nel;	/* number of elements */=0A=
 };=0A=
 =0A=
-int avtab_init(struct avtab *);=0A=
+int avtab_init(struct avtab *h, u32 bits);=0A=
 int avtab_insert(struct avtab *h, struct avtab_key *k, struct =
avtab_datum *d);=0A=
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k, =
int specified);=0A=
 void avtab_destroy(struct avtab *h);=0A=
@@ -77,12 +79,6 @@=0A=
 struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key =
*key, int specified);=0A=
 =0A=
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int =
specified);=0A=
-=0A=
-#define AVTAB_HASH_BITS 15=0A=
-#define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)=0A=
-#define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)=0A=
-=0A=
-#define AVTAB_SIZE AVTAB_HASH_BUCKETS=0A=
 =0A=
 #endif	/* _SS_AVTAB_H_ */=0A=
 =0A=
diff -Nru a/linux-2.6/security/selinux/ss/conditional.c =
b/linux-2.6/security/selinux/ss/conditional.c=0A=
--- a/linux-2.6/security/selinux/ss/conditional.c	Thu Jan 15 16:22:31 =
2004=0A=
+++ b/linux-2.6/security/selinux/ss/conditional.c	Thu Jan 15 16:22:31 =
2004=0A=
@@ -122,7 +122,7 @@=0A=
 {=0A=
 	p->bool_val_to_struct =3D NULL;=0A=
 	p->cond_list =3D NULL;=0A=
-	if (avtab_init(&p->te_cond_avtab))=0A=
+	if (avtab_init(&p->te_cond_avtab, 8))=0A=
 		return -1;=0A=
 =0A=
 	return 0;=0A=
diff -Nru a/linux-2.6/security/selinux/ss/policydb.c =
b/linux-2.6/security/selinux/ss/policydb.c=0A=
--- a/linux-2.6/security/selinux/ss/policydb.c	Thu Jan 15 16:22:31 2004=0A=
+++ b/linux-2.6/security/selinux/ss/policydb.c	Thu Jan 15 16:22:31 2004=0A=
@@ -102,7 +102,7 @@=0A=
 			goto out_free_symtab;=0A=
 	}=0A=
 =0A=
-	rc =3D avtab_init(&p->te_avtab);=0A=
+	rc =3D avtab_init(&p->te_avtab, 15);=0A=
 	if (rc)=0A=
 		goto out_free_symtab;=0A=
 =0A=

------=_NextPart_000_00E8_01C42798.F9FC24A0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
