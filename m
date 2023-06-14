Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1856EB64D8
	for <selinux@archiver.kernel.org>; Wed, 14 Jun 2023 19:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjFNTR7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFNTR6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jun 2023 15:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A491BFD
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686770229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MtgdPFTTuWZpD8ascBh2aBgWZM9/5TnqFbNkFFW+L7A=;
        b=J2I0XCrlSw8qshB4oQqAisH8xQ6tEk8g+UrDeTD6TJ2A+6SxR/foTS0NwCp05euFrri8c7
        ofV35uBmJEaTnx8uXUhhSxmSVW5MegYt3nTyY9bdJnPefxtNouMB3iV/ZX+W2ZJwBvjb+u
        J4mzxMTtR8bH9XrU+57FY4brQ9aSAIQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-zS5_EaFmNYqrdPDB7jEEdw-1; Wed, 14 Jun 2023 15:17:08 -0400
X-MC-Unique: zS5_EaFmNYqrdPDB7jEEdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCDB71C0513B
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 19:17:07 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 249F740C20F4;
        Wed, 14 Jun 2023 19:17:06 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH v2 1/2] dismod: print the policy version only in interactive mode
Date:   Thu, 15 Jun 2023 04:16:57 +0900
Message-Id: <20230614191658.3356192-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Instead, a new action, 'v' for printing the policy (and/or
module) version in batch mode is added.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dismod.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 515fc9a5..fa729ef2 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -91,6 +91,7 @@ static struct command {
 	{CMD|NOOPT, 'l', "Link in a module"},
 	{CMD,       'u', "Display the unknown handling setting"},
 	{CMD,       'F', "Display filename_trans rules"},
+	{CMD,       'v', "display the version of policy and/or module"},
 	{HEADER, 0, ""},
 	{CMD|NOOPT, 'f',  "set output file"},
 	{CMD|NOOPT, 'm',  "display menu"},
@@ -899,6 +900,19 @@ static int menu(void)
 	return 0;
 }
 
+static void print_version_info(policydb_t * p, FILE * fp)
+{
+	if (p->policy_type == POLICY_BASE) {
+		fprintf(fp, "Binary base policy file loaded.\n");
+	} else {
+		fprintf(fp, "Binary policy module file loaded.\n");
+		fprintf(fp, "Module name: %s\n", p->name);
+		fprintf(fp, "Module version: %s\n", p->version);
+	}
+
+	fprintf(fp, "Policy version: %d\n\n", p->policyvers);
+}
+
 int main(int argc, char **argv)
 {
 	char *ops = NULL;
@@ -952,17 +966,10 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	if (policydb.policy_type == POLICY_BASE) {
-		printf("Binary base policy file loaded.\n");
-	} else {
-		printf("Binary policy module file loaded.\n");
-		printf("Module name: %s\n", policydb.name);
-		printf("Module version: %s\n", policydb.version);
-	}
-
-	printf("Policy version: %d\n\n", policydb.policyvers);
-	if (!ops)
+	if (!ops) {
+		print_version_info(&policydb, stdout);
 		menu();
+	}
 	for (;;) {
 		if (ops) {
 			puts("");
@@ -1069,6 +1076,9 @@ int main(int argc, char **argv)
 		case 'l':
 			link_module(&policydb, out_fp);
 			break;
+		case 'v':
+			print_version_info(&policydb, out_fp);
+			break;
 		case 'q':
 			policydb_destroy(&policydb);
 			exit(0);
-- 
2.40.1

