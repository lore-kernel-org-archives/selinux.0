From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jeffv@google.com, jwcart2@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] libsepol, checkpolicy: add binary module support for xperms
Date: Tue, 16 May 2017 17:22:36 -0400
Message-Id: <20170516212236.30782-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Presently we support xperms rules in source policy and in CIL modules.
The binary policy module format however was never extended for xperms.
This limitation inhibits use of xperms in refpolicy-based policy modules
(including the selinux-testsuite policy).  Update libsepol to support
linking, reading, and writing a new binary policy module version that
supports xperms rules.  Update dismod to display xperms rules in binary
policy modules.

Also, to support use of a non-base binary policy module with a newer
version on a system using a base policy module with an older version,
automatically upgrade the version during module linking.  This facilitates
usage of newer features in non-base modules without requiring rebuilding
the base module.

Tests:
1. Add an allowxperms rule to the selinux-testsuite policy and
confirm that it is properly written to the binary policy module
(displayed by dismod), converted to CIL (the latter was already supported),
and included in the kernel policy (via dispol and kernel test).

2. Use semodule_link and semodule_expand to manually link and expand
all of the .pp files via libsepol, and confirm that the allowxperms rule
is correctly propagated to the kernel policy.  This test is required to
exercise the legacy link/expand code path for binary modules that predated
CIL.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 updates the dismod code to convert the av_extended_perms_t structure
from the avrule to an equivalent avtab_extended_perms_t structure rather
than assuming that they will always be identical.
 checkpolicy/test/dismod.c                  | 25 +++++++++++
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/link.c                        | 15 +++++++
 libsepol/src/policydb.c                    | 66 +++++++++++++++++++++++++++++-
 libsepol/src/write.c                       | 60 +++++++++++++++++++++------
 5 files changed, 153 insertions(+), 16 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index aac13e1..d5c7eea 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -243,6 +243,13 @@ int display_avrule(avrule_t * avrule, policydb_t * policy,
 		}
 	} else if (avrule->specified & AVRULE_NEVERALLOW) {
 		fprintf(fp, "  neverallow");
+	} else if (avrule->specified & AVRULE_XPERMS) {
+		if (avrule->specified & AVRULE_XPERMS_ALLOWED)
+			fprintf(fp, "allowxperm ");
+		else if (avrule->specified & AVRULE_XPERMS_AUDITALLOW)
+			fprintf(fp, "auditallowxperm ");
+		else if (avrule->specified & AVRULE_XPERMS_DONTAUDIT)
+			fprintf(fp, "dontauditxperm ");
 	} else {
 		fprintf(fp, "     ERROR: no valid rule type specified\n");
 		return -1;
@@ -282,6 +289,24 @@ int display_avrule(avrule_t * avrule, policydb_t * policy,
 				   policy, fp);
 	} else if (avrule->specified & AVRULE_TYPE) {
 		display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
+	} else if (avrule->specified & AVRULE_XPERMS) {
+		avtab_extended_perms_t xperms;
+		int i;
+
+		if (avrule->xperms->specified == AVRULE_XPERMS_IOCTLFUNCTION)
+			xperms.specified = AVTAB_XPERMS_IOCTLFUNCTION;
+		else if (avrule->xperms->specified == AVRULE_XPERMS_IOCTLDRIVER)
+			xperms.specified = AVTAB_XPERMS_IOCTLDRIVER;
+		else {
+			fprintf(fp, "     ERROR: no valid xperms specified\n");
+			return -1;
+		}
+
+		xperms.driver = avrule->xperms->driver;
+		for (i = 0; i < EXTENDED_PERMS_LEN; i++)
+			xperms.perms[i] = avrule->xperms->perms[i];
+
+		fprintf(fp, "%s", sepol_extended_perms_to_string(&xperms));
 	}
 
 	fprintf(fp, ";\n");
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 37e0c9e..99e4990 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -748,9 +748,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	15
 #define MOD_POLICYDB_VERSION_DEFAULT_TYPE	16
 #define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES  17
