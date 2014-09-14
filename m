Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELgsEO009324
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:55 -0400
Received: by mail-wi0-f169.google.com with SMTP id cc10so1604768wib.4
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:37 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.36
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:36 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 18/20] Fix gcc -Wstrict-prototypes warnings
Date: Sun, 14 Sep 2014 23:41:49 +0200
Message-Id: <1410730911-14512-19-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In C, defining a function with () means "any number of parameters", not
"no parameter".  Use (void) instead where applicable and add unused
parameters when needed.
---
 checkpolicy/checkpolicy.c                 | 4 ++--
 checkpolicy/policy_parse.y                | 2 +-
 checkpolicy/policy_scan.l                 | 2 +-
 checkpolicy/test/dismod.c                 | 2 +-
 checkpolicy/test/dispol.c                 | 2 +-
 libsemanage/src/conf-parse.y              | 2 +-
 policycoreutils/newrole/newrole.c         | 4 ++--
 policycoreutils/restorecond/restorecond.c | 2 +-
 policycoreutils/restorecond/restorecond.h | 2 +-
 policycoreutils/restorecond/user.c        | 2 +-
 policycoreutils/restorecond/watch.c       | 2 +-
 policycoreutils/run_init/run_init.c       | 2 +-
 policycoreutils/sandbox/seunshare.c       | 2 +-
 policycoreutils/setfiles/restore.h        | 4 ++--
 policycoreutils/setfiles/setfiles.c       | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 8c199d7c8628..0d9c4ea16dbf 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -289,7 +289,7 @@ static int identify_equiv_types(void)
 
 extern char *av_to_string(uint32_t tclass, sepol_access_vector_t av);
 
-int display_bools()
+int display_bools(void)
 {
 	uint32_t i;
 
@@ -335,7 +335,7 @@ void display_expr(cond_expr_t * exp)
 	}
 }
 
-int display_cond_expressions()
+int display_cond_expressions(void)
 {
 	cond_node_t *cur;
 
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index d31773a412e7..587059135a1c 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -61,7 +61,7 @@ extern int yylex(void);
 extern int yywarn(const char *msg);
 extern int yyerror(const char *msg);
 
-typedef int (* require_func_t)();
+typedef int (* require_func_t)(int pass);
 
 %}
 
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 131613faa422..3a739626ff2f 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -25,7 +25,7 @@
 #include <stdint.h>
 #include <string.h>
 
-typedef int (* require_func_t)();
+typedef int (* require_func_t)(void);
 
 #ifdef ANDROID
 #include "policy_parse.h"
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 7c754c02ba77..b305643d5f21 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -807,7 +807,7 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 	}
 }
 
-int menu()
+int menu(void)
 {
 	printf("\nSelect a command:\n");
 	printf("1)  display unconditional AVTAB\n");
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index ba4a71fde639..9d6635865efb 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -369,7 +369,7 @@ static void display_filename_trans(policydb_t *p, FILE *fp)
 	}
 }
 
