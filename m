Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38G6Zm3021132
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 12:06:39 -0400
Received: by mail-pa0-f67.google.com with SMTP id hb4so9370959pac.1
 for <selinux@tycho.nsa.gov>; Fri, 08 Apr 2016 09:06:36 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/7] genhomedircon: make USERID, USERNAME context lists
Date: Sat,  9 Apr 2016 00:05:34 +0800
Message-Id: <1460131535-15688-7-git-send-email-jason@perfinion.com>
In-Reply-To: <1460131535-15688-1-git-send-email-jason@perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsemanage/src/genhomedircon.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ae4a261..60c9d27 100644
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
 
@@ -463,8 +468,23 @@ static int HOME_DIR_PRED(const char *string)
 	return semanage_is_prefix(string, TEMPLATE_HOME_DIR);
 }
 
+/* new names */
+static int USERNAME_CONTEXT_PRED(const char *string)
+{
+	return (int)(strstr(string, TEMPLATE_USERNAME) != NULL);
+}
+
+static int USERID_CONTEXT_PRED(const char *string)
+{
+	return (int)(strstr(string, TEMPLATE_USERID) != NULL);
+}
+
+/* This will never match USER if USERNAME or USERID are found. */
 static int USER_CONTEXT_PRED(const char *string)
 {
+	if (USERNAME_CONTEXT_PRED(string) || USERID_CONTEXT_PRED(string))
+		return 0;
+
 	return (int)(strstr(string, TEMPLATE_USER) != NULL);
 }
 
@@ -943,16 +963,24 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 {
 	semanage_list_t *homedirs = NULL;
 	semanage_list_t *h = NULL;
-	semanage_list_t *user_context_tpl = NULL;
 	semanage_list_t *homedir_context_tpl = NULL;
 	semanage_list_t *homeroot_context_tpl = NULL;
+	semanage_list_t *username_context_tpl = NULL;
+	semanage_list_t *userid_context_tpl = NULL;
+	semanage_list_t *user_context_tpl = NULL;
 	int retval = STATUS_SUCCESS;
 
 	homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
 	homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
+	username_context_tpl = make_template(s, &USERNAME_CONTEXT_PRED);
+	userid_context_tpl = make_template(s, &USERID_CONTEXT_PRED);
 	user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
 
-	if (!homedir_context_tpl && !homeroot_context_tpl && !user_context_tpl)
+	if (!homedir_context_tpl
+	 && !homeroot_context_tpl
+	 && !userid_context_tpl
+	 && !username_context_tpl
+	 && !user_context_tpl)
 		goto done;
 
 	if (write_file_context_header(out) != STATUS_SUCCESS) {
@@ -1021,6 +1049,8 @@ static int write_context_file(genhomedircon_settings_t * s, FILE * out)
 done:
 	/* Cleanup */
 	semanage_list_destroy(&homedirs);
+	semanage_list_destroy(&username_context_tpl);
+	semanage_list_destroy(&userid_context_tpl);
 	semanage_list_destroy(&user_context_tpl);
 	semanage_list_destroy(&homedir_context_tpl);
 	semanage_list_destroy(&homeroot_context_tpl);
-- 
2.7.3
