Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA094C4360C
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BD9206C2
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfJHGxu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:53:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730131AbfJHGxu (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Oct 2019 02:53:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D0FB4023031
        for <selinux@vger.kernel.org>; Tue,  8 Oct 2019 06:45:18 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6441178BA;
        Tue,  8 Oct 2019 06:45:17 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 2/5] dispol: add an option for printing the command usage
Date:   Tue,  8 Oct 2019 15:44:57 +0900
Message-Id: <20191008064500.8651-4-yamato@redhat.com>
In-Reply-To: <20191008064500.8651-1-yamato@redhat.com>
References: <20191008064500.8651-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 08 Oct 2019 06:45:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 08 Oct 2019 06:45:18 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 1d9556f4..37b22cf8 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -39,7 +39,7 @@ static policydb_t policydb;
 static __attribute__((__noreturn__)) void usage(const char *progname,
 						int status)
 {
-	printf("usage:  %s binary_pol_file\n\n", progname);
+	printf("usage:  %s [-h] binary_pol_file\n\n", progname);
 	exit(status);
 }
 
@@ -395,7 +395,11 @@ int main(int argc, char **argv)
 	int state;
 	struct policy_file pf;
 
-	if (argc != 2)
+	if (argc <= 1)
+		usage(argv[0], 1);
+	else if (strcmp(argv[1], "-h") == 0)
+		usage(argv[0], 0);
+	else if (argc != 2)
 		usage(argv[0], 1);
 
 	fd = open(argv[1], O_RDONLY);
-- 
2.21.0

