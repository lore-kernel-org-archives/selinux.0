Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MD8oLd011891
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 09:08:56 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v3 5/9] libsepol: Add ibendport ocontext handling
Date: Mon, 22 May 2017 16:08:27 +0300
Message-Id: <1495458511-46724-6-git-send-email-danielj@mellanox.com>
In-Reply-To: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
References: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Add support for reading, writing, and copying IB end port ocontext data.
Also add support for querying a IB end port sid to checkpolicy.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

---
v1:
Stephen Smalley:
- Removed unused domain and type params from sepol_ibendport_sid.
- Remove ibendport initial sid from ocontext_selinux_isid_to_cil
- Check the length provide for the device name in ocontext_read_selinux
- Used strcmp for dev_name comparison.

James Carter:
- Added ibendport handling to kernel_to_cil.c and kernel_to_conf.c

v2:
James Carter
- Sort ocontexts in kernel_to_common.c
---
 checkpolicy/checkpolicy.c                  | 20 ++++++++++++++
 libsepol/include/sepol/policydb/services.h |  8 ++++++
 libsepol/src/expand.c                      |  8 ++++++
 libsepol/src/kernel_to_cil.c               | 42 ++++++++++++++++++++++++++++++
 libsepol/src/kernel_to_common.c            | 18 +++++++++++++
 libsepol/src/kernel_to_conf.c              | 41 +++++++++++++++++++++++++++++
 libsepol/src/libsepol.map.in               |  1 +
 libsepol/src/module_to_cil.c               | 14 ++++++++++
 libsepol/src/policydb.c                    | 26 +++++++++++++++---
 libsepol/src/services.c                    | 37 ++++++++++++++++++++++++++
 libsepol/src/write.c                       | 14 ++++++++++
 11 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 8aeecc1b..b75f2afa 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -701,6 +701,7 @@ int main(int argc, char **argv)
 	printf("i)  display constraint expressions\n");
 	printf("j)  display validatetrans expressions\n");
 	printf("k)  Call ibpkey_sid\n");
+	printf("l)  Call ibendport_sid\n");
 #ifdef EQUIVTYPES
 	printf("z)  Show equivalent types\n");
 #endif
@@ -1247,6 +1248,25 @@ int main(int argc, char **argv)
 				printf("sid %d\n", ssid);
 			}
 			break;
