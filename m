Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3U7wqTD016092
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 03:58:52 -0400
Received: by mail-pa0-f65.google.com with SMTP id vv3so16793956pab.0
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 00:58:50 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Jason Zaman <jason@perfinion.com>
Subject: [PATCH v4 3/7] genhomedircon: move fallback user to
 genhomedircon_user_entry_t
Date: Sat, 30 Apr 2016 15:58:08 +0800
Message-Id: <1462003092-4611-4-git-send-email-jason@perfinion.com>
In-Reply-To: <1462003092-4611-1-git-send-email-jason@perfinion.com>
References: <1462003092-4611-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The fallback user is used in all the write functions, making all the
functions take the struct directly allows us to have everything
consistent between normal and fallback users.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 128 +++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 74 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ba997e1..60f9012 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -84,17 +84,6 @@
 #define FALLBACK_NAME ".*"
 #define DEFAULT_LOGIN "__default__"
 
-typedef struct {
-	const char *fcfilepath;
-	int usepasswd;
-	const char *homedir_template_path;
-	char *fallback_user;
-	char *fallback_user_prefix;
-	char *fallback_user_level;
-	semanage_handle_t *h_semanage;
-	sepol_policydb_t *policydb;
-} genhomedircon_settings_t;
-
 typedef struct user_entry {
 	char *name;
 	char *sename;
@@ -105,6 +94,15 @@ typedef struct user_entry {
 } genhomedircon_user_entry_t;
 
 typedef struct {
+	const char *fcfilepath;
+	int usepasswd;
+	const char *homedir_template_path;
+	genhomedircon_user_entry_t *fallback;
+	semanage_handle_t *h_semanage;
+	sepol_policydb_t *policydb;
+} genhomedircon_settings_t;
+
+typedef struct {
 	const char *search_for;
 	const char *replace_with;
 } replacement_pair_t;
@@ -573,20 +571,23 @@ static int write_replacements(genhomedircon_settings_t * s, FILE * out,
 }
 
 static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
-				  semanage_list_t * tpl, const char *user,
-				  const char *seuser, const char *home,
-				  const char *role_prefix, const char *level)
+				  semanage_list_t * tpl, const genhomedircon_user_entry_t *user)
 {
 	replacement_pair_t repl[] = {
-		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
-		{.search_for = TEMPLATE_HOME_DIR,.replace_with = home},
-		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
-		{.search_for = TEMPLATE_LEVEL,.replace_with = level},
+		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
+		{.search_for = TEMPLATE_HOME_DIR,.replace_with = user->home},
+		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
+		{.search_for = TEMPLATE_LEVEL,.replace_with = user->level},
 		{NULL, NULL}
 	};
 
-	if (fprintf(out, COMMENT_USER_HOME_CONTEXT, user) < 0)
-		return STATUS_ERR;
+	if (strcmp(user->name, FALLBACK_NAME) == 0) {
+		if (fprintf(out, COMMENT_USER_HOME_CONTEXT, FALLBACK_SENAME) < 0)
+			return STATUS_ERR;
+	} else {
+		if (fprintf(out, COMMENT_USER_HOME_CONTEXT, user->name) < 0)
+			return STATUS_ERR;
+	}
 
 	return write_replacements(s, out, tpl, repl);
 }
@@ -603,13 +604,12 @@ static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
 }
 
 static int write_user_context(genhomedircon_settings_t * s, FILE * out,
-			      semanage_list_t * tpl, const char *user,
-			      const char *seuser, const char *role_prefix)
+			      semanage_list_t * tpl, const genhomedircon_user_entry_t *user)
 {
 	replacement_pair_t repl[] = {
-		{.search_for = TEMPLATE_USER,.replace_with = user},
-		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
-		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
+		{.search_for = TEMPLATE_USER,.replace_with = user->name},
+		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
+		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
 		{NULL, NULL}
 	};
 
@@ -694,32 +694,6 @@ static void pop_user_entry(genhomedircon_user_entry_t ** list)
 	free(temp);
 }
 
-static int set_fallback_user(genhomedircon_settings_t *s, const char *user,
-			     const char *prefix, const char *level)
-{
-	char *fallback_user = strdup(user);
-	char *fallback_user_prefix = strdup(prefix);
-	char *fallback_user_level = NULL;
-	if (level) 
-		fallback_user_level = strdup(level);
-
-	if (fallback_user == NULL || fallback_user_prefix == NULL ||
-	    (fallback_user_level == NULL && level != NULL)) {
-		free(fallback_user);
-		free(fallback_user_prefix);
-		free(fallback_user_level);
-		return STATUS_ERR;
-	}
-
-	free(s->fallback_user);
-	free(s->fallback_user_prefix);
-	free(s->fallback_user_level);
-	s->fallback_user = fallback_user;
-	s->fallback_user_prefix = fallback_user_prefix;
-	s->fallback_user_level = fallback_user_level;
-	return STATUS_SUCCESS;
-}
-
 static int setup_fallback_user(genhomedircon_settings_t * s)
 {
 	semanage_seuser_t **seuser_list = NULL;
@@ -764,7 +738,8 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 					level = FALLBACK_LEVEL;
 			}
 
