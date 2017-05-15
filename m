Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4FKhKYw021276
 for <selinux@tycho.nsa.gov>; Mon, 15 May 2017 16:43:21 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v1 2/9] libsepol: Add ibpkey ocontext handling
Date: Mon, 15 May 2017 23:42:34 +0300
Message-Id: <1494880961-73481-3-git-send-email-danielj@mellanox.com>
In-Reply-To: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Add support for reading, writing, and copying Infinabinda Pkey ocontext
data. Also add support for querying a Pkey sid to checkpolicy.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

---
v1:
Stephen Smalley:
- Removed domain and type params from sepol_ibpkey_sid.
- Removed splen param from sepol_ibpkey_sid, it never varied.
- Removed extra XPERMS_IOCTL version from policydb_compat_info.
- Confirm that low order bytes of IPv6 addr for subnet prefix is 0's.

James Carter:
- Added ibpkey handling to kernel_to_cil.c and kernel_to_conf.c

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 checkpolicy/checkpolicy.c                  | 25 +++++++++++++
 libsepol/include/sepol/policydb/services.h |  8 ++++
 libsepol/src/expand.c                      |  9 +++++
 libsepol/src/kernel_to_cil.c               | 58 +++++++++++++++++++++++++++++
 libsepol/src/kernel_to_conf.c              | 59 ++++++++++++++++++++++++++++++
 libsepol/src/libsepol.map.in               |  1 +
 libsepol/src/module_to_cil.c               | 38 +++++++++++++++++++
 libsepol/src/policydb.c                    | 37 +++++++++++++++++++
 libsepol/src/services.c                    | 51 ++++++++++++++++++++++++++
 libsepol/src/write.c                       | 16 ++++++++
 10 files changed, 302 insertions(+)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 534fc22..d0e46ba 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -22,6 +22,7 @@
  *
  *	Policy Module support.
  *
+ * Copyright (C) 2017 Mellanox Technologies Inc.
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
@@ -699,6 +700,7 @@ int main(int argc, char **argv)
 	printf("h)  change a boolean value\n");
 	printf("i)  display constraint expressions\n");
 	printf("j)  display validatetrans expressions\n");
+	printf("k)  Call ibpkey_sid\n");
 #ifdef EQUIVTYPES
 	printf("z)  Show equivalent types\n");
 #endif
@@ -1220,6 +1222,29 @@ int main(int argc, char **argv)
 				    "\nNo validatetrans expressions found.\n");
 			}
 			break;
