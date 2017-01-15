Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0FD4ofm000632
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 08:04:50 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7B84056481B
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 14:04:18 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/5] libsepol: use constant keys in hashtab functions
Date: Sun, 15 Jan 2017 14:03:55 +0100
Message-Id: <20170115130359.6108-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Even though "hashtab_key_t" is an alias for "char *", "const
hashtab_key_t" is not an alias for "(const char) *" but means "(char *)
const".

Introduce const_hashtab_key_t to map "(const char) *" and use it in
hashtab_search() and hashtab key comparison functions.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c                | 48 ++++++++++++++--------------
 libsepol/cil/src/cil_strpool.c               | 12 +++----
 libsepol/include/sepol/policydb/hashtab.h    | 13 ++++----
 libsepol/src/hashtab.c                       |  8 ++---
 libsepol/src/policydb.c                      |  8 ++---
 libsepol/src/roles.c                         |  3 +-
 libsepol/src/symtab.c                        | 16 ++++------
 libsepol/src/users.c                         | 12 +++----
 policycoreutils/newrole/hashtab.c            |  8 ++---
 policycoreutils/newrole/hashtab.h            | 13 ++++----
 policycoreutils/newrole/newrole.c            | 12 +++----
 semodule-utils/semodule_deps/semodule_deps.c | 16 ++++------
 12 files changed, 77 insertions(+), 92 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 60c175029c27..aaad364efce7 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4027,53 +4027,53 @@ exit:
 	return rc;
 }
 
-static unsigned int filename_trans_hash(hashtab_t h, hashtab_key_t key)
+static unsigned int filename_trans_hash(hashtab_t h, const_hashtab_key_t key)
 {
-	filename_trans_t *k = (filename_trans_t *)key;
+	const filename_trans_t *k = (const filename_trans_t *)key;
 	return ((k->tclass + (k->ttype << 2) +
 				(k->stype << 9)) & (h->size - 1));
 }
 
 static int filename_trans_compare(hashtab_t h
-             __attribute__ ((unused)), hashtab_key_t key1,
-			              hashtab_key_t key2)
+             __attribute__ ((unused)), const_hashtab_key_t key1,
+			              const_hashtab_key_t key2)
 {
-	filename_trans_t *a = (filename_trans_t *)key1;
-	filename_trans_t *b = (filename_trans_t *)key2;
+	const filename_trans_t *a = (const filename_trans_t *)key1;
+	const filename_trans_t *b = (const filename_trans_t *)key2;
 
 	return a->stype != b->stype || a->ttype != b->ttype || a->tclass != b->tclass || strcmp(a->name, b->name);
 }
 
-static unsigned int range_trans_hash(hashtab_t h, hashtab_key_t key)
+static unsigned int range_trans_hash(hashtab_t h, const_hashtab_key_t key)
 {
-	range_trans_t *k = (range_trans_t *)key;
+	const range_trans_t *k = (const range_trans_t *)key;
 	return ((k->target_class + (k->target_type << 2) +
 				(k->source_type << 5)) & (h->size - 1));
 }
 
 static int range_trans_compare(hashtab_t h
-             __attribute__ ((unused)), hashtab_key_t key1,
-			              hashtab_key_t key2)
+             __attribute__ ((unused)), const_hashtab_key_t key1,
+			              const_hashtab_key_t key2)
 {
-	range_trans_t *a = (range_trans_t *)key1;
-	range_trans_t *b = (range_trans_t *)key2;
+	const range_trans_t *a = (const range_trans_t *)key1;
+	const range_trans_t *b = (const range_trans_t *)key2;
 
 	return a->source_type != b->source_type || a->target_type != b->target_type || a->target_class != b->target_class;
 }
 
-static unsigned int role_trans_hash(hashtab_t h, hashtab_key_t key)
+static unsigned int role_trans_hash(hashtab_t h, const_hashtab_key_t key)
 {
-	role_trans_t *k = (role_trans_t *)key;
+	const role_trans_t *k = (const role_trans_t *)key;
 	return ((k->role + (k->type << 2) +
 				(k->tclass << 5)) & (h->size - 1));
 }
 
 static int role_trans_compare(hashtab_t h
-             __attribute__ ((unused)), hashtab_key_t key1,
-			              hashtab_key_t key2)
+             __attribute__ ((unused)), const_hashtab_key_t key1,
+			              const_hashtab_key_t key2)
 {
-	role_trans_t *a = (role_trans_t *)key1;
-	role_trans_t *b = (role_trans_t *)key2;
+	const role_trans_t *a = (const role_trans_t *)key1;
+	const role_trans_t *b = (const role_trans_t *)key2;
 
 	return a->role != b->role || a->type != b->type || a->tclass != b->tclass;
 }
