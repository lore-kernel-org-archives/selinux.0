From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v0 PATCH 2/3] SELinux: Compute role in newcontext for all classes
Date: Wed, 23 Mar 2011 10:28:39 +0800
Message-Id: <1300847325-20308-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus200@hotmail.com>

For the process class, the role_trans.type is compared with
tcontext->type, that is, the program executable type.

For all the rest classes, the role_trans.type is compared with
newcontext.type, that is, the type for the newly created object
of that class.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/ss/services.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a03cfaf..01fc3d5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1443,17 +1443,18 @@ static int security_compute_sid(u32 ssid,
 	}
 
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
+			    (roletr->cclass == tclass) &&
+			    ((roletr->cclass == policydb.process_class &&
+			      roletr->type == tcontext->type) ||
+			     (roletr->cclass != policydb.process_class &&
+			      roletr->type == newcontext.type))){
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
