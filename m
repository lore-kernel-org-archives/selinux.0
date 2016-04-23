Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3N65MDJ007341
 for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2016 02:05:22 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so12078199pac.2
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 23:05:19 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 1/8] genhomedircon: factor out common replacement code
Date: Sat, 23 Apr 2016 14:04:52 +0800
Message-Id: <1461391499-20593-2-git-send-email-jason@perfinion.com>
In-Reply-To: <1461391499-20593-1-git-send-email-jason@perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

All the write_*_contexts() methods use exactly the same code.
This splits it off into a common helper function.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 70 ++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 1a9e87e..09c2a10 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -548,23 +548,12 @@ static int check_line(genhomedircon_settings_t * s, Ustr *line)
 	return result;
 }
 
-static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
-				  semanage_list_t * tpl, const char *user,
-				  const char *seuser, const char *home,
-				  const char *role_prefix, const char *level)
+static int write_replacements(genhomedircon_settings_t * s, FILE * out,
+			      const semanage_list_t * tpl,
+			      const replacement_pair_t *repl)
 {
-	replacement_pair_t repl[] = {
-		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
-		{.search_for = TEMPLATE_HOME_DIR,.replace_with = home},
-		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
-		{.search_for = TEMPLATE_LEVEL,.replace_with = level},
-		{NULL, NULL}
-	};
 	Ustr *line = USTR_NULL;
 
-	if (fprintf(out, COMMENT_USER_HOME_CONTEXT, user) < 0)
-		return STATUS_ERR;
-
 	for (; tpl; tpl = tpl->next) {
 		line = replace_all(tpl->data, repl);
 		if (!line)
@@ -582,6 +571,25 @@ static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 	return STATUS_ERR;
 }
 
+static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
+				  semanage_list_t * tpl, const char *user,
+				  const char *seuser, const char *home,
+				  const char *role_prefix, const char *level)
+{
+	replacement_pair_t repl[] = {
+		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
+		{.search_for = TEMPLATE_HOME_DIR,.replace_with = home},
+		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
+		{.search_for = TEMPLATE_LEVEL,.replace_with = level},
+		{NULL, NULL}
+	};
+
+	if (fprintf(out, COMMENT_USER_HOME_CONTEXT, user) < 0)
+		return STATUS_ERR;
+
+	return write_replacements(s, out, tpl, repl);
+}
+
 static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
 				   semanage_list_t * tpl, char *homedir)
 {
@@ -589,23 +597,8 @@ static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
 		{.search_for = TEMPLATE_HOME_ROOT,.replace_with = homedir},
 		{NULL, NULL}
 	};
-	Ustr *line = USTR_NULL;
-
-	for (; tpl; tpl = tpl->next) {
-		line = replace_all(tpl->data, repl);
-		if (!line)
-			goto fail;
-		if (check_line(s, line) == STATUS_SUCCESS) {
-			if (!ustr_io_putfileline(&line, out))
-				goto fail;
-		}
-		ustr_sc_free(&line);
-	}
-	return STATUS_SUCCESS;
 
-      fail:
-	ustr_sc_free(&line);
-	return STATUS_ERR;
+	return write_replacements(s, out, tpl, repl);
 }
 
 static int write_user_context(genhomedircon_settings_t * s, FILE * out,
@@ -618,23 +611,8 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
 		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
 		{NULL, NULL}
 	};
-	Ustr *line = USTR_NULL;
-
-	for (; tpl; tpl = tpl->next) {
-		line = replace_all(tpl->data, repl);
-		if (!line)
-			goto fail;
-		if (check_line(s, line) == STATUS_SUCCESS) {
-			if (!ustr_io_putfileline(&line, out))
-				goto fail;
-		}
-		ustr_sc_free(&line);
-	}
-	return STATUS_SUCCESS;
 
-      fail:
-	ustr_sc_free(&line);
-	return STATUS_ERR;
+	return write_replacements(s, out, tpl, repl);
 }
 
 static int user_sort_func(semanage_user_t ** arg1, semanage_user_t ** arg2)
-- 
2.7.3
