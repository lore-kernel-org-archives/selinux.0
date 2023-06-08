Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D939C7EE43
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjFHBxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjFHBxk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 21:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF5926A6
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 18:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686189179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcGiQpYrRy/XVGAXvo0YsNFJOTeHq8ZyEf8+W8MQ4CY=;
        b=GDHb1xq3OwOljybDw2Oj3kcaSQd34jA5jODpvQPxXlkiYZh/VozXc1g6AgTrvD/qsGyVQI
        lo9XhJ+YvJMMOpxP4PxZhrTZ4I6xrltnCj7hQDu2abUFd96jU/gaHkix2edtTQJDA7yxKp
        pGmy/31bLQAsvg0Oek2pCE8vU7zNTo0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-bVuOd7t6N3GWrdXFweqFLQ-1; Wed, 07 Jun 2023 21:52:58 -0400
X-MC-Unique: bVuOd7t6N3GWrdXFweqFLQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEF8029AB3E1
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 01:52:57 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4791D403362;
        Thu,  8 Jun 2023 01:52:57 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 4/4] dispol: add --actions option for non-interactive use
Date:   Thu,  8 Jun 2023 10:52:41 +0900
Message-Id: <20230608015241.2454912-4-yamato@redhat.com>
In-Reply-To: <20230608015241.2454912-1-yamato@redhat.com>
References: <20230608015241.2454912-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Example session:

    $ ./dispol --help
    Usage:
     ./dismod [OPTIONS] binary_pol_file

    Options:
     -h, --help              print this help message
     -a, --actions ACTIONS   run non-interactively

    Actions:
      1    display unconditional AVTAB
      2    display conditional AVTAB (entirely)
      3    display conditional AVTAB (only ENABLED rules)
      4    display conditional AVTAB (only DISABLED rules)
      5    display conditional bools
      6    display conditional expressions
      8    display role transitions
      c    display policy capabilities
      b    display booleans
      C    display classes
      r    display roles
      t    display types
      a    display type attributes
      p    display the list of permissive types
      u    display unknown handling setting
      F    display filename_trans rules

    $ ./dispol --actions 1 /etc/selinux/targeted/policy/policy.33  | head
    Reading policy...
    libsepol.policydb_index_others: security:  8 users, 15 roles, 5408 types, 358 bools
    libsepol.policydb_index_others: security: 1 sens, 1024 cats
    libsepol.policydb_index_others: security:  134 classes, 86750 rules, 8818 cond rules
    binary policy file loaded

    allow abrt_dump_oops_t sssd_var_lib_t : sock_file { write getattr append open };
    type_transition authconfig_t entropyd_initrc_exec_t : process initrc_t;
    type_transition glusterd_t syslogd_initrc_exec_t : process initrc_t;xxxx

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 121 +++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 35 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index e1f6d7fc..bee1a660 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -35,13 +35,58 @@
 
 static policydb_t policydb;
 
+static struct command {
+	enum {
+		EOL    = 0,
+		HEADER = 1,
+		CMD    = 1 << 1,
+		NOOPT  = 1 << 2,
+	} meta;
+	char cmd;
+	const char *desc;
+} commands[] = {
+	{HEADER, 0, "\nSelect a command:"},
+	{CMD,       '1',  "display unconditional AVTAB" },
+	{CMD,       '2',  "display conditional AVTAB (entirely)"},
+	{CMD,       '3',  "display conditional AVTAB (only ENABLED rules)"},
+	{CMD,       '4',  "display conditional AVTAB (only DISABLED rules)"},
+	{CMD,       '5',  "display conditional bools"},
+	{CMD,       '6',  "display conditional expressions"},
+	{CMD|NOOPT, '7',  "change a boolean value"},
+	{CMD,       '8',  "display role transitions"},
+	{HEADER, 0, ""},
+	{CMD,       'c',  "display policy capabilities"},
+	{CMD,       'b',  "display booleans"},
+	{CMD,       'C',  "display classes"},
+	{CMD,       'r',  "display roles"},
+	{CMD,       't',  "display types"},
+	{CMD,       'a',  "display type attributes"},
+	{CMD,       'p',  "display the list of permissive types"},
+	{CMD,       'u',  "display unknown handling setting"},
+	{CMD,       'F',  "display filename_trans rules"},
+	{HEADER, 0, ""},
+	{CMD|NOOPT, 'f',  "set output file"},
+	{CMD|NOOPT, 'm',  "display menu"},
+	{CMD|NOOPT, 'q',  "quit"},
+	{EOL,   0, "" },
+};
+
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	puts("Usage:");
 	printf(" %s [OPTIONS] binary_pol_file\n\n", progname);
 	puts("Options:");
 	puts(" -h, --help   print this help message");