-int menu()
+int menu(void)
 {
 	printf("\nSelect a command:\n");
 	printf("1)  display unconditional AVTAB\n");
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 84bc48b4f7e0..df12530edd4a 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -31,7 +31,7 @@
 #include <stdlib.h>
 #include <string.h>
 
-extern int semanage_lex();                /* defined in conf-scan.c */
+extern int semanage_lex(void);                /* defined in conf-scan.c */
 int semanage_error(const char *msg);
 
 extern FILE *semanage_in;
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 7eeb14fa6a47..94794e9a9dd3 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -307,7 +307,7 @@ static int process_pam_config(FILE * cfg)
  *  Files specified one per line executable with a corresponding
  *  pam service name.
  */
-static int read_pam_config()
+static int read_pam_config(void)
 {
 	const char *config_file_path = PAM_SERVICE_CONFIG;
 	FILE *cfg = NULL;
@@ -966,7 +966,7 @@ static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
 /**
  * Take care of any signal setup
  */
-static int set_signal_handles()
+static int set_signal_handles(void)
 {
 	sigset_t empty;
 
diff --git a/policycoreutils/restorecond/restorecond.c b/policycoreutils/restorecond/restorecond.c
index 193cddb7f895..8f847b669eeb 100644
--- a/policycoreutils/restorecond/restorecond.c
+++ b/policycoreutils/restorecond/restorecond.c
@@ -111,7 +111,7 @@ static int write_pid_file(void)
 /*
  * SIGTERM handler
  */
-static void term_handler()
+static void term_handler(int s __attribute__ ((unused)))
 {
 	terminate = 1;
 	/* trigger a failure in the watch */
diff --git a/policycoreutils/restorecond/restorecond.h b/policycoreutils/restorecond/restorecond.h
index 8c85ef09d65d..6adc087313b0 100644
--- a/policycoreutils/restorecond/restorecond.h
+++ b/policycoreutils/restorecond/restorecond.h
@@ -40,6 +40,6 @@ extern int watch(int fd, const char *watch_file);
 extern void watch_list_add(int inotify_fd, const char *path);
 extern int watch_list_find(int wd, const char *file);
 extern void watch_list_free(int fd);
-extern int watch_list_isempty();
+extern int watch_list_isempty(void);
 
 #endif
diff --git a/policycoreutils/restorecond/user.c b/policycoreutils/restorecond/user.c
index 2c28676c78ee..714aae781f9a 100644
--- a/policycoreutils/restorecond/user.c
+++ b/policycoreutils/restorecond/user.c
@@ -194,7 +194,7 @@ int start() {
 	return 0;
 }
 
-static int local_server() {
+static int local_server(void) {
 	// ! dbus, run as local service
 	char *ptr=NULL;
 	if (asprintf(&ptr, "%s/.restorecond", homedir) < 0) {
diff --git a/policycoreutils/restorecond/watch.c b/policycoreutils/restorecond/watch.c
index 9a45cba09729..10978cb3e3d4 100644
--- a/policycoreutils/restorecond/watch.c
+++ b/policycoreutils/restorecond/watch.c
@@ -34,7 +34,7 @@ struct watchList {
 };
 struct watchList *firstDir = NULL;
 
-int watch_list_isempty() {
+int watch_list_isempty(void) {
 	return firstDir == NULL;
 }
 
diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 92034be9c7fe..129db730a9c2 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -230,7 +230,7 @@ int authenticate_via_shadow_passwd(const struct passwd *p_passwd_line)
  * return:	0 When success
  *		-1 When failure
  */
-int authenticate_user()
+int authenticate_user(void)
 {
 
 #define INITLEN 255
diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index 6ca6d329dbb4..289fcf75b872 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -62,7 +62,7 @@ static capng_select_t cap_set = CAPNG_SELECT_CAPS;
 /**
  * This function will drop all capabilities.
  */
-static int drop_caps()
+static int drop_caps(void)
 {
 	if (capng_have_capabilities(cap_set) == CAPNG_NONE)
 		return 0;
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index 406594b2bf09..b55de81f2480 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -45,12 +45,12 @@ struct restore_opts {
 };
 
 void restore_init(struct restore_opts *opts);
-void restore_finish();
+void restore_finish(void);
 int add_exclude(const char *directory);
 int exclude(const char *path);
 void remove_exclude(const char *directory);
 int process_one_realpath(char *name, int recurse);
 int process_glob(char *name, int recurse);
-int exclude_non_seclabel_mounts();
+int exclude_non_seclabel_mounts(void);
 
 #endif
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 2dc81dd55471..86d3f2834ecd 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -61,7 +61,7 @@ void usage(const char *const name)
 
 static int nerr = 0;
 
-void inc_err()
+void inc_err(void)
 {
 	nerr++;
 	if (nerr > ABORT_ON_ERRORS - 1 && !r_opts.debug) {
-- 
2.1.0
