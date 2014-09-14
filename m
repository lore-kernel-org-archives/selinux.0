Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELgsEP009324
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:55 -0400
Received: by mail-we0-f178.google.com with SMTP id q58so3143741wes.9
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:39 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.37
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:38 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 19/20] checkpolicy: fix gcc -Wunused-variable warnings
Date: Sun, 14 Sep 2014 23:41:50 +0200
Message-Id: <1410730911-14512-20-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add __attribute__ ((unused)) to unused function parameters.
---
 checkpolicy/checkpolicy.c     | 2 +-
 checkpolicy/module_compiler.c | 2 +-
 checkpolicy/policy_define.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 0d9c4ea16dbf..7699619f5327 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -361,7 +361,7 @@ int change_bool(char *name, int state)
 	return 0;
 }
 
-static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg)
+static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __attribute__ ((unused)))
 {
 	level_datum_t *levdatum = (level_datum_t *) datum;
 
diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 463d042125ad..d7f27f5390b5 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -1446,7 +1446,7 @@ int begin_optional(int pass)
 	return -1;
 }
 
-int end_optional(int pass)
+int end_optional(int pass __attribute__ ((unused)))
 {
 	/* once nested conditionals are allowed, do the stack unfolding here */
 	pop_stack();
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 675ca8ce5a2f..683eb0f62219 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -995,7 +995,7 @@ int define_category(void)
 	return -1;
 }
 
-static int clone_level(hashtab_key_t key, hashtab_datum_t datum, void *arg)
+static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *arg)
 {
 	level_datum_t *levdatum = (level_datum_t *) datum;
 	mls_level_t *level = (mls_level_t *) arg, *newlevel;
@@ -2123,8 +2123,8 @@ role_datum_t *merge_roles_dom(role_datum_t * r1, role_datum_t * r2)
 }
 
 /* This function eliminates the ordering dependency of role dominance rule */
-static int dominate_role_recheck(hashtab_key_t key, hashtab_datum_t datum,
-				 void *arg)
+static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unused)),
+				 hashtab_datum_t datum, void *arg)
 {
 	role_datum_t *rdp = (role_datum_t *) arg;
 	role_datum_t *rdatum = (role_datum_t *) datum;
@@ -3443,7 +3443,7 @@ static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_t * cats
 	return 0;
 }
 
-static int parse_semantic_categories(char *id, level_datum_t * levdatum,
+static int parse_semantic_categories(char *id, level_datum_t * levdatum __attribute__ ((unused)),
 				     mls_semantic_cat_t ** cats)
 {
 	cat_datum_t *cdatum;
-- 
2.1.0
