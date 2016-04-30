Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3U7wahg016059
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 03:58:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id e190so16806342pfe.0
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 00:58:41 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Jason Zaman <jason@perfinion.com>
Subject: [PATCH v4 1/7] genhomedircon: factor out common replacement code
Date: Sat, 30 Apr 2016 15:58:06 +0800
Message-Id: <1462003092-4611-2-git-send-email-jason@perfinion.com>
In-Reply-To: <1462003092-4611-1-git-send-email-jason@perfinion.com>
References: <1462003092-4611-1-git-send-email-jason@perfinion.com>
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
