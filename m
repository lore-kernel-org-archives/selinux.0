Subject: [PATCH] changing whitespace for fun and profit: policydb.c
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 17 Apr 2008 13:37:12 -0400
Message-Id: <1208453832.2985.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

More formatting changes.  Aside from the 80 character line limit even
the checkpatch scripts like this file now.  Too bad I don't get paid by
the lines of code I change.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/ss/policydb.c |  131 +++++++++++++++++++---------------------
 1 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 891c2d0..84f8cc7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -11,7 +11,7 @@
  *
  * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
- * 	Added conditional policy language extensions
+ *	Added conditional policy language extensions
  *
  * Updated: Hewlett-Packard <paul.moore@hp.com>
  *
@@ -21,7 +21,7 @@
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
+ *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  */
 
@@ -51,7 +51,7 @@ static char *symtab_name[SYM_NUM] = {
 };
 #endif
 
-int selinux_mls_enabled = 0;
+int selinux_mls_enabled;
 
 static unsigned int symtab_sizes[SYM_NUM] = {
 	2,
@@ -73,39 +73,39 @@ struct policydb_compat_info {
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
 	{
-		.version        = POLICYDB_VERSION_BASE,
-		.sym_num        = SYM_NUM - 3,
-		.ocon_num       = OCON_NUM - 1,
+		.version	= POLICYDB_VERSION_BASE,
+		.sym_num	= SYM_NUM - 3,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
-		.version        = POLICYDB_VERSION_BOOL,
-		.sym_num        = SYM_NUM - 2,
-		.ocon_num       = OCON_NUM - 1,
+		.version	= POLICYDB_VERSION_BOOL,
+		.sym_num	= SYM_NUM - 2,
+		.ocon_num	= OCON_NUM - 1,
 	},
 	{
-		.version        = POLICYDB_VERSION_IPV6,
-		.sym_num        = SYM_NUM - 2,
-		.ocon_num       = OCON_NUM,
+		.version	= POLICYDB_VERSION_IPV6,
+		.sym_num	= SYM_NUM - 2,
+		.ocon_num	= OCON_NUM,
 	},
 	{
-		.version        = POLICYDB_VERSION_NLCLASS,
-		.sym_num        = SYM_NUM - 2,
-		.ocon_num       = OCON_NUM,
+		.version	= POLICYDB_VERSION_NLCLASS,
+		.sym_num	= SYM_NUM - 2,
+		.ocon_num	= OCON_NUM,
 	},
 	{
-		.version        = POLICYDB_VERSION_MLS,
-		.sym_num        = SYM_NUM,
-		.ocon_num       = OCON_NUM,
+		.version	= POLICYDB_VERSION_MLS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
 	},
 	{
-		.version        = POLICYDB_VERSION_AVTAB,
-		.sym_num        = SYM_NUM,
-		.ocon_num       = OCON_NUM,
+		.version	= POLICYDB_VERSION_AVTAB,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
 	},
 	{
-		.version        = POLICYDB_VERSION_RANGETRANS,
-		.sym_num        = SYM_NUM,
-		.ocon_num       = OCON_NUM,
+		.version	= POLICYDB_VERSION_RANGETRANS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
 	},
 	{
 		.version	= POLICYDB_VERSION_POLCAP,
@@ -152,7 +152,7 @@ static int roles_init(struct policydb *p)
 		rc = -EINVAL;
 		goto out_free_role;
 	}
-	key = kmalloc(strlen(OBJECT_R)+1,GFP_KERNEL);
+	key = kmalloc(strlen(OBJECT_R)+1, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto out_free_role;
@@ -424,7 +424,7 @@ static int policydb_index_others(struct policydb *p)
 
 	p->role_val_to_struct =
 		kmalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
-		        GFP_KERNEL);
+			GFP_KERNEL);
 	if (!p->role_val_to_struct) {
 		rc = -ENOMEM;
 		goto out;
@@ -432,7 +432,7 @@ static int policydb_index_others(struct policydb *p)
 
 	p->user_val_to_struct =
 		kmalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
-		        GFP_KERNEL);
+			GFP_KERNEL);
 	if (!p->user_val_to_struct) {
 		rc = -ENOMEM;
 		goto out;
@@ -634,7 +634,7 @@ void policydb_destroy(struct policydb *p)
 		while (c) {
 			ctmp = c;
 			c = c->next;
-			ocontext_destroy(ctmp,i);
+			ocontext_destroy(ctmp, i);
 		}
 		p->ocontexts[i] = NULL;
 	}
