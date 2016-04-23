Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3N65jAj007380
 for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2016 02:05:45 -0400
Received: by mail-pa0-f65.google.com with SMTP id vv3so11735595pab.0
 for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2016 23:05:43 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 6/8] genhomedircon: make USERID, USERNAME context lists
Date: Sat, 23 Apr 2016 14:04:57 +0800
Message-Id: <1461391499-20593-7-git-send-email-jason@perfinion.com>
In-Reply-To: <1461391499-20593-1-git-send-email-jason@perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libsemanage/src/genhomedircon.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 56c58e0..e69b311 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -73,8 +73,13 @@
    which are searched for and replaced */
 #define TEMPLATE_HOME_ROOT "HOME_ROOT"
 #define TEMPLATE_HOME_DIR "HOME_DIR"
+/* these are legacy */
 #define TEMPLATE_USER "USER"
 #define TEMPLATE_ROLE "ROLE"
+/* new names */
+#define TEMPLATE_USERNAME "%{USERNAME}"
+#define TEMPLATE_USERID "%{USERID}"
+
 #define TEMPLATE_SEUSER "system_u"
 #define TEMPLATE_LEVEL "s0"
 
@@ -463,8 +468,21 @@ static int HOME_DIR_PRED(const char *string)
 	return semanage_is_prefix(string, TEMPLATE_HOME_DIR);
 }
 
+/* new names */
+static int USERNAME_CONTEXT_PRED(const char *string)
+{
+	return (int)(
+		(strstr(string, TEMPLATE_USERNAME) != NULL) ||
+		(strstr(string, TEMPLATE_USERID) != NULL)
+	);
+}
+
+/* This will never match USER if USERNAME or USERID are found. */
 static int USER_CONTEXT_PRED(const char *string)
 {
+	if (USERNAME_CONTEXT_PRED(string))
+		return 0;
+
 	return (int)(strstr(string, TEMPLATE_USER) != NULL);
 }
 
@@ -944,16 +962,21 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 {
 	semanage_list_t *homedirs = NULL;
 	semanage_list_t *h = NULL;
-	semanage_list_t *user_context_tpl = NULL;
 	semanage_list_t *homedir_context_tpl = NULL;
 	semanage_list_t *homeroot_context_tpl = NULL;
+	semanage_list_t *username_context_tpl = NULL;
+	semanage_list_t *user_context_tpl = NULL;
 	int retval = STATUS_SUCCESS;
 
 	homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
 	homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
+	username_context_tpl = make_template(s, &USERNAME_CONTEXT_PRED);
 	user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
 
-	if (!homedir_context_tpl && !homeroot_context_tpl && !user_context_tpl)
+	if (!homedir_context_tpl
+	 && !homeroot_context_tpl
+	 && !username_context_tpl
+	 && !user_context_tpl)
 		goto done;
 
 	if (write_file_context_header(out) != STATUS_SUCCESS) {
@@ -1022,6 +1045,7 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 done:
 	/* Cleanup */
 	semanage_list_destroy(&homedirs);
+	semanage_list_destroy(&username_context_tpl);
 	semanage_list_destroy(&user_context_tpl);
 	semanage_list_destroy(&homedir_context_tpl);
 	semanage_list_destroy(&homeroot_context_tpl);
-- 
2.7.3
