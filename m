Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KLKSWt023138
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:20:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KLKG0p008473
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:20:16 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
	by jazzswing.ncsc.mil  with ESMTP id h9KLKEr7008470
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:20:14 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id 5EA47170021
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 23:34:21 +0200 (CEST)
Date: Mon, 20 Oct 2003 23:20:56 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: [Patch] checkpolicy (3)
Message-ID: <20031020212056.GF3579@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

- fix calls to fwrite (size_t instead of int)
file: write.c

Joerg


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=checkpolicy-3

--- ../../upstream/current/checkpolicy/write.c	2003-10-19 19:29:31.000000000 +0200
+++ write.c	2003-10-19 19:31:42.000000000 +0200
@@ -18,17 +18,17 @@
 		count++;
 	buf[2] = cpu_to_le32(count);
 
-	items = fwrite(buf, sizeof(__u32), 3, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 3, fp);
 	if (items != 3)
 		return -1;
 
 	for (n = e->node; n; n = n->next) {
 		bit = cpu_to_le32(n->startbit);
-		items = fwrite(&bit, sizeof(__u32), 1, fp);
+		items = fwrite(&bit, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 		map = cpu_to_le64(n->map);
-		items = fwrite(&map, sizeof(__u64), 1, fp);
+		items = fwrite(&map, sizeof(__u64), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 
@@ -46,7 +46,7 @@
 	size_t items, items2;
 
 	nel = cpu_to_le32(a->nel);
-	items = fwrite(&nel, sizeof(__u32), 1, fp);
+	items = fwrite(&nel, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 
@@ -101,10 +101,10 @@
 		    FILE * fp)
 {
 	__u32 sens;
-	int items;
+	size_t items;
 
 	sens = cpu_to_le32(l->sens);
-	items = fwrite(&sens, sizeof(__u32), 1, fp);
+	items = fwrite(&sens, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 
@@ -123,7 +123,7 @@
 				  FILE * fp)
 {
 	__u32 buf[3];
-	int items, items2;
+	size_t items, items2;
 	int rel;
 
 	rel = mls_level_relation(r->level[1], r->level[0]);
@@ -163,7 +163,7 @@
 {
 	mls_perms_t *p = &cladatum->mlsperms;
 	__u32 buf[32];
-	int items, items2;
+	size_t items, items2;
 
 	items = 0;
 	buf[items++] = cpu_to_le32(p->read);
@@ -191,7 +191,7 @@
 	for (r = usrdatum->ranges; r; r = r->next)
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	for (r = usrdatum->ranges; r; r = r->next) {
@@ -207,7 +207,7 @@
 	size_t items;
 
 	buf[0] = cpu_to_le32(p->nlevels);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	return 0;
@@ -227,8 +227,8 @@
 int sens_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	level_datum_t *levdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	levdatum = (level_datum_t *) datum;
@@ -241,7 +241,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -254,8 +254,8 @@
 int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	cat_datum_t *catdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 
@@ -317,8 +317,8 @@
 static int perm_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	perm_datum_t *perdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	perdatum = (perm_datum_t *) datum;
@@ -332,7 +332,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -343,8 +343,8 @@
 static int common_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	common_datum_t *comdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	comdatum = (common_datum_t *) datum;
@@ -359,7 +359,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -375,8 +375,8 @@
 	class_datum_t *cladatum;
 	constraint_node_t *c;
 	constraint_expr_t *e;
-	__u32 buf[32], len, len2, ncons, nexpr;
-	int items, items2;
+	__u32 buf[32], ncons, nexpr;
+	size_t items, items2, len, len2;
 	FILE *fp = p;
 
 	cladatum = (class_datum_t *) datum;
@@ -406,12 +406,12 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
 	if (cladatum->comkey) {
-		items = fwrite(cladatum->comkey, 1, len2, fp);
+		items = fwrite(cladatum->comkey, (size_t) 1, len2, fp);
 		if (items != len2)
 			return -1;
 	}
@@ -425,7 +425,7 @@
 		}
 		buf[0] = cpu_to_le32(c->permissions);
 		buf[1] = cpu_to_le32(nexpr);
-		items = fwrite(buf, sizeof(__u32), 2, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 		if (items != 2)
 			return -1;
 		for (e = c->expr; e; e = e->next) {
@@ -457,8 +457,8 @@
 static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	role_datum_t *role;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	role = (role_datum_t *) datum;
@@ -471,7 +471,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -487,8 +487,8 @@
 static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	type_datum_t *typdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	typdatum = (type_datum_t *) datum;
@@ -502,7 +502,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -512,8 +512,8 @@
 static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	user_datum_t *usrdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 
@@ -527,7 +527,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -561,8 +561,8 @@
 	ocontext_t *c;
 	genfs_t *genfs;
 	int i, j;
-	__u32 buf[32], len, config, nel;
-	size_t items, items2;
+	__u32 buf[32], config;
+	size_t items, items2, len, nel;
 	char *policydb_str = POLICYDB_STRING;
 
 	config = 0;
@@ -576,7 +576,7 @@
 	items2 = fwrite(buf, sizeof(__u32), items, fp);
 	if (items != items2)
 		return -1;
-	items = fwrite(policydb_str, 1, len, fp);
+	items = fwrite(policydb_str, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -596,7 +596,7 @@
 	for (i = 0; i < SYM_NUM; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
 		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
-		items = fwrite(buf, sizeof(__u32), 2, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 		if (items != 2)
 			return -1;
 		if (hashtab_map(p->symtab[i].table, write_f[i], fp))
@@ -610,14 +610,14 @@
 	for (tr = p->role_tr; tr; tr = tr->next) 
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	for (tr = p->role_tr; tr; tr = tr->next) {
 		buf[0] = cpu_to_le32(tr->role);
 		buf[1] = cpu_to_le32(tr->type);
 		buf[2] = cpu_to_le32(tr->new_role);
-		items = fwrite(buf, sizeof(__u32), 3, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 3, fp);
 		if (items != 3)
 			return -1;		
 	}
@@ -626,13 +626,13 @@
 	for (ra = p->role_allow; ra; ra = ra->next) 
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	for (ra = p->role_allow; ra; ra = ra->next) {
 		buf[0] = cpu_to_le32(ra->role);
 		buf[1] = cpu_to_le32(ra->new_role);
-		items = fwrite(buf, sizeof(__u32), 2, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 		if (items != 2)
 			return -1;		
 	}
@@ -642,14 +642,14 @@
 		for (c = p->ocontexts[i]; c; c = c->next)
 			nel++;
 		buf[0] = cpu_to_le32(nel);
-		items = fwrite(buf, sizeof(__u32), 1, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 		for (c = p->ocontexts[i]; c; c = c->next) {
 			switch (i) {
 			case OCON_ISID:
 				buf[0] = cpu_to_le32(c->sid[0]);
-				items = fwrite(buf, sizeof(__u32), 1, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 				if (items != 1)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -659,10 +659,10 @@
 			case OCON_NETIF:
 				len = strlen(c->u.name);
 				buf[0] = cpu_to_le32(len);
-				items = fwrite(buf, sizeof(__u32), 1, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 				if (items != 1)
 					return -1;
-				items = fwrite(c->u.name, 1, len, fp);
+				items = fwrite(c->u.name, (size_t) 1, len, fp);
 				if (items != len)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -677,7 +677,7 @@
 				for (j = 0; j < 3; j++) {
 					buf[j] = cpu_to_le32(buf[j]);
 				}
-				items = fwrite(buf, sizeof(__u32), 3, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 3, fp);
 				if (items != 3)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -686,7 +686,7 @@
 			case OCON_NODE:
 				buf[0] = cpu_to_le32(c->u.node.addr);
 				buf[1] = cpu_to_le32(c->u.node.mask);
-				items = fwrite(buf, sizeof(__u32), 2, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 				if (items != 2)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -696,10 +696,10 @@
 				buf[0] = cpu_to_le32(c->v.behavior);
 				len = strlen(c->u.name);
 				buf[1] = cpu_to_le32(len);
-				items = fwrite(buf, sizeof(__u32), 2, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 				if (items != 2)
 					return -1;
-				items = fwrite(c->u.name, 1, len, fp);
+				items = fwrite(c->u.name, (size_t) 1, len, fp);
 				if (items != len)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -713,36 +713,36 @@
 	for (genfs = p->genfs; genfs; genfs = genfs->next) 
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;	
 	for (genfs = p->genfs; genfs; genfs = genfs->next) {
 		len = strlen(genfs->fstype);
 		buf[0] = cpu_to_le32(len);
-		items = fwrite(buf, sizeof(__u32), 1, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
-		items = fwrite(genfs->fstype, 1, len, fp);
+		items = fwrite(genfs->fstype, (size_t) 1, len, fp);
 		if (items != len)
 			return -1;
 		nel = 0;
 		for (c = genfs->head; c; c = c->next)
 			nel++;
 		buf[0] = cpu_to_le32(nel);
-		items = fwrite(buf, sizeof(__u32), 1, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 		for (c = genfs->head; c; c = c->next) {
 			len = strlen(c->u.name);
 			buf[0] = cpu_to_le32(len);
-			items = fwrite(buf, sizeof(__u32), 1, fp);
+			items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 			if (items != 1)
 				return -1;
-			items = fwrite(c->u.name, 1, len, fp);
+			items = fwrite(c->u.name, (size_t) 1, len, fp);
 			if (items != len)
 				return -1;
 			buf[0] = cpu_to_le32(c->v.sclass);
-			items = fwrite(buf, sizeof(__u32), 1, fp);
+			items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 			if (items != 1)
 				return -1;
 			if (context_write(&c->context[0], fp))

--DBIVS5p969aUjpLe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
