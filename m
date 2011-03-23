From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v0 PATCH 3/5] Handle the class in role_trans structure
Date: Wed, 23 Mar 2011 10:28:43 +0800
Message-Id: <1300847325-20308-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus2002@hotmail.com>

Add the class support to various functions that handle the role_trans
structure.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/policydb.c |   28 ++++++++++++++++++++++++----
 libsepol/src/write.c    |   22 +++++++++++++++++-----
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 5c0081f..9b43c56 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -137,6 +137,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_ROLETRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -2103,12 +2110,15 @@ static int type_read(policydb_t * p
 	return -1;
 }
 
-int role_trans_read(role_trans_t ** t, struct policy_file *fp)
+int role_trans_read(policydb_t *p, struct policy_file *fp)
 {
+	role_trans_t **t = &p->role_tr;
 	unsigned int i;
 	uint32_t buf[3], nel;
 	role_trans_t *tr, *ltr;
 	int rc;
+	int new_roletr = (p->policy_type == POLICY_KERN &&
+			  p->policyvers >= POLICYDB_VERSION_ROLETRANS);
 
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
@@ -2125,12 +2135,22 @@ int role_trans_read(role_trans_t ** t, struct policy_file *fp)
 		} else {
 			*t = tr;
 		}
-		rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 		if (rc < 0)
 			return -1;
 		tr->role = le32_to_cpu(buf[0]);
 		tr->type = le32_to_cpu(buf[1]);
-		tr->new_role = le32_to_cpu(buf[2]);
+		if (new_roletr) {
+			rc = next_entry(buf, fp, sizeof(uint32_t));
+			if (rc < 0)
+				return -1;
+			tr->cclass = le32_to_cpu(buf[0]);
+		} else
+			tr->cclass = SECCLASS_PROCESS;
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			return -1;
+		tr->new_role = le32_to_cpu(buf[0]);
 		ltr = tr;
 	}
 	return 0;
@@ -3451,7 +3471,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (r_policyvers >= POLICYDB_VERSION_BOOL)
 			if (cond_read_list(p, &p->cond_list, fp))
 				goto bad;
-		if (role_trans_read(&p->role_tr, fp))
+		if (role_trans_read(p, fp))
 			goto bad;
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 00c605f..1db5960 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -462,11 +462,14 @@ static int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	return POLICYDB_SUCCESS;
 }
 
-static int role_trans_write(role_trans_t * r, struct policy_file *fp)
+static int role_trans_write(policydb_t *p, struct policy_file *fp)
 {
+	role_trans_t *r = p->role_tr;
 	role_trans_t *tr;
 	uint32_t buf[3];
 	size_t nel, items;
+	int new_roletr = (p->policy_type == POLICY_KERN &&
+			  p->policyvers >= POLICYDB_VERSION_ROLETRANS);
 
 	nel = 0;
 	for (tr = r; tr; tr = tr->next)
@@ -478,9 +481,18 @@ static int role_trans_write(role_trans_t * r, struct policy_file *fp)
 	for (tr = r; tr; tr = tr->next) {
 		buf[0] = cpu_to_le32(tr->role);
 		buf[1] = cpu_to_le32(tr->type);
-		buf[2] = cpu_to_le32(tr->new_role);
-		items = put_entry(buf, sizeof(uint32_t), 3, fp);
-		if (items != 3)
+		items = put_entry(buf, sizeof(uint32_t), 2, fp);
+		if (items != 2)
+			return POLICYDB_ERROR;
+		if (new_roletr) {
+			buf[0] = cpu_to_le32(tr->cclass);
+			items = put_entry(buf, sizeof(uint32_t), 1, fp);
+			if (items != 1)
+				return POLICYDB_ERROR;
+		}
+		buf[0] = cpu_to_le32(tr->new_role);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
 			return POLICYDB_ERROR;
 	}
 
@@ -1815,7 +1827,7 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 			if (cond_write_list(p, p->cond_list, fp))
 				return POLICYDB_ERROR;
 		}
-		if (role_trans_write(p->role_tr, fp))
+		if (role_trans_write(p, fp))
 			return POLICYDB_ERROR;
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
