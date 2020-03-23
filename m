Return-Path: <SRS0=0U01=5I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A4C3F2CD
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 18:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E992520719
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 18:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Sy/bnN9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCWSbn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:31:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55623 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWSbn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Mar 2020 14:31:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so483590wmi.5
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2020 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sT5rw0jtXD9id6/RfBg+nMZ6WeST42Bni+Fe2UnEdU=;
        b=Sy/bnN9ep2aQ8Nxaiy8WyzI6u0mI8vS1sssOB5LplR9B0uO7qrbPBlRgA+ITqS1IB9
         ZAG++XzxOXcuQtelBDMVQF+Zdbw6j8R+xHFtByyBNcuNs33KwGEFRX8uylxtoj54SRPw
         3uPa7KRceuLzVQXzHdOM2prumE0xDra5aa1LXFjFIc+Svk8jDx0tLVbIk70TvyT2CDFN
         YTU9gexuGd9F4eccM9zsJiNM0buWz03kR13jkgfUFkakVjJKet+R0Zq9sFvpjl9yZbkR
         2hGtek5nhcPsV3PLn7EnjFphPoK+qHlboirio4oFEa3/VZ0d1D22X6TC7y+OsOjOwZJy
         DyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sT5rw0jtXD9id6/RfBg+nMZ6WeST42Bni+Fe2UnEdU=;
        b=iB3wSwOhUqxCYIRa4BxCf+YZdNpO3opTTVSgygFCU7GST9lLEr0aOVqOa9ZNfVNeDp
         cQr4CvcXkUAl8Aa+HRwGzOLPkFF/8XLQNrK//bLg/MSAeZhN1QqZgU94my5/DmIaJNFK
         6hHXS4X/gpL4uhxKQxkpgNXKc226Ee5+ou5+T3rf7ccZBLZIxPlovlQcoLJ0kJzon8PE
         KJo/o0QIfVz6W1oYo6y93bFi7nsLHSy8hyACzhBZRKufhsdQ9Qs0XOsIiS8RaEnSKA2g
         sSd4FxQF/bzTQvPzAlE63HBxFx1mfnexK8ixcLmNACuzw06MLvRD1IQNyYHQVNJUTXg0
         MSXw==
X-Gm-Message-State: ANhLgQ0cplV4OBOrU5L90Ba5hOfYxtoR32EsY0PQ4f02kVIg1SXjJZMQ
        EX7fNae7VMKyT4VA8dTu+Y1wU9oQ
X-Google-Smtp-Source: ADFU+vv95ZehBTOpJq/ouU2T9J6ku3qQ3BCi5uGHt5EKhqixw+aayhr9PxBm1givO9/8O+U31NBLxw==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr715109wmh.104.1584988297792;
        Mon, 23 Mar 2020 11:31:37 -0700 (PDT)
Received: from debianHome.localdomain (x4d004a48.dyn.telefonica.de. [77.0.74.72])
        by smtp.gmail.com with ESMTPSA id r18sm24987826wro.13.2020.03.23.11.31.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 11:31:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] tree-wide: replace last occurrences of security_context_t
Date:   Mon, 23 Mar 2020 19:31:30 +0100
Message-Id: <20200323183130.17307-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Follow-up of: 9eb9c9327563014ad6a807814e7975424642d5b9 ("Get rid of security_context_t and fix const declarations.")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcscolor.c             |  8 +++---
 mcstrans/src/mcstrans.c             | 12 ++++-----
 mcstrans/src/mcstrans.h             |  4 +--
 mcstrans/src/mcstransd.c            |  6 ++---
 mcstrans/utils/transcon.c           |  2 +-
 mcstrans/utils/untranscon.c         |  2 +-
 policycoreutils/newrole/newrole.c   | 40 ++++++++++++++---------------
 policycoreutils/run_init/run_init.c |  4 +--
 policycoreutils/secon/secon.c       | 19 +++++++-------
 sandbox/seunshare.c                 | 10 ++++----
 10 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index 4ee0db50..a3838850 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -44,7 +44,7 @@ static setab_t *clist[N_COLOR];
 static setab_t *cend[N_COLOR];
 static semnemonic_t *mnemonics;
 
