Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D86FC77B7A
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 01:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjEaBdW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 May 2023 21:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEaBdV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 May 2023 21:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2268CF9
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 18:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685496755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=STXLjgF5rJJ/4dh75acSaEa2oIx0a5P3U05iqmckWH0=;
        b=QxiFUnbZK1pN0vixPbZYhDDV6vi6NC/4UTA93Su4DsVUVcXGZ6gjyGaFM9HAfE2hqyH690
        NOPcvlzF2sFHvasftBrmOhWKSvR54N/ivneWqTOOsVCjrWlxw5opQOR0pSLiowfEfrwYpf
        8EecEKNYq7gNE5qGN3YQ/dyqcJgeUII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-REn2fJ9VNh-finzt47WByQ-1; Tue, 30 May 2023 21:32:33 -0400
X-MC-Unique: REn2fJ9VNh-finzt47WByQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF33B85A5B5
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 01:32:32 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 178D0140EBB8;
        Wed, 31 May 2023 01:32:31 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 1/4] dismod: add --help option
Date:   Wed, 31 May 2023 10:32:21 +0900
Message-Id: <20230531013224.1135775-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dismod.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 929ee308..eb090a36 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -66,7 +66,11 @@ static const char *symbol_labels[9] = {
 
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
-	printf("usage:  %s binary_pol_file\n\n", progname);
+	puts("Usage:");
+	printf(" %s [OPTIONS] binary_pol_file\n\n", progname);
+	puts("Options:");
+	puts(" -h, --help	print this help message");
+	puts("\n");
 	exit(1);
 }
 
@@ -872,7 +876,7 @@ int main(int argc, char **argv)
 	FILE *out_fp = stdout;
 	char ans[81], OutfileName[121];
 
-	if (argc != 2)
+	if (argc < 2 || strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
 		usage(argv[0]);
 
 	/* read the binary policy */
-- 
2.40.1