+#define MOD_POLICYDB_VERSION_XPERMS_IOCTL  18
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_CONSTRAINT_NAMES
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_XPERMS_IOCTL
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index f211164..cd4cc86 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1325,6 +1325,15 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
 			tail_perm = new_perm;
 			cur_perm = cur_perm->next;
 		}
+
+		if (cur->xperms) {
+			new_rule->xperms = calloc(1, sizeof(*new_rule->xperms));
+			if (!new_rule->xperms)
+				goto cleanup;
+			memcpy(new_rule->xperms, cur->xperms,
+			       sizeof(*new_rule->xperms));
+		}
+
 		new_rule->line = cur->line;
 		new_rule->source_line = cur->source_line;
 		if (cur->source_filename) {
@@ -2569,6 +2578,12 @@ int link_modules(sepol_handle_t * handle,
 			goto cleanup;
 		}
 
+		if (mods[i]->policyvers > b->policyvers) {
+			WARN(state.handle,
+			     "Upgrading policy version from %u to %u\n", b->policyvers, mods[i]->policyvers);
+			b->policyvers = mods[i]->policyvers;
+		}
+
 		if ((modules[i] =
 		     (policy_module_t *) calloc(1,
 						sizeof(policy_module_t))) ==
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 7093b29..069eb7e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -284,6 +284,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_XPERMS_IOCTL,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -381,6 +388,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_XPERMS_IOCTL,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -557,6 +571,8 @@ void avrule_destroy(avrule_t * x)
 		next = cur->next;
 		free(cur);
 	}
+
+	free(x->xperms);
 }
 
 void role_trans_rule_init(role_trans_rule_t * x)
