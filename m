Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1QJG3YU024943
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 14:16:03 -0500
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH 2/2] libsemanage: Fix memory leaks when parsing semanage.conf
Date: Thu, 26 Feb 2015 14:16:00 -0500
Message-ID: <1424978160-4652-3-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1424978160-4652-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1424978160-4652-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- Free args as they are parsed and strdup args when neccessary. Memory used for
  lex initialization is now freed using yylex_destroy().
- Add noyywrap option to flex. This is the correct way to make the scanner
  not call yywrap upon an end of file. Before, we were overriding the
  function and returning 1.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsemanage/src/conf-parse.y | 13 +++++++++++--
 libsemanage/src/conf-scan.l  |  8 +-------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index a22f08d..b527e89 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -32,6 +32,7 @@
 #include <string.h>
 
 extern int semanage_lex(void);                /* defined in conf-scan.c */
+extern int semanage_lex_destroy(void);        /* defined in conf-scan.c */
 int semanage_error(const char *msg);
 
 extern FILE *semanage_in;
@@ -101,6 +102,7 @@ module_store:   MODULE_STORE '=' ARG {
                                 parse_errors++;
                                 YYABORT;
                         }
+                        free($3);
                 }
 
         ;
@@ -110,6 +112,7 @@ store_root:     STORE_ROOT '=' ARG  {
                                 parse_errors++;
                                 YYABORT;
                         }
+                        free($3);
                 }
         ;
 
@@ -118,6 +121,7 @@ compiler_dir:       COMPILER_DIR '=' ARG  {
                                 parse_errors++;
                                 YYABORT;
                         }
+                        free($3);
                 }
         ;
 
@@ -129,6 +133,7 @@ ignore_module_cache:	IGNORE_MODULE_CACHE '=' ARG  {
 							else {
 								yyerror("disable-caching can only be 'true' or 'false'");
 							}
+							free($3);
 						}
         ;
 
@@ -151,6 +156,7 @@ target_platform: TARGET_PLATFORM '=' ARG  {
                         else {
                                 yyerror("target_platform can only be 'selinux' or 'xen'");
                         }
+                        free($3);
                 }
         ;
 
@@ -174,6 +180,7 @@ save_previous:    SAVE_PREVIOUS '=' ARG {
 			else {
 				yyerror("save-previous can only be 'true' or 'false'");
 			}
+			free($3);
                 }
         ;
 
@@ -186,6 +193,7 @@ save_linked:    SAVE_LINKED '=' ARG {
 			else {
 				yyerror("save-linked can only be 'true' or 'false'");
 			}
+			free($3);
                 }
         ;
 
@@ -213,6 +221,7 @@ usepasswd: USEPASSWD '=' ARG {
 
 ignoredirs: IGNOREDIRS '=' ARG {
 	current_conf->ignoredirs = strdup($3);
+	free($3);
  }
 
 handle_unknown: HANDLE_UNKNOWN '=' ARG {
@@ -416,6 +425,7 @@ semanage_conf_t *semanage_conf_parse(const char *config_filename)
 	parse_errors = 0;
 	semanage_parse();
 	fclose(semanage_in);
+	semanage_lex_destroy();
 	if (parse_errors != 0) {
 		goto cleanup;
 	}
@@ -485,10 +495,9 @@ static int parse_module_store(char *arg)
 		current_conf->store_path =
 		    strdup(basename(selinux_policy_root()));
 		current_conf->server_port = -1;
-		free(arg);
 	} else if (*arg == '/') {
 		current_conf->store_type = SEMANAGE_CON_POLSERV_LOCAL;
-		current_conf->store_path = arg;
+		current_conf->store_path = strdup(arg);
 		current_conf->server_port = -1;
 	} else {
 		char *s;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 5414582..607bbf0 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -27,12 +27,10 @@
 static char *my_strdup (char * s);
 static char *my_qstrdup (char * s);
 
-int yywrap(void);
- 
 %}
 
 %option stack prefix="semanage_"
-%option noinput nounput noyy_push_state noyy_pop_state noyy_top_state
+%option noinput nounput noyy_push_state noyy_pop_state noyy_top_state noyywrap
 
 %x arg
 
@@ -75,10 +73,6 @@ args              return PROG_ARGS;
 
 %%
 
-int yywrap(void) {
-	return 1;
-}
-
 /* Like strdup(), but also trim leading and trailing whitespace.
  * Returns NULL on error. */
 static char *my_strdup(char *s) {
-- 
1.9.3
