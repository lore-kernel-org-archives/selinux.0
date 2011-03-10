From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] Consider role_transition for newly created files or dirs.
Date: Thu, 10 Mar 2011 14:51:50 +0800
Message-Id: <1299739911-19352-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1299739911-19352-1-git-send-email-qingtao.cao@windriver.com>
References: <1299739911-19352-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Consider role_transition for newly created files or dirs object, so that
their role could be overriden by relevant role_transition rule than the
default "object_r".

In reference policy role_transtion rule could be used for newly created
files or dirs object as in below example:
	role_transition object_r $1 $2;
where "$1" and "$2" are the domain and role of the creator respectively.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/ss/policydb.h |    6 +++---
 security/selinux/ss/services.c |   21 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4e3ab9d..06cef40 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -71,9 +71,9 @@ struct role_datum {
 };
 
 struct role_trans {
-	u32 role;		/* current role */
-	u32 type;		/* program executable type */
-	u32 new_role;		/* new role */
+	u32 role;		/* current role, or the parent dir role */
+	u32 type;		/* program executable type, or creator domain */
+	u32 new_role;		/* new role, or creator role */
 	struct role_trans *next;
 };
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index bddcf30..c9bfa43 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1372,7 +1372,7 @@ static int security_compute_sid(u32 ssid,
 	struct avtab_node *node;
 	u16 tclass;
 	int rc = 0;
-	bool sock;
+	bool sock, filedir;
 
 	if (!ss_initialized) {
 		switch (orig_tclass) {
@@ -1393,9 +1393,11 @@ static int security_compute_sid(u32 ssid,
 	if (kern) {
 		tclass = unmap_class(orig_tclass);
 		sock = security_is_socket_class(orig_tclass);
+		filedir = security_is_filedir_class(orig_tclass);
 	} else {
 		tclass = orig_tclass;
 		sock = security_is_socket_class(map_class(tclass));
+		filedir = security_is_filedir_class(map_class(tclass));
 	}
 
 	scontext = sidtab_search(&sidtab, ssid);
@@ -1432,8 +1434,13 @@ static int security_compute_sid(u32 ssid,
 		newcontext.role = scontext->role;
 		newcontext.type = scontext->type;
 	} else {
-		/* Use the well-defined object role. */
-		newcontext.role = OBJECT_R_VAL;
+		if (filedir == true)
+			/* Inherit the role from the parent dir */
+			newcontext.role = tcontext->role;
+		else
+			/* Use the well-defined object role. */
+			newcontext.role = OBJECT_R_VAL;
+
 		/* Use the type of the related object. */
 		newcontext.type = tcontext->type;
 	}
@@ -1462,13 +1469,17 @@ static int security_compute_sid(u32 ssid,
 	}
 
 	/* Check for class-specific changes. */
-	if  (tclass == policydb.process_class) {
+	if ((tclass == policydb.process_class) || (filedir == true)) {
 		if (specified & AVTAB_TRANSITION) {
 			/* Look for a role transition rule. */
 			for (roletr = policydb.role_tr; roletr;
 			     roletr = roletr->next) {
 				if (roletr->role == scontext->role &&
-				    roletr->type == tcontext->type) {
+				    roletr->type == tcontext->type &&
+				    tclass == policydb.process_class ||
+				    roletr->role == tcontext->role &&
+				    roletr->type == scontext->type &&
+				    filedir == true) {
 					/* Use the role transition rule. */
 					newcontext.role = roletr->new_role;
 					break;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
