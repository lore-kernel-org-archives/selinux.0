Subject: Re: [PATCH] initialize sym_val_to_name arrays
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015881706A0@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015881706A0@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 13:55:27 -0400
Message-Id: <1147888527.30789.365.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-17 at 10:13 -0400, Kevin Carr wrote:
> The attached patch initializes the sym_val_to_name arrays to NULL on
> creation. There are circumstances where a symbol name might not be
> present (e.g., attributes lack names when loaded from kernel binary
> policy). Without this patch the symbol name will be undefined rather
> than NULL in those cases. Though it is possible to determine which names
> are undefined based on the policy type and the symbol datum, this patch
> helps avoid inadvertent mistakes.

Seems cleaner to then replace the malloc with a calloc, and to do
likewise elsewhere.

Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.40
diff -u -p -r1.40 policydb.c
--- libsepol/src/policydb.c	8 May 2006 15:28:25 -0000	1.40
+++ libsepol/src/policydb.c	17 May 2006 17:47:32 -0000
@@ -337,12 +337,11 @@ static int roles_init(policydb_t *p)
 	int rc;
 	role_datum_t *role;
 
-	role = malloc(sizeof(role_datum_t));
+	role = calloc(1, sizeof(role_datum_t));
 	if (!role) {
 		rc = -ENOMEM;
 		goto out;
 	}	
