From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: [v2 PATCH 2/2] role_transition for newly created files or dirs.
Date: Fri, 11 Mar 2011 15:21:00 +0800
Message-Id: <1299828060-18411-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1299828060-18411-1-git-send-email-qingtao.cao@windriver.com>
References: <1299828060-18411-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Support role_transition for newly created files or dirs object, so that
their role could be overriden by relevant role_transition rule than the
default "object_r".

In reference policy a role_transtion rule could be used for newly created
files or dirs object as in below format:
   role_transition <subject role> <new object type> <new object role>;
for example,
   role_transition sysadm_r user_home_t sysadm_r;
which means if the creator role == sysadm_r and the new object has a
type == user_home_t, then the new object role would be set to sysadm_r
as its creator.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/ss/policydb.h |    2 +-
 security/selinux/ss/services.c |   28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4e3ab9d..ca223c7 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -72,7 +72,7 @@ struct role_datum {
 
 struct role_trans {
 	u32 role;		/* current role */
-	u32 type;		/* program executable type */
+	u32 type;		/* program executable type, or new object type */
 	u32 new_role;		/* new role */
 	struct role_trans *next;
 };
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index bddcf30..e1707af 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1370,9 +1370,9 @@ static int security_compute_sid(u32 ssid,
 	struct avtab_key avkey;
 	struct avtab_datum *avdatum;
 	struct avtab_node *node;
-	u16 tclass;
+	u16 tclass, class_kern_val;
 	int rc = 0;
-	bool sock;
+	bool sock, filedir;
 
 	if (!ss_initialized) {
 		switch (orig_tclass) {
@@ -1392,11 +1392,14 @@ static int security_compute_sid(u32 ssid,
 
 	if (kern) {
 		tclass = unmap_class(orig_tclass);
-		sock = security_is_socket_class(orig_tclass);
+		class_kern_val = orig_tclass;
 	} else {
 		tclass = orig_tclass;
-		sock = security_is_socket_class(map_class(tclass));
+		class_kern_val = map_class(tclass);
 	}
+	
+	sock = security_is_socket_class(class_kern_val);
+	filedir = security_is_filedir_class(class_kern_val);
 
 	scontext = sidtab_search(&sidtab, ssid);
 	if (!scontext) {
@@ -1432,8 +1435,13 @@ static int security_compute_sid(u32 ssid,
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
@@ -1462,13 +1470,17 @@ static int security_compute_sid(u32 ssid,
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
+				    roletr->role == scontext->role &&
+				    roletr->type == newcontext.type &&
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