@@ -3215,8 +3231,8 @@ static avrule_t *avrule_read(policydb_t * p
 	if (rc < 0)
 		goto bad;
 
-	(avrule)->specified = le32_to_cpu(buf[0]);
-	(avrule)->flags = le32_to_cpu(buf[1]);
+	avrule->specified = le32_to_cpu(buf[0]);
+	avrule->flags = le32_to_cpu(buf[1]);
 
 	if (type_set_read(&avrule->stypes, fp))
 		goto bad;
@@ -3252,6 +3268,52 @@ static avrule_t *avrule_read(policydb_t * p
 		tail = cur;
 	}
 
+	if (avrule->specified & AVRULE_XPERMS) {
+		uint8_t buf8;
+		size_t nel = ARRAY_SIZE(avrule->xperms->perms);
+		uint32_t buf32[nel];
+
+		if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
+			ERR(fp->handle,
+			    "module policy version %u does not support ioctl"
+			    " extended permissions rules and one was specified",
+			    p->policyvers);
+			goto bad;
+		}
+
+		if (p->target_platform != SEPOL_TARGET_SELINUX) {
+			ERR(fp->handle,
+			    "Target platform %s does not support ioctl"
+			    " extended permissions rules and one was specified",
+			    policydb_target_strings[p->target_platform]);
+			goto bad;
+		}
+
+		avrule->xperms = calloc(1, sizeof(*avrule->xperms));
+		if (!avrule->xperms)
+			goto bad;
+
+		rc = next_entry(&buf8, fp, sizeof(uint8_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			goto bad;
+		}
+		avrule->xperms->specified = buf8;
+		rc = next_entry(&buf8, fp, sizeof(uint8_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			goto bad;
+		}
+		avrule->xperms->driver = buf8;
+		rc = next_entry(buf32, fp, sizeof(uint32_t)*nel);
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			goto bad;
+		}
+		for (i = 0; i < nel; i++)
+			avrule->xperms->perms[i] = le32_to_cpu(buf32[i]);
+	}
+
 	return avrule;
       bad:
 	if (avrule) {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index e75b9ab..1606807 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -50,7 +50,8 @@ struct policy_data {
 	struct policydb *p;
 };
 
-static int avrule_write_list(avrule_t * avrules, struct policy_file *fp);
+static int avrule_write_list(policydb_t *p,
+			     avrule_t * avrules, struct policy_file *fp);
 
 static int ebitmap_write(ebitmap_t * e, struct policy_file *fp)
 {
@@ -779,9 +780,9 @@ static int cond_write_node(policydb_t * p,
 		if (cond_write_av_list(p, node->false_list, fp) != 0)
 			return POLICYDB_ERROR;
 	} else {
-		if (avrule_write_list(node->avtrue_list, fp))
+		if (avrule_write_list(p, node->avtrue_list, fp))
 			return POLICYDB_ERROR;
-		if (avrule_write_list(node->avfalse_list, fp))
+		if (avrule_write_list(p, node->avfalse_list, fp))
 			return POLICYDB_ERROR;
 	}
 
@@ -1613,18 +1614,13 @@ static int range_write(policydb_t * p, struct policy_file *fp)
 
 /************** module writing functions below **************/
 
-static int avrule_write(avrule_t * avrule, struct policy_file *fp)
+static int avrule_write(policydb_t *p, avrule_t * avrule,
+			struct policy_file *fp)
 {
 	size_t items, items2;
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
 
-	if (avrule->specified & AVRULE_XPERMS) {
-		ERR(fp->handle, "module policy does not support extended"
-				" permissions rules and one was specified");
-		return POLICYDB_ERROR;
-	}
-
 	items = 0;
 	buf[items++] = cpu_to_le32(avrule->specified);
 	buf[items++] = cpu_to_le32(avrule->flags);
@@ -1661,10 +1657,48 @@ static int avrule_write(avrule_t * avrule, struct policy_file *fp)
 		cur = cur->next;
 	}
 
+	if (avrule->specified & AVRULE_XPERMS) {
+		size_t nel = ARRAY_SIZE(avrule->xperms->perms);
+		uint32_t buf32[nel];
+		uint8_t buf8;
+		unsigned int i;
+
+		if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
+			ERR(fp->handle,
+			    "module policy version %u does not support ioctl"
+			    " extended permissions rules and one was specified",
+			    p->policyvers);
+			return POLICYDB_ERROR;
+		}
+
+		if (p->target_platform != SEPOL_TARGET_SELINUX) {
+			ERR(fp->handle,
+			    "Target platform %s does not support ioctl"
+			    " extended permissions rules and one was specified",
+			    policydb_target_strings[p->target_platform]);
+			return POLICYDB_ERROR;
+		}
+
+		buf8 = avrule->xperms->specified;
+		items = put_entry(&buf8, sizeof(uint8_t),1,fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+		buf8 = avrule->xperms->driver;
+		items = put_entry(&buf8, sizeof(uint8_t),1,fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+		for (i = 0; i < nel; i++)
+			buf32[i] = cpu_to_le32(avrule->xperms->perms[i]);
+		items = put_entry(buf32, sizeof(uint32_t), nel, fp);
+		if (items != nel)
+			return POLICYDB_ERROR;
+	}
+
 	return POLICYDB_SUCCESS;
 }
 
-static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
+static int avrule_write_list(policydb_t *p, avrule_t * avrules,
+			     struct policy_file *fp)
 {
 	uint32_t buf[32], len;
 	avrule_t *avrule;
@@ -1682,7 +1716,7 @@ static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
 
 	avrule = avrules;
 	while (avrule) {
-		if (avrule_write(avrule, fp))
+		if (avrule_write(p, avrule, fp))
 			return POLICYDB_ERROR;
 		avrule = avrule->next;
 	}
@@ -1870,7 +1904,7 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
 		return POLICYDB_ERROR;
 	}
 	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
-	    avrule_write_list(decl->avrules, fp) == -1 ||
+	    avrule_write_list(p, decl->avrules, fp) == -1 ||
 	    role_trans_rule_write(p, decl->role_tr_rules, fp) == -1 ||
 	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
 		return POLICYDB_ERROR;
-- 
2.9.3