@@ -4081,9 +4081,9 @@ static int role_trans_compare(hashtab_t h
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
-static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, hashtab_key_t key)
+static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, const_hashtab_key_t key)
 {
-	avtab_key_t *k = (avtab_key_t *)key;
+	const avtab_key_t *k = (const avtab_key_t *)key;
 
 	static const uint32_t c1 = 0xcc9e2d51;
 	static const uint32_t c2 = 0x1b873593;
@@ -4121,11 +4121,11 @@ static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, hashtab_ke
 }
 
 static int avrulex_compare(hashtab_t h
-             __attribute__ ((unused)), hashtab_key_t key1,
-			              hashtab_key_t key2)
+             __attribute__ ((unused)), const_hashtab_key_t key1,
+			              const_hashtab_key_t key2)
 {
-	avtab_key_t *a = (avtab_key_t *)key1;
-	avtab_key_t *b = (avtab_key_t *)key2;
+	const avtab_key_t *a = (const avtab_key_t *)key1;
+	const avtab_key_t *b = (const avtab_key_t *)key2;
 
 	return a->source_type != b->source_type || a->target_type != b->target_type || a->target_class != b->target_class || a->specified != b->specified;
 }
diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index 5b7df8c6e0ce..b1396d2daebb 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -45,14 +45,14 @@ static pthread_mutex_t cil_strpool_mutex = PTHREAD_MUTEX_INITIALIZER;
 static unsigned int cil_strpool_readers = 0;
 static hashtab_t cil_strpool_tab = NULL;
 
-static unsigned int cil_strpool_hash(hashtab_t h, hashtab_key_t key)
+static unsigned int cil_strpool_hash(hashtab_t h, const_hashtab_key_t key)
 {
-	char *p, *keyp;
+	const char *p, *keyp;
 	size_t size;
 	unsigned int val;
 
 	val = 0;
-	keyp = (char*)key;
+	keyp = (const char*)key;
 	size = strlen(keyp);
 	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
 		val =
@@ -60,10 +60,10 @@ static unsigned int cil_strpool_hash(hashtab_t h, hashtab_key_t key)
 	return val & (h->size - 1);
 }
 
-static int cil_strpool_compare(hashtab_t h __attribute__ ((unused)), hashtab_key_t key1, hashtab_key_t key2)
+static int cil_strpool_compare(hashtab_t h __attribute__ ((unused)), const_hashtab_key_t key1, const_hashtab_key_t key2)
 {
-	char *keyp1 = (char*)key1;
-	char *keyp2 = (char*)key2;
+	const char *keyp1 = (const char*)key1;
+	const char *keyp2 = (const char*)key2;
 	return strcmp(keyp1, keyp2);
 }
 
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index df49258c7cba..ae5674adcb7f 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -23,6 +23,7 @@ extern "C" {
 #endif
 
 typedef char *hashtab_key_t;	/* generic key type */
+typedef const char *const_hashtab_key_t;	/* constant generic key type */
 typedef void *hashtab_datum_t;	/* generic datum type */
 
 typedef struct hashtab_node *hashtab_ptr_t;
@@ -37,8 +38,8 @@ typedef struct hashtab_val {
 	hashtab_ptr_t *htable;	/* hash table */
 	unsigned int size;	/* number of slots in hash table */
 	uint32_t nel;		/* number of elements in hash table */
-	unsigned int (*hash_value) (struct hashtab_val * h, hashtab_key_t key);	/* hash function */
-	int (*keycmp) (struct hashtab_val * h, hashtab_key_t key1, hashtab_key_t key2);	/* key comparison function */
+	unsigned int (*hash_value) (struct hashtab_val * h, const_hashtab_key_t key);	/* hash function */
+	int (*keycmp) (struct hashtab_val * h, const_hashtab_key_t key1, const_hashtab_key_t key2);	/* key comparison function */
 } hashtab_val_t;
 
 typedef hashtab_val_t *hashtab_t;
@@ -50,11 +51,11 @@ typedef hashtab_val_t *hashtab_t;
    the new hash table otherwise.
  */
 extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-							    const hashtab_key_t
+							    const_hashtab_key_t
 							    key),
 				int (*keycmp) (hashtab_t h,
-					       const hashtab_key_t key1,
-					       const hashtab_key_t key2),
+					       const_hashtab_key_t key1,
+					       const_hashtab_key_t key2),
 				unsigned int size);
 /*
    Inserts the specified (key, datum) pair into the specified hash table.
@@ -98,7 +99,7 @@ extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
    Returns NULL if no entry has the specified key or
    the datum of the entry otherwise.
  */
