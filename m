Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9I9qUWt013439
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 05:52:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9I9qK0p010042
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 09:52:20 GMT
Received: from extern.mail.waldi.eu.org (nat.moeglingen.waldi.eu.org [82.139.201.30] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h9I9qJr7010039
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 09:52:19 GMT
Date: Sat, 18 Oct 2003 11:52:22 +0200
From: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: Re: checkpolicy patch
Message-ID: <20031018095222.GA18713@wavehammer.waldi.eu.org>
References: <20031018090524.GA17313@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
In-Reply-To: <20031018090524.GA17313@wavehammer.waldi.eu.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i forget the patch

bastian

-- 
We do not colonize.  We conquer.  We rule.  There is no other way for us.
		-- Rojan, "By Any Other Name", stardate 4657.5

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=checkpolicy-1

Index: symtab.c
===================================================================
--- symtab.c	(.../upstream/current/checkpolicy)	(revision 12)
+++ symtab.c	(.../trunk/checkpolicy)	(revision 12)
@@ -12,19 +12,19 @@
 static unsigned int symhash(hashtab_t h, hashtab_key_t key)
 {
 	char *p, *keyp;
-	unsigned int size;
+	size_t size;
 	unsigned int val;
 
 
 	val = 0;
 	keyp = (char *) key;
 	size = strlen(keyp);
-	for (p = keyp; (p - keyp) < size; p++)
+	for (p = keyp; ((size_t)(p - keyp)) < size; p++)
 		val = (val << 4 | (val >> (8*sizeof(unsigned int)-4))) ^ (*p);
 	return val & (h->size - 1);
 }
 
-static int symcmp(hashtab_t h, hashtab_key_t key1, hashtab_key_t key2)
+static int symcmp(hashtab_t h __attribute__ ((unused)), hashtab_key_t key1, hashtab_key_t key2)
 {
 	char *keyp1, *keyp2;
 
Index: policydb.c
===================================================================
--- policydb.c	(.../upstream/current/checkpolicy)	(revision 12)
+++ policydb.c	(.../trunk/checkpolicy)	(revision 12)
@@ -287,7 +287,7 @@
  * symbol data in the policy database.
  */
 
-static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	if (key)
 		kfree(key);
@@ -296,7 +296,7 @@
 }
 
 
-static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	common_datum_t *comdatum;
 
@@ -310,7 +310,7 @@
 }
 
 
-static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	class_datum_t *cladatum;
 	constraint_node_t *constraint, *ctemp;
@@ -340,7 +340,7 @@
 	return 0;
 }
 
-static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	role_datum_t *role;
 
@@ -353,7 +353,7 @@
 	return 0;
 }
 
-static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	if (key)
 		kfree(key);
@@ -361,7 +361,7 @@
 	return 0;
 }
 
-static int user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	user_datum_t *usrdatum;
 
@@ -529,7 +529,7 @@
  */
 static int context_read_and_validate(context_struct_t * c,
 				     policydb_t * p,
-				     void * fp)
+				     struct policy_file * fp)
 {
 	__u32 *buf;
 
@@ -561,11 +561,12 @@
  * binary representation file.
  */
 
-static int perm_read(policydb_t * p, hashtab_t h, void * fp)
+static int perm_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	perm_datum_t *perdatum;
-	__u32 *buf, len;
+	__u32 *buf;
+	size_t len;
 
 	perdatum = kmalloc(sizeof(perm_datum_t),GFP_KERNEL);
 	if (!perdatum)
@@ -601,12 +602,13 @@
 }
 
 
-static int common_read(policydb_t * p, hashtab_t h, void * fp)
+static int common_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	common_datum_t *comdatum;
-	__u32 *buf, len, nel;
-	int i;
+	__u32 *buf;
+	size_t len, nel;
+	unsigned int i;
 
 	comdatum = kmalloc(sizeof(common_datum_t),GFP_KERNEL);
 	if (!comdatum)
@@ -650,14 +652,16 @@
 }
 
 
