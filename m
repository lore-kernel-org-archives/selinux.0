Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p813TsYY031916
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 23:30:04 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p813Tr06012553
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 03:29:53 GMT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p813TqMi007118
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:29:52 -0700 (PDT)
From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 1/8] Indicate when boolean is indeed a tunable.
Date: Thu, 1 Sep 2011 11:29:40 +0800
Message-ID: <1314847787-4055-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add flags to cond_bool_datum_t and cond_node_t structures to differentiate
the tunables' identifiers and conditionals from those of booleans.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/include/sepol/policydb/conditional.h |    6 ++++--
 libsepol/include/sepol/policydb/policydb.h    |    5 ++++-
 libsepol/src/policydb.c                       |   14 ++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
index a8ed694..48ec106 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -77,15 +77,17 @@ typedef struct cond_node {
 	/* these true/false lists point into te_avtab when that is used */
 	cond_av_list_t *true_list;
 	cond_av_list_t *false_list;
-	/* and these are using during parsing and for modules */
+	/* and these are used during parsing and for modules */
 	avrule_t *avtrue_list;
 	avrule_t *avfalse_list;
 	/* these fields are not written to binary policy */
 	unsigned int nbools;
 	uint32_t bool_ids[COND_MAX_BOOLS];
 	uint32_t expr_pre_comp;
-	/*                                               */
 	struct cond_node *next;
+	/* a tunable conditional, calculated and used at expansion */
+#define	COND_NODE_FLAGS_TUNABLE	0x01
+	uint32_t flags;
 } cond_node_t;
 
 extern int cond_evaluate_expr(policydb_t * p, cond_expr_t * expr);
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 5320bc8..1848a7b 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -210,6 +210,8 @@ typedef struct range_trans {
 typedef struct cond_bool_datum {
 	symtab_datum_t s;
 	int state;
+#define COND_BOOL_FLAGS_TUNABLE	0x01	/* is this a tunable? */
+	uint32_t flags;
 } cond_bool_datum_t;
 
 struct cond_node;
@@ -683,9 +685,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_FILENAME_TRANS	11
 #define MOD_POLICYDB_VERSION_ROLETRANS		12
 #define MOD_POLICYDB_VERSION_ROLEATTRIB		13
+#define MOD_POLICYDB_VERSION_TUNABLE_SEP	14
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_ROLEATTRIB
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_TUNABLE_SEP
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 017aeca..136b450 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -221,6 +221,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_TUNABLE_SEP,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -290,6 +297,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_TUNABLE_SEP,
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
