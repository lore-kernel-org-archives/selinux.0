Message-Id: <20071206213941.502313266@tresys.com>
References: <20071206213852.083412876@tresys.com>
Date: Thu, 06 Dec 2007 16:38:53 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@manicmethod.com, Stephen Smalley <sds@tycho.nsa.gov>,
        dwalsh@redhat.com, paul.moore@hp.com, cpebenito@tresys.com,
        kmacmillan@mentalrootkit.com
Subject: [patch 1/2] library policy capability support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch includes the library support for policy capabilities.
Currently the only capability that exists is peersid.  Patch policy
capabilities are only valid in the base policy.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Index: trunk/libsepol/include/sepol/policydb/polcaps.h
===================================================================
--- /dev/null
+++ trunk/libsepol/include/sepol/policydb/polcaps.h
@@ -0,0 +1,17 @@
+#ifndef _SEPOL_POLICYDB_POLCAPS_H_
+#define _SEPOL_POLICYDB_POLCAPS_H_
+
+/* Policy capabilities */
+enum {
+	POLICYDB_CAPABILITY_NETPEER,
+	__POLICYDB_CAPABILITY_MAX
+};
+#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
+
+/* Convert a capability name to number. */
+extern int sepol_polcap_getnum(const char *name);
+
+/* Convert a capability number to name. */
+extern const char *sepol_polcap_getname(int capnum);
+
+#endif /* _SEPOL_POLICYDB_POLCAPS_H_ */
Index: trunk/libsepol/include/sepol/policydb/policydb.h
===================================================================
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
@@ -595,9 +598,10 @@ extern int policydb_write(struct policyd
 #define MOD_POLICYDB_VERSION_MLS	   5
 #define MOD_POLICYDB_VERSION_RANGETRANS	   6
 #define MOD_POLICYDB_VERSION_MLS_USERS	   6
+#define MOD_POLICYDB_VERSION_POLCAP	   7
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_MLS_USERS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_POLCAP
 
 #define POLICYDB_CONFIG_MLS    1
 
Index: trunk/libsepol/src/expand.c
===================================================================
--- trunk.orig/libsepol/src/expand.c
+++ trunk/libsepol/src/expand.c
@@ -2252,6 +2252,12 @@ int expand_module(sepol_handle_t * handl
 	out->mls = base->mls;
 	out->handle_unknown = base->handle_unknown;
 
+	/* Copy policy capabilities */
+	if (ebitmap_cpy(&out->policycaps, &base->policycaps)) {
+		ERR(handle, "Out of memory!");
+		goto cleanup;
+	}
+
 	if ((state.typemap =
 	     (uint32_t *) calloc(state.base->p_types.nprim,
 				 sizeof(uint32_t))) == NULL) {
Index: trunk/libsepol/src/polcaps.c
===================================================================
--- /dev/null
+++ trunk/libsepol/src/polcaps.c
@@ -0,0 +1,32 @@
+/*
+ * Policy capability support functions
+ */
+
+#include <string.h>
+#include <sepol/policydb/polcaps.h>
+
+static const char *polcap_names[] = {
+	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
+	NULL
+};
+
+int sepol_polcap_getnum(const char *name)
+{
+	int capnum;
+
+	for (capnum = 0; capnum <= POLICYDB_CAPABILITY_MAX; capnum++) {
+		if (polcap_names[capnum] == NULL)
+			continue;
+		if (strcasecmp(polcap_names[capnum], name) == 0)
+			return capnum;
+	}
+	return -1;
+}
+
+const char *sepol_polcap_getname(int capnum)
+{
+	if (capnum > POLICYDB_CAPABILITY_MAX)
+		return NULL;
+
+	return polcap_names[capnum];
+}
Index: trunk/libsepol/src/policydb.c
===================================================================
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
@@ -117,6 +123,12 @@ static struct policydb_compat_info polic
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_POLCAP,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -132,6 +144,12 @@ static struct policydb_compat_info polic
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
 	 .sym_num = SYM_NUM,
+	 .ocon_num = 0
+	 },
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_POLCAP,
+	 .sym_num = SYM_NUM,
 	 .ocon_num = 0},
 };
 
@@ -447,6 +465,8 @@ int policydb_init(policydb_t * p)
 
 	memset(p, 0, sizeof(policydb_t));
 
+	ebitmap_init(&p->policycaps);
+
 	for (i = 0; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] = NULL;
 		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
@@ -971,6 +991,8 @@ void policydb_destroy(policydb_t * p)
 	if (!p)
 		return;
 
+	ebitmap_destroy(&p->policycaps);
+
 	symtabs_destroy(p->symtab);
 
 	for (i = 0; i < SYM_NUM; i++) {
@@ -3123,6 +3145,16 @@ int policydb_read(policydb_t * p, struct
 		p->version[len] = '\0';
 	}
 
+	if ((p->policyvers >= POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_KERN) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_BASE) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_MOD)) {
+		if (ebitmap_read(&p->policycaps, fp))
+			goto bad;
+	}
+
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 		if (rc < 0)
Index: trunk/libsepol/src/write.c
===================================================================
--- trunk.orig/libsepol/src/write.c
+++ trunk/libsepol/src/write.c
@@ -1595,6 +1595,17 @@ int policydb_write(policydb_t * p, struc
 		if (items != len)
 			return POLICYDB_ERROR;
 	}
+
+	if ((p->policyvers >= POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_KERN) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_BASE) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_MOD)) {
+		if (ebitmap_write(&p->policycaps, fp) == -1)
+			return POLICYDB_ERROR;
+	}
+
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