-static int class_read(policydb_t * p, hashtab_t h, void * fp)
+static int class_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	class_datum_t *cladatum;
 	constraint_node_t *c, *lc;
 	constraint_expr_t *e, *le;
-	__u32 *buf, len, len2, ncons, nexpr, nel;
-	int i, j, depth;
+	__u32 *buf;
+	size_t len, len2, ncons, nexpr, nel;
+	unsigned int i, j;
+	int depth;
 
 	cladatum = (class_datum_t *) kmalloc(sizeof(class_datum_t),GFP_KERNEL);
 	if (!cladatum)
@@ -806,11 +810,12 @@
 }
 
 
-static int role_read(policydb_t * p, hashtab_t h, void * fp)
+static int role_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	role_datum_t *role;
-	__u32 *buf, len;
+	__u32 *buf;
+	size_t len;
 
 	role = kmalloc(sizeof(role_datum_t),GFP_KERNEL);
 	if (!role)
@@ -861,11 +866,12 @@
 }
 
 
-static int type_read(policydb_t * p, hashtab_t h, void * fp)
+static int type_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	type_datum_t *typdatum;
-	__u32 *buf, len;
+	__u32 *buf;
+	size_t len;
 
 	typdatum = kmalloc(sizeof(type_datum_t),GFP_KERNEL);
 	if (!typdatum)
@@ -899,11 +905,12 @@
 	return -1;
 }
 
-static int user_read(policydb_t * p, hashtab_t h, void * fp)
+static int user_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	user_datum_t *usrdatum;
-	__u32 *buf, len;
+	__u32 *buf;
+	size_t len;
 
 
 	usrdatum = kmalloc(sizeof(user_datum_t),GFP_KERNEL);
@@ -944,7 +951,7 @@
 }
 
 
-static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h, void * fp) =
+static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h, struct policy_file * fp) =
 {
 	common_read,
 	class_read,
@@ -961,14 +968,15 @@
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
  */
-int policydb_read(policydb_t * p, void * fp)
+int policydb_read(policydb_t * p, struct policy_file * fp)
 {
 	struct role_allow *ra, *lra;
 	struct role_trans *tr, *ltr;
 	ocontext_t *l, *c, *newc;
 	genfs_t *genfs_p, *genfs, *newgenfs;
-	int i, j;
-	__u32 *buf, len, len2, config, nprim, nel, nel2;
+	unsigned int i, j;
+	__u32 *buf, config;
+	size_t len, len2, nprim, nel, nel2;
 	char *policydb_str;
 
 	config = 0;
@@ -991,7 +999,7 @@
 
 	len = buf[1];
 	if (len != strlen(POLICYDB_STRING)) {
-		printk("security:  policydb string length %d does not match expected length %d\n", len, strlen(POLICYDB_STRING));
+		printk("security:  policydb string length %zu does not match expected length %zu\n", len, strlen(POLICYDB_STRING));
 		goto bad;
 	}
 	buf = next_entry(fp, len);
@@ -1001,7 +1009,7 @@
 	}
 	policydb_str = kmalloc(len + 1,GFP_KERNEL);
 	if (!policydb_str) {
-		printk("security:  unable to allocate memory for policydb string of length %d\n", len);
+		printk("security:  unable to allocate memory for policydb string of length %zu\n", len);
 		goto bad;
 	}
 	memcpy(policydb_str, buf, len);
Index: policydb.h
===================================================================
--- policydb.h	(.../upstream/current/checkpolicy)	(revision 12)
+++ policydb.h	(.../trunk/checkpolicy)	(revision 12)
@@ -237,8 +237,10 @@
 
 extern int policydb_context_isvalid(policydb_t *p, context_struct_t *c);
 
-extern int policydb_read(policydb_t * p, void * fp);
+struct policy_file;
 
+extern int policydb_read(policydb_t * p, struct policy_file * fp);
+
 #define PERM_SYMTAB_SIZE 32
 
 #define POLICYDB_VERSION 15

--5vNYLRcllDrimb99--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
