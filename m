Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWbTW016463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:38 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHVmGC003383
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:31:48 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXBXP009802
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXBvF009801
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:11 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DDRBJw025859
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 09:27:12 -0400
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DD9n51026719
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 13:09:49 GMT
Received: by wwb39 with SMTP id 39so2959951wwb.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 06:10:36 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:50:35 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 1/7 v2] selinux: cleanup return codes in avtab_read_item()
Message-ID: <20100612185035.GP5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The avtab_read_item() function tends to return -1 as a default error
code which is wrong (-1 means -EPERM).  I modified it to return
appropriate error codes which is -EINVAL or the error code from
next_entry() or insertf().

next_entry() returns -EINVAL.
insertf() is a function pointer to either avtab_insert() or
cond_insertf().
avtab_insert() returns -EINVAL, -ENOMEM, and -EEXIST.
cond_insertf() currently returns -1, but I will fix it in a later patch.

There is code in avtab_read() which translates the -1 returns from 
avtab_read_item() to -EINVAL. The translation is no longer needed, so I
removed it.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: use "if (rc)" instead of "if (rc < 0)" throughout

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 1215b8e..929480c 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -342,20 +342,20 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 
 	if (vers < POLICYDB_VERSION_AVTAB) {
 		rc = next_entry(buf32, fp, sizeof(u32));
-		if (rc < 0) {
+		if (rc) {
 			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
-			return -1;
+			return rc;
 		}
 		items2 = le32_to_cpu(buf32[0]);
 		if (items2 > ARRAY_SIZE(buf32)) {
 			printk(KERN_ERR "SELinux: avtab: entry overflow\n");
-			return -1;
+			return -EINVAL;
 
 		}
 		rc = next_entry(buf32, fp, sizeof(u32)*items2);
-		if (rc < 0) {
+		if (rc) {
 			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
-			return -1;
+			return rc;
 		}
 		items = 0;
 
@@ -363,19 +363,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		key.source_type = (u16)val;
 		if (key.source_type != val) {
 			printk(KERN_ERR "SELinux: avtab: truncated source type\n");
-			return -1;
+			return -EINVAL;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_type = (u16)val;
 		if (key.target_type != val) {
 			printk(KERN_ERR "SELinux: avtab: truncated target type\n");
-			return -1;
+			return -EINVAL;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_class = (u16)val;
 		if (key.target_class != val) {
 			printk(KERN_ERR "SELinux: avtab: truncated target class\n");
-			return -1;
+			return -EINVAL;
 		}
 
 		val = le32_to_cpu(buf32[items++]);
@@ -383,12 +383,12 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 
 		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
 			printk(KERN_ERR "SELinux: avtab: null entry\n");
-			return -1;
+			return -EINVAL;
 		}
 		if ((val & AVTAB_AV) &&
 		    (val & AVTAB_TYPE)) {
 			printk(KERN_ERR "SELinux: avtab: entry has both access vectors and types\n");
-			return -1;
+			return -EINVAL;
 		}
 
 		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
@@ -403,15 +403,15 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 
 		if (items != items2) {
 			printk(KERN_ERR "SELinux: avtab: entry only had %d items, expected %d\n", items2, items);
-			return -1;
+			return -EINVAL;
 		}
 		return 0;
 	}
 
 	rc = next_entry(buf16, fp, sizeof(u16)*4);
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux: avtab: truncated entry\n");
-		return -1;
+		return rc;
 	}
 
 	items = 0;
@@ -424,7 +424,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	    !policydb_type_isvalid(pol, key.target_type) ||
 	    !policydb_class_isvalid(pol, key.target_class)) {
 		printk(KERN_ERR "SELinux: avtab: invalid type or class\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	set = 0;
@@ -434,19 +434,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	}
 	if (!set || set > 1) {
 		printk(KERN_ERR "SELinux:  avtab:  more than one specifier\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	rc = next_entry(buf32, fp, sizeof(u32));
-	if (rc < 0) {
+	if (rc) {
 		printk(KERN_ERR "SELinux: avtab: truncated entry\n");
-		return -1;
+		return rc;
 	}
 	datum.data = le32_to_cpu(*buf32);
 	if ((key.specified & AVTAB_TYPE) &&
 	    !policydb_type_isvalid(pol, datum.data)) {
 		printk(KERN_ERR "SELinux: avtab: invalid type\n");
-		return -1;
+		return -EINVAL;
 	}
 	return insertf(a, &key, &datum, p);
 }
@@ -487,8 +487,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 				printk(KERN_ERR "SELinux: avtab: out of memory\n");
 			else if (rc == -EEXIST)
 				printk(KERN_ERR "SELinux: avtab: duplicate entry\n");
-			else
-				rc = -EINVAL;
+
 			goto bad;
 		}
 	}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
