Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u86DrjD0007265
 for <selinux@tycho.nsa.gov>; Tue, 6 Sep 2016 09:53:45 -0400
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] genhomedircon: remove hardcoded refpolicy strings
Date: Tue,  6 Sep 2016 14:48:21 +0100
Message-Id: <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
In-Reply-To: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Removes the "system_u" and "s0" string literals from refpolicy and
replaces the seuser and range in each homedir, uid, and username context
specification for every user.

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 libsemanage/src/genhomedircon.c | 79 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index cce3884..cca97f6 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -20,6 +20,7 @@
  *  02110-1301  USA
  */
 
+#include <selinux/context.h>
 #include <semanage/handle.h>
 #include <semanage/seusers_policy.h>
 #include <semanage/users_policy.h>
@@ -82,9 +83,6 @@
 #define TEMPLATE_USERNAME "%{USERNAME}"
 #define TEMPLATE_USERID "%{USERID}"
 
-#define TEMPLATE_SEUSER "system_u"
-#define TEMPLATE_LEVEL "s0"
-
 #define FALLBACK_SENAME "user_u"
 #define FALLBACK_PREFIX "user"
 #define FALLBACK_LEVEL "s0"
@@ -92,6 +90,8 @@
 #define FALLBACK_UIDGID "[0-9]+"
 #define DEFAULT_LOGIN "__default__"
 
+#define CONTEXT_NONE "<<none>>"
+
 typedef struct user_entry {
 	char *name;
 	char *uid;
@@ -599,14 +599,72 @@ static int write_replacements(genhomedircon_settings_t * s, FILE * out,
 	return STATUS_ERR;
 }
 
+static int write_user_replacements(genhomedircon_settings_t *s, FILE *out,
+			  semanage_list_t *tpl, const replacement_pair_t *repl,
+			  const genhomedircon_user_entry_t *user)
+{
+	Ustr *line = USTR_NULL;
+	context_t context = NULL;
+
+	for (; tpl; tpl = tpl->next) {
+		line = replace_all(tpl->data, repl);
+		if (!line) {
+			goto fail;
+		}
+
+		const char *old_context_str = extract_context(line);
+		if (!old_context_str) {
+			goto fail;
+		}
+
+		if (strcmp(old_context_str, CONTEXT_NONE) == 0) {
+			if (check_line(s, line) &&
+			    !ustr_io_putfileline(&line, out)) {
+				goto fail;
+			}
+
+			continue;
+		}
+
+		context = context_new(old_context_str);
+		if (!context) {
+			goto fail;
+		}
+
+		if (context_user_set(context, user->sename) != 0 ||
+		    context_range_set(context, user->level) != 0) {
+			goto fail;
+		}
+
+		const char *new_context_str = context_str(context);
+		if (!ustr_replace_cstr(&line, old_context_str,
+				       new_context_str, 1)) {
+			goto fail;
+		}
+
+		if (check_line(s, line) == STATUS_SUCCESS) {
+			if (!ustr_io_putfileline(&line, out)) {
+				goto fail;
+			}
+		}
+
+		ustr_sc_free(&line);
+		context_free(context);
+	}
+
+	return STATUS_SUCCESS;
+fail:
+	ustr_sc_free(&line);
+	context_free(context);
+	return STATUS_ERR;
+}
+
 static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 				  semanage_list_t * tpl, const genhomedircon_user_entry_t *user)
 {
 	replacement_pair_t repl[] = {
-		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
 		{.search_for = TEMPLATE_HOME_DIR,.replace_with = user->home},
 		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
-		{.search_for = TEMPLATE_LEVEL,.replace_with = user->level},
 		{NULL, NULL}
 	};
 
@@ -618,7 +676,7 @@ static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 			return STATUS_ERR;
 	}
 
-	return write_replacements(s, out, tpl, repl);
+	return write_user_replacements(s, out, tpl, repl, user);
 }
 
 static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
@@ -640,11 +698,10 @@ static int write_username_context(genhomedircon_settings_t * s, FILE * out,
 		{.search_for = TEMPLATE_USERNAME,.replace_with = user->name},
 		{.search_for = TEMPLATE_USERID,.replace_with = user->uid},
 		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
-		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
 		{NULL, NULL}
 	};
 
-	return write_replacements(s, out, tpl, repl);
+	return write_user_replacements(s, out, tpl, repl, user);
 }
 
 static int write_user_context(genhomedircon_settings_t * s, FILE * out,
@@ -653,11 +710,10 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_USER,.replace_with = user->name},
 		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
-		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
 		{NULL, NULL}
 	};
 
-	return write_replacements(s, out, tpl, repl);
+	return write_user_replacements(s, out, tpl, repl, user);
 }
 
 static int seuser_sort_func(const void *arg1, const void *arg2)
@@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 		if (strcmp(name, DEFAULT_LOGIN) == 0)
 			continue;
 
-		if (strcmp(name, TEMPLATE_SEUSER) == 0)
-			continue;
-
 		/* find the user structure given the name */
 		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
 			    (int (*)(const void *, const void *))
-- 
2.7.4
