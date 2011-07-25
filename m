Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6P1OMiA025319
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2011 21:24:24 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6P1ODfI009079
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 01:24:13 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>, <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v4 PATCH 2/6] Add role attribute support when generating pp files.
Date: Mon, 25 Jul 2011 09:23:55 +0800
Message-ID: <1311557039-2977-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
References: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support to read/write the flavor flag and roles ebitmap in the
role_datum_t structure from/to policy module, if its version is no less
than MOD_POLICYDB_VERSION_ROLEATTRIB.

Since the role ebitmap would be expanded and won't be written into
policy.X, neither is the flavor flag, kernel SELinux security server
needs no change, the maximum version number for policy.X needs no bump.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/include/sepol/policydb/policydb.h |    3 ++-
 libsepol/src/policydb.c                    |   26 ++++++++++++++++++++++++++
 libsepol/src/write.c                       |   11 +++++++++++
 3 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index b59ab2e..5320bc8 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -682,9 +682,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS	10
 #define MOD_POLICYDB_VERSION_FILENAME_TRANS	11
 #define MOD_POLICYDB_VERSION_ROLETRANS		12
+#define MOD_POLICYDB_VERSION_ROLEATTRIB		13
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_ROLETRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_ROLEATTRIB
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index eb6d590..9145f2a 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -214,6 +214,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_ROLEATTRIB,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -276,6 +283,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_ROLEATTRIB,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -2090,6 +2104,18 @@ static int role_read(policydb_t * p
 		if (type_set_read(&role->types, fp))
 			goto bad;
 	}
+	
+	if (p->policy_type != POLICY_KERN &&
+	    p->policyvers >= MOD_POLICYDB_VERSION_ROLEATTRIB) {
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			goto bad;
+
+		role->flavor = le32_to_cpu(buf[0]);
+
+		if (ebitmap_read(&role->roles, fp))
+			goto bad;
+	}
 
 	if (strcmp(key, OBJECT_R) == 0) {
 		if (role->s.value != OBJECT_R_VAL) {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 9657e6c..290e036 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -996,6 +996,17 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 			return POLICYDB_ERROR;
 	}
 
+	if (p->policy_type != POLICY_KERN &&
+	    p->policyvers >= MOD_POLICYDB_VERSION_ROLEATTRIB) {
+		buf[0] = cpu_to_le32(role->flavor);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		if (ebitmap_write(&role->roles, fp))
+			return POLICYDB_ERROR;
+	}
+
 	return POLICYDB_SUCCESS;
 }
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
