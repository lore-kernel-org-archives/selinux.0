Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NETFb3027846
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 10:29:15 -0400
Received: from workstation.fluency.net.uk ([185.34.9.224]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0M8ZtH-1b1Vsg0Yx1-00wAJD for
 <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 16:29:05 +0200
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] genhomedircon: support policies using RBACSEP
Date: Fri, 23 Sep 2016 15:28:44 +0100
Message-Id: <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1474639773.git.gary.tierney@gmx.com>
References: <cover.1474639773.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1474639773.git.gary.tierney@gmx.com>
References: <cover.1474639773.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Introduces support for generating homedir/user contexts for policies
that implement RBACSEP.  The support works by taking the prefix of a
logins seuser and replacing the role field in their context
specifications with the prefix.  A new option "genhomedircon-rbacsep"
was added to /etc/selinux/semanage.conf to allow toggling this behavior.

The user prefix can be set from both standard kernel policy and CIL:

CIL:
    (user user_u)
    (role user_r)
    (userrole user_u user_r)
    (userprefix user_u user_r)

kernel policy language:
    role user_r;
    user user_u roles { user_r } prefix user_r;

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 libsemanage/src/conf-parse.y    | 14 +++++++++++++-
 libsemanage/src/conf-scan.l     |  1 +
 libsemanage/src/genhomedircon.c | 30 +++++++++++++++++++++++++++++-
 libsemanage/src/semanage_conf.h |  1 +
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b527e89..d2112d2 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -61,7 +61,7 @@ static int parse_errors;
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
-%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
+%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL GENHOMEDIRCON_RBACSEP
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -95,6 +95,7 @@ single_opt:     module_store
 	|	bzip_blocksize
 	|	bzip_small
 	|	remove_hll
+	|	genhomedircon_rbacsep
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
 	free($3);
 }
 
+genhomedircon_rbacsep:  GENHOMEDIRCON_RBACSEP'=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->genhomedircon_rbacsep = 0;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->genhomedircon_rbacsep = 1;
+	} else {
+		yyerror("genhomedircon-rbacsep can only be 'true' or 'false'");
+	}
+	free($3);
+}
+
 command_block: 
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 607bbf0..114098c 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
 remove-hll	return REMOVE_HLL;
+genhomedircon-rbacsep	return GENHOMEDIRCON_RBACSEP;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 3fc9e7a..98f9ebd 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -71,6 +71,10 @@
 #define COMMENT_USER_HOME_CONTEXT "\n\n#\n# Home Context for user %s" \
 			"\n#\n\n"
 
+#define WARNING_RBACSEP_INVALID_ROLE  "genhomedircon-rbacsep is enabled, " \
+			"but the user prefix of " \
+			"'%s' for %s is not a valid role.  Skipping user."
+
 /* placeholders used in the template file
    which are searched for and replaced */
 #define TEMPLATE_HOME_ROOT "HOME_ROOT"
@@ -638,6 +642,11 @@ static int write_contexts(genhomedircon_settings_t *s, FILE *out,
 			goto fail;
 		}
 
+		if (s->h_semanage->conf->genhomedircon_rbacsep &&
+		    sepol_context_set_role(sepolh, context, user->prefix) < 0) {
+		    goto fail;
+		}
+
 		if (sepol_context_to_string(sepolh, context,
 					    &new_context_str) < 0) {
 			goto fail;
@@ -857,7 +866,7 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 	int errors = 0;
 
 	retval = semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers);
-	if (retval < 0 || (nseusers < 1)) {
+	if (retval < 0 || (nseusers < 2)) {
 		/* if there are no users, this function can't do any other work */
 		return errors;
 	}
@@ -886,6 +895,17 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 					level = FALLBACK_LEVEL;
 			}
 
+			if (u && s->h_semanage->conf->genhomedircon_rbacsep &&
+			    !semanage_user_has_role(u, prefix)) {
+				WARN(s->h_semanage, WARNING_RBACSEP_INVALID_ROLE,
+				     prefix, seuname);
+
+				errors = STATUS_ERR;
+				semanage_user_key_free(key);
+				semanage_user_free(u);
+				break;
+			}
+
 			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
 					    FALLBACK_UIDGID, FALLBACK_UIDGID,
 					    seuname, prefix, "", level,
@@ -969,6 +989,14 @@ static int add_user(genhomedircon_settings_t * s,
 		level = FALLBACK_LEVEL;
 	}
 
+	if (s->h_semanage->conf->genhomedircon_rbacsep &&
+	    !semanage_user_has_role(user, prefix)) {
+		WARN(s->h_semanage, WARNING_RBACSEP_INVALID_ROLE, prefix, sename);
+
+		retval = STATUS_SUCCESS;
+		goto cleanup;
+	}
+
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
 	if (retval != 0 || pwent == NULL) {
 		if (retval != 0 && retval != ENOENT) {
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index c99ac8c..2c968da 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -46,6 +46,7 @@ typedef struct semanage_conf {
 	int bzip_blocksize;
 	int bzip_small;
 	int remove_hll;
+	int genhomedircon_rbacsep;
 	int ignore_module_cache;
 	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
-- 
2.4.11
