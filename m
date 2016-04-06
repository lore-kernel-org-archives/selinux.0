Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u36BiqZD012291
 for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2016 07:44:52 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: Add support for portcon dccp protocol
Date: Wed,  6 Apr 2016 12:44:35 +0100
Message-Id: <1459943075-4050-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This adds CIL and checkpolicy support for the (portcon dccp ...)
statement. The kernel already handles name_bind and name_connect
permissions for the dccp_socket class.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 checkpolicy/checkpolicy.c                      | 2 ++
 checkpolicy/policy_define.c                    | 2 ++
 libsepol/cil/src/cil.c                         | 1 +
 libsepol/cil/src/cil_binary.c                  | 3 +++
 libsepol/cil/src/cil_build_ast.c               | 2 ++
 libsepol/cil/src/cil_internal.h                | 4 +++-
 libsepol/cil/src/cil_policy.c                  | 2 ++
 libsepol/cil/src/cil_tree.c                    | 2 ++
 libsepol/include/sepol/port_record.h           | 1 +
 libsepol/src/module_to_cil.c                   | 1 +
 libsepol/src/port_record.c                     | 2 ++
 libsepol/src/ports.c                           | 4 ++++
 secilc/docs/cil_network_labeling_statements.md | 5 +++--
 secilc/test/policy.cil                         | 1 +
 14 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 9da661e..ea9ee00 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -919,6 +919,8 @@ int main(int argc, char **argv)
 				protocol = IPPROTO_TCP;
 			else if (!strcmp(ans, "udp") || !strcmp(ans, "UDP"))
 				protocol = IPPROTO_UDP;
