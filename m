Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56451C10F14
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393B9206C2
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfJHGy2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:54:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730140AbfJHGy2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Oct 2019 02:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 450424074C88
        for <selinux@vger.kernel.org>; Tue,  8 Oct 2019 06:45:23 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2D6178BF;
        Tue,  8 Oct 2019 06:45:22 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 4/5] dispol: introduce -b option to run commands in batch
Date:   Tue,  8 Oct 2019 15:44:59 +0900
Message-Id: <20191008064500.8651-6-yamato@redhat.com>
In-Reply-To: <20191008064500.8651-1-yamato@redhat.com>
References: <20191008064500.8651-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 08 Oct 2019 06:45:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 08 Oct 2019 06:45:23 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

dispol command requires interaction. It not suitable for using
in a script. This change introduces -b that is for running
dispol in non-interactively.

An example:

    $ ./dispol -b 1 /sys/fs/selinux/policy
    allow deltacloudd_log_t tmp_t : filesystem { associate };
    allow kern_unconfined sysctl_type : lnk_file { ioctl read ...
    ...

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 49 ++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 26bbba7a..0eaa830a 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -39,7 +39,7 @@ static policydb_t policydb;
 static __attribute__((__noreturn__)) void usage(const char *progname,
 						int status)
 {
-	printf("usage:  %s [-h] binary_pol_file\n\n", progname);
+	printf("usage:  %s [-h] [-b cmds] binary_pol_file\n\n", progname);
 	exit(status);
 }
 
@@ -395,14 +395,21 @@ int main(int argc, char **argv)
 	int state;
 	struct policy_file pf;
 	char *pf_name;
+	char *cmds = NULL;
 
 	if (argc <= 1)
 		usage(argv[0], 1);
 	else if (strcmp(argv[1], "-h") == 0)
 		usage(argv[0], 0);
-	else if (argc != 2)
+	else if (strcmp(argv[1], "-b") == 0) {
+		if (argc != 4)
+			usage(argv[0], 1);
+		cmds = argv[2];
+		pf_name = argv[3];
+	} else if (argc == 2)
+		pf_name = argv[1];
+	else
 		usage(argv[0], 1);
-	pf_name = argv[1];
 
 	fd = open(pf_name, O_RDONLY);
 	if (fd < 0) {
@@ -424,7 +431,8 @@ int main(int argc, char **argv)
 	}
 
 	/* read the binary policy */
-	fprintf(out_fp, "Reading policy...\n");
+	if (!cmds)
+		fprintf(out_fp, "Reading policy...\n");
 	policy_file_init(&pf);
 	pf.type = PF_USE_MEMORY;
 	pf.data = map;
@@ -433,7 +441,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
 		exit(1);
 	}
-	ret = policydb_read(&policydb, &pf, 1);
+	ret = policydb_read(&policydb, &pf, cmds == NULL);
 	if (ret) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while parsing configuration\n",
@@ -441,16 +449,30 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	fprintf(stdout, "binary policy file loaded\n\n");
+	if (!cmds)
+		fprintf(stdout, "binary policy file loaded\n\n");
 	close(fd);
 
-	menu();
+	if (!cmds)
+		menu();
 	for (;;) {
-		printf("\nCommand (\'m\' for menu):  ");
-		if (fgets(ans, sizeof(ans), stdin) == NULL) {
-			fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+		if (cmds) {
+			ans[0] = *cmds++;
+			if (ans[0] == '\0')
+				ans[0] = 'q';
+			else if (strchr("7fm", ans[0])) {
+				fprintf(stderr,
+					"Unacceptable command in batch mode: %c\n",
+					ans[0]);
+				exit(1);
+			}
+		} else {
+			printf("\nCommand (\'m\' for menu):  ");
+			if (fgets(ans, sizeof(ans), stdin) == NULL) {
+				fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
 					strerror(errno));
-			continue;
+				continue;
+			}
 		}
 		switch (ans[0]) {
 
@@ -551,6 +573,11 @@ int main(int argc, char **argv)
 			menu();
 			break;
 		default:
+			if (cmds) {
+				fprintf(stderr,
+					"Invalid command: %c\n", ans[0]);
+				exit(1);
+			}
 			printf("\nInvalid choice\n");
 			menu();
 			break;
-- 
2.21.0

