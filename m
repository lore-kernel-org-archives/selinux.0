Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38G6God021115
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 12:06:16 -0400
Received: by mail-pa0-f66.google.com with SMTP id hb4so9370408pac.1
 for <selinux@tycho.nsa.gov>; Fri, 08 Apr 2016 09:06:13 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/7] genhomedircon: factor out common replacement code
Date: Sat,  9 Apr 2016 00:05:29 +0800
Message-Id: <1460131535-15688-2-git-send-email-jason@perfinion.com>
In-Reply-To: <1460131535-15688-1-git-send-email-jason@perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

All the write_*_contexts() methods use exactly the same code.
This splits it off into a common helper function.
---
 libsemanage/src/genhomedircon.c | 69 ++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 1a9e87e..a95ab16 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -548,23 +548,11 @@ static int check_line(genhomedircon_settings_t * s, Ustr *line)
 	return result;
 }
 
-static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
-				  semanage_list_t * tpl, const char *user,
-				  const char *seuser, const char *home,
-				  const char *role_prefix, const char *level)
+static int write_replacements(genhomedircon_settings_t * s, FILE * out,
+			      semanage_list_t * tpl, replacement_pair_t *repl)
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
@@ -582,6 +570,25 @@ static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
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
@@ -589,23 +596,8 @@ static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
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
@@ -618,23 +610,8 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
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
