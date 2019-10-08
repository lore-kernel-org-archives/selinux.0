Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1BC4360C
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AD1206C2
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 06:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfJHGy6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:54:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730054AbfJHGy6 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Oct 2019 02:54:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9ABE3804BBA5
        for <selinux@vger.kernel.org>; Tue,  8 Oct 2019 06:45:20 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D41C6178BA;
        Tue,  8 Oct 2019 06:45:19 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 3/5] dispol: introduce a local variable representing the input file
Date:   Tue,  8 Oct 2019 15:44:58 +0900
Message-Id: <20191008064500.8651-5-yamato@redhat.com>
In-Reply-To: <20191008064500.8651-1-yamato@redhat.com>
References: <20191008064500.8651-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 08 Oct 2019 06:45:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 08 Oct 2019 06:45:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 37b22cf8..26bbba7a 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -394,6 +394,7 @@ int main(int argc, char **argv)
 	char *name;
 	int state;
 	struct policy_file pf;
+	char *pf_name;
 
 	if (argc <= 1)
 		usage(argv[0], 1);
@@ -401,23 +402,24 @@ int main(int argc, char **argv)
 		usage(argv[0], 0);
 	else if (argc != 2)
 		usage(argv[0], 1);
+	pf_name = argv[1];
 
-	fd = open(argv[1], O_RDONLY);
+	fd = open(pf_name, O_RDONLY);
 	if (fd < 0) {
 		fprintf(stderr, "Can't open '%s':  %s\n",
-			argv[1], strerror(errno));
+			pf_name, strerror(errno));
 		exit(1);
 	}
 	if (fstat(fd, &sb) < 0) {
 		fprintf(stderr, "Can't stat '%s':  %s\n",
-			argv[1], strerror(errno));
+			pf_name, strerror(errno));
 		exit(1);
 	}
 	map =
 	    mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED) {
 		fprintf(stderr, "Can't map '%s':  %s\n",
-			argv[1], strerror(errno));
+			pf_name, strerror(errno));
 		exit(1);
 	}
 
-- 
2.21.0

