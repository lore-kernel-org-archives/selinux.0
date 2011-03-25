From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v2 PATCH 3/3] SELinux: Write class field in role_trans_write.
Date: Fri, 25 Mar 2011 13:52:00 +0800
Message-Id: <1301032323-20363-6-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If kernel policy version is >= 26, then write the class field of the
role_trans structure into the binary reprensentation.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/ss/policydb.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index fd62c50..a493eae 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2535,8 +2535,9 @@ static int cat_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int role_trans_write(struct role_trans *r, void *fp)
+static int role_trans_write(struct policydb *p, void *fp)
 {
+	struct role_trans *r = p->role_tr;
 	struct role_trans *tr;
 	u32 buf[3];
 	size_t nel;
@@ -2556,6 +2557,12 @@ static int role_trans_write(struct role_trans *r, void *fp)
 		rc = put_entry(buf, sizeof(u32), 3, fp);
 		if (rc)
 			return rc;
+		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
+			buf[0] = cpu_to_le32(tr->tclass);
+			rc = put_entry(buf, sizeof(u32), 1, fp);
+			if (rc)
+				return rc;
+		}
 	}
 
 	return 0;
@@ -3267,7 +3274,7 @@ int policydb_write(struct policydb *p, void *fp)
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
