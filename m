Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2BGN9fg031184
 for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2018 12:23:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 3zzmcq5ZJrz34qvp
 for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2018 16:23:07 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 3zzmcq4Qj2z34qv4
 for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2018 16:23:07 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Sun, 11 Mar 2018 16:22:55 +0000
Message-Id: <20180311162255.27901-1-richard_c_haines@btinternet.com>
Subject: [PATCH] selinux: Add support for the SCTP portcon keyword
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update libsepol, checkpolicy and the CIL compiler to support the SCTP
portcon keyword.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 checkpolicy/checkpolicy.c                      | 5 +++++
 checkpolicy/policy_define.c                    | 5 +++++
 libsepol/cil/src/cil.c                         | 1 +
 libsepol/cil/src/cil_binary.c                  | 6 ++++++
 libsepol/cil/src/cil_build_ast.c               | 2 ++
 libsepol/cil/src/cil_internal.h                | 4 +++-
 libsepol/cil/src/cil_policy.c                  | 2 ++
 libsepol/cil/src/cil_tree.c                    | 2 ++
 libsepol/include/sepol/port_record.h           | 1 +
 libsepol/src/kernel_to_cil.c                   | 4 ++++
 libsepol/src/kernel_to_common.c                | 3 +++
 libsepol/src/kernel_to_conf.c                  | 4 ++++
 libsepol/src/module_to_cil.c                   | 4 ++++
 libsepol/src/port_record.c                     | 2 ++
 libsepol/src/ports.c                           | 7 +++++++
 secilc/docs/cil_network_labeling_statements.md | 5 +++--
 secilc/test/policy.cil                         | 1 +
 17 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 923b47c1..fbda4558 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -69,6 +69,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 #include <arpa/inet.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -944,6 +947,8 @@ int main(int argc, char **argv)
 				protocol = IPPROTO_UDP;
 			else if (!strcmp(ans, "dccp") || !strcmp(ans, "DCCP"))
 				protocol = IPPROTO_DCCP;
