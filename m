From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v0 PATCH 1/3] SELinux: Add class support to the role_trans structure
Date: Wed, 23 Mar 2011 10:28:38 +0800
Message-Id: <1300847325-20308-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus200@hotmail.com>

If kernel policy version is >= 25, then the binary representation of
the role_trans structure supports specifying the class for the current
subject or the newly created object.

If kernel policy version is < 25, then the class field would be default
to the process class.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/include/security.h |    3 ++-
 security/selinux/ss/policydb.c      |   24 +++++++++++++++++++++---
 security/selinux/ss/policydb.h      |    7 ++++---
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 671273e..a9d9e2b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -28,13 +28,14 @@
 #define POLICYDB_VERSION_POLCAP		22
 #define POLICYDB_VERSION_PERMISSIVE	23
 #define POLICYDB_VERSION_BOUNDARY	24
+#define POLICYDB_VERSION_ROLETRANS	25
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_ROLETRANS
 #endif
 
 /* Mask for just the mount related flags */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 5736356..b660f08 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -123,6 +123,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_ROLETRANS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -2209,16 +2214,29 @@ int policydb_read(struct policydb *p, void *fp)
 			ltr->next = tr;
 		else
 			p->role_tr = tr;
-		rc = next_entry(buf, fp, sizeof(u32)*3);
+		rc = next_entry(buf, fp, sizeof(u32)*2);
 		if (rc)
 			goto bad;
 
-		rc = -EINVAL;
 		tr->role = le32_to_cpu(buf[0]);
 		tr->type = le32_to_cpu(buf[1]);
-		tr->new_role = le32_to_cpu(buf[2]);
+		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
+			rc = next_entry(buf, fp, sizeof(u32));
+			if (rc)
+				goto bad;
+			tr->cclass = le32_to_cpu(buf[0]);
+		} else
+			tr->cclass = p->process_class;
+
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc)
+			goto bad;
+		tr->new_role = le32_to_cpu(buf[0]);
+
+		rc = -EINVAL;
 		if (!policydb_role_isvalid(p, tr->role) ||
 		    !policydb_type_isvalid(p, tr->type) ||
+		    !policydb_class_isvalid(p, tr->cclass) ||
 		    !policydb_role_isvalid(p, tr->new_role))
 			goto bad;
 		ltr = tr;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4e3ab9d..ba08fb4 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -71,9 +71,10 @@ struct role_datum {
 };
 
 struct role_trans {
-	u32 role;		/* current role */
-	u32 type;		/* program executable type */
-	u32 new_role;		/* new role */
+	u32 role;	/* current role */
+	u32 type;	/* program executable type, or new object type */
+	u32 cclass;	/* process class, or new object class */
+	u32 new_role;	/* new role */
 	struct role_trans *next;
 };
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
