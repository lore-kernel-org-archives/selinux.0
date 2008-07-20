Date: Sun, 20 Jul 2008 23:57:01 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: [patch] SELinux: Trivial minor fixes that change C null character
 style
Message-ID: <Pine.LNX.4.64L.0807202351490.6954@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Trivial minor fixes that change C null character style.

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

---

Trivial minor fixes that change C null character style.


 security/selinux/ss/conditional.c |    2 +-
 security/selinux/ss/mls.c         |   14 +++++++-------
 security/selinux/ss/policydb.c    |   20 ++++++++++----------
 3 files changed, 18 insertions(+), 18 deletions(-)



--- security-testing-2.6/security/selinux/ss/conditional.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/ss/conditional.c	2008-07-20 23:14:10.000000000 +0300
@@ -239,7 +239,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto err;
-	key[len] = 0;
+	key[len] = '\0';
 	if (hashtab_insert(h, key, booldatum))
 		goto err;

--- security-testing-2.6/security/selinux/ss/mls.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/ss/mls.c	2008-07-20 23:07:57.000000000 +0300
@@ -283,8 +283,8 @@
 		p++;

 	delim = *p;
-	if (delim != 0)
-		*p++ = 0;
+	if (delim != '\0')
+		*p++ = '\0';

 	for (l = 0; l < 2; l++) {
 		levdatum = hashtab_search(pol->p_levels.table, scontextp);
@@ -302,14 +302,14 @@
 				while (*p && *p != ',' && *p != '-')
 					p++;
 				delim = *p;
-				if (delim != 0)
-					*p++ = 0;
+				if (delim != '\0')
+					*p++ = '\0';

 				/* Separate into range if exists */
 				rngptr = strchr(scontextp, '.');
 				if (rngptr != NULL) {
 					/* Remove '.' */
-					*rngptr++ = 0;
+					*rngptr++ = '\0';
 				}

 				catdatum = hashtab_search(pol->p_cats.table,
@@ -357,8 +357,8 @@
 				p++;

 			delim = *p;
-			if (delim != 0)
-				*p++ = 0;
+			if (delim != '\0')
+				*p++ = '\0';
 		} else
 			break;
 	}
--- security-testing-2.6/security/selinux/ss/policydb.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/ss/policydb.c	2008-07-20 23:05:27.000000000 +0300
@@ -932,7 +932,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	rc = hashtab_insert(h, key, perdatum);
 	if (rc)
@@ -979,7 +979,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	for (i = 0; i < nel; i++) {
 		rc = perm_read(p, comdatum->permissions.table, fp);
@@ -1117,7 +1117,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	if (len2) {
 		cladatum->comkey = kmalloc(len2 + 1, GFP_KERNEL);
@@ -1128,7 +1128,7 @@
 		rc = next_entry(cladatum->comkey, fp, len2);
 		if (rc < 0)
 			goto bad;
-		cladatum->comkey[len2] = 0;
+		cladatum->comkey[len2] = '\0';

 		cladatum->comdatum = hashtab_search(p->p_commons.table,
 						    cladatum->comkey);
@@ -1201,7 +1201,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	rc = ebitmap_read(&role->dominates, fp);
 	if (rc)
@@ -1262,7 +1262,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	rc = hashtab_insert(h, key, typdatum);
 	if (rc)
@@ -1334,7 +1334,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	rc = ebitmap_read(&usrdatum->roles, fp);
 	if (rc)
@@ -1388,7 +1388,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	levdatum->level = kmalloc(sizeof(struct mls_level), GFP_ATOMIC);
 	if (!levdatum->level) {
@@ -1440,7 +1440,7 @@
 	rc = next_entry(key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
+	key[len] = '\0';

 	rc = hashtab_insert(h, key, catdatum);
 	if (rc)
@@ -1523,7 +1523,7 @@
 		kfree(policydb_str);
 		goto bad;
 	}
-	policydb_str[len] = 0;
+	policydb_str[len] = '\0';
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		printk(KERN_ERR "SELinux:  policydb string %s does not match "
 		       "my string %s\n", policydb_str, POLICYDB_STRING);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
