From: Richard Haines <richard_c_haines@btinternet.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 2/2] checkpolicy: Add debug feature to display constraints / validatetrans
Date: Sun,  3 Nov 2013 19:12:29 +0000
Message-Id: <1383505949-2639-1-git-send-email-richard_c_haines@btinternet.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Allow mls/constraint mls/validatetrans constraints to be displayed
in debug mode. If POLICY_KERN version is >=
POLICYDB_VERSION_CONSTRAINT_NAMES then the policy defined
types/attributes will be returned.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 checkpolicy/checkpolicy.c | 110 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 292f568..9881dd7 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -377,7 +377,7 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg)
 int main(int argc, char **argv)
 {
 	sepol_security_class_t tclass;
-	sepol_security_id_t ssid, tsid, *sids;
+	sepol_security_id_t ssid, tsid, *sids, oldsid, newsid, tasksid;
 	sepol_security_context_t scontext;
 	struct sepol_av_decision avd;
 	class_datum_t *cladatum;
@@ -395,6 +395,9 @@ int main(int argc, char **argv)
 	char *name;
 	int state;
 	int show_version = 0;
+	char *reason_buf = NULL;
+	unsigned int reason;
+	int flags;
 	struct policy_file pf;
 	struct option long_options[] = {
 		{"output", required_argument, NULL, 'o'},
@@ -644,6 +647,8 @@ int main(int argc, char **argv)
 	printf("f)  display conditional bools\n");
 	printf("g)  display conditional expressions\n");
 	printf("h)  change a boolean value\n");
+	printf("i)  display constraint expressions\n");
+	printf("j)  display validatetrans expressions\n");
 #ifdef EQUIVTYPES
 	printf("z)  Show equivalent types\n");
 #endif
@@ -1060,6 +1065,109 @@ int main(int argc, char **argv)
 			change_bool(name, state);
 			free(name);
 			break;
+		case 'i':
+			printf("source sid?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			ssid = atoi(ans);
+
+			printf("target sid?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			tsid = atoi(ans);
+
+			printf("target class?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			if (isdigit(ans[0])) {
+				tclass = atoi(ans);
+				if (!tclass
+				    || tclass > policydb.p_classes.nprim) {
+					printf("\nNo such class.\n");
+					break;
+				}
+				cladatum =
+				    policydb.class_val_to_struct[tclass - 1];
+			} else {
+				ans[strlen(ans) - 1] = 0;
+				cladatum =
+				    (class_datum_t *) hashtab_search(policydb.
+								     p_classes.
+								     table,
+								     ans);
+				if (!cladatum) {
+					printf("\nNo such class\n");
+					break;
+				}
+				tclass = cladatum->s.value;
+			}
+
+			flags = SHOW_GRANTED;
+			if (sepol_compute_av_reason_buffer(ssid, tsid,
+					tclass, 0, &avd, &reason,
+					&reason_buf, flags)) {
+				printf("\nconstraint error\n");
+				break;
+			}
+			if (reason_buf) {
+				printf("\nConstraint expressions:\n%s",
+						reason_buf);
+				free(reason_buf);
+			} else {
+				printf("\nNo constraints found.\n");
+			}
+			break;
+		case 'j':
+			printf("old sid?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			oldsid = atoi(ans);
+
+			printf("new sid?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			newsid = atoi(ans);
+
+			printf("task sid?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			tasksid = atoi(ans);
+
+			printf("target class?  ");
+			FGETS(ans, sizeof(ans), stdin);
+			if (isdigit(ans[0])) {
+				tclass = atoi(ans);
+				if (!tclass
+				    || tclass > policydb.p_classes.nprim) {
+					printf("\nNo such class.\n");
+					break;
+				}
+				cladatum =
+				    policydb.class_val_to_struct[tclass - 1];
+			} else {
+				ans[strlen(ans) - 1] = 0;
+				cladatum =
+				    (class_datum_t *) hashtab_search(policydb.
+								     p_classes.
+								     table,
+								     ans);
+				if (!cladatum) {
+					printf("\nNo such class\n");
+					break;
+				}
+				tclass = cladatum->s.value;
+			}
+
+			flags = SHOW_GRANTED;
+			if (sepol_validate_transition_reason_buffer(oldsid,
+						newsid, tasksid, tclass,
+						&reason_buf, flags)) {
+				printf("\nvalidatetrans error\n");
+				break;
+			}
+			if (reason_buf) {
+				printf("\nValidatetrans expressions:\n%s",
+						reason_buf);
+				free(reason_buf);
+			} else {
+				printf(
+				    "\nNo validatetrans expressions found.\n");
+			}
+			break;
 #ifdef EQUIVTYPES
 		case 'z':
 			identify_equiv_types();
-- 
1.8.3.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
