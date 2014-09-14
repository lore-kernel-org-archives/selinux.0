Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sL009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:20 -0400
Received: by mail-we0-f178.google.com with SMTP id q58so3143630wes.9
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:25 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.24
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:24 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 10/20] checkpolicy: fix gcc -Wsign-compare warnings
Date: Sun, 14 Sep 2014 23:41:41 +0200
Message-Id: <1410730911-14512-11-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 checkpolicy/checkpolicy.c     | 2 +-
 checkpolicy/module_compiler.c | 6 +++---
 checkpolicy/policy_define.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 9881dd7dc317..7fa37af2849b 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -291,7 +291,7 @@ extern char *av_to_string(uint32_t tclass, sepol_access_vector_t av);
 
 int display_bools()
 {
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < policydbp->p_bools.nprim; i++) {
 		printf("%s : %d\n", policydbp->p_bool_val_to_name[i],
diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 8ac81f78f4e2..463d042125ad 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -701,7 +701,7 @@ int add_perm_to_class(uint32_t perm_value, uint32_t class_value)
 	assert(class_value >= 1);
 	scope = &decl->required;
 	if (class_value > scope->class_perms_len) {
-		int i;
+		uint32_t i;
 		ebitmap_t *new_map = realloc(scope->class_perms_map,
 					     class_value * sizeof(*new_map));
 		if (new_map == NULL) {
@@ -1225,7 +1225,7 @@ int require_cat(int pass)
 
 static int is_scope_in_stack(scope_datum_t * scope, scope_stack_t * stack)
 {
-	int i;
+	uint32_t i;
 	if (stack == NULL) {
 		return 0;	/* no matching scope found */
 	}
@@ -1482,7 +1482,7 @@ int begin_optional_else(int pass)
 
 static int copy_requirements(avrule_decl_t * dest, scope_stack_t * stack)
 {
-	int i;
+	uint32_t i;
 	if (stack == NULL) {
 		return 0;
 	}
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7e6091e41179..92cb8246fc4c 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -828,7 +828,7 @@ int define_sens(void)
 int define_dominance(void)
 {
 	level_datum_t *datum;
-	int order;
+	uint32_t order;
 	char *id;
 
 	if (!mlspol) {
-- 
2.1.0