-extern hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t k);
+extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k);
 
 /*
    Destroys the specified hash table.
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index c4be72cd3f5f..ec49c1571534 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -33,10 +33,10 @@
 #include <sepol/policydb/hashtab.h>
 
 hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-						     const hashtab_key_t key),
+						     const_hashtab_key_t key),
 			 int (*keycmp) (hashtab_t h,
-					const hashtab_key_t key1,
-					const hashtab_key_t key2),
+					const_hashtab_key_t key1,
+					const_hashtab_key_t key2),
 			 unsigned int size)
 {
 
@@ -175,7 +175,7 @@ int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
 	return SEPOL_OK;
 }
 
-hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t key)
+hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 {
 
 	int hvalue;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ed4bdc8c821e..3f9b1f3fd2ac 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -727,7 +727,7 @@ partial_name_hash(unsigned long c, unsigned long prevhash)
 	return (prevhash + (c << 4) + (c >> 4)) * 11;
 }
 
-static unsigned int filenametr_hash(hashtab_t h, hashtab_key_t k)
+static unsigned int filenametr_hash(hashtab_t h, const_hashtab_key_t k)
 {
 	const struct filename_trans *ft = (const struct filename_trans *)k;
 	unsigned long hash;
@@ -743,7 +743,7 @@ static unsigned int filenametr_hash(hashtab_t h, hashtab_key_t k)
 }
 
 static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
-			  hashtab_key_t k1, hashtab_key_t k2)
+			  const_hashtab_key_t k1, const_hashtab_key_t k2)
 {
 	const struct filename_trans *ft1 = (const struct filename_trans *)k1;
 	const struct filename_trans *ft2 = (const struct filename_trans *)k2;
@@ -765,7 +765,7 @@ static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
 
 }
 
-static unsigned int rangetr_hash(hashtab_t h, hashtab_key_t k)
+static unsigned int rangetr_hash(hashtab_t h, const_hashtab_key_t k)
 {
 	const struct range_trans *key = (const struct range_trans *)k;
 	return (key->source_type + (key->target_type << 3) +
@@ -773,7 +773,7 @@ static unsigned int rangetr_hash(hashtab_t h, hashtab_key_t k)
 }
 
 static int rangetr_cmp(hashtab_t h __attribute__ ((unused)),
-		       hashtab_key_t k1, hashtab_key_t k2)
+		       const_hashtab_key_t k1, const_hashtab_key_t k2)
 {
 	const struct range_trans *key1 = (const struct range_trans *)k1;
 	const struct range_trans *key2 = (const struct range_trans *)k2;
diff --git a/libsepol/src/roles.c b/libsepol/src/roles.c
index 713d834df3f9..4540cee80e19 100644
--- a/libsepol/src/roles.c
+++ b/libsepol/src/roles.c
@@ -13,8 +13,7 @@ int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
 {
 
 	policydb_t *policydb = &p->p;
-	*response = (hashtab_search(policydb->p_roles.table,
-				    (const hashtab_key_t)role) != NULL);
+	*response = (hashtab_search(policydb->p_roles.table, role) != NULL);
 
 	return STATUS_SUCCESS;
 }
diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
index b319c8f2b0e4..c1e625dbf16f 100644
--- a/libsepol/src/symtab.c
+++ b/libsepol/src/symtab.c
@@ -11,14 +11,14 @@
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
 
-static unsigned int symhash(hashtab_t h, hashtab_key_t key)
+static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
 {
-	char *p, *keyp;
+	const char *p, *keyp;
 	size_t size;
 	unsigned int val;
 
 	val = 0;
-	keyp = (char *)key;
+	keyp = (const char *)key;
 	size = strlen(keyp);
 	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
 		val =
@@ -27,14 +27,10 @@ static unsigned int symhash(hashtab_t h, hashtab_key_t key)
 }
 
 static int symcmp(hashtab_t h
-		  __attribute__ ((unused)), hashtab_key_t key1,
-		  hashtab_key_t key2)
+		  __attribute__ ((unused)), const_hashtab_key_t key1,
+		  const_hashtab_key_t key2)
 {
-	char *keyp1, *keyp2;
-
-	keyp1 = (char *)key1;
-	keyp2 = (char *)key2;
-	return strcmp(keyp1, keyp2);
+	return strcmp(key1, key2);
 }
 
 int symtab_init(symtab_t * s, unsigned int size)
diff --git a/libsepol/src/users.c b/libsepol/src/users.c
index 3ffb166b1c66..1929399bf447 100644
--- a/libsepol/src/users.c
+++ b/libsepol/src/users.c
@@ -139,8 +139,7 @@ int sepol_user_modify(sepol_handle_t * handle,
 		goto err;
 
 	/* Now, see if a user exists */
