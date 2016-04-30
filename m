Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3U7x7jI016239
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 03:59:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so16966438pfr.2
 for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2016 00:59:09 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Jason Zaman <jason@perfinion.com>
Subject: [PATCH v4 6/7] genhomedircon: write contexts for username and userid
Date: Sat, 30 Apr 2016 15:58:11 +0800
Message-Id: <1462003092-4611-7-git-send-email-jason@perfinion.com>
In-Reply-To: <1462003092-4611-1-git-send-email-jason@perfinion.com>
References: <1462003092-4611-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index b299656..6c6eaef 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -624,6 +624,21 @@ static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
 	return write_replacements(s, out, tpl, repl);
 }
 
+static int write_username_context(genhomedircon_settings_t * s, FILE * out,
+				  semanage_list_t * tpl,
+				  const genhomedircon_user_entry_t *user)
+{
+	replacement_pair_t repl[] = {
+		{.search_for = TEMPLATE_USERNAME,.replace_with = user->name},
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
@@ -931,6 +946,7 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 }
 
 static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
+				      semanage_list_t * username_context_tpl,
 				      semanage_list_t * user_context_tpl,
 				      semanage_list_t * homedir_context_tpl)
 {
@@ -945,6 +961,8 @@ static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 	for (; users; pop_user_entry(&users)) {
 		if (write_home_dir_context(s, out, homedir_context_tpl, users))
 			goto err;
+		if (write_username_context(s, out, username_context_tpl, users))
+			goto err;
 		if (write_user_context(s, out, user_context_tpl, users))
 			goto err;
 	}
@@ -1035,15 +1053,22 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 			s->fallback->home = NULL;
 		}
 	}
-	if (user_context_tpl) {
+	if (user_context_tpl || username_context_tpl) {
+		if (write_username_context(s, out, username_context_tpl,
+					   s->fallback) != STATUS_SUCCESS) {
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
-					       homedir_context_tpl) != STATUS_SUCCESS) {
+		if (write_gen_home_dir_context(s, out, username_context_tpl,
+					       user_context_tpl, homedir_context_tpl)
+				!= STATUS_SUCCESS) {
 			retval = STATUS_ERR;
 		}
 	}
-- 
2.7.3