-	puts("\n");
+	puts(" -a, --actions ACTIONS   run non-interactively");
+	puts("");
+	puts("Actions:");
+	for (unsigned int i = 0; commands[i].meta != EOL; i++) {
+		if (commands[i].meta == HEADER
+		    || commands[i].meta & NOOPT)
+			continue;
+		printf("  %c    %s\n", commands[i].cmd, commands[i].desc);
+	}
+	puts("");
 	exit(1);
 }
 
@@ -447,34 +492,20 @@ static void display_filename_trans(policydb_t *p, FILE *fp)
 
 static int menu(void)
 {
-	printf("\nSelect a command:\n");
-	printf("1)  display unconditional AVTAB\n");
-	printf("2)  display conditional AVTAB (entirely)\n");
-	printf("3)  display conditional AVTAB (only ENABLED rules)\n");
-	printf("4)  display conditional AVTAB (only DISABLED rules)\n");
-	printf("5)  display conditional bools\n");
-	printf("6)  display conditional expressions\n");
-	printf("7)  change a boolean value\n");
-	printf("8)  display role transitions\n");
-	printf("\n");
-	printf("c)  display policy capabilities\n");
-	printf("b)  display booleans\n");
-	printf("C)  display classes\n");
-	printf("r)  display roles\n");
-	printf("t)  display types\n");
-	printf("a)  display type attributes\n");
-	printf("p)  display the list of permissive types\n");
-	printf("u)  display unknown handling setting\n");
-	printf("F)  display filename_trans rules\n");
-	printf("\n");
-	printf("f)  set output file\n");
-	printf("m)  display menu\n");
-	printf("q)  quit\n");
+	unsigned int i;
+	for (i = 0; commands[i].meta != EOL; i++) {
+		if (commands[i].meta == HEADER)
+			printf("%s\n", commands[i].desc);
+		else if (commands[i].meta & CMD)
+			printf("%c) %s\n", commands[i].cmd, commands[i].desc);
+	}
 	return 0;
 }
 
 int main(int argc, char **argv)
 {
+	char *ops = NULL;
+	char *bpol;
 	FILE *out_fp = stdout;
 	char ans[81], OutfileName[121];
 	int fd, ret;
@@ -487,22 +518,35 @@ int main(int argc, char **argv)
 	if (argc < 2 || strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
 		usage(argv[0]);
 
-	fd = open(argv[1], O_RDONLY);
+	bpol = argv[1];
+	if (strcmp (bpol, "--actions") == 0 || strcmp (bpol, "-a") == 0) {
+		if (argc != 4) {
+			fprintf(stderr, "%s: unexpected number of arguments\n", argv[0]);
+			usage(argv[0]);
+		}
+		ops = argv[2];
+		bpol = argv[3];
+	} else if (bpol[0] == '-') {
+		fprintf(stderr, "%s: unknown option: %s\n", argv[0], bpol);
+		usage(argv[0]);
+	}
+
+	fd = open(bpol, O_RDONLY);
 	if (fd < 0) {
 		fprintf(stderr, "Can't open '%s':  %s\n",
-			argv[1], strerror(errno));
+			bpol, strerror(errno));
 		exit(1);
 	}
 	if (fstat(fd, &sb) < 0) {
 		fprintf(stderr, "Can't stat '%s':  %s\n",
-			argv[1], strerror(errno));
+			bpol, strerror(errno));
 		exit(1);
 	}
 	map =
 	    mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED) {
 		fprintf(stderr, "Can't map '%s':  %s\n",
-			argv[1], strerror(errno));
+			bpol, strerror(errno));
 		exit(1);
 	}
 
@@ -527,15 +571,22 @@ int main(int argc, char **argv)
 	fprintf(stdout, "binary policy file loaded\n\n");
 	close(fd);
 
-	menu();
+	if (!ops)
+		menu();
 	for (;;) {
-		printf("\nCommand (\'m\' for menu):  ");
-		if (fgets(ans, sizeof(ans), stdin) == NULL) {
-			if (feof(stdin))
-				break;
-			fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+		if (ops) {
+			puts("");
+			ans[0] = *ops? *ops++: 'q';
+			ans[1] = '\0';
+		} else {
+			printf("\nCommand (\'m\' for menu):  ");
+			if (fgets(ans, sizeof(ans), stdin) == NULL) {
+				if (feof(stdin))
+					break;
+				fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
 					strerror(errno));
-			continue;
+				continue;
+			}
 		}
 		switch (ans[0]) {
 
-- 
2.40.1