+		case 'l':
+			printf("device name (eg. mlx4_0)?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			ans[strlen(ans) - 1] = 0;
+
+			name = malloc((strlen(ans) + 1) * sizeof(char));
+			if (!name) {
+				fprintf(stderr, "couldn't malloc string.\n");
+				break;
+			}
+			strcpy(name, ans);
+
+			printf("port? ");
+			FGETS(ans, sizeof(ans), stdin);
+			port = atoi(ans);
+			sepol_ibendport_sid(name, port, &ssid);
+			printf("sid %d\n", ssid);
+			free(name);
+			break;
 #ifdef EQUIVTYPES
 		case 'z':
 			identify_equiv_types();
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 3f3b95d1..efdf7de5 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -196,6 +196,14 @@ extern int sepol_ibpkey_sid(uint64_t subnet_prefix_p,
 			    sepol_security_id_t *out_sid);
 
 /*
+ * Return the SID of the ibendport specified by
+ * `dev_name', and `port'.
+ */
+extern int sepol_ibendport_sid(char *dev_name,
+			       uint8_t port,
+			       sepol_security_id_t *out_sid);
+
+/*
  * Return the SIDs to use for a network interface
  * with the name `name'.  The `if_sid' SID is returned for 
  * the interface and the `msg_sid' SID is returned as
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index e4cfc41e..8f7a25d8 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2224,6 +2224,14 @@ static int ocontext_copy_selinux(expand_state_t *state)
 				n->u.ibpkey.low_pkey = c->u.ibpkey.low_pkey;
 				n->u.ibpkey.high_pkey = c->u.ibpkey.high_pkey;
 			break;
+			case OCON_IBENDPORT:
+				n->u.ibendport.dev_name = strdup(c->u.ibendport.dev_name);
+				if (!n->u.ibendport.dev_name) {
+					ERR(state->handle, "Out of memory!");
+					return -1;
+				}
+				n->u.ibendport.port = c->u.ibendport.port;
+				break;
 			case OCON_PORT:
 				n->u.port.protocol = c->u.port.protocol;
 				n->u.port.low_port = c->u.port.low_port;
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index d1006186..f4ec8832 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2841,6 +2841,43 @@ exit:
 	return rc;
 }
 
+static int write_selinux_ibendport_rules_to_cil(FILE *out, struct policydb *pdb)
+{
+	struct ocontext *ibendportcon;
+	char port_str[4];
+	char *ctx;
+	int rc = 0;
+
+	for (ibendportcon = pdb->ocontexts[OCON_IBENDPORT];
+	     ibendportcon != NULL; ibendportcon = ibendportcon->next) {
+		rc = snprintf(port_str, 4, "%u", ibendportcon->u.ibendport.port);
+		if (rc < 0 || rc >= 4) {
+			rc = -1;
+			goto exit;
+		}
+
+		ctx = context_to_str(pdb, &ibendportcon->context[0]);
+		if (!ctx) {
+			rc = -1;
+			goto exit;
+		}
+
+		sepol_printf(out, "(ibendportcon %s %s %s)\n",
+			     ibendportcon->u.ibendport.dev_name, port_str, ctx);
+
+		free(ctx);
+	}
+
+	rc = 0;
+
+exit:
+	if (rc != 0) {
+		sepol_log_err("Error writing ibendportcon rules to CIL\n");
+	}
+
+	return rc;
+}
+
 static int write_xen_isid_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	return write_sid_context_rules_to_cil(out, pdb, xen_sid_to_str);
@@ -3242,6 +3279,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		if (rc != 0) {
 			goto exit;
 		}
+
+		rc = write_selinux_ibendport_rules_to_cil(out, pdb);
+		if (rc != 0) {
+			goto exit;
+		}
 	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
 		rc = write_xen_isid_rules_to_cil(out, pdb);
 		if (rc != 0) {
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 294f0b4e..01ffc8fc 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -532,6 +532,19 @@ static int ibpkey_data_cmp(const void *a, const void *b)
 			      (*bb)->u.ibpkey.low_pkey, (*bb)->u.ibpkey.high_pkey);
 }
 
+static int ibendport_data_cmp(const void *a, const void *b)
+{
+	int rc;
+	struct ocontext *const *aa = a;
+	struct ocontext *const *bb = b;
+
+	rc = strcmp((*aa)->u.ibendport.dev_name, (*bb)->u.ibendport.dev_name);
+	if (rc)
+		return rc;
+
+	return (*aa)->u.ibendport.port - (*bb)->u.ibendport.port;
+}
+
 static int pirq_data_cmp(const void *a, const void *b)
 {
 	struct ocontext *const *aa = a;
@@ -660,6 +673,11 @@ int sort_ocontexts(struct policydb *pdb)
 		if (rc != 0) {
 			goto exit;
 		}
+
+		rc = sort_ocontext_data(&pdb->ocontexts[OCON_IBENDPORT], ibendport_data_cmp);
+		if (rc != 0) {
+			goto exit;
+		}
 	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
 		rc = sort_ocontext_data(&pdb->ocontexts[1], pirq_data_cmp);
 		if (rc != 0) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 23307ce6..a74873f0 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2703,6 +2703,42 @@ exit:
 	return rc;
 }
 
+static int write_selinux_ibendport_rules_to_conf(FILE *out, struct policydb *pdb)
+{
+	struct ocontext *ibendportcon;
+	char port_str[4];
+	char *ctx;
+	int rc = 0;
+
+	for (ibendportcon = pdb->ocontexts[OCON_IBENDPORT];
+	     ibendportcon != NULL; ibendportcon = ibendportcon->next) {
+		rc = snprintf(port_str, 4, "%u", ibendportcon->u.ibendport.port);
+		if (rc < 0 || rc >= 4) {
+			rc = -1;
+			goto exit;
+		}
+
+		ctx = context_to_str(pdb, &ibendportcon->context[0]);
+		if (!ctx) {
+			rc = -1;
+			goto exit;
+		}
+
+		sepol_printf(out, "ibendportcon %s %s %s\n", ibendportcon->u.ibendport.dev_name, port_str, ctx);
+
+		free(ctx);
+	}
+
+	rc = 0;
+
+exit:
+	if (rc != 0) {
+		sepol_log_err("Error writing ibendportcon rules to policy.conf\n");
+	}
+
+	return rc;
+}
+
 static int write_xen_isid_rules_to_conf(FILE *out, struct policydb *pdb)
 {
 	return write_sid_context_rules_to_conf(out, pdb, xen_sid_to_str);
@@ -3108,6 +3144,11 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 		if (rc != 0) {
 			goto exit;
 		}
+
+		rc = write_selinux_ibendport_rules_to_conf(out, pdb);
+		if (rc != 0) {
+			goto exit;
+		}
 	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
 		rc = write_xen_isid_rules_to_conf(out, pdb);
 		if (rc != 0) {
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 36225d1c..dd1fec21 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -7,6 +7,7 @@ LIBSEPOL_1.0 {
 	sepol_iface_*; 
 	sepol_port_*;
 	sepol_ibpkey_*;
+	sepol_ibendport_*;
 	sepol_node_*;
 	sepol_user_*; sepol_genusers; sepol_set_delusers;
 	sepol_msg_*; sepol_debug;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 10d0700c..41f0d6ce 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2776,6 +2776,19 @@ exit:
 	return rc;
 }
 
+static int ocontext_selinux_ibendport_to_cil(struct policydb *pdb, struct ocontext *ibendports)
+{
+	struct ocontext *ibendport;
+
+	for (ibendport = ibendports; ibendport; ibendport = ibendport->next) {
+		cil_printf("(ibendportcon %s %u ", ibendport->u.ibendport.dev_name, ibendport->u.ibendport.port);
+		context_to_cil(pdb, &ibendport->context[0]);
+
+		cil_printf(")\n");
+	}
+
+	return 0;
+}
 
 static int ocontext_selinux_fsuse_to_cil(struct policydb *pdb, struct ocontext *fsuses)
 {
@@ -2930,6 +2943,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
 		ocontext_selinux_fsuse_to_cil,
 		ocontext_selinux_node6_to_cil,
 		ocontext_selinux_ibpkey_to_cil,
+		ocontext_selinux_ibendport_to_cil,
 	};
 	static int (*ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
 		ocontext_xen_isid_to_cil,
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 09d14140..ab3b31f7 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -190,7 +190,7 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_INFINIBAND,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_IBPKEY + 1,
+	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
@@ -302,7 +302,7 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_INFINIBAND,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_IBPKEY + 1,
+	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
@@ -2804,7 +2804,7 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				len = le32_to_cpu(buf[0]);
-				if (zero_or_saturated(len))
+				if (zero_or_saturated(len) || len > 63)
 					return -1;
 				c->u.name = malloc(len + 1);
 				if (!c->u.name)
@@ -2835,6 +2835,26 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 				    (&c->context[0], p, fp))
 					return -1;
 				break;
+			case OCON_IBENDPORT:
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+				if (rc < 0)
+					return -1;
+				len = le32_to_cpu(buf[0]);
+				if (len == 0 || len > IB_DEVICE_NAME_MAX - 1)
+					return -1;
+
+				c->u.ibendport.dev_name = malloc(len + 1);
+				if (!c->u.ibendport.dev_name)
+					return -1;
+				rc = next_entry(c->u.ibendport.dev_name, fp, len);
+				if (rc < 0)
+					return -1;
+				c->u.ibendport.dev_name[len] = 0;
+				c->u.ibendport.port = le32_to_cpu(buf[1]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
 			case OCON_PORT:
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 				if (rc < 0)
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 27e802c6..10338a65 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1948,6 +1948,43 @@ out:
 }
 
 /*
+ * Return the SID of the subnet management interface specified by
+ * `device name', and `port'.
+ */
+int hidden sepol_ibendport_sid(char *dev_name,
+			       uint8_t port,
+			       sepol_security_id_t *out_sid)
+{
+	ocontext_t *c;
+	int rc = 0;
+
+	c = policydb->ocontexts[OCON_IBENDPORT];
+	while (c) {
+		if (c->u.ibendport.port == port &&
+		    !strcmp(dev_name, c->u.ibendport.dev_name))
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
+
+/*
  * Return the SID of the port specified by
  * `domain', `type', `protocol', and `port'.
  */
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index f63e7489..e486e286 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1427,6 +1427,20 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
 				if (context_write(p, &c->context[0], fp))
 					return POLICYDB_ERROR;
 				break;
+			case OCON_IBENDPORT:
+				len = strlen(c->u.ibendport.dev_name);
+				buf[0] = cpu_to_le32(len);
+				buf[1] = cpu_to_le32(c->u.ibendport.port);
+				items = put_entry(buf, sizeof(uint32_t), 2, fp);
+				if (items != 2)
+					return POLICYDB_ERROR;
+				items = put_entry(c->u.ibendport.dev_name, 1, len, fp);
+				if (items != len)
+					return POLICYDB_ERROR;
+
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
 			case OCON_PORT:
 				buf[0] = c->u.port.protocol;
 				buf[1] = c->u.port.low_port;
-- 
2.12.2
