Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F10DC7EE23
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 01:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjEaBda (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 May 2023 21:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEaBd3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 May 2023 21:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F7410B
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 18:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685496762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOqlpP3mjiZAe/MMxj39LhA3HTeZoIBDXrXmpg4cbL4=;
        b=dr/0lcYr4hddbPJ2Oe+sdk5yS/MKc61IWu5FPGC0kPRwt6ceNZrr1i4xAEeGlYvzZmod31
        FeRz+vG233Lru9shXioculhCDlpdLUlU2jn/mrFIfsxkzVJkAx2D43ulzmBjseVFvmxA3W
        zOPTD47iTaRNJP02C6jCH5vkc3uGwjA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-LdxDyqsoOUCLUhUy0V0wwA-1; Tue, 30 May 2023 21:32:40 -0400
X-MC-Unique: LdxDyqsoOUCLUhUy0V0wwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31A511C04B45
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 01:32:40 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D347140EBB8;
        Wed, 31 May 2023 01:32:39 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 4/4] dismod: add --actions option for non-interactive use
Date:   Wed, 31 May 2023 10:32:24 +0900
Message-Id: <20230531013224.1135775-4-yamato@redhat.com>
In-Reply-To: <20230531013224.1135775-1-yamato@redhat.com>
References: <20230531013224.1135775-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Example session:

    $ ./dismod --help
    Usage:
     ./dismod [OPTIONS] binary_pol_file

    Options:
     -h, --help              print this help message
     -a, --actions ACTIONS   run non-interactively

    Actions:
      1    display unconditional AVTAB
      2    display conditional AVTAB
      3    display users
      4    display bools
      5    display roles
      6    display types, attributes, and aliases
      7    display role transitions
      8    display role allows
      9    Display policycon
      0    Display initial SIDs
      a    Display avrule requirements
      b    Display avrule declarations
      c    Display policy capabilities
      u    Display the unknown handling setting
      F    Display filename_trans rules

    $ ./dismod --actions 16 input.mod
    Reading policy...
    libsepol.policydb_index_others: security:  0 users, 1 roles, 2 types, 0 bools
    libsepol.policydb_index_others: security: 0 sens, 0 cats
    libsepol.policydb_index_others: security:  1 classes, 0 rules, 0 cond rules
    libsepol.policydb_index_others: security:  0 users, 1 roles, 2 types, 0 bools
    libsepol.policydb_index_others: security: 0 sens, 0 cats
    libsepol.policydb_index_others: security:  1 classes, 0 rules, 0 cond rules
    Binary policy module file loaded.
    Module name: input
    Module version: 1.0.0
    Policy version: 21

    unconditional avtab:
    --- begin avrule block ---
    decl 1:
      allow [httpd_t] [http_port_t] : [tcp_socket] { name_bind };

     [http_port_t] [2]: type flags:0
     [httpd_t] [1]: type flags:0

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dismod.c | 115 +++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 32 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 3b81b1ce..515fc9a5 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -63,13 +63,57 @@ static const char *symbol_labels[9] = {
 	"levels ", "cats   ", "attribs"
 };
 
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
+	{CMD,       '1', "display unconditional AVTAB" },
+	{CMD,       '2', "display conditional AVTAB" },
+	{CMD,       '3', "display users" },
+	{CMD,       '4', "display bools" },
+	{CMD,       '5', "display roles" },
+	{CMD,       '6', "display types, attributes, and aliases" },
+	{CMD,       '7', "display role transitions" },
+	{CMD,       '8', "display role allows" },
+	{CMD,       '9', "Display policycon" },
+	{CMD,       '0', "Display initial SIDs" },
+	{HEADER, 0, ""},
+	{CMD,       'a', "Display avrule requirements"},
+	{CMD,       'b', "Display avrule declarations"},
+	{CMD,       'c', "Display policy capabilities"},
+	{CMD|NOOPT, 'l', "Link in a module"},
+	{CMD,       'u', "Display the unknown handling setting"},
+	{CMD,       'F', "Display filename_trans rules"},
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
-	puts(" -h, --help	print this help message");
-	puts("\n");
+	puts(" -h, --help              print this help message");
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
 
@@ -845,46 +889,46 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 
 static int menu(void)
 {
-	printf("\nSelect a command:\n");
-	printf("1)  display unconditional AVTAB\n");
-	printf("2)  display conditional AVTAB\n");
-	printf("3)  display users\n");
-	printf("4)  display bools\n");
-	printf("5)  display roles\n");
-	printf("6)  display types, attributes, and aliases\n");
-	printf("7)  display role transitions\n");
-	printf("8)  display role allows\n");
-	printf("9)  Display policycon\n");
-	printf("0)  Display initial SIDs\n");
-	printf("\n");
-	printf("a)  Display avrule requirements\n");
-	printf("b)  Display avrule declarations\n");
-	printf("c)  Display policy capabilities\n");
-	printf("l)  Link in a module\n");
-	printf("u)  Display the unknown handling setting\n");
-	printf("F)  Display filename_trans rules\n");
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
+	char *mod;
 	FILE *out_fp = stdout;
 	char ans[81], OutfileName[121];
 
 	if (argc < 2 || strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
 		usage(argv[0]);
 
+	mod = argv[1];
+	if (strcmp (mod, "--actions") == 0 || strcmp (mod, "-a") == 0) {
+		if (argc != 4) {
+			fprintf(stderr, "%s: unexpected number of arguments\n", argv[0]);
+			usage(argv[0]);
+		}
+		ops = argv[2];
+		mod = argv[3];
+	} else if (mod[0] == '-') {
+		fprintf(stderr, "%s: unknown option: %s\n", argv[0], mod);
+		usage(argv[0]);
+	}
+
 	/* read the binary policy */
 	fprintf(out_fp, "Reading policy...\n");
 	if (policydb_init(&policydb)) {
 		fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
 		exit(1);
 	}
-	if (read_policy(argv[1], &policydb)) {
+	if (read_policy(mod, &policydb)) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while loading policy\n",
 			argv[0]);
@@ -917,15 +961,22 @@ int main(int argc, char **argv)
 	}
 
 	printf("Policy version: %d\n\n", policydb.policyvers);
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