+			else if (!strcmp(ans, "dccp") || !strcmp(ans, "DCCP"))
+				protocol = IPPROTO_DCCP;
 			else {
 				printf("unknown protocol\n");
 				break;
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index ee20fea..7a4d2f1 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4876,6 +4876,8 @@ int define_port_context(unsigned int low, unsigned int high)
 		protocol = IPPROTO_TCP;
 	} else if ((strcmp(id, "udp") == 0) || (strcmp(id, "UDP") == 0)) {
 		protocol = IPPROTO_UDP;
+	} else if ((strcmp(id, "dccp") == 0) || (strcmp(id, "DCCP") == 0)) {
+		protocol = IPPROTO_DCCP;
 	} else {
 		yyerror2("unrecognized protocol %s", id);
 		free(newc);
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index afdc240..de7033a 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -108,6 +108,7 @@ static void cil_init_keys(void)
 	CIL_KEY_STAR = cil_strpool_add("*");
 	CIL_KEY_UDP = cil_strpool_add("udp");
 	CIL_KEY_TCP = cil_strpool_add("tcp");
+	CIL_KEY_DCCP = cil_strpool_add("dccp");
 	CIL_KEY_AUDITALLOW = cil_strpool_add("auditallow");
 	CIL_KEY_TUNABLEIF = cil_strpool_add("tunableif");
 	CIL_KEY_ALLOW = cil_strpool_add("allow");
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index f749e53..5d7e52e 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3035,6 +3035,9 @@ int cil_portcon_to_policydb(policydb_t *pdb, struct cil_sort *portcons)
 		case CIL_PROTOCOL_TCP:
 			new_ocon->u.port.protocol = IPPROTO_TCP;
 			break;
+		case CIL_PROTOCOL_DCCP:
+			new_ocon->u.port.protocol = IPPROTO_DCCP;
+			break;
 		default:
 			/* should not get here */
 			rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 1135e06..90fee8e 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4261,6 +4261,8 @@ int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		portcon->proto = CIL_PROTOCOL_UDP;
 	} else if (proto == CIL_KEY_TCP) {
 		portcon->proto = CIL_PROTOCOL_TCP;
+	} else if (proto == CIL_KEY_DCCP) {
+		portcon->proto = CIL_PROTOCOL_DCCP;
 	} else {
 		cil_log(CIL_ERR, "Invalid protocol\n");
 		rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index a0a5480..a75ddf8 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -101,6 +101,7 @@ char *CIL_KEY_OBJECT_R;
 char *CIL_KEY_STAR;
 char *CIL_KEY_TCP;
 char *CIL_KEY_UDP;
+char *CIL_KEY_DCCP;
 char *CIL_KEY_AUDITALLOW;
 char *CIL_KEY_TUNABLEIF;
 char *CIL_KEY_ALLOW;
@@ -713,7 +714,8 @@ struct cil_filecon {
 
 enum cil_protocol {
 	CIL_PROTOCOL_UDP = 1,
-	CIL_PROTOCOL_TCP	
+	CIL_PROTOCOL_TCP,
+	CIL_PROTOCOL_DCCP
 };
 
 struct cil_portcon {
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 2c9b158..382129b 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -123,6 +123,8 @@ int cil_portcon_to_policy(FILE **file_arr, struct cil_sort *sort)
 			fprintf(file_arr[NETIFCONS], "udp ");
 		} else if (portcon->proto == CIL_PROTOCOL_TCP) {
 			fprintf(file_arr[NETIFCONS], "tcp ");
+		} else if (portcon->proto == CIL_PROTOCOL_DCCP) {
+			fprintf(file_arr[NETIFCONS], "dccp ");
 		}
 		fprintf(file_arr[NETIFCONS], "%d ", portcon->port_low);
 		fprintf(file_arr[NETIFCONS], "%d ", portcon->port_high);
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 1c23efc..563b817 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1319,6 +1319,8 @@ void cil_tree_print_node(struct cil_tree_node *node)
 				cil_log(CIL_INFO, " udp");
 			} else if (portcon->proto == CIL_PROTOCOL_TCP) {
 				cil_log(CIL_INFO, " tcp");
+			} else if (portcon->proto == CIL_PROTOCOL_DCCP) {
+				cil_log(CIL_INFO, " dccp");
 			}
 			cil_log(CIL_INFO, " (%d %d)", portcon->port_low, portcon->port_high);
 
diff --git a/libsepol/include/sepol/port_record.h b/libsepol/include/sepol/port_record.h
index 697cea4..c07d1fa 100644
--- a/libsepol/include/sepol/port_record.h
+++ b/libsepol/include/sepol/port_record.h
@@ -14,6 +14,7 @@ typedef struct sepol_port_key sepol_port_key_t;
 
 #define SEPOL_PROTO_UDP 0
 #define SEPOL_PROTO_TCP 1
+#define SEPOL_PROTO_DCCP 2
 
 /* Key */
 extern int sepol_port_compare(const sepol_port_t * port,
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 18ec6b9..b478d9f 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2537,6 +2537,7 @@ static int ocontext_selinux_port_to_cil(struct policydb *pdb, struct ocontext *p
 		switch (portcon->u.port.protocol) {
 		case IPPROTO_TCP: protocol = "tcp"; break;
 		case IPPROTO_UDP: protocol = "udp"; break;
+		case IPPROTO_DCCP: protocol = "dccp"; break;
 		default:
 			log_err("Unknown portcon protocol: %i", portcon->u.port.protocol);
 			rc = -1;
diff --git a/libsepol/src/port_record.c b/libsepol/src/port_record.c
index 6a33d93..ed9093b 100644
--- a/libsepol/src/port_record.c
+++ b/libsepol/src/port_record.c
@@ -184,6 +184,8 @@ const char *sepol_port_get_proto_str(int proto)
 		return "udp";
 	case SEPOL_PROTO_TCP:
 		return "tcp";
+	case SEPOL_PROTO_DCCP:
+		return "dccp";
 	default:
 		return "???";
 	}
diff --git a/libsepol/src/ports.c b/libsepol/src/ports.c
index 607a629..b1ee094 100644
--- a/libsepol/src/ports.c
+++ b/libsepol/src/ports.c
@@ -16,6 +16,8 @@ static inline int sepol2ipproto(sepol_handle_t * handle, int proto)
 		return IPPROTO_TCP;
 	case SEPOL_PROTO_UDP:
 		return IPPROTO_UDP;
+	case SEPOL_PROTO_DCCP:
+		return IPPROTO_DCCP;
 	default:
 		ERR(handle, "unsupported protocol %u", proto);
 		return STATUS_ERR;
@@ -30,6 +32,8 @@ static inline int ipproto2sepol(sepol_handle_t * handle, int proto)
 		return SEPOL_PROTO_TCP;
 	case IPPROTO_UDP:
 		return SEPOL_PROTO_UDP;
+	case IPPROTO_DCCP:
+		return SEPOL_PROTO_DCCP;
 	default:
 		ERR(handle, "invalid protocol %u " "found in policy", proto);
 		return STATUS_ERR;
diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
index 183b350..b06dbcc 100644
--- a/secilc/docs/cil_network_labeling_statements.md
+++ b/secilc/docs/cil_network_labeling_statements.md
@@ -155,7 +155,7 @@ These examples show named and anonymous [`nodecon`](cil_network_labeling_stateme
 portcon
 -------
 
-Label a udp or tcp port.
+Label a udp, tcp or dccp port.
 
 **Statement definition:**
 
@@ -175,7 +175,7 @@ Label a udp or tcp port.
 </tr>
 <tr class="even">
 <td align="left"><p><code>protocol</code></p></td>
-<td align="left"><p>The protocol keyword <code>tcp</code> or <code>udp</code>.</p></td>
+<td align="left"><p>The protocol keyword <code>tcp</code>, <code>udp</code> or <code>dccp</code>.</p></td>
 </tr>
 <tr class="odd">
 <td align="left"><p><code>port |</code></p>
@@ -199,3 +199,4 @@ These examples show named and anonymous [`portcon`](cil_network_labeling_stateme
     (portcon tcp 3333 (unconfined.user object_r unconfined.object levelrange_1))
     (portcon udp 4444 (unconfined.user object_r unconfined.object ((s0) level_2)))
     (portcon tcp (2000 20000) (unconfined.user object_r unconfined.object (systemlow level_3)))
+    (portcon dccp (6840 6880) (unconfined.user object_r unconfined.object ((s0) level_2)))
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index 884d2dc..2078399 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -270,6 +270,7 @@
 	(nodecon ip_v6 netmask_v6 system_u_bin_t_l2h)
 	(portcon udp 25 system_u_bin_t_l2h)
 	(portcon tcp 22 system_u_bin_t_l2h)
+	(portcon dccp (2048 2096) system_u_bin_t_l2h)
 	(genfscon - "/usr/bin" system_u_bin_t_l2h)
 	(netifcon eth0 system_u_bin_t_l2h system_u_bin_t_l2h) ;different contexts?
 	(fsuse xattr ext3 system_u_bin_t_l2h)
-- 
2.5.5
