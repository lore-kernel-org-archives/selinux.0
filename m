From: <rongqing.li@windriver.com>
To: <sds@tycho.nsa.gov>, <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 1/1] SELinux: skip file_name_trans_write() when policy downgraded.
Date: Fri, 20 May 2011 10:38:06 +0800
Message-ID: <1305859086-28362-2-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1305859086-28362-1-git-send-email-rongqing.li@windriver.com>
References: <1305859086-28362-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

When policy version is less than POLICYDB_VERSION_FILENAME_TRANS,
skip file_name_trans_write().

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 security/selinux/ss/policydb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 102e9ec..d246aca 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -3222,6 +3222,9 @@ static int filename_trans_write(struct policydb *p, void *fp)
 	__le32 buf[1];
 	int rc;
 
+	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
+		return 0;
+
 	nel = 0;
 	rc = hashtab_map(p->filename_trans, hashtab_cnt, &nel);
 	if (rc)
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
