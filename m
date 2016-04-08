Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38G6Zm4021132
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 12:06:43 -0400
Received: by mail-pa0-f66.google.com with SMTP id hb4so9371070pac.1
 for <selinux@tycho.nsa.gov>; Fri, 08 Apr 2016 09:06:40 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 7/7] genhomedircon: write contexts for username and userid
Date: Sat,  9 Apr 2016 00:05:35 +0800
Message-Id: <1460131535-15688-8-git-send-email-jason@perfinion.com>
In-Reply-To: <1460131535-15688-1-git-send-email-jason@perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsemanage/src/genhomedircon.c | 51 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 60c9d27..66ab307 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -625,6 +625,34 @@ static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
 	return write_replacements(s, out, tpl, repl);
 }
 
+static int write_username_context(genhomedircon_settings_t * s, FILE * out,
+				  semanage_list_t * tpl,
+				  const genhomedircon_user_entry_t *user)
+{
+	replacement_pair_t repl[] = {
+		{.search_for = TEMPLATE_USERNAME,.replace_with = user->name},
+		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
+		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
+		{NULL, NULL}
+	};
+
+	return write_replacements(s, out, tpl, repl);
+}
+
+static int write_userid_context(genhomedircon_settings_t * s, FILE * out,
+				  semanage_list_t * tpl,
+				  const genhomedircon_user_entry_t *user)
+{
+	replacement_pair_t repl[] = {
+		{.search_for = TEMPLATE_USERID,.replace_with = user->uid},
+		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
+		{.search_for = TEMPLATE_SEUSER,.replace_with = user->sename},
+		{NULL, NULL}
+	};
+
+	return write_replacements(s, out, tpl, repl);
+}
+
 static int write_user_context(genhomedircon_settings_t * s, FILE * out,
 			      semanage_list_t * tpl, const genhomedircon_user_entry_t *user)
 {
@@ -926,6 +954,8 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 }
 
 static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
+				      semanage_list_t * username_context_tpl,
+				      semanage_list_t * userid_context_tpl,
 				      semanage_list_t * user_context_tpl,
 				      semanage_list_t * homedir_context_tpl)
 {
@@ -940,6 +970,10 @@ static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 	for (; users; pop_user_entry(&users)) {
 		if (write_home_dir_context(s, out, homedir_context_tpl, users))
 			goto err;
+		if (write_username_context(s, out, username_context_tpl, users))
+			goto err;
+		if (write_userid_context(s, out, userid_context_tpl, users))
+			goto err;
 		if (write_user_context(s, out, user_context_tpl, users))
 			goto err;
 	}
@@ -1033,14 +1067,27 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 			s->fallback->home = NULL;
 		}
 	}
-	if (user_context_tpl) {
+	if (user_context_tpl || userid_context_tpl || username_context_tpl) {
+		if (write_username_context(s, out, username_context_tpl,
+					   s->fallback) != STATUS_SUCCESS) {
+			retval = STATUS_ERR;
+			goto done;
+		}
+
+		if (write_userid_context(s, out, userid_context_tpl,
+					 s->fallback) != STATUS_SUCCESS) {
+			retval = STATUS_ERR;
+			goto done;
+		}
+
 		if (write_user_context(s, out, user_context_tpl,
 				       s->fallback) != STATUS_SUCCESS) {
 			retval = STATUS_ERR;
 			goto done;
 		}
 
-		if (write_gen_home_dir_context(s, out, user_context_tpl,
+		if (write_gen_home_dir_context(s, out, username_context_tpl,
+					       userid_context_tpl, user_context_tpl,
 					       homedir_context_tpl) != STATUS_SUCCESS) {
 			retval = STATUS_ERR;
 		}
-- 
2.7.3