-	memset(role, 0, sizeof(role_datum_t));
 	key = malloc(strlen(OBJECT_R)+1);
 	if (!key) {
 		rc = -ENOMEM;
@@ -695,11 +694,9 @@ int policydb_index_others(sepol_handle_t
         
         free(p->type_val_to_struct);
         p->type_val_to_struct = (type_datum_t **)
-            malloc(p->p_types.nprim * sizeof(type_datum_t *));
+		calloc(p->p_types.nprim, sizeof(type_datum_t *));
         if (!p->type_val_to_struct)
                 return -1;
-	memset(p->type_val_to_struct, 0, 
-	       p->p_types.nprim*sizeof(type_datum_t *));
 
 	cond_init_bool_indexes(p);
 
@@ -707,7 +704,7 @@ int policydb_index_others(sepol_handle_t
 		if (p->sym_val_to_name[i])
 			free(p->sym_val_to_name[i]);
 		p->sym_val_to_name[i] = (char **)
-		    malloc(p->symtab[i].nprim * sizeof(char *));
+			calloc(p->symtab[i].nprim, sizeof(char *));
 		if (!p->sym_val_to_name[i])
 			return -1;
 		if (hashtab_map(p->symtab[i].table, index_f[i], p))
@@ -1342,10 +1339,9 @@ static int perm_read(policydb_t * p __at
 	uint32_t *buf;
 	size_t len;
 
-	perdatum = malloc(sizeof(perm_datum_t));
+	perdatum = calloc(1, sizeof(perm_datum_t));
 	if (!perdatum)
 		return -1;
-	memset(perdatum, 0, sizeof(perm_datum_t));
 
 	buf = next_entry(fp, sizeof(uint32_t)*2);
 	if (!buf)
@@ -1382,10 +1378,9 @@ static int common_read(policydb_t * p, h
 	size_t len, nel;
 	unsigned int i;
 
-	comdatum = malloc(sizeof(common_datum_t));
+	comdatum = calloc(1, sizeof(common_datum_t));
 	if (!comdatum)
 		return -1;
-	memset(comdatum, 0, sizeof(common_datum_t));
 
 	buf = next_entry(fp, sizeof(uint32_t)*4);
 	if (!buf)
@@ -1436,10 +1431,9 @@ static int read_cons_helper(policydb_t *
 
 	lc = NULL;
 	for (i = 0; i < ncons; i++) {
-		c = malloc(sizeof(constraint_node_t));
+		c = calloc(1, sizeof(constraint_node_t));
 		if (!c)
 			return -1;
-		memset(c, 0, sizeof(constraint_node_t));
 		buf = next_entry(fp, (sizeof(uint32_t) * 2));
 		if (!buf)
 			return -1;
@@ -1539,10 +1533,9 @@ static int class_read(policydb_t * p, ha
 	size_t len, len2, ncons, nel;
 	unsigned int i;
 
-	cladatum = (class_datum_t *) malloc(sizeof(class_datum_t));
+	cladatum = (class_datum_t *) calloc(1, sizeof(class_datum_t));
 	if (!cladatum)
 		return -1;
-	memset(cladatum, 0, sizeof(class_datum_t));
 
 	buf = next_entry(fp, sizeof(uint32_t)*6);
 	if (!buf)
@@ -1623,10 +1616,9 @@ static int role_read(policydb_t * p __at
 	uint32_t *buf;
 	size_t len;
 
-	role = malloc(sizeof(role_datum_t));
+	role = calloc(1, sizeof(role_datum_t));
 	if (!role)
 		return -1;
-	memset(role, 0, sizeof(role_datum_t));
 
 	buf = next_entry(fp, sizeof(uint32_t)*2);
 	if (!buf)
@@ -1685,10 +1677,9 @@ static int type_read(policydb_t * p __at
 	uint32_t *buf;
 	size_t len;
 
-	typdatum = malloc(sizeof(type_datum_t));
+	typdatum = calloc(1, sizeof(type_datum_t));
 	if (!typdatum)
 		return -1;
-	memset(typdatum, 0, sizeof(type_datum_t));
 
         if (p->policy_type == POLICY_KERN) {
                 buf = next_entry(fp, sizeof(uint32_t)*3);
@@ -1739,11 +1730,10 @@ int role_trans_read(role_trans_t **t, st
         nel = le32_to_cpu(buf[0]);
         ltr = NULL;
         for (i = 0; i < nel; i++) {
-                tr = malloc(sizeof(struct role_trans));
+                tr = calloc(1, sizeof(struct role_trans));
                 if (!tr) {
                         return -1;
                 }       
-                memset(tr, 0, sizeof(struct role_trans));
                 if (ltr) {
                         ltr->next = tr;
                 } else {
@@ -1772,11 +1762,10 @@ int role_allow_read(role_allow_t **r, st
         nel = le32_to_cpu(buf[0]);
         lra = NULL;
         for (i = 0; i < nel; i++) {
-                ra = malloc(sizeof(struct role_allow));
+                ra = calloc(1, sizeof(struct role_allow));
                 if (!ra) {
                         return -1;
                 }
-                memset(ra, 0, sizeof(struct role_allow));
                 if (lra) {
                         lra->next = ra;
                 } else {
@@ -1805,11 +1794,10 @@ static int ocontext_read (struct policyd
                 nel = le32_to_cpu(buf[0]);
                 l = NULL;
                 for (j = 0; j < nel; j++) {
-                        c = malloc(sizeof(ocontext_t));
+			c = calloc(1, sizeof(ocontext_t));
                         if (!c) {
                                 return -1;
                         }
-                        memset(c, 0, sizeof(ocontext_t));
                         if (l) {
                                 l->next = c;
                         } else {
@@ -1918,11 +1906,10 @@ static int genfs_read (policydb_t *p, st
         nel = le32_to_cpu(buf[0]);
         genfs_p = NULL;         
         for (i = 0; i < nel; i++) {
-                newgenfs = malloc(sizeof(genfs_t));
+                newgenfs = calloc(1, sizeof(genfs_t));
                 if (!newgenfs) {        
                         goto bad;
                 }                       
-                memset(newgenfs, 0, sizeof(genfs_t));
                 buf = next_entry(fp, sizeof(uint32_t));
                 if (!buf)       
                         goto bad;
@@ -1956,11 +1943,10 @@ static int genfs_read (policydb_t *p, st
                         goto bad;
                 nel2 = le32_to_cpu(buf[0]);
                 for (j = 0; j < nel2; j++) {
-                        newc = malloc(sizeof(ocontext_t));
+                        newc = calloc(1, sizeof(ocontext_t));
                         if (!newc) {
                                 goto bad;
                         }
-                        memset(newc, 0, sizeof(ocontext_t));
                         buf = next_entry(fp, sizeof(uint32_t));
                         if (!buf)
                                 goto bad;
@@ -2043,10 +2029,9 @@ static int user_read(policydb_t * p, has
 	uint32_t *buf;
 	size_t len;
 
-	usrdatum = malloc(sizeof(user_datum_t));
+	usrdatum = calloc(1, sizeof(user_datum_t));
 	if (!usrdatum)
 		return -1;
-	memset(usrdatum, 0, sizeof(user_datum_t));
 
 	buf = next_entry(fp, sizeof(uint32_t)*2);
 	if (!buf)
@@ -2096,10 +2081,9 @@ static int sens_read(policydb_t * p __at
 	level_datum_t *levdatum;
 	uint32_t *buf, len;
 
-	levdatum = malloc(sizeof(level_datum_t));
+	levdatum = calloc(1, sizeof(level_datum_t));
 	if (!levdatum)
 		return -1;
-	memset(levdatum, 0, sizeof(level_datum_t));
 
 	buf = next_entry(fp, (sizeof(uint32_t) * 2));
 	if (!buf)
@@ -2137,10 +2121,9 @@ static int cat_read(policydb_t * p __att
 	cat_datum_t *catdatum;
 	uint32_t *buf, len;
 
-	catdatum = malloc(sizeof(cat_datum_t));
+	catdatum = calloc(1, sizeof(cat_datum_t));
 	if (!catdatum)
 		return -1;
-	memset(catdatum, 0, sizeof(cat_datum_t));
 
 	buf = next_entry(fp, (sizeof(uint32_t) * 3));
 	if (!buf)
@@ -2259,10 +2242,9 @@ static int range_read(policydb_t *p, str
         nel = le32_to_cpu(buf[0]);
         lrt = NULL;
         for (i = 0; i < nel; i++) {
-                rt = malloc(sizeof(range_trans_t));
+                rt = calloc(1, sizeof(range_trans_t));
                 if (!rt)
                         return -1;
-                memset(rt, 0, sizeof(range_trans_t));
                 if (lrt)
                         lrt->next = rt;
                 else

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
