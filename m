Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o66MNM2Z024366
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2010 18:23:24 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o66MMRJ5028058
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2010 22:22:30 GMT
Received: by mail-pv0-f181.google.com with SMTP id 2so246838pvg.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Jul 2010 15:23:22 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Cc: refpolicy@oss1.tresys.com, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 1/3]checkpolicy Fix error: variable 'newattr' set but not used(and others as well)
Date: Tue,  6 Jul 2010 15:23:28 -0700
Message-Id: <1278455010-23244-2-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1278455010-23244-1-git-send-email-justinmattock@gmail.com>
References: <1278455010-23244-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The below patch fixes some warning messages Im receiving
with GCC:(in this case some are erros due to -Werror)
policy_define.c: In function 'define_type':
policy_define.c:1216:6: error: variable 'newattr' set but not used
cc1: all warnings being treated as errors

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 checkpolicy/policy_define.c |    3 ---
 checkpolicy/test/dismod.c   |    2 --
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index a064307..82ab44c 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1213,7 +1213,6 @@ int define_type(int alias)
 {
 	char *id;
 	type_datum_t *datum, *attr;
-	int newattr = 0;
 
 	if (pass == 2) {
 		/*
@@ -1266,8 +1265,6 @@ int define_type(int alias)
 			/* treat it as a fatal error */
 			yyerror2("attribute %s is not declared", id);
 			return -1;
-		} else {
-			newattr = 0;
 		}
 
 		if (attr->flavor != TYPE_ATTRIB) {
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 705f1cb..4d31597 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -474,11 +474,9 @@ void display_role_allow(role_allow_rule_t * ra, policydb_t * p, FILE * fp)
 
 int role_display_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-	char *id;
 	role_datum_t *role;
 	FILE *fp;
 
-	id = key;
 	role = (role_datum_t *) datum;
 	fp = (FILE *) data;
 
-- 
1.7.1.rc1.21.gf3bd6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
