Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF26C7EE29
	for <selinux@archiver.kernel.org>; Tue, 13 Jun 2023 10:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbjFMKp1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jun 2023 06:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbjFMKp0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jun 2023 06:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DF92
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686653084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MtgdPFTTuWZpD8ascBh2aBgWZM9/5TnqFbNkFFW+L7A=;
        b=RRGjVMmaNUR5nWne+VdBQ+HHkpQXQuq+fhRgO8s6jke/JVFe/dW4Xt70jkiqPj6+pnqNYx
        eV+G6+8d22UsEqwtDHkpiooyzLTOIrMSVaGgLF4/2Mp3noxFsxB33l9IJ8J2GeuKuOLIlA
        W2SwkX19wrTGaMJ44dBtCTgE/N1mH2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-YC7uA4VgNUeirxxwwyrETA-1; Tue, 13 Jun 2023 06:44:42 -0400
X-MC-Unique: YC7uA4VgNUeirxxwwyrETA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A75F8185A78F
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 10:44:42 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002C71121314;
        Tue, 13 Jun 2023 10:44:41 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 1/2] dismod: print the policy version only in interactive mode
Date:   Tue, 13 Jun 2023 19:44:38 +0900
Message-Id: <20230613104439.2985001-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

