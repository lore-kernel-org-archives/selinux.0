Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D2C43217
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E273D60296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhKLPpC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbhKLPpC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A31C061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z21so39283562edb.5
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SN02xIldcHjxtmBai/ug1s+OUlSAhUGWa6QRImMK1rs=;
        b=mpTt7y8Joy7n/YUZ4zsl6honS6tSIX/NM8ihBauzM93wYunXWaqhZn6GNc9NSNGv9/
         mw83bHGgMbC3+lYQRfYJ54RNRQaoBPvEZ1yu2iSssihWKxyV+ml9fjnVsflcEyM6WA0G
         yLVUwVR6oLp/TarM3TkZAqGMtbq8GTvefMVTzB8LzEqDeJW0/n7+Dt/CqO6C0Rwq+GaB
         ZL5FsoD+hdmO8TcySzy8LSMjqfUOc+UGeviLcjRpHMgvZBQtTYoxn5M2od9mFYuKbLA4
         Aop51MfGSj7MqK0QZ00o9QoHavOh+2OEjxYkNdvSwg1IkEglS8b3yVGWFvN7I0vP1bq/
         tyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SN02xIldcHjxtmBai/ug1s+OUlSAhUGWa6QRImMK1rs=;
        b=xrC2lR+s+wKNHwEuLMbQScbEBVa+Pr5+D1F+Zj7l8V0wTH8GH83NVeG7vHrKjPpWyA
         fxQG9SZpapRHvQjztr09kKL08+BvluyJD1K6WP2K4RwPfyPQSWx18iln3eI82r2gnlm5
         4NZIrogcGRf3ymE4Z6vVHWa/BxtA7VGsOfl3rYzOwkJldph2mYwqG6FuFa5EQUWpcBq+
         p3g5+W1eLaAYQ9i0V6A4TqGXbCWWTJvvSpU+fUwANebNg+2jdIIhRqVT5FBzFe4s5X9R
         mN1tw8UM1GAvCk7FDfJIRS+02hLG/r62rzVlDj1DqOpxyy+ZnD+oU87iRZkqA1Pbpmz7
         CKkw==
X-Gm-Message-State: AOAM533hrCX12svI4mMh0ebCbjHRBeOWG0ffdSueSd7PaL0uXkzAl24q
        kRfu20G9QGoIY9/U61Awxi7W7JUSuHY=
X-Google-Smtp-Source: ABdhPJxvh+ckfbH3RJZH/f1ABOcz697utpcvUYpn4JcuTPEMQuf0uAwhJcChomKNqJx0uo256mWOcA==
X-Received: by 2002:a17:906:2e97:: with SMTP id o23mr19531662eji.541.1636731729807;
        Fri, 12 Nov 2021 07:42:09 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:09 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 06/12] policycoreutils: mark local functions static
Date:   Fri, 12 Nov 2021 16:41:55 +0100
Message-Id: <20211112154201.78217-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    setfiles.c:50:6: warning: no previous prototype for ‘set_rootpath’ [-Wmissing-prototypes]
       50 | void set_rootpath(const char *arg)
          |      ^~~~~~~~~~~~
    setfiles.c:67:5: warning: no previous prototype for ‘canoncon’ [-Wmissing-prototypes]
       67 | int canoncon(char **contextp)
          |     ^~~~~~~~

    newrole.c:185:5: warning: no previous prototype for ‘authenticate_via_pam’ [-Wmissing-prototypes]
      185 | int authenticate_via_pam(const char *ttyn, pam_handle_t * pam_handle)
          |     ^~~~~~~~~~~~~~~~~~~~

    run_init.c:241:5: warning: no previous prototype for ‘authenticate_user’ [-Wmissing-prototypes]
      241 | int authenticate_user(void)
          |     ^~~~~~~~~~~~~~~~~
    run_init.c:306:5: warning: no previous prototype for ‘get_init_context’ [-Wmissing-prototypes]
      306 | int get_init_context(char **context)
          |     ^~~~~~~~~~~~~~~~

    sestatus.c:38:5: warning: no previous prototype for ‘cmp_cmdline’ [-Wmissing-prototypes]
       38 | int cmp_cmdline(const char *command, int pid)
          |     ^~~~~~~~~~~
    sestatus.c:62:5: warning: no previous prototype for ‘pidof’ [-Wmissing-prototypes]
       62 | int pidof(const char *command)
          |     ^~~~~
    sestatus.c:95:6: warning: no previous prototype for ‘load_checks’ [-Wmissing-prototypes]
       95 | void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
          |      ^~~~~~~~~~~
    sestatus.c:171:6: warning: no previous prototype for ‘printf_tab’ [-Wmissing-prototypes]
      171 | void printf_tab(const char *outp)
          |      ^~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c   |  4 ++--
 policycoreutils/run_init/run_init.c | 12 ++++--------
 policycoreutils/sestatus/sestatus.c |  8 ++++----
 policycoreutils/setfiles/setfiles.c |  4 ++--
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 31b51c5a..9d68b6ab 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -182,7 +182,7 @@ const char *service_name = "newrole";
  * program.  This is the only function in this program that makes PAM
  * calls.
  */
