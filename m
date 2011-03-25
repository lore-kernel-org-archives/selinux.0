From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v2 PATCH 3/5] Userspace: handle the class field in role_trans struct
Date: Fri, 25 Mar 2011 13:52:01 +0800
Message-Id: <1301032323-20363-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus2002@hotmail.com>

Add the class support to various functions that handle role_trans
structure.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/policydb.c |   14 ++++++++++++--
 libsepol/src/write.c    |   22 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 53a7eef..1f414f9 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2124,12 +2124,15 @@ static int type_read(policydb_t * p
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
@@ -2152,6 +2155,13 @@ int role_trans_read(role_trans_t ** t, struct policy_file *fp)
 		tr->role = le32_to_cpu(buf[0]);
 		tr->type = le32_to_cpu(buf[1]);
 		tr->new_role = le32_to_cpu(buf[2]);
+		if (new_roletr) {
+			rc = next_entry(buf, fp, sizeof(uint32_t));
+			if (rc < 0)
+				return -1;
+			tr->tclass = le32_to_cpu(buf[0]);
+		} else
+			tr->tclass = SECCLASS_PROCESS;
 		ltr = tr;
 	}
 	return 0;
@@ -3472,7 +3482,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (r_policyvers >= POLICYDB_VERSION_BOOL)
 			if (cond_read_list(p, &p->cond_list, fp))
 				goto bad;
-		if (role_trans_read(&p->role_tr, fp))
+		if (role_trans_read(p, fp))
 			goto bad;
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 00c605f..764200d 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -462,11 +462,15 @@ static int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
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
+	int warning_issued = 0;
 
 	nel = 0;
 	for (tr = r; tr; tr = tr->next)
@@ -476,12 +480,26 @@ static int role_trans_write(role_trans_t * r, struct policy_file *fp)
 	if (items != 1)
 		return POLICYDB_ERROR;
 	for (tr = r; tr; tr = tr->next) {
+		if (!new_roletr && tr->tclass != SECCLASS_PROCESS) {
+			if (!warning_issued)
+				WARN(fp->handle, "Discarding role_transition "
+				     "rules for security classes other than "
+				     "\"process\"");
+			warning_issued = 1;
+			continue;
+		}
 		buf[0] = cpu_to_le32(tr->role);
 		buf[1] = cpu_to_le32(tr->type);
 		buf[2] = cpu_to_le32(tr->new_role);
 		items = put_entry(buf, sizeof(uint32_t), 3, fp);
 		if (items != 3)
 			return POLICYDB_ERROR;
+		if (new_roletr) {
+			buf[0] = cpu_to_le32(tr->tclass);
+			items = put_entry(buf, sizeof(uint32_t), 1, fp);
+			if (items != 1)
+				return POLICYDB_ERROR;
+		}
 	}
 
 	return POLICYDB_SUCCESS;
@@ -1815,7 +1833,7 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
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
