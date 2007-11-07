Message-Id: <20071107205303.408158643@manicmethod.com>
References: <20071107205047.102519666@manicmethod.com>
Date: Wed, 07 Nov 2007 15:50:48 -0500
From: "Joshua Brindle" <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul.moore@hp.com
Subject: [patch 1/2] Version 22/Policy capability support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Basic infrastructure for policy capability support

---
 libsepol/include/sepol/policydb/policydb.h |    5 ++++-
 libsepol/src/policydb.c                    |   15 +++++++++++++++
 libsepol/src/write.c                       |    5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

--- trunk.orig/libsepol/include/sepol/policydb/policydb.h
+++ trunk/libsepol/include/sepol/policydb/policydb.h
@@ -468,6 +468,8 @@ typedef struct policydb {
 
 	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
 
+	ebitmap_t policycaps;
+
 	unsigned policyvers;
 
 	unsigned handle_unknown;
@@ -584,10 +586,11 @@ extern int policydb_write(struct policyd
 #define POLICYDB_VERSION_MLS		19
 #define POLICYDB_VERSION_AVTAB		20
 #define POLICYDB_VERSION_RANGETRANS	21
+#define POLICYDB_VERSION_POLCAP		22
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE	   4
--- trunk.orig/libsepol/src/policydb.c
+++ trunk/libsepol/src/policydb.c
@@ -99,6 +99,12 @@ static struct policydb_compat_info polic
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_POLCAP,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -447,6 +453,8 @@ int policydb_init(policydb_t * p)
 
 	memset(p, 0, sizeof(policydb_t));
 
+	ebitmap_init(&p->policycaps);
+
 	for (i = 0; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] = NULL;
 		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
@@ -971,6 +979,8 @@ void policydb_destroy(policydb_t * p)
 	if (!p)
 		return;
 
+	ebitmap_destroy(&p->policycaps);
+
 	symtabs_destroy(p->symtab);
 
 	for (i = 0; i < SYM_NUM; i++) {
@@ -3097,6 +3107,11 @@ int policydb_read(policydb_t * p, struct
 		goto bad;
 	}
 
+	if (p->policy_type == POLICY_KERN && p->policyvers >= POLICYDB_VERSION_POLCAP) {
+		if (ebitmap_read(&p->policycaps, fp))
+			goto bad;
+	}	
+
 	if (p->policy_type == POLICY_MOD) {
 		/* Get the module name and version */
 		if ((rc = next_entry(buf, fp, sizeof(uint32_t))) < 0) {
--- trunk.orig/libsepol/src/write.c
+++ trunk/libsepol/src/write.c
@@ -1576,6 +1576,11 @@ int policydb_write(policydb_t * p, struc
 	if (items != items2)
 		return POLICYDB_ERROR;
 
+	if (p->policyvers >= POLICYDB_VERSION_POLCAP) {
+		if (ebitmap_write(&p->policycaps, fp) == -1)
+			return POLICYDB_ERROR;
+	}
+
 	if (p->policy_type == POLICY_MOD) {
 		/* Write module name and version */
 		len = strlen(p->name);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
