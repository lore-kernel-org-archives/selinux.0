From: <rongqing.li@windriver.com>
To: <sds@tycho.nsa.gov>, <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 2/2] SELinux: Modify the searching of the role transition rule
Date: Tue, 24 May 2011 17:46:14 +0800
Message-ID: <1306230374-29019-3-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>
References: <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Search the hash table of the role transition rule for a matching one
when computing the new context.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 security/selinux/ss/services.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e11b4b0..741334b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1392,7 +1392,8 @@ static int security_compute_sid(u32 ssid,
 				bool kern)
 {
 	struct context *scontext = NULL, *tcontext = NULL, newcontext;
-	struct role_trans *roletr = NULL;
+	struct roletr_key rtkey;
+	struct roletr_datum *rtdatum = NULL;
 	struct avtab_key avkey;
 	struct avtab_datum *avdatum;
 	struct avtab_node *node;
@@ -1495,15 +1496,12 @@ static int security_compute_sid(u32 ssid,
 	/* Check for class-specific changes. */
 	if (specified & AVTAB_TRANSITION) {
 		/* Look for a role transition rule. */
-		for (roletr = policydb.role_tr; roletr; roletr = roletr->next) {
-			if ((roletr->role == scontext->role) &&
-			    (roletr->type == tcontext->type) &&
-			    (roletr->tclass == tclass)) {
-				/* Use the role transition rule. */
-				newcontext.role = roletr->new_role;
-				break;
-			}
-		}
+		rtkey.role = scontext->role;
+		rtkey.type = tcontext->type;
+		rtkey.tclass = tclass;
+		rtdatum = hashtab_search(policydb.role_tr, &rtkey);
+		if (rtdatum != NULL)
+			newcontext.role = rtdatum->new_role;
 	}
 
 	/* Set the MLS attributes.
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