+		case 'k':
+			{
+				char *p;
+				struct in6_addr addr6;
+				unsigned int pkey;
+
+				printf("subnet prefix?  ");
+				FGETS(ans, sizeof(ans), stdin);
+				ans[strlen(ans) - 1] = 0;
+				p = (char *)&addr6;
+
+				if (inet_pton(AF_INET6, ans, p) < 1) {
+					printf("error parsing subnet prefix\n");
+					break;
+				}
+
+				printf("pkey? ");
+				FGETS(ans, sizeof(ans), stdin);
+				pkey = atoi(ans);
+				sepol_ibpkey_sid(p, pkey, &ssid);
+				printf("sid %d\n", ssid);
+			}
+			break;
 #ifdef EQUIVTYPES
 		case 'z':
 			identify_equiv_types();
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 9162149..459254e 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -188,6 +188,14 @@ extern int sepol_port_sid(uint16_t domain,
 			  uint16_t port, sepol_security_id_t * out_sid);
 
 /*
+ * Return the SID of the ibpkey specified by
+ * `subnet prefix', and `pkey'.
+ */
+extern int sepol_ibpkey_sid(void *subnet_prefix_p,
+			    uint16_t pkey,
+			    sepol_security_id_t *out_sid);
+
+/*
  * Return the SIDs to use for a network interface
  * with the name `name'.  The `if_sid' SID is returned for 
  * the interface and the `msg_sid' SID is returned as
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 54bf781..c45ecbe 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
  * Copyright (C) 2007 Red Hat, Inc.
+ * Copyright (C) 2017 Mellanox Technologies, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -2217,6 +2218,14 @@ static int ocontext_copy_selinux(expand_state_t *state)
 					return -1;
 				}
 				break;
+			case OCON_IBPKEY:
+				n->u.ibpkey.subnet_prefix[0] = c->u.ibpkey.subnet_prefix[0];
+				n->u.ibpkey.subnet_prefix[1] = c->u.ibpkey.subnet_prefix[1];
+				n->u.ibpkey.subnet_prefix[2] = c->u.ibpkey.subnet_prefix[2];
+				n->u.ibpkey.subnet_prefix[3] = c->u.ibpkey.subnet_prefix[3];
+				n->u.ibpkey.low_pkey = c->u.ibpkey.low_pkey;
+				n->u.ibpkey.high_pkey = c->u.ibpkey.high_pkey;
+			break;
 			case OCON_PORT:
 				n->u.port.protocol = c->u.port.protocol;
 				n->u.port.low_port = c->u.port.low_port;
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 3a1c0be..fcfd0e0 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2784,6 +2784,59 @@ exit:
 	return rc;
 }
 
+static int write_selinux_ibpkey_rules_to_cil(FILE *out, struct policydb *pdb)
+{
+	struct ocontext *ibpkeycon;
+	char subnet_prefix[INET6_ADDRSTRLEN];
+	uint16_t low;
+	uint16_t high;
+	char low_high_str[44]; /* 2^64 <= 20 digits so "(low high)" <= 44 chars */
+	char *ctx;
+	int rc = 0;
+
+	for (ibpkeycon = pdb->ocontexts[OCON_IBPKEY]; ibpkeycon != NULL;
+	     ibpkeycon = ibpkeycon->next) {
+		if (inet_ntop(AF_INET6, &ibpkeycon->u.ibpkey.subnet_prefix,
+			      subnet_prefix, INET6_ADDRSTRLEN) == NULL) {
+			sepol_log_err("ibpkeycon subnet_prefix is invalid: %s",
+				      strerror(errno));
+			rc = -1;
+			goto exit;
+		}
+
+		low = ibpkeycon->u.ibpkey.low_pkey;
+		high = ibpkeycon->u.ibpkey.high_pkey;
+		if (low == high) {
+			rc = snprintf(low_high_str, 44, "%u", low);
+		} else {
+			rc = snprintf(low_high_str, 44, "(%u %u)", low, high);
+		}
+		if (rc < 0 || rc >= 44) {
+			rc = -1;
+			goto exit;
+		}
+
+		ctx = context_to_str(pdb, &ibpkeycon->context[0]);
+		if (!ctx) {
+			rc = -1;
+			goto exit;
+		}
+
+		sepol_printf(out, "(ibpkeycon %s %s %s)\n", subnet_prefix, low_high_str, ctx);
+
+		free(ctx);
+	}
+
+	rc = 0;
+
+exit:
+	if (rc != 0) {
+		sepol_log_err("Error writing ibpkeycon rules to CIL\n");
+	}
+
+	return rc;
+}
+
 static int write_xen_isid_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	return write_sid_context_rules_to_cil(out, pdb, xen_sid_to_str);
@@ -3180,6 +3233,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		if (rc != 0) {
 			goto exit;
 		}
+
+		rc = write_selinux_ibpkey_rules_to_cil(out, pdb);
+		if (rc != 0) {
+			goto exit;
+		}
 	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
 		rc = write_xen_isid_rules_to_cil(out, pdb);
 		if (rc != 0) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 22a0909..795cf56 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2645,6 +2645,60 @@ exit:
 	return rc;
 }
 