-	usrdatum = hashtab_search(policydb->p_users.table,
-				  (const hashtab_key_t)cname);
+	usrdatum = hashtab_search(policydb->p_users.table, cname);
 
 	/* If it does, we will modify it */
 	if (usrdatum) {
@@ -163,8 +162,7 @@ int sepol_user_modify(sepol_handle_t * handle,
 	for (i = 0; i < num_roles; i++) {
 
 		/* Search for the role */
-		roldatum = hashtab_search(policydb->p_roles.table,
-					  (const hashtab_key_t)roles[i]);
+		roldatum = hashtab_search(policydb->p_roles.table, roles[i]);
 		if (!roldatum) {
 			ERR(handle, "undefined role %s for user %s",
 			    roles[i], cname);
@@ -301,8 +299,7 @@ int sepol_user_exists(sepol_handle_t * handle __attribute__ ((unused)),
 	const char *cname;
 	sepol_user_key_unpack(key, &cname);
 
-	*response = (hashtab_search(policydb->p_users.table,
-				    (const hashtab_key_t)cname) != NULL);
+	*response = (hashtab_search(policydb->p_users.table, cname) != NULL);
 
 	return STATUS_SUCCESS;
 }
@@ -328,8 +325,7 @@ int sepol_user_query(sepol_handle_t * handle,
 	const char *cname;
 	sepol_user_key_unpack(key, &cname);
 
-	usrdatum = hashtab_search(policydb->p_users.table,
-				  (const hashtab_key_t)cname);
+	usrdatum = hashtab_search(policydb->p_users.table, cname);
 
 	if (!usrdatum) {
 		*response = NULL;
diff --git a/policycoreutils/newrole/hashtab.c b/policycoreutils/newrole/hashtab.c
index 0442ab35ad26..77ed143c832d 100644
--- a/policycoreutils/newrole/hashtab.c
+++ b/policycoreutils/newrole/hashtab.c
@@ -12,10 +12,10 @@
 #include "hashtab.h"
 
 hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-						     const hashtab_key_t key),
+						     const_hashtab_key_t key),
 			 int (*keycmp) (hashtab_t h,
-					const hashtab_key_t key1,
-					const hashtab_key_t key2),
+					const_hashtab_key_t key1,
+					const_hashtab_key_t key2),
 			 unsigned int size)
 {
 
@@ -154,7 +154,7 @@ int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
 	return HASHTAB_SUCCESS;
 }
 
-hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t key)
+hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 {
 
 	int hvalue;
diff --git a/policycoreutils/newrole/hashtab.h b/policycoreutils/newrole/hashtab.h
index abc80c312257..9f737df64e70 100644
--- a/policycoreutils/newrole/hashtab.h
+++ b/policycoreutils/newrole/hashtab.h
@@ -19,6 +19,7 @@
 #include <stdio.h>
 
 typedef char *hashtab_key_t;	/* generic key type */
+typedef const char *const_hashtab_key_t;	/* constant generic key type */
 typedef void *hashtab_datum_t;	/* generic datum type */
 
 typedef struct hashtab_node *hashtab_ptr_t;
@@ -33,8 +34,8 @@ typedef struct hashtab_val {
 	hashtab_ptr_t *htable;	/* hash table */
 	unsigned int size;	/* number of slots in hash table */
 	uint32_t nel;		/* number of elements in hash table */
-	unsigned int (*hash_value) (struct hashtab_val * h, hashtab_key_t key);	/* hash function */
-	int (*keycmp) (struct hashtab_val * h, hashtab_key_t key1, hashtab_key_t key2);	/* key comparison function */
+	unsigned int (*hash_value) (struct hashtab_val * h, const_hashtab_key_t key);	/* hash function */
+	int (*keycmp) (struct hashtab_val * h, const_hashtab_key_t key1, const_hashtab_key_t key2);	/* key comparison function */
 } hashtab_val_t;
 
 typedef hashtab_val_t *hashtab_t;
@@ -52,11 +53,11 @@ typedef hashtab_val_t *hashtab_t;
    the new hash table otherwise.
  */
 extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-							    const hashtab_key_t
+							    const_hashtab_key_t
 							    key),
 				int (*keycmp) (hashtab_t h,
-					       const hashtab_key_t key1,
-					       const hashtab_key_t key2),
+					       const_hashtab_key_t key1,
+					       const_hashtab_key_t key2),
 				unsigned int size);
 /*
    Inserts the specified (key, datum) pair into the specified hash table.
@@ -100,7 +101,7 @@ extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
    Returns NULL if no entry has the specified key or
    the datum of the entry otherwise.
  */
