Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B1EB64D9
	for <selinux@archiver.kernel.org>; Wed, 14 Jun 2023 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjFNTR6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFNTR5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jun 2023 15:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5E2135
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686770233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8FoVNRMNoFDOCOGiSQ2u+JfDEqIuYt2CvWQpnsLwnc=;
        b=D/65zJgZNNaLZdm8arXYWQd1jp3c4qCE2KxRPwnxXIY/SorBzA8Y7KvezJ6YwQ8/PzbndW
        5TyFLPor5IYhHoQW2UQj/39OjMNC9LX3/OX/XINyx2+c74/pRDNBMcWxhIW4CEexAneJ6x
        jPNh08CGO0iOXHRKyyklezcfba+G0Ag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-i9DIBidVPS2zFgM_2hdfrA-1; Wed, 14 Jun 2023 15:17:10 -0400
X-MC-Unique: i9DIBidVPS2zFgM_2hdfrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A079E80067D
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 19:17:10 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC51E40C20F4;
        Wed, 14 Jun 2023 19:17:09 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH v2 2/2] dismod, dispol: reduce the messages in batch mode
Date:   Thu, 15 Jun 2023 04:16:58 +0900
Message-Id: <20230614191658.3356192-2-yamato@redhat.com>
In-Reply-To: <20230614191658.3356192-1-yamato@redhat.com>
References: <20230614191658.3356192-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A change in v2:
* pass `verbose' to sepol_module_package_read().

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dismod.c | 22 ++++++++++++----------
 checkpolicy/test/dispol.c |  8 +++++---
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index fa729ef2..3f095da7 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -773,7 +773,7 @@ static int display_handle_unknown(policydb_t * p, FILE * out_fp)
 	return 0;
 }
 
-static int read_policy(char *filename, policydb_t * policy)
+static int read_policy(char *filename, policydb_t * policy, int verbose)
 {
 	FILE *in_fp;
 	struct policy_file f;
@@ -808,7 +808,7 @@ static int read_policy(char *filename, policydb_t * policy)
 		package->file_contexts = NULL;
 		retval =
 		    sepol_module_package_read(package,
-					      (sepol_policy_file_t *) & f, 1);
+					      (sepol_policy_file_t *) & f, verbose);
 		package->policy = NULL;
 		sepol_module_package_free(package);
 	} else {
@@ -816,13 +816,13 @@ static int read_policy(char *filename, policydb_t * policy)
 			fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
 			exit(1);
 		}
-		retval = policydb_read(policy, &f, 1);
+		retval = policydb_read(policy, &f, verbose);
 	}
 	fclose(in_fp);
 	return retval;
 }
 
-static void link_module(policydb_t * base, FILE * out_fp)
+static void link_module(policydb_t * base, FILE * out_fp, int verbose)
 {
 	char module_name[80] = { 0 };
 	int ret;
@@ -845,8 +845,9 @@ static void link_module(policydb_t * base, FILE * out_fp)
 	}
 
 	/* read the binary policy */
-	fprintf(out_fp, "Reading module...\n");
-	if (read_policy(module_name, mods)) {
+	if (verbose)
+		fprintf(out_fp, "Reading module...\n");
+	if (read_policy(module_name, mods, verbose)) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while loading policy\n",
 			module_name);
@@ -937,12 +938,13 @@ int main(int argc, char **argv)
 	}
 
 	/* read the binary policy */
-	fprintf(out_fp, "Reading policy...\n");
+	if (!ops)
+		fprintf(out_fp, "Reading policy...\n");
 	if (policydb_init(&policydb)) {
 		fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
 		exit(1);
 	}
-	if (read_policy(mod, &policydb)) {
+	if (read_policy(mod, &policydb, ops? 0: 1)) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while loading policy\n",
 			argv[0]);
@@ -961,7 +963,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	if (policydb_index_others(NULL, &policydb, 1)) {
+	if (policydb_index_others(NULL, &policydb, ops? 0: 1)) {
 		fprintf(stderr, "Error indexing others\n");
 		exit(1);
 	}
@@ -1074,7 +1076,7 @@ int main(int argc, char **argv)
 					&policydb, out_fp);
 			break;
 		case 'l':
-			link_module(&policydb, out_fp);
+			link_module(&policydb, out_fp, ops? 0: 1);
 			break;
 		case 'v':
 			print_version_info(&policydb, out_fp);
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index bee1a660..b567ce77 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -551,7 +551,8 @@ int main(int argc, char **argv)
 	}
 
 	/* read the binary policy */
-	fprintf(out_fp, "Reading policy...\n");
+	if (!ops)
+		fprintf(out_fp, "Reading policy...\n");
 	policy_file_init(&pf);
 	pf.type = PF_USE_MEMORY;
 	pf.data = map;
@@ -560,7 +561,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
 		exit(1);
 	}
-	ret = policydb_read(&policydb, &pf, 1);
+	ret = policydb_read(&policydb, &pf, ops? 0: 1);
 	if (ret) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while parsing configuration\n",
@@ -568,7 +569,8 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	fprintf(stdout, "binary policy file loaded\n\n");
+	if (!ops)
+		fprintf(stdout, "binary policy file loaded\n\n");
 	close(fd);
 
 	if (!ops)
-- 
2.40.1