-			if (set_fallback_user(s, seuname, prefix, level) != 0)
+			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
+					    seuname, prefix, "", level) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
 			if (u)
@@ -825,7 +800,7 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 		name = semanage_seuser_get_name(seuser_list[i]);
 
-		if (strcmp(name,"root") && strcmp(seuname, s->fallback_user) == 0)
+		if (strcmp(name,"root") && strcmp(seuname, s->fallback->sename) == 0)
 			continue;
 
 		if (strcmp(name, DEFAULT_LOGIN) == 0)
@@ -918,13 +893,9 @@ static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 	}
 
 	for (; users; pop_user_entry(&users)) {
-		if (write_home_dir_context(s, out, homedir_context_tpl,
-					   users->name,
-					   users->sename, users->home,
-					   users->prefix, users->level))
+		if (write_home_dir_context(s, out, homedir_context_tpl, users))
 			goto err;
-		if (write_user_context(s, out, user_context_tpl, users->name,
-				       users->sename, users->prefix))
+		if (write_user_context(s, out, user_context_tpl, users))
 			goto err;
 	}
 
@@ -986,13 +957,13 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 				goto done;
 			}
 
-			if (write_home_dir_context(s, out,
-						   homedir_context_tpl,
-						   s->fallback_user, s->fallback_user,
-						   ustr_cstr(temp),
-						   s->fallback_user_prefix, s->fallback_user_level) !=
-			    STATUS_SUCCESS) {
+			free(s->fallback->home);
+			s->fallback->home = (char*) ustr_cstr(temp);
+
+			if (write_home_dir_context(s, out, homedir_context_tpl,
+						   s->fallback) != STATUS_SUCCESS) {
 				ustr_sc_free(&temp);
+				s->fallback->home = NULL;
 				retval = STATUS_ERR;
 				goto done;
 			}
@@ -1000,17 +971,18 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 						    homeroot_context_tpl,
 						    h->data) != STATUS_SUCCESS) {
 				ustr_sc_free(&temp);
+				s->fallback->home = NULL;
 				retval = STATUS_ERR;
 				goto done;
 			}
 
 			ustr_sc_free(&temp);
+			s->fallback->home = NULL;
 		}
 	}
 	if (user_context_tpl) {
 		if (write_user_context(s, out, user_context_tpl,
-				       ".*", s->fallback_user,
-				       s->fallback_user_prefix) != STATUS_SUCCESS) {
+				       s->fallback) != STATUS_SUCCESS) {
 			retval = STATUS_ERR;
 			goto done;
 		}
@@ -1047,10 +1019,20 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	s.fcfilepath = semanage_final_path(SEMANAGE_FINAL_TMP,
 					   SEMANAGE_FC_HOMEDIRS);
 
-	s.fallback_user = strdup(FALLBACK_SENAME);
-	s.fallback_user_prefix = strdup(FALLBACK_PREFIX);
-	s.fallback_user_level = strdup(FALLBACK_LEVEL);
-	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL) {
+	s.fallback = calloc(1, sizeof(genhomedircon_user_entry_t));
+	if (s.fallback == NULL) {
+		retval = STATUS_ERR;
+		goto done;
+	}
+
+	s.fallback->name = strdup(FALLBACK_NAME);
+	s.fallback->sename = strdup(FALLBACK_SENAME);
+	s.fallback->prefix = strdup(FALLBACK_PREFIX);
+	s.fallback->level = strdup(FALLBACK_LEVEL);
+	if (s.fallback->name == NULL
+	 || s.fallback->sename == NULL
+	 || s.fallback->prefix == NULL
+	 || s.fallback->level == NULL) {
 		retval = STATUS_ERR;
 		goto done;
 	}
@@ -1074,9 +1056,7 @@ done:
 	if (out != NULL)
 		fclose(out);
 
-	free(s.fallback_user);
-	free(s.fallback_user_prefix);
-	free(s.fallback_user_level);
+	pop_user_entry(&(s.fallback));
 	ignore_free();
 
 	return retval;
-- 
2.7.3