-extern hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t k);
+extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k);
 
 /*
    Destroys the specified hash table.
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index c6544eed07b9..faf937b94f6d 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -228,7 +228,7 @@ static int free_hashtab_entry(hashtab_key_t key, hashtab_datum_t d,
 	return 0;
 }
 
-static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
+static unsigned int reqsymhash(hashtab_t h, const_hashtab_key_t key)
 {
 	char *p, *keyp;
 	size_t size;
@@ -244,14 +244,10 @@ static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
 }
 
 static int reqsymcmp(hashtab_t h
-		     __attribute__ ((unused)), hashtab_key_t key1,
-		     hashtab_key_t key2)
+		     __attribute__ ((unused)), const_hashtab_key_t key1,
+		     const_hashtab_key_t key2)
 {
-	char *keyp1, *keyp2;
-
-	keyp1 = (char *)key1;
-	keyp2 = (char *)key2;
-	return strcmp(keyp1, keyp2);
+	return strcmp(key1, key2);
 }
 
 static hashtab_t app_service_names = NULL;
diff --git a/semodule-utils/semodule_deps/semodule_deps.c b/semodule-utils/semodule_deps/semodule_deps.c
index ab3d1cb800af..ab99d159f788 100644
--- a/semodule-utils/semodule_deps/semodule_deps.c
+++ b/semodule-utils/semodule_deps/semodule_deps.c
@@ -52,14 +52,14 @@ static void usage(char *program_name)
 /* Basic string hash and compare for the hashtables used in
  * generate_requires. Copied from symtab.c.
  */
-static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
+static unsigned int reqsymhash(hashtab_t h, const_hashtab_key_t key)
 {
-	char *p, *keyp;
+	const char *p, *keyp;
 	size_t size;
 	unsigned int val;
 
 	val = 0;
-	keyp = (char *)key;
+	keyp = (const char *)key;
 	size = strlen(keyp);
 	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
 		val =
@@ -68,14 +68,10 @@ static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
 }
 
 static int reqsymcmp(hashtab_t h
-		     __attribute__ ((unused)), hashtab_key_t key1,
-		     hashtab_key_t key2)
+		     __attribute__ ((unused)), const_hashtab_key_t key1,
+		     const_hashtab_key_t key2)
 {
-	char *keyp1, *keyp2;
-
-	keyp1 = (char *)key1;
-	keyp2 = (char *)key2;
-	return strcmp(keyp1, keyp2);
+	return strcmp(key1, key2);
 }
 
 /* Load a policy package from the given filename. Progname is used for
-- 
2.11.0
