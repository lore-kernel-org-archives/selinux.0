From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v2 PATCH 2/3] SELinux: Socket retains creator role and MLS attribute
Date: Wed,  2 Mar 2011 13:32:33 +0800
Message-Id: <1299043954-21877-2-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The socket SID would be computed on creation and no longer inherit
its creator's SID by default. Socket may have a different type but
needs to retain the creator's role and MLS attribute in order not
to break labeled networking and network access control.

The kernel value for a class would be used to determine if the class
if one of socket classes. If security_compute_sid is called from
userspace the policy value for a class would be mapped to the relevant
kernel value first.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/ss/mls.c      |    5 +++--
 security/selinux/ss/mls.h      |    3 ++-
 security/selinux/ss/services.c |   28 ++++++++++++++++++++++++----
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 1ef8e4e..e961742 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -512,7 +512,8 @@ int mls_compute_sid(struct context *scontext,
 		    struct context *tcontext,
 		    u16 tclass,
 		    u32 specified,
-		    struct context *newcontext)
+		    struct context *newcontext,
+		    bool sock)
 {
 	struct range_trans rtr;
 	struct mls_range *r;
@@ -531,7 +532,7 @@ int mls_compute_sid(struct context *scontext,
 			return mls_range_set(newcontext, r);
 		/* Fallthrough */
 	case AVTAB_CHANGE:
-		if (tclass == policydb.process_class)
+		if ((tclass == policydb.process_class) || (sock == true))
 			/* Use the process MLS attributes. */
 			return mls_context_cpy(newcontext, scontext);
 		else
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index cd91526..037bf9d 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -49,7 +49,8 @@ int mls_compute_sid(struct context *scontext,
 		    struct context *tcontext,
 		    u16 tclass,
 		    u32 specified,
-		    struct context *newcontext);
+		    struct context *newcontext,
+		    bool sock);
 
 int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
 			 struct context *usercon);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a03cfaf..bddcf30 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -201,6 +201,21 @@ static u16 unmap_class(u16 tclass)
 	return tclass;
 }
 
+/*
+ * Get kernel value for class from its policy value
+ */
+static u16 map_class(u16 pol_value)
+{
+	u16 i;
+
+	for (i = 1; i < current_mapping_size; i++) {
+		if (current_mapping[i].value == pol_value)
+			return i;
+	}
+
+	return pol_value;
+}
+
 static void map_decision(u16 tclass, struct av_decision *avd,
 			 int allow_unknown)
 {
@@ -1357,6 +1372,7 @@ static int security_compute_sid(u32 ssid,
 	struct avtab_node *node;
 	u16 tclass;
 	int rc = 0;
+	bool sock;
 
 	if (!ss_initialized) {
 		switch (orig_tclass) {
@@ -1374,10 +1390,13 @@ static int security_compute_sid(u32 ssid,
 
 	read_lock(&policy_rwlock);
 
-	if (kern)
+	if (kern) {
 		tclass = unmap_class(orig_tclass);
-	else
+		sock = security_is_socket_class(orig_tclass);
+	} else {
 		tclass = orig_tclass;
+		sock = security_is_socket_class(map_class(tclass));
+	}
 
 	scontext = sidtab_search(&sidtab, ssid);
 	if (!scontext) {
@@ -1408,7 +1427,7 @@ static int security_compute_sid(u32 ssid,
 	}
 
 	/* Set the role and type to default values. */
-	if (tclass == policydb.process_class) {
+	if ((tclass == policydb.process_class) || (sock == true)) {
 		/* Use the current role and type of process. */
 		newcontext.role = scontext->role;
 		newcontext.type = scontext->type;
@@ -1460,7 +1479,8 @@ static int security_compute_sid(u32 ssid,
 
 	/* Set the MLS attributes.
 	   This is done last because it may allocate memory. */
-	rc = mls_compute_sid(scontext, tcontext, tclass, specified, &newcontext);
+	rc = mls_compute_sid(scontext, tcontext, tclass, specified,
+			     &newcontext, sock);
 	if (rc)
 		goto out_unlock;
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
