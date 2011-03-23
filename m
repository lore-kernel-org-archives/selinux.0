From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v0 PATCH 3/3] SELinux: Write class field in role_trans_write.
Date: Wed, 23 Mar 2011 10:28:40 +0800
Message-Id: <1300847325-20308-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus2002@hotmail.com>

If kernel policy version is >= 25, then write the class field of the
role_trans structure into the binary reprensentation.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/ss/policydb.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index b660f08..a6be0f5 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2450,10 +2450,11 @@ static int cat_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int role_trans_write(struct role_trans *r, void *fp)
+static int role_trans_write(struct policydb *p, void *fp)
 {
+	struct role_trans *r = p->role_tr;
 	struct role_trans *tr;
-	u32 buf[3];
+	u32 buf[4];
 	size_t nel;
 	int rc;
 
@@ -2467,8 +2468,15 @@ static int role_trans_write(struct role_trans *r, void *fp)
 	for (tr = r; tr; tr = tr->next) {
 		buf[0] = cpu_to_le32(tr->role);
 		buf[1] = cpu_to_le32(tr->type);
-		buf[2] = cpu_to_le32(tr->new_role);
-		rc = put_entry(buf, sizeof(u32), 3, fp);
+		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
+			buf[2] = cpu_to_le32(tr->cclass);
+			buf[3] = cpu_to_le32(tr->new_role);
+			rc = put_entry(buf, sizeof(u32), 4, fp);
+		} else {
+			buf[2] = cpu_to_le32(tr->new_role);
+			rc = put_entry(buf, sizeof(u32), 3, fp);
+		}
+
 		if (rc)
 			return rc;
 	}
@@ -3145,7 +3153,7 @@ int policydb_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
-	rc = role_trans_write(p->role_tr, fp);
+	rc = role_trans_write(p, fp);
 	if (rc)
 		return rc;
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