@@ -647,7 +647,7 @@ void policydb_destroy(struct policydb *p)
 		while (c) {
 			ctmp = c;
 			c = c->next;
-			ocontext_destroy(ctmp,OCON_FSUSE);
+			ocontext_destroy(ctmp, OCON_FSUSE);
 		}
 		gtmp = g;
 		g = g->next;
@@ -664,14 +664,14 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(ltr);
 
-	for (ra = p->role_allow; ra; ra = ra -> next) {
+	for (ra = p->role_allow; ra; ra = ra->next) {
 		cond_resched();
 		kfree(lra);
 		lra = ra;
 	}
 	kfree(lra);
 
-	for (rt = p->range_tr; rt; rt = rt -> next) {
+	for (rt = p->range_tr; rt; rt = rt->next) {
 		cond_resched();
 		if (lrt) {
 			ebitmap_destroy(&lrt->target_range.level[0].cat);
@@ -924,7 +924,7 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
 
-	key = kmalloc(len + 1,GFP_KERNEL);
+	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -971,7 +971,7 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[3]);
 
-	key = kmalloc(len + 1,GFP_KERNEL);
+	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -998,7 +998,7 @@ bad:
 }
 
 static int read_cons_helper(struct constraint_node **nodep, int ncons,
-                            int allowxtarget, void *fp)
+			    int allowxtarget, void *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
@@ -1012,11 +1012,10 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 		if (!c)
 			return -ENOMEM;
 
-		if (lc) {
+		if (lc)
 			lc->next = c;
-		} else {
+		else
 			*nodep = c;
-		}
 
 		rc = next_entry(buf, fp, (sizeof(u32) * 2));
 		if (rc < 0)
@@ -1030,11 +1029,10 @@ static int read_cons_helper(struct constraint_node **nodep, int ncons,
 			if (!e)
 				return -ENOMEM;
 
-			if (le) {
+			if (le)
 				le->next = e;
-			} else {
+			else
 				c->expr = e;
-			}
 
 			rc = next_entry(buf, fp, (sizeof(u32) * 3));
 			if (rc < 0)
@@ -1111,7 +1109,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 
 	ncons = le32_to_cpu(buf[5]);
 
-	key = kmalloc(len + 1,GFP_KERNEL);
+	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -1122,7 +1120,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	key[len] = 0;
 
 	if (len2) {
-		cladatum->comkey = kmalloc(len2 + 1,GFP_KERNEL);
+		cladatum->comkey = kmalloc(len2 + 1, GFP_KERNEL);
 		if (!cladatum->comkey) {
 			rc = -ENOMEM;
 			goto bad;
@@ -1195,7 +1193,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	len = le32_to_cpu(buf[0]);
 	role->value = le32_to_cpu(buf[1]);
 
-	key = kmalloc(len + 1,GFP_KERNEL);
+	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -1242,7 +1240,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[3];
 	u32 len;
 
-	typdatum = kzalloc(sizeof(*typdatum),GFP_KERNEL);
+	typdatum = kzalloc(sizeof(*typdatum), GFP_KERNEL);
 	if (!typdatum) {
 		rc = -ENOMEM;
 		return rc;
@@ -1256,7 +1254,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 	typdatum->value = le32_to_cpu(buf[1]);
 	typdatum->primary = le32_to_cpu(buf[2]);
 
-	key = kmalloc(len + 1,GFP_KERNEL);
+	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -1328,7 +1326,7 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	len = le32_to_cpu(buf[0]);
 	usrdatum->value = le32_to_cpu(buf[1]);
 
-	key = kmalloc(len + 1,GFP_KERNEL);
+	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -1382,7 +1380,7 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 	len = le32_to_cpu(buf[0]);
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
-	key = kmalloc(len + 1,GFP_ATOMIC);
+	key = kmalloc(len + 1, GFP_ATOMIC);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -1434,7 +1432,7 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
 	catdatum->value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
-	key = kmalloc(len + 1,GFP_ATOMIC);
+	key = kmalloc(len + 1, GFP_ATOMIC);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
@@ -1493,7 +1491,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto out;
 
 	/* Read the magic number and string length. */
-	rc = next_entry(buf, fp, sizeof(u32)* 2);
+	rc = next_entry(buf, fp, sizeof(u32) * 2);
 	if (rc < 0)
 		goto bad;
 
@@ -1511,7 +1509,7 @@ int policydb_read(struct policydb *p, void *fp)
 		       len, strlen(POLICYDB_STRING));
 		goto bad;
 	}
-	policydb_str = kmalloc(len + 1,GFP_KERNEL);
+	policydb_str = kmalloc(len + 1, GFP_KERNEL);
 	if (!policydb_str) {
 		printk(KERN_ERR "SELinux:  unable to allocate memory for policydb "
 		       "string of length %d\n", len);
@@ -1544,9 +1542,9 @@ int policydb_read(struct policydb *p, void *fp)
 	if (p->policyvers < POLICYDB_VERSION_MIN ||
 	    p->policyvers > POLICYDB_VERSION_MAX) {
 		printk(KERN_ERR "SELinux:  policydb version %d does not match "
-	    	       "my version range %d-%d\n",
-	    	       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
-	    	goto bad;
+		       "my version range %d-%d\n",
+		       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+		goto bad;
 	}
 
 	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
@@ -1634,11 +1632,10 @@ int policydb_read(struct policydb *p, void *fp)
 			rc = -ENOMEM;
 			goto bad;
 		}
-		if (ltr) {
+		if (ltr)
 			ltr->next = tr;
-		} else {
+		else
 			p->role_tr = tr;
-		}
 		rc = next_entry(buf, fp, sizeof(u32)*3);
 		if (rc < 0)
 			goto bad;
@@ -1665,11 +1662,10 @@ int policydb_read(struct policydb *p, void *fp)
 			rc = -ENOMEM;
 			goto bad;
 		}
-		if (lra) {
+		if (lra)
 			lra->next = ra;
-		} else {
+		else
 			p->role_allow = ra;
-		}
 		rc = next_entry(buf, fp, sizeof(u32)*2);
 		if (rc < 0)
 			goto bad;
@@ -1703,11 +1699,10 @@ int policydb_read(struct policydb *p, void *fp)
 				rc = -ENOMEM;
 				goto bad;
 			}
-			if (l) {
+			if (l)
 				l->next = c;
-			} else {
+			else
 				p->ocontexts[i] = c;
-			}
 			l = c;
 			rc = -EINVAL;
 			switch (i) {
@@ -1726,7 +1721,7 @@ int policydb_read(struct policydb *p, void *fp)
 				if (rc < 0)
 					goto bad;
 				len = le32_to_cpu(buf[0]);
-				c->u.name = kmalloc(len + 1,GFP_KERNEL);
+				c->u.name = kmalloc(len + 1, GFP_KERNEL);
 				if (!c->u.name) {
 					rc = -ENOMEM;
 					goto bad;
@@ -1754,7 +1749,7 @@ int policydb_read(struct policydb *p, void *fp)
 					goto bad;
 				break;
 			case OCON_NODE:
-				rc = next_entry(buf, fp, sizeof(u32)* 2);
+				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc < 0)
 					goto bad;
 				c->u.node.addr = le32_to_cpu(buf[0]);
@@ -1771,7 +1766,7 @@ int policydb_read(struct policydb *p, void *fp)
 				if (c->v.behavior > SECURITY_FS_USE_NONE)
 					goto bad;
 				len = le32_to_cpu(buf[1]);
-				c->u.name = kmalloc(len + 1,GFP_KERNEL);
+				c->u.name = kmalloc(len + 1, GFP_KERNEL);
 				if (!c->u.name) {
 					rc = -ENOMEM;
 					goto bad;
@@ -1819,7 +1814,7 @@ int policydb_read(struct policydb *p, void *fp)
 			goto bad;
 		}
 
-		newgenfs->fstype = kmalloc(len + 1,GFP_KERNEL);
+		newgenfs->fstype = kmalloc(len + 1, GFP_KERNEL);
 		if (!newgenfs->fstype) {
 			rc = -ENOMEM;
 			kfree(newgenfs);
@@ -1865,7 +1860,7 @@ int policydb_read(struct policydb *p, void *fp)
 				goto bad;
 			}
 
-			newc->u.name = kmalloc(len + 1,GFP_KERNEL);
+			newc->u.name = kmalloc(len + 1, GFP_KERNEL);
 			if (!newc->u.name) {
 				rc = -ENOMEM;
 				goto bad_newc;
@@ -1969,7 +1964,7 @@ int policydb_read(struct policydb *p, void *fp)
 out:
 	return rc;
 bad_newc:
-	ocontext_destroy(newc,OCON_FSUSE);
+	ocontext_destroy(newc, OCON_FSUSE);
 bad:
 	if (!rc)
 		rc = -EINVAL;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
