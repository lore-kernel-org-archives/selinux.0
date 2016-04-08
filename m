Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38G6LBH021119
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 12:06:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so9830593pfr.2
 for <selinux@tycho.nsa.gov>; Fri, 08 Apr 2016 09:06:26 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/7] genhomedircon: make all write context funcs take
 user_entry struct
Date: Sat,  9 Apr 2016 00:05:32 +0800
Message-Id: <1460131535-15688-5-git-send-email-jason@perfinion.com>
In-Reply-To: <1460131535-15688-1-git-send-email-jason@perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsemanage/src/genhomedircon.c | 86 ++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 56 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 61f503f..495f084 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -570,20 +570,23 @@ static int write_replacements(genhomedircon_settings_t * s, FILE * out,
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
@@ -600,13 +603,12 @@ static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
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
 
@@ -691,32 +693,6 @@ static void pop_user_entry(genhomedircon_user_entry_t ** list)
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
@@ -761,7 +737,8 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 					level = FALLBACK_LEVEL;
 			}
 
-			if (set_fallback_user(s, seuname, prefix, level) != 0)
+			if (push_user_entry(&(s->fallback), FALLBACK_NAME, 0, 0,
+					    seuname, prefix, "", level) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
 			if (u)
@@ -822,7 +799,7 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 		name = semanage_seuser_get_name(seuser_list[i]);
 
-		if (strcmp(name,"root") && strcmp(seuname, s->fallback_user) == 0)
+		if (strcmp(name,"root") && strcmp(seuname, s->fallback->sename) == 0)
 			continue;
 
 		if (strcmp(name, DEFAULT_LOGIN) == 0)
@@ -915,13 +892,9 @@ static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
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
 
@@ -983,13 +956,13 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
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
@@ -997,17 +970,18 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
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
-- 
2.7.3