+static int write_selinux_ibpkey_rules_to_conf(FILE *out, struct policydb *pdb)
+{
+	struct ocontext *ibpkeycon;
+	char subnet_prefix[INET6_ADDRSTRLEN];
+	uint16_t low;
+	uint16_t high;
+	char low_high_str[44]; /* 2^64 <= 20 digits so "low-high" <= 44 chars */
+	char *ctx;
+	int rc = 0;
+
+	for (ibpkeycon = pdb->ocontexts[OCON_IBPKEY]; ibpkeycon != NULL;
+	     ibpkeycon = ibpkeycon->next) {
+		if (inet_ntop(AF_INET6, &ibpkeycon->u.ibpkey.subnet_prefix,
+			      subnet_prefix, INET6_ADDRSTRLEN) == NULL) {
+			sepol_log_err("ibpkeycon address is invalid: %s",
+				      strerror(errno));
+			rc = -1;
+			goto exit;
+		}
+
+		low = ibpkeycon->u.ibpkey.low_pkey;
+		high = ibpkeycon->u.ibpkey.high_pkey;
+		if (low == high) {
+			rc = snprintf(low_high_str, 44, "%u", low);
+		} else {
+			rc = snprintf(low_high_str, 44, "%u-%u", low, high);
+		}
+		if (rc < 0 || rc >= 44) {
+			rc = -1;
+			goto exit;
+		}
+
+		ctx = context_to_str(pdb, &ibpkeycon->context[0]);
+		if (!ctx) {
+			rc = -1;
+			goto exit;
+		}
+
+		sepol_printf(out, "ibpkeycon %s %s %s\n", subnet_prefix,
+			     low_high_str, ctx);
+
+		free(ctx);
+	}
+
+	rc = 0;
+
+exit:
+	if (rc != 0) {
+		sepol_log_err("Error writing ibpkeycon rules to policy.conf\n");
+	}
+
+	return rc;
+}
+
 static int write_xen_isid_rules_to_conf(FILE *out, struct policydb *pdb)
 {
 	return write_sid_context_rules_to_conf(out, pdb, xen_sid_to_str);
@@ -3045,6 +3099,11 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 		if (rc != 0) {
 			goto exit;
 		}
+
+		rc = write_selinux_ibpkey_rules_to_conf(out, pdb);
+		if (rc != 0) {
+			goto exit;
+		}
 	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
 		rc = write_xen_isid_rules_to_conf(out, pdb);
 		if (rc != 0) {
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 4042640..36225d1 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -6,6 +6,7 @@ LIBSEPOL_1.0 {
 	sepol_context_*; sepol_mls_*; sepol_check_context;
 	sepol_iface_*; 
 	sepol_port_*;
+	sepol_ibpkey_*;
 	sepol_node_*;
 	sepol_user_*; sepol_genusers; sepol_set_delusers;
 	sepol_msg_*; sepol_debug;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 7d8eb20..c97f453 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3,6 +3,7 @@
  * Functions to convert policy module to CIL
  *
  * Copyright (C) 2015 Tresys Technology, LLC
+ * Copyright (C) 2017 Mellanox Technologies Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -2656,6 +2657,42 @@ exit:
 	return rc;
 }
 
+static int ocontext_selinux_ibpkey_to_cil(struct policydb *pdb,
+					struct ocontext *ibpkeycons)
+{
+	int rc = -1;
+	struct ocontext *ibpkeycon;
+	char subnet_prefix[INET6_ADDRSTRLEN];
+	uint16_t high;
+	uint16_t low;
+
+	for (ibpkeycon = ibpkeycons; ibpkeycon; ibpkeycon = ibpkeycon->next) {
+		low = ibpkeycon->u.ibpkey.low_pkey;
+		high = ibpkeycon->u.ibpkey.high_pkey;
+
+		if (inet_ntop(AF_INET6, &ibpkeycon->u.ibpkey.subnet_prefix,
+			      subnet_prefix, INET6_ADDRSTRLEN) == NULL) {
+			log_err("ibpkeycon subnet_prefix is invalid: %s",
+				strerror(errno));
+			rc = -1;
+			goto exit;
+		}
+
+		if (low == high)
+			cil_printf("(ibpkeycon %s %i ", subnet_prefix, low);
+		else
+			cil_printf("(ibpkeycon %s (%i %i) ", subnet_prefix, low,
+				   high);
+
+		context_to_cil(pdb, &ibpkeycon->context[0]);
+
+		cil_printf(")\n");
+	}
+	return 0;
+exit:
+	return rc;
+}
+
 static int ocontext_selinux_netif_to_cil(struct policydb *pdb, struct ocontext *netifs)
 {
 	struct ocontext *netif;
@@ -2889,6 +2926,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
 		ocontext_selinux_node_to_cil,
 		ocontext_selinux_fsuse_to_cil,
 		ocontext_selinux_node6_to_cil,
+		ocontext_selinux_ibpkey_to_cil,
 	};
 	static int (*ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
 		ocontext_xen_isid_to_cil,
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 7093b29..d6e8e6f 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -18,6 +18,7 @@
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2005 Tresys Technology, LLC
  * Copyright (C) 2003 - 2007 Red Hat, Inc.
+ * Copyright (C) 2017 Mellanox Technologies Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -186,6 +187,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_INFINIBAND,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBPKEY + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -284,6 +292,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_INFINIBAND,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBPKEY + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -381,6 +396,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_INFINIBAND,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -2782,6 +2804,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 				    (&c->context[1], p, fp))
 					return -1;
 				break;
+			case OCON_IBPKEY:
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 6);
+				if (rc < 0 || buf[2] || buf[3])
+					return -1;
+
+				c->u.ibpkey.subnet_prefix[0] = buf[0];
+				c->u.ibpkey.subnet_prefix[1] = buf[1];
+
+				c->u.ibpkey.low_pkey = le32_to_cpu(buf[4]);
+				c->u.ibpkey.high_pkey = le32_to_cpu(buf[5]);
+
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
 			case OCON_PORT:
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 				if (rc < 0)
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 03fb120..4236aac 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -21,6 +21,7 @@
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  * Copyright (C) 2003 - 2004 Red Hat, Inc.
+ * Copyright (C) 2017 Mellanox Technologies Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -1910,6 +1911,56 @@ int hidden sepol_fs_sid(char *name,
 	return rc;
 }
 
+static int match_subnet_prefix(uint32_t *input, uint32_t *subnet_prefix)
+{
+	int i, fail = 0;
+
+	for (i = 0; i < 4; i++)
+		if (subnet_prefix[i] != input[i]) {
+			fail = 1;
+			break;
+		}
+
+	return !fail;
+}
+
+/*
+ * Return the SID of the ibpkey specified by
+ * `subnet prefix', and `pkey number'.
+ */
+int hidden sepol_ibpkey_sid(void *subnet_prefix_p,
+			    uint16_t pkey, sepol_security_id_t *out_sid)
+{
+	ocontext_t *c;
+	int rc = 0;
+
+	c = policydb->ocontexts[OCON_IBPKEY];
+	while (c) {
+		if (c->u.ibpkey.low_pkey <= pkey &&
+		    c->u.ibpkey.high_pkey >= pkey &&
+		    match_subnet_prefix(subnet_prefix_p,
+					c->u.ibpkey.subnet_prefix))
+			break;
+		c = c->next;
+	}
+
+	if (c) {
+		if (!c->sid[0]) {
+			rc = sepol_sidtab_context_to_sid(sidtab,
+							 &c->context[0],
+							 &c->sid[0]);
+			if (rc)
+				goto out;
+		}
+		*out_sid = c->sid[0];
+	} else {
+		*out_sid = SECINITSID_UNLABELED;
+	}
+
+out:
+	return rc;
+}
+
 /*
  * Return the SID of the port specified by
  * `domain', `type', `protocol', and `port'.
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index e75b9ab..fa1b7d1 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -16,6 +16,7 @@
  *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003-2005 Tresys Technology, LLC
+ * Copyright (C) 2017 Mellanox Technologies Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -1410,6 +1411,21 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
 				if (context_write(p, &c->context[1], fp))
 					return POLICYDB_ERROR;
 				break;
+			case OCON_IBPKEY:
+				 /* The subnet prefix is in network order */
+				for (j = 0; j < 4; j++)
+					buf[j] = c->u.ibpkey.subnet_prefix[j];
+
+				buf[4] = cpu_to_le32(c->u.ibpkey.low_pkey);
+				buf[5] = cpu_to_le32(c->u.ibpkey.high_pkey);
+
+				items = put_entry(buf, sizeof(uint32_t), 6, fp);
+				if (items != 6)
+					return POLICYDB_ERROR;
+
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
 			case OCON_PORT:
 				buf[0] = c->u.port.protocol;
 				buf[1] = c->u.port.low_port;
-- 
2.7.4