-int authenticate_via_pam(const char *ttyn, pam_handle_t * pam_handle)
+static int authenticate_via_pam(const char *ttyn, pam_handle_t * pam_handle)
 {
 
 	int result = 0;		/* set to 0 (not authenticated) by default */
@@ -348,7 +348,7 @@ static int read_pam_config(void)
  * This function uses the shadow passwd file to thenticate the user running
  * this program.
  */
-int authenticate_via_shadow_passwd(const char *uname)
+static int authenticate_via_shadow_passwd(const char *uname)
 {
 	struct spwd *p_shadow_line;
 	char *unencrypted_password_s;
diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 545490a2..ce499781 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -86,8 +86,6 @@
 				  /* The file containing the context to run 
 				   * the scripts under.                     */
 
-int authenticate_via_pam(const struct passwd *);
-
 /* authenticate_via_pam()
  *
  * in:     p_passwd_line - struct containing data from our user's line in 
@@ -104,7 +102,7 @@ int authenticate_via_pam(const struct passwd *);
  *
  */
 
-int authenticate_via_pam(const struct passwd *p_passwd_line)
+static int authenticate_via_pam(const struct passwd *p_passwd_line)
 {
 
 	int result = 0;		/* our result, set to 0 (not authenticated) by default */
@@ -169,8 +167,6 @@ int authenticate_via_pam(const struct passwd *p_passwd_line)
 
 #define PASSWORD_PROMPT _("Password:")	/* prompt for getpass() */
 
-int authenticate_via_shadow_passwd(const struct passwd *);
-
 /* authenticate_via_shadow_passwd()
  *
  * in:     p_passwd_line - struct containing data from our user's line in 
@@ -187,7 +183,7 @@ int authenticate_via_shadow_passwd(const struct passwd *);
  *
  */
 
-int authenticate_via_shadow_passwd(const struct passwd *p_passwd_line)
+static int authenticate_via_shadow_passwd(const struct passwd *p_passwd_line)
 {
 
 	struct spwd *p_shadow_line;	/* struct derived from shadow passwd file line */
@@ -238,7 +234,7 @@ int authenticate_via_shadow_passwd(const struct passwd *p_passwd_line)
  * return:	0 When success
  *		-1 When failure
  */
-int authenticate_user(void)
+static int authenticate_user(void)
 {
 
 #define INITLEN 255
@@ -303,7 +299,7 @@ int authenticate_user(void)
  * out:		The CONTEXT associated with the context.
  * return:	0 on success, -1 on failure.
  */
-int get_init_context(char **context)
+static int get_init_context(char **context)
 {
 
 	FILE *fp;
diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 538c73bc..7dcc9944 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -35,7 +35,7 @@ static unsigned int COL = 32;
 
 extern char *selinux_mnt;
 
-int cmp_cmdline(const char *command, int pid)
+static int cmp_cmdline(const char *command, int pid)
 {
 
 	char buf[BUFSIZE];
@@ -59,7 +59,7 @@ int cmp_cmdline(const char *command, int pid)
 		return 0;
 }
 
-int pidof(const char *command)
+static int pidof(const char *command)
 {
 /* inspired by killall5.c from psmisc */
 	char stackpath[PATH_MAX + 1], *p;
@@ -92,7 +92,7 @@ int pidof(const char *command)
 	return ret;
 }
 
-void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
+static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 {
 
 	FILE *fp = fopen(CONF, "r");
@@ -168,7 +168,7 @@ void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 	return;
 }
 
-void printf_tab(const char *outp)
+static void printf_tab(const char *outp)
 {
 	printf("%-*s", COL, outp);
 
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index f018d161..fedb93a1 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -47,7 +47,7 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 	exit(-1);
 }
 
-void set_rootpath(const char *arg)
+static void set_rootpath(const char *arg)
 {
 	if (strlen(arg) == 1 && strncmp(arg, "/", 1) == 0) {
 		fprintf(stderr, "%s:  invalid alt_rootpath: %s\n",
@@ -64,7 +64,7 @@ void set_rootpath(const char *arg)
 	}
 }
 
-int canoncon(char **contextp)
+static int canoncon(char **contextp)
 {
 	char *context = *contextp, *tmpcon;
 	int rc = 0;
-- 
2.33.1

