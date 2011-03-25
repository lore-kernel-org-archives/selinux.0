From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v2 PATCH 2/3] SELinux: Compute role in newcontext for all classes
Date: Fri, 25 Mar 2011 13:51:58 +0800
Message-Id: <1301032323-20363-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus200@hotmail.com>

Apply role_transition rules for all kinds of classes.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/ss/services.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3e7544d..03f7a47 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1484,17 +1484,15 @@ static int security_compute_sid(u32 ssid,
 				      tcontext->type, tclass, qstr);
 
 	/* Check for class-specific changes. */
-	if  (tclass == policydb.process_class) {
-		if (specified & AVTAB_TRANSITION) {
-			/* Look for a role transition rule. */
-			for (roletr = policydb.role_tr; roletr;
-			     roletr = roletr->next) {
-				if (roletr->role == scontext->role &&
-				    roletr->type == tcontext->type) {
-					/* Use the role transition rule. */
-					newcontext.role = roletr->new_role;
-					break;
-				}
+	if (specified & AVTAB_TRANSITION) {
+		/* Look for a role transition rule. */
+		for (roletr = policydb.role_tr; roletr; roletr = roletr->next) {
+			if ((roletr->role == scontext->role) &&
+			    (roletr->type == tcontext->type) &&
+			    (roletr->tclass == tclass)) {
+				/* Use the role transition rule. */
+				newcontext.role = roletr->new_role;
+				break;
 			}
 		}
 	}
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
