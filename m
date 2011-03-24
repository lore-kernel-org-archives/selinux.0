From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v1 PATCH 5/5] Userspace: display the class in role_transition rule
Date: Thu, 24 Mar 2011 18:42:46 +0800
Message-Id: <1300963366-9169-9-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
References: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support to display the class field in the role_transition rule
in the checkpolicy/test/dismod program.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 checkpolicy/test/dismod.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 4d31597..33a29e4 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -451,13 +451,38 @@ void display_initial_sids(policydb_t * p, FILE * fp)
 #endif
 }
 
+void display_class_set(ebitmap_t *classes, policydb_t *p, FILE *fp)
+{
+	int i, num = 0;
+
+	for (i = ebitmap_startbit(classes); i < ebitmap_length(classes); i++) {
+		if (!ebitmap_get_bit(classes, i))
+			continue;
+		num++;
+		if (num > 1) {
+			fprintf(fp, "{");
+			break;
+		}
+	}
+
+	for (i = ebitmap_startbit(classes); i < ebitmap_length(classes); i++) {
+		if (ebitmap_get_bit(classes, i))
+			display_id(p, fp, SYM_CLASSES, i, "");
+	}
+
+	if (num > 1)
+		fprintf(fp, " }");
+}
+
 void display_role_trans(role_trans_rule_t * tr, policydb_t * p, FILE * fp)
 {
 	for (; tr; tr = tr->next) {
 		fprintf(fp, "role transition ");
 		display_mod_role_set(&tr->roles, p, fp);
 		display_type_set(&tr->types, 0, p, fp);
-		display_id(p, fp, SYM_ROLES, tr->new_role - 1, " :");
+		fprintf(fp, " :");
+		display_class_set(&tr->classes, p, fp);
+		display_id(p, fp, SYM_ROLES, tr->new_role - 1, "");
 		fprintf(fp, "\n");
 	}
 }
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