-static security_context_t my_context;
+static char *my_context;
 
 void finish_context_colors(void) {
 	setab_t *cur, *next;
@@ -76,7 +76,7 @@ void finish_context_colors(void) {
 }
 
 static int check_dominance(const char *pattern, const char *raw) {
-	security_context_t ctx;
+	char *ctx;
 	context_t con;
 	struct av_decision avd;
 	int rc = -1;
@@ -109,7 +109,7 @@ static int check_dominance(const char *pattern, const char *raw) {
 	if (!raw)
 		goto out;
 
-	rc = security_compute_av_raw(ctx, (security_context_t)raw, context_class, context_contains_perm, &avd);
+	rc = security_compute_av_raw(ctx, raw, context_class, context_contains_perm, &avd);
 	if (rc)
 		goto out;
 
@@ -282,7 +282,7 @@ static int parse_components(context_t con, char **components) {
 
 /* Look up colors.
  */
-int raw_color(const security_context_t raw, char **color_str) {
+int raw_color(const char *raw, char **color_str) {
 #define CHARS_PER_COLOR 16
 	context_t con;
 	uint32_t i, j, mask = 0;
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 96bdbdff..4a073ca4 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -7,8 +7,8 @@
 
  int init_translations(void);
  void finish_context_translations(void);
- int trans_context(const security_context_t, security_context_t *);
- int untrans_context(const security_context_t, security_context_t *);
+ int trans_context(const char *, char **);
+ int untrans_context(const char *, char **);
 
 */
 
@@ -888,7 +888,7 @@ init_translations(void) {
 }
 
 char *
-extract_range(const security_context_t incon) {
+extract_range(const char *incon) {
 	context_t con = context_new(incon);
 	if (!con) {
 		syslog(LOG_ERR, "extract_range context_new(%s) failed: %s", incon, strerror(errno));
@@ -911,7 +911,7 @@ extract_range(const security_context_t incon) {
 }
 
 char *
-new_context_str(const security_context_t incon, const char *range) {
+new_context_str(const char *incon, const char *range) {
 	char *rcon = NULL;
 	context_t con = context_new(incon);
 	if (!con) {
@@ -1489,7 +1489,7 @@ err:
 }
 
 int
-trans_context(const security_context_t incon, security_context_t *rcon) {
+trans_context(const char *incon, char **rcon) {
 	char *trans = NULL;
 	*rcon = NULL;
 
@@ -1612,7 +1612,7 @@ trans_context(const security_context_t incon, security_context_t *rcon) {
 }
 
 int
-untrans_context(const security_context_t incon, security_context_t *rcon) {
+untrans_context(const char *incon, char **rcon) {
 	char *raw = NULL;
 	*rcon = NULL;
 
diff --git a/mcstrans/src/mcstrans.h b/mcstrans/src/mcstrans.h
index a2f68c18..e5cda93b 100644
--- a/mcstrans/src/mcstrans.h
+++ b/mcstrans/src/mcstrans.h
@@ -4,6 +4,6 @@
 
 extern int init_translations(void);
 extern void finish_context_translations(void);
-extern int trans_context(const security_context_t, security_context_t *);
-extern int untrans_context(const security_context_t, security_context_t *);
+extern int trans_context(const char *, char **);
+extern int untrans_context(const char *, char **);
 
diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 85899493..07c052fd 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -45,12 +45,12 @@
 
 extern int init_translations(void);
 extern void finish_context_translations(void);
-extern int trans_context(const security_context_t, security_context_t *);
-extern int untrans_context(const security_context_t, security_context_t *);
+extern int trans_context(const char *, char **);
+extern int untrans_context(const char *, char **);
 
 extern int init_colors(void);
 extern void finish_context_colors(void);
-extern int raw_color(const security_context_t, char **);
+extern int raw_color(const char *, char **);
 
 #define SETRANSD_PATHNAME "/sbin/mcstransd"
 
diff --git a/mcstrans/utils/transcon.c b/mcstrans/utils/transcon.c
index f4ded53e..4bf1bd56 100644
--- a/mcstrans/utils/transcon.c
+++ b/mcstrans/utils/transcon.c
@@ -14,7 +14,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 }
 
 int main(int argc, char **argv) {
-	security_context_t scon;
+	char *scon;
 	if ( argc != 2 ) usage(argv[0]);
 	if (init_translations()==0) {
 		if(trans_context(argv[1],&scon) == 0) {
diff --git a/mcstrans/utils/untranscon.c b/mcstrans/utils/untranscon.c
index 85cea294..81668746 100644
--- a/mcstrans/utils/untranscon.c
+++ b/mcstrans/utils/untranscon.c
@@ -13,7 +13,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	exit(1);
 }
 int main(int argc, char **argv) {
-	security_context_t scon;
+	char *scon;
 	if ( argc != 2 ) usage(argv[0]);
 	if (init_translations()==0) {
 		if(untrans_context(argv[1],&scon) == 0) {
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index e70051b1..36e2ba9c 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -643,8 +643,8 @@ static int transition_to_caller_uid()
 #ifdef AUDIT_LOG_PRIV
 /* Send audit message */
 static
-int send_audit_message(int success, security_context_t old_context,
-		       security_context_t new_context, const char *ttyn)
+int send_audit_message(int success, const char *old_context,
+		       const char *new_context, const char *ttyn)
 {
 	char *msg = NULL;
 	int rc;
@@ -677,9 +677,9 @@ int send_audit_message(int success, security_context_t old_context,
 #else
 static inline
     int send_audit_message(int success __attribute__ ((unused)),
-			   security_context_t old_context
+			   const char *old_context
 			   __attribute__ ((unused)),
-			   security_context_t new_context
+			   const char *new_context
 			   __attribute__ ((unused)), const char *ttyn
 			   __attribute__ ((unused)))
 {
@@ -695,14 +695,14 @@ static inline
  * This function will not fail if it can not relabel the tty when selinux is
  * in permissive mode.
  */
-static int relabel_tty(const char *ttyn, security_context_t new_context,
-		       security_context_t * tty_context,
-		       security_context_t * new_tty_context)
+static int relabel_tty(const char *ttyn, const char *new_context,
+		       char **tty_context,
+		       char **new_tty_context)
 {
 	int fd, rc;
 	int enforcing = security_getenforce();
-	security_context_t tty_con = NULL;
-	security_context_t new_tty_con = NULL;
+	char *tty_con = NULL;
+	char *new_tty_con = NULL;
 
 	if (!ttyn)
 		return 0;
@@ -775,11 +775,11 @@ static int relabel_tty(const char *ttyn, security_context_t new_context,
  * Returns zero on success, non-zero otherwise
  */
 static int restore_tty_label(int fd, const char *ttyn,
-			     security_context_t tty_context,
-			     security_context_t new_tty_context)
+			     const char *tty_context,
+			     const char *new_tty_context)
 {
 	int rc = 0;
-	security_context_t chk_tty_context = NULL;
+	char *chk_tty_context = NULL;
 
 	if (!ttyn)
 		goto skip_relabel;
@@ -816,8 +816,8 @@ static int restore_tty_label(int fd, const char *ttyn,
  * Returns zero on success, non-zero otherwise.
  */
 static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
-					security_context_t old_context,
-					security_context_t * new_context,
+					const char *old_context,
+					char **new_context,
 					int *preserve_environment)
 {
 	int flag_index;		/* flag index in argv[] */
@@ -827,8 +827,8 @@ static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
 	char *type_ptr = NULL;	/* stores malloc'd data from get_default_type */
 	char *level_s = NULL;	/* level spec'd by user in argv[] */
 	char *range_ptr = NULL;
-	security_context_t new_con = NULL;
-	security_context_t tty_con = NULL;
+	char *new_con = NULL;
+	char *tty_con = NULL;
 	context_t context = NULL;	/* manipulatable form of new_context */
 	const struct option long_options[] = {
 		{"role", 1, 0, 'r'},
@@ -1021,10 +1021,10 @@ static int set_signal_handles(void)
 
 int main(int argc, char *argv[])
 {
-	security_context_t new_context = NULL;	/* target security context */
-	security_context_t old_context = NULL;	/* original securiy context */
-	security_context_t tty_context = NULL;	/* current context of tty */
-	security_context_t new_tty_context = NULL;	/* new context of tty */
+	char *new_context = NULL;	/* target security context */
+	char *old_context = NULL;	/* original securiy context */
+	char *tty_context = NULL;	/* current context of tty */
+	char *new_tty_context = NULL;	/* new context of tty */
 
 	struct passwd pw;	/* struct derived from passwd file line */
 	char *ttyn = NULL;	/* tty path */
diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index a007ce49..1c5eb68e 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -303,7 +303,7 @@ int authenticate_user(void)
  * out:		The CONTEXT associated with the context.
  * return:	0 on success, -1 on failure.
  */
-int get_init_context(security_context_t * context)
+int get_init_context(char **context)
 {
 
 	FILE *fp;
@@ -354,7 +354,7 @@ int main(int argc, char *argv[])
 
 	extern char *optarg;	/* used by getopt() for arg strings */
 	extern int opterr;	/* controls getopt() error messages */
-	security_context_t new_context;	/* context for the init script context  */
+	char *new_context;	/* context for the init script context  */
 
 #ifdef USE_NLS
 	setlocale(LC_ALL, "");
diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 477057a6..d257a9a1 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -341,7 +341,7 @@ static void cmd_line(int argc, char *argv[])
 		errx(EXIT_FAILURE, "SELinux is not enabled");
 }
 
-static int my_getXcon_raw(pid_t pid, security_context_t * con, const char *val)
+static int my_getXcon_raw(pid_t pid, char  **con, const char *val)
 {
 	char buf[4096];
 	FILE *fp = NULL;
@@ -371,23 +371,23 @@ static int my_getXcon_raw(pid_t pid, security_context_t * con, const char *val)
 	return (0);
 }
 
-static int my_getpidexeccon_raw(pid_t pid, security_context_t * con)
+static int my_getpidexeccon_raw(pid_t pid, char **con)
 {
 	return (my_getXcon_raw(pid, con, "exec"));
 }
-static int my_getpidfscreatecon_raw(pid_t pid, security_context_t * con)
+static int my_getpidfscreatecon_raw(pid_t pid, char **con)
 {
 	return (my_getXcon_raw(pid, con, "fscreate"));
 }
-static int my_getpidkeycreatecon_raw(pid_t pid, security_context_t * con)
+static int my_getpidkeycreatecon_raw(pid_t pid, char **con)
 {
 	return (my_getXcon_raw(pid, con, "keycreate"));
 }
 
-static security_context_t get_scon(void)
+static char *get_scon(void)
 {
 	static char dummy_NIL[1] = "";
-	security_context_t con = NULL, con_tmp;
+	char *con = NULL, *con_tmp;
 	int ret = -1;
 
 	switch (opts->from_type) {
@@ -620,9 +620,10 @@ static void disp__con_val(const char *name, const char *val,
 	done = TRUE;
 }
 
-static void disp_con(security_context_t scon_raw)
+static void disp_con(const char *scon_raw)
 {
-	security_context_t scon_trans, scon;
+	char *scon_trans;
+	const char *scon;
 	context_t con = NULL;
 	char *color_str = NULL;
 	struct context_color_t color = { .valid = 0 };
@@ -748,7 +749,7 @@ static void disp_con(security_context_t scon_raw)
 
 int main(int argc, char *argv[])
 {
-	security_context_t scon_raw = NULL;
+	char *scon_raw = NULL;
 
 	cmd_line(argc, argv);
 
diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 9707a456..d626e98d 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -431,13 +431,13 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
  * to clean it up.
  */
 static char *create_tmpdir(const char *src, struct stat *src_st,
-	struct stat *out_st, struct passwd *pwd, security_context_t execcon)
+	struct stat *out_st, struct passwd *pwd, const char *execcon)
 {
 	char *tmpdir = NULL;
 	char *cmdbuf = NULL;
 	int fd_t = -1, fd_s = -1;
 	struct stat tmp_st;
-	security_context_t con = NULL;
+	char *con = NULL;
 
 	/* get selinux context */
 	if (execcon) {
@@ -549,10 +549,10 @@ good:
 #define PROC_BASE "/proc"
 
 static int
-killall (security_context_t execcon)
+killall (const char *execcon)
 {
 	DIR *dir;
-	security_context_t scon;
+	char *scon;
 	struct dirent *de;
 	pid_t *pid_table, pid, self;
 	int i;
@@ -615,7 +615,7 @@ killall (security_context_t execcon)
 
 int main(int argc, char **argv) {
 	int status = -1;
-	security_context_t execcon = NULL;
+	const char *execcon = NULL;
 
 	int clflag;		/* holds codes for command line flags */
 	int kill_all = 0;
-- 
2.26.0.rc2

