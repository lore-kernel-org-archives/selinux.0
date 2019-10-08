Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40C1C10F14
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4B5206C2
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfJHGxu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:53:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730129AbfJHGxt (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Oct 2019 02:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51B294023035
        for <selinux@vger.kernel.org>; Tue,  8 Oct 2019 06:45:25 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83BB2178BA;
        Tue,  8 Oct 2019 06:45:24 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 5/5] dispol: add the list of commands for batch mode to help message
Date:   Tue,  8 Oct 2019 15:45:00 +0900
Message-Id: <20191008064500.8651-7-yamato@redhat.com>
In-Reply-To: <20191008064500.8651-1-yamato@redhat.com>
References: <20191008064500.8651-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 08 Oct 2019 06:45:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 08 Oct 2019 06:45:25 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 0eaa830a..f6e6a26a 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -36,10 +36,14 @@
 
 static policydb_t policydb;
 
+int menu(int interactive);
+
 static __attribute__((__noreturn__)) void usage(const char *progname,
 						int status)
 {
 	printf("usage:  %s [-h] [-b cmds] binary_pol_file\n\n", progname);
+	printf("acceptable commands for -b option:\n");
+	menu(0);
 	exit(status);
 }
 
@@ -361,25 +365,30 @@ static void display_filename_trans(policydb_t *p, FILE *fp)
 	hashtab_map(p->filename_trans, filenametr_display, &args);
 }
 
-int menu(void)
+int menu(int interactive)
 {
-	printf("\nSelect a command:\n");
+	if (interactive)
+		printf("\nSelect a command:\n");
 	printf("1)  display unconditional AVTAB\n");
 	printf("2)  display conditional AVTAB (entirely)\n");
 	printf("3)  display conditional AVTAB (only ENABLED rules)\n");
 	printf("4)  display conditional AVTAB (only DISABLED rules)\n");
 	printf("5)  display conditional bools\n");
 	printf("6)  display conditional expressions\n");
-	printf("7)  change a boolean value\n");
+	if (interactive)
+		printf("7)  change a boolean value\n");
 	printf("8)  display role transitions\n");
-	printf("\n");
+	if (interactive)
+		printf("\n");
 	printf("c)  display policy capabilities\n");
 	printf("p)  display the list of permissive types\n");
 	printf("u)  display unknown handling setting\n");
 	printf("F)  display filename_trans rules\n");
-	printf("\n");
-	printf("f)  set output file\n");
-	printf("m)  display menu\n");
+	if (interactive) {
+		printf("\n");
+		printf("f)  set output file\n");
+		printf("m)  display menu\n");
+	}
 	printf("q)  quit\n");
 	return 0;
 }
@@ -454,7 +463,7 @@ int main(int argc, char **argv)
 	close(fd);
 
 	if (!cmds)
-		menu();
+		menu(cmds == NULL);
 	for (;;) {
 		if (cmds) {
 			ans[0] = *cmds++;
@@ -570,7 +579,7 @@ int main(int argc, char **argv)
 			exit(0);
 			break;
 		case 'm':
-			menu();
+			menu(1);
 			break;
 		default:
 			if (cmds) {
@@ -579,7 +588,7 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			printf("\nInvalid choice\n");
-			menu();
+			menu(1);
 			break;
 
 		}
-- 
2.21.0

