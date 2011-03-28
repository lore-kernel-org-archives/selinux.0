Subject: [PATCH] checkpolicy: use #define for dismod selections
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: method@manicmethod.com, sds@tycho.nsa.gov
Date: Mon, 28 Mar 2011 13:39:03 -0400
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1301333944.14296.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We just use random numbers to make menu selections.  Use #defines and
names that make some sense instead.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

diff -up checkpolicy-2.0.23/test/dismod.c.eparis1 checkpolicy-2.0.23/test/dismod.c
--- checkpolicy-2.0.23/test/dismod.c.eparis1	2010-12-21 16:35:45.000000000 -0500
+++ checkpolicy-2.0.23/test/dismod.c	2011-03-23 13:58:31.561072307 -0400
@@ -45,6 +45,14 @@
 #define le32_to_cpu(x) bswap_32(x)
 #endif
 
+#define DISPLAY_AVBLOCK_COND_AVTAB	0
+#define DISPLAY_AVBLOCK_UNCOND_AVTAB	1
+#define DISPLAY_AVBLOCK_ROLE_TYPE_NODE	2 /* unused? */
+#define DISPLAY_AVBLOCK_ROLE_TRANS	3
+#define DISPLAY_AVBLOCK_ROLE_ALLOW	4
+#define DISPLAY_AVBLOCK_REQUIRES	5
+#define DISPLAY_AVBLOCK_DECLARES	6
+
 static policydb_t policydb;
 extern unsigned int ss_initialized;
 
@@ -571,7 +579,7 @@ int display_avdecl(avrule_decl_t * decl,
 	fprintf(out_fp, "decl %u:%s\n", decl->decl_id,
 		(decl->enabled ? " [enabled]" : ""));
 	switch (field) {
-	case 0:{
+	case DISPLAY_AVBLOCK_COND_AVTAB:{
 			cond_list_t *cond = decl->cond_list;
 			avrule_t *avrule;
 			while (cond) {
@@ -599,7 +607,7 @@ int display_avdecl(avrule_decl_t * decl,
 			}
 			break;
 		}
-	case 1:{
+	case DISPLAY_AVBLOCK_UNCOND_AVTAB:{
 			avrule_t *avrule = decl->avrules;
 			if (avrule == NULL) {
 				fprintf(out_fp, "  <empty>\n");
@@ -613,26 +621,26 @@ int display_avdecl(avrule_decl_t * decl,
 			}
 			break;
 		}
-	case 2:{		/* role_type_node */
+	case DISPLAY_AVBLOCK_ROLE_TYPE_NODE:{	/* role_type_node */
 			break;
 		}
-	case 3:{
+	case DISPLAY_AVBLOCK_ROLE_TRANS:{
 			display_role_trans(decl->role_tr_rules, policy, out_fp);
 			break;
 		}
-	case 4:{
+	case DISPLAY_AVBLOCK_ROLE_ALLOW:{
 			display_role_allow(decl->role_allow_rules, policy,
 					   out_fp);
 			break;
 		}
-	case 5:{
+	case DISPLAY_AVBLOCK_REQUIRES:{
 			if (display_scope_index
 			    (&decl->required, policy, out_fp)) {
 				return -1;
 			}
 			break;
 		}
-	case 6:{
+	case DISPLAY_AVBLOCK_DECLARES:{
 			if (display_scope_index
 			    (&decl->declared, policy, out_fp)) {
 				return -1;
@@ -861,15 +869,16 @@ int main(int argc, char **argv)
 		fgets(ans, sizeof(ans), stdin);
 		switch (ans[0]) {
 
-		case '1':{
-				fprintf(out_fp, "unconditional avtab:\n");
-				display_avblock(1, RENDER_UNCONDITIONAL,
-						&policydb, out_fp);
-				break;
-			}
+		case '1':
+			fprintf(out_fp, "unconditional avtab:\n");
+			display_avblock(DISPLAY_AVBLOCK_UNCOND_AVTAB,
+					RENDER_UNCONDITIONAL, &policydb,
+					out_fp);
+			break;
 		case '2':
 			fprintf(out_fp, "conditional avtab:\n");
-			display_avblock(0, RENDER_UNCONDITIONAL, &policydb,
+			display_avblock(DISPLAY_AVBLOCK_COND_AVTAB,
+					RENDER_UNCONDITIONAL, &policydb,
 					out_fp);
 			break;
 		case '3':
@@ -892,11 +901,13 @@ int main(int argc, char **argv)
 			break;
 		case '7':
 			fprintf(out_fp, "role transitions:\n");
-			display_avblock(3, 0, &policydb, out_fp);
+			display_avblock(DISPLAY_AVBLOCK_ROLE_TRANS, 0,
+					&policydb, out_fp);
 			break;
 		case '8':
 			fprintf(out_fp, "role allows:\n");
-			display_avblock(4, 0, &policydb, out_fp);
+			display_avblock(DISPLAY_AVBLOCK_ROLE_ALLOW, 0,
+					&policydb, out_fp);
 			break;
 		case '9':
 			display_policycon(&policydb, out_fp);
@@ -906,11 +917,13 @@ int main(int argc, char **argv)
 			break;
 		case 'a':
 			fprintf(out_fp, "avrule block requirements:\n");
-			display_avblock(5, 0, &policydb, out_fp);
+			display_avblock(DISPLAY_AVBLOCK_REQUIRES, 0,
+					&policydb, out_fp);
 			break;
 		case 'b':
 			fprintf(out_fp, "avrule block declarations:\n");
-			display_avblock(6, 0, &policydb, out_fp);
+			display_avblock(DISPLAY_AVBLOCK_DECLARES, 0,
+					&policydb, out_fp);
 			break;
 		case 'c':
 			display_policycaps(&policydb, out_fp);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