+			else if (!strcmp(ans, "sctp") || !strcmp(ans, "SCTP"))
+				protocol = IPPROTO_SCTP;
 			else {
 				printf("unknown protocol\n");
 				break;
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 2c5db55d..11fd37d8 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -40,6 +40,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 #include <arpa/inet.h>
 #include <stdlib.h>
 #include <limits.h>
@@ -5004,6 +5007,8 @@ int define_port_context(unsigned int low, unsigned int high)
 		protocol = IPPROTO_UDP;
 	} else if ((strcmp(id, "dccp") == 0) || (strcmp(id, "DCCP") == 0)) {
 		protocol = IPPROTO_DCCP;
+	} else if ((strcmp(id, "sctp") == 0) || (strcmp(id, "SCTP") == 0)) {
+		protocol = IPPROTO_SCTP;
 	} else {
 		yyerror2("unrecognized protocol %s", id);
 		goto bad;
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 5a64c2bc..2a7ec063 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -109,6 +109,7 @@ static void cil_init_keys(void)
 	CIL_KEY_UDP = cil_strpool_add("udp");
 	CIL_KEY_TCP = cil_strpool_add("tcp");
 	CIL_KEY_DCCP = cil_strpool_add("dccp");
+	CIL_KEY_SCTP = cil_strpool_add("sctp");
 	CIL_KEY_AUDITALLOW = cil_strpool_add("auditallow");
 	CIL_KEY_TUNABLEIF = cil_strpool_add("tunableif");
 	CIL_KEY_ALLOW = cil_strpool_add("allow");
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 431cd9cd..0cc6eeb1 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -34,6 +34,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/polcaps.h>
@@ -3272,6 +3275,9 @@ int cil_portcon_to_policydb(policydb_t *pdb, struct cil_sort *portcons)
 		case CIL_PROTOCOL_DCCP:
 			new_ocon->u.port.protocol = IPPROTO_DCCP;
 			break;
+		case CIL_PROTOCOL_SCTP:
+			new_ocon->u.port.protocol = IPPROTO_SCTP;
+			break;
 		default:
 			/* should not get here */
 			rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index e84336bf..b90b0f60 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4405,6 +4405,8 @@ int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 		portcon->proto = CIL_PROTOCOL_TCP;
 	} else if (proto == CIL_KEY_DCCP) {
 		portcon->proto = CIL_PROTOCOL_DCCP;
+	} else if (proto == CIL_KEY_SCTP) {
+		portcon->proto = CIL_PROTOCOL_SCTP;
 	} else {
 		cil_log(CIL_ERR, "Invalid protocol\n");
 		rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 8393e391..6ff32285 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -103,6 +103,7 @@ char *CIL_KEY_STAR;
 char *CIL_KEY_TCP;
 char *CIL_KEY_UDP;
 char *CIL_KEY_DCCP;
+char *CIL_KEY_SCTP;
 char *CIL_KEY_AUDITALLOW;
 char *CIL_KEY_TUNABLEIF;
 char *CIL_KEY_ALLOW;
@@ -740,7 +741,8 @@ struct cil_filecon {
 enum cil_protocol {
 	CIL_PROTOCOL_UDP = 1,
 	CIL_PROTOCOL_TCP,
-	CIL_PROTOCOL_DCCP
+	CIL_PROTOCOL_DCCP,
+	CIL_PROTOCOL_SCTP
 };
 
 struct cil_ibpkeycon {
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 99eb53c2..5edab5e0 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1757,6 +1757,8 @@ static void cil_portcons_to_policy(FILE *out, struct cil_sort *portcons, int mls
 			fprintf(out, "tcp ");
 		} else if (portcon->proto == CIL_PROTOCOL_DCCP) {
 			fprintf(out, "dccp ");
+		} else if (portcon->proto == CIL_PROTOCOL_SCTP) {
+			fprintf(out, "sctp ");
 		}
 		if (portcon->port_low == portcon->port_high) {
 			fprintf(out, "%d ", portcon->port_low);
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index b394a9d8..2abbb96c 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1436,6 +1436,8 @@ void cil_tree_print_node(struct cil_tree_node *node)
 				cil_log(CIL_INFO, " tcp");
 			} else if (portcon->proto == CIL_PROTOCOL_DCCP) {
 				cil_log(CIL_INFO, " dccp");
+			} else if (portcon->proto == CIL_PROTOCOL_SCTP) {
+				cil_log(CIL_INFO, " sctp");
 			}
 			cil_log(CIL_INFO, " (%d %d)", portcon->port_low, portcon->port_high);
 
diff --git a/libsepol/include/sepol/port_record.h b/libsepol/include/sepol/port_record.h
index df04ea09..77149cfa 100644
--- a/libsepol/include/sepol/port_record.h
+++ b/libsepol/include/sepol/port_record.h
@@ -16,6 +16,7 @@ typedef struct sepol_port_key sepol_port_key_t;
 #define SEPOL_PROTO_UDP 0
 #define SEPOL_PROTO_TCP 1
 #define SEPOL_PROTO_DCCP 2
+#define SEPOL_PROTO_SCTP 3
 
 /* Key */
 extern int sepol_port_compare(const sepol_port_t * port,
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 0055c238..b1eb66d6 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -12,6 +12,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/conditional.h>
@@ -2631,6 +2634,7 @@ static int write_selinux_port_rules_to_cil(FILE *out, struct policydb *pdb)
 		case IPPROTO_TCP: protocol = "tcp"; break;
 		case IPPROTO_UDP: protocol = "udp"; break;
 		case IPPROTO_DCCP: protocol = "dccp"; break;
+		case IPPROTO_SCTP: protocol = "sctp"; break;
 		default:
 			sepol_log_err("Unknown portcon protocol: %i", portcon->u.port.protocol);
 			rc = -1;
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 01ffc8fc..342bc3c9 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -10,6 +10,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/hashtab.h>
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 95aa92fc..95405207 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -11,6 +11,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/conditional.h>
@@ -2491,6 +2494,7 @@ static int write_selinux_port_rules_to_conf(FILE *out, struct policydb *pdb)
 		case IPPROTO_TCP: protocol = "tcp"; break;
 		case IPPROTO_UDP: protocol = "udp"; break;
 		case IPPROTO_DCCP: protocol = "dccp"; break;
+		case IPPROTO_SCTP: protocol = "sctp"; break;
 		default:
 			sepol_log_err("Unknown portcon protocol: %i", portcon->u.port.protocol);
 			rc = -1;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 15b58a7a..5b8ed19e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -30,6 +30,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 #include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
@@ -2656,6 +2659,7 @@ static int ocontext_selinux_port_to_cil(struct policydb *pdb, struct ocontext *p
 		case IPPROTO_TCP: protocol = "tcp"; break;
 		case IPPROTO_UDP: protocol = "udp"; break;
 		case IPPROTO_DCCP: protocol = "dccp"; break;
+		case IPPROTO_SCTP: protocol = "sctp"; break;
 		default:
 			log_err("Unknown portcon protocol: %i", portcon->u.port.protocol);
 			rc = -1;
diff --git a/libsepol/src/port_record.c b/libsepol/src/port_record.c
index ed9093bf..15fb198f 100644
--- a/libsepol/src/port_record.c
+++ b/libsepol/src/port_record.c
@@ -186,6 +186,8 @@ const char *sepol_port_get_proto_str(int proto)
 		return "tcp";
 	case SEPOL_PROTO_DCCP:
 		return "dccp";
+	case SEPOL_PROTO_SCTP:
+		return "sctp";
 	default:
 		return "???";
 	}
diff --git a/libsepol/src/ports.c b/libsepol/src/ports.c
index 62ec6029..cc558632 100644
--- a/libsepol/src/ports.c
+++ b/libsepol/src/ports.c
@@ -2,6 +2,9 @@
 #ifndef IPPROTO_DCCP
 #define IPPROTO_DCCP 33
 #endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 #include <stdlib.h>
 
 #include "debug.h"
@@ -21,6 +24,8 @@ static inline int sepol2ipproto(sepol_handle_t * handle, int proto)
 		return IPPROTO_UDP;
 	case SEPOL_PROTO_DCCP:
 		return IPPROTO_DCCP;
+	case SEPOL_PROTO_SCTP:
+		return IPPROTO_SCTP;
 	default:
 		ERR(handle, "unsupported protocol %u", proto);
 		return STATUS_ERR;
@@ -37,6 +42,8 @@ static inline int ipproto2sepol(sepol_handle_t * handle, int proto)
 		return SEPOL_PROTO_UDP;
 	case IPPROTO_DCCP:
 		return SEPOL_PROTO_DCCP;
+	case IPPROTO_SCTP:
+		return SEPOL_PROTO_SCTP;
 	default:
 		ERR(handle, "invalid protocol %u " "found in policy", proto);
 		return STATUS_ERR;
diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
index b06dbccc..49a836c1 100644
--- a/secilc/docs/cil_network_labeling_statements.md
+++ b/secilc/docs/cil_network_labeling_statements.md
@@ -155,7 +155,7 @@ These examples show named and anonymous [`nodecon`](cil_network_labeling_stateme
 portcon
 -------
 
-Label a udp, tcp or dccp port.
+Label a udp, tcp, dccp or sctp port.
 
 **Statement definition:**
 
@@ -175,7 +175,7 @@ Label a udp, tcp or dccp port.
 </tr>
 <tr class="even">
 <td align="left"><p><code>protocol</code></p></td>
-<td align="left"><p>The protocol keyword <code>tcp</code>, <code>udp</code> or <code>dccp</code>.</p></td>
+<td align="left"><p>The protocol keyword <code>tcp</code>, <code>udp</code>, <code>dccp</code> or <code>sctp</code>.</p></td>
 </tr>
 <tr class="odd">
 <td align="left"><p><code>port |</code></p>
@@ -200,3 +200,4 @@ These examples show named and anonymous [`portcon`](cil_network_labeling_stateme
     (portcon udp 4444 (unconfined.user object_r unconfined.object ((s0) level_2)))
     (portcon tcp (2000 20000) (unconfined.user object_r unconfined.object (systemlow level_3)))
     (portcon dccp (6840 6880) (unconfined.user object_r unconfined.object ((s0) level_2)))
+    (portcon sctp (1024 1035) (unconfined.user object_r unconfined.object ((s0) level_2)))
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index 4c37ecca..02f4f88d 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -271,6 +271,7 @@
 	(portcon udp 25 system_u_bin_t_l2h)
 	(portcon tcp 22 system_u_bin_t_l2h)
 	(portcon dccp (2048 2096) system_u_bin_t_l2h)
+	(portcon sctp (1024 1035) system_u_bin_t_l2h)
 	(genfscon - "/usr/bin" system_u_bin_t_l2h)
 	(netifcon eth0 system_u_bin_t_l2h system_u_bin_t_l2h) ;different contexts?
 	(fsuse xattr ext3 system_u_bin_t_l2h)
-- 
2.14.3
