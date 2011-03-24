From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v1 PATCH 1/5] Userspace: add class to role_trans & role_trans_rule
Date: Thu, 24 Mar 2011 18:42:40 +0800
Message-Id: <1300963366-9169-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
References: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus2002@hotmail.com>

Introduce the class support to role_trans and role_trans_rule
structures, which could be the subject class("process") or the
class that the newly created object belongs to.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/include/sepol/policydb/policydb.h |   12 ++++++++----
 libsepol/src/policydb.c                    |   21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index e8991e2..e9e80af 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -124,7 +124,8 @@ typedef struct role_datum {
 
 typedef struct role_trans {
 	uint32_t role;		/* current role */
-	uint32_t type;		/* program executable type */
+	uint32_t type;		/* program executable type, or new object type */
+	uint32_t classes;	/* process class, or new object class */
 	uint32_t new_role;	/* new role */
 	struct role_trans *next;
 } role_trans_t;
@@ -234,7 +235,8 @@ typedef struct avrule {
 
 typedef struct role_trans_rule {
 	role_set_t roles;	/* current role */
-	type_set_t types;	/* program executable type */
+	type_set_t types;	/* program executable type, or new object type */
+	ebitmap_t classes;	/* process class, or new object class */
 	uint32_t new_role;	/* new role */
 	struct role_trans_rule *next;
 } role_trans_rule_t;
@@ -630,10 +632,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_POLCAP		22
 #define POLICYDB_VERSION_PERMISSIVE	23
 #define POLICYDB_VERSION_BOUNDARY	24
+#define POLICYDB_VERSION_ROLETRANS	26
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_ROLETRANS
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
@@ -645,9 +648,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_PERMISSIVE		8
 #define MOD_POLICYDB_VERSION_BOUNDARY		9
 #define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS	10
+#define MOD_POLICYDB_VERSION_ROLETRANS		12
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_BOUNDARY_ALIAS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_ROLETRANS
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 5c0081f..53a7eef 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -137,6 +137,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_ROLETRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -186,6 +193,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_ROLETRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -234,6 +248,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_ROLETRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
