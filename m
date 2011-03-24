From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v1 PATCH 2/3] SELinux: Compute role in newcontext for all classes
Date: Thu, 24 Mar 2011 18:42:41 +0800
Message-Id: <1300963366-9169-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
References: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
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
index 3e7544d..8d3eb2b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1484,17 +1484,18 @@ static int security_compute_sid(u32 ssid,
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
+			    (roletr->classes == tclass) &&
+			    ((roletr->classes == policydb.process_class &&
+			      roletr->type == tcontext->type) ||
+			    (roletr->classes != policydb.process_class &&
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
