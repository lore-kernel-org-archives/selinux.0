Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD0C10F14
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DCD206C2
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfJHGyM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:54:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730131AbfJHGyL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Oct 2019 02:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95FFA405C64A
        for <selinux@vger.kernel.org>; Tue,  8 Oct 2019 06:45:16 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEF33178BA;
        Tue,  8 Oct 2019 06:45:15 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 1/5] dispol: extend usage() to take exit status
Date:   Tue,  8 Oct 2019 15:44:56 +0900
Message-Id: <20191008064500.8651-3-yamato@redhat.com>
In-Reply-To: <20191008064500.8651-1-yamato@redhat.com>
References: <20191008064500.8651-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 08 Oct 2019 06:45:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 08 Oct 2019 06:45:16 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index d72d9fb3..6c4829c4 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -36,10 +36,10 @@
 
 static policydb_t policydb;
 
-static __attribute__((__noreturn__)) void usage(const char *progname)
+static __attribute__((__noreturn__)) void usage(const char *progname, int status)
 {
 	printf("usage:  %s binary_pol_file\n\n", progname);
-	exit(1);
+	exit(status);
 }
 
 int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
@@ -395,7 +395,7 @@ int main(int argc, char **argv)
 	struct policy_file pf;
 
 	if (argc != 2)
-		usage(argv[0]);
+		usage(argv[0], 1);
 
 	fd = open(argv[1], O_RDONLY);
 	if (fd < 0) {
-- 
2.21.0

