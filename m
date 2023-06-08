Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F0C7EE2F
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 01:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFHBxl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 21:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFHBxk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 21:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1C2682
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686189172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OFq59jc9NksBjDyJXXa0XJFnrvuOdE81wt7jWfFrVKo=;
        b=jB7CqYbj8r1qK/Age/cBwsprtVa0doX+GvtfRfAfysGZdb1kwGyz5Nzb2Lh2pshUx/W4zc
        5EjVvcC4m1A5asBw2JBxqB1QcSNXivB9Svb/7LLRcBu3QrwpTBYmzmdLlG80H4TFOMBEnV
        4XyzlNO3XSXvI4H/Sq6ejU09k5vqsUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-J1P6oxFZPk-Qsdape85bdQ-1; Wed, 07 Jun 2023 21:52:50 -0400
X-MC-Unique: J1P6oxFZPk-Qsdape85bdQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CA998002BF
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 01:52:50 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4900403362;
        Thu,  8 Jun 2023 01:52:49 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 1/4] dispol: add --help option
Date:   Thu,  8 Jun 2023 10:52:38 +0900
Message-Id: <20230608015241.2454912-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index b61f1b4b..50027e40 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -38,7 +38,11 @@ static policydb_t policydb;
 
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
-	printf("usage:  %s binary_pol_file\n\n", progname);
+	puts("Usage:");
+	printf(" %s [OPTIONS] binary_pol_file\n\n", progname);
+	puts("Options:");
+	puts(" -h, --help   print this help message");
+	puts("\n");
 	exit(1);
 }
 
@@ -481,7 +485,7 @@ int main(int argc, char **argv)
 	int state;
 	struct policy_file pf;
 
-	if (argc != 2)
+	if (argc < 2 || strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
 		usage(argv[0]);
 
 	fd = open(argv[1], O_RDONLY);
-- 
2.40.1

