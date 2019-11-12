Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B296C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 01:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F65E21925
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLBXk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:23:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbfKLBXk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 11 Nov 2019 20:23:40 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F8818B04A7D51A5DE76
        for <selinux@vger.kernel.org>; Tue, 12 Nov 2019 09:23:38 +0800 (CST)
Received: from DESKTOP-AMN0A62.china.huawei.com (10.67.101.91) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 09:23:33 +0800
From:   Baichuan Kong <kongbaichuan@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH] restorecond: Fix redundant console log output error
Date:   Tue, 12 Nov 2019 09:23:28 +0800
Message-ID: <20191112012328.2314-1-kongbaichuan@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.91]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: kong baichuan <kongbaichuan@huawei.com>

When starting restorecond without any option the following redundant
console log is outputed:

/dev/log 100.0%
/var/volatile/run/syslogd.pid 100.0%
...

This is caused by two global variables of same name r_opts. When
executes r_opts = opts in restore_init(), it originally intends
to assign the address of struct r_opts in "restorecond.c" to the
pointer *r_opts in "restore.c".

However, the address is assigned to the struct r_opts and covers
the value of low eight bytes in it. That causes unexpected value
of member varibale 'nochange' and 'verbose' in struct r_opts, thus
affects value of 'restorecon_flags' and executes unexpected operations
when restorecon the files such as the redundant console log output or
file label nochange.

Signed-off-by: kong baichuan <kongbaichuan@huawei.com>
---
 restorecond/restore.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/restorecond/restore.c b/restorecond/restore.c
index f6e30001..b93b5fdb 100644
--- a/restorecond/restore.c
+++ b/restorecond/restore.c
@@ -12,39 +12,36 @@
 char **exclude_list;
 int exclude_count;
 
-struct restore_opts *r_opts;
-
 void restore_init(struct restore_opts *opts)
 {
 	int rc;
 
-	r_opts = opts;
 	struct selinux_opt selinux_opts[] = {
-		{ SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
-		{ SELABEL_OPT_PATH, r_opts->selabel_opt_path },
-		{ SELABEL_OPT_DIGEST, r_opts->selabel_opt_digest }
+		{ SELABEL_OPT_VALIDATE, opts->selabel_opt_validate },
+		{ SELABEL_OPT_PATH, opts->selabel_opt_path },
+		{ SELABEL_OPT_DIGEST, opts->selabel_opt_digest }
 	};
 
-	r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
-	if (!r_opts->hnd) {
-		perror(r_opts->selabel_opt_path);
+	opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
+	if (!opts->hnd) {
+		perror(opts->selabel_opt_path);
 		exit(1);
 	}
 
-	r_opts->restorecon_flags = 0;
-	r_opts->restorecon_flags = r_opts->nochange | r_opts->verbose |
-			   r_opts->progress | r_opts->set_specctx  |
-			   r_opts->add_assoc | r_opts->ignore_digest |
-			   r_opts->recurse | r_opts->userealpath |
-			   r_opts->xdev | r_opts->abort_on_error |
-			   r_opts->syslog_changes | r_opts->log_matches |
-			   r_opts->ignore_noent | r_opts->ignore_mounts;
+	opts->restorecon_flags = 0;
+	opts->restorecon_flags = opts->nochange | opts->verbose |
+			   opts->progress | opts->set_specctx  |
+			   opts->add_assoc | opts->ignore_digest |
+			   opts->recurse | opts->userealpath |
+			   opts->xdev | opts->abort_on_error |
+			   opts->syslog_changes | opts->log_matches |
+			   opts->ignore_noent | opts->ignore_mounts;
 
 	/* Use setfiles, restorecon and restorecond own handles */
-	selinux_restorecon_set_sehandle(r_opts->hnd);
+	selinux_restorecon_set_sehandle(opts->hnd);
 
-	if (r_opts->rootpath) {
-		rc = selinux_restorecon_set_alt_rootpath(r_opts->rootpath);
+	if (opts->rootpath) {
+		rc = selinux_restorecon_set_alt_rootpath(opts->rootpath);
 		if (rc) {
 			fprintf(stderr,
 				"selinux_restorecon_set_alt_rootpath error: %s.\n",
@@ -75,7 +72,6 @@ int process_glob(char *name, struct restore_opts *opts)
 	size_t i = 0;
 	int len, rc, errors;
 
-	r_opts = opts;
 	memset(&globbuf, 0, sizeof(globbuf));
 
 	errors = glob(name, GLOB_TILDE | GLOB_PERIOD |
@@ -90,7 +86,7 @@ int process_glob(char *name, struct restore_opts *opts)
 		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
 			continue;
 		rc = selinux_restorecon(globbuf.gl_pathv[i],
-					r_opts->restorecon_flags);
+					opts->restorecon_flags);
 		if (rc < 0)
 			errors = rc;
 	}
-- 
2.23.0.windows.1


