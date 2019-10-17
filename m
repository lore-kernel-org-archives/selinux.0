Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA2AC4CECE
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 07:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E5C20640
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 07:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392640AbfJQHFW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:05:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390918AbfJQHFW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 17 Oct 2019 03:05:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC859405C63A
        for <selinux@vger.kernel.org>; Thu, 17 Oct 2019 07:05:21 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F25C2166BA1;
        Thu, 17 Oct 2019 07:05:20 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 1/3] checkpolicy: remove a redundant if-condition
Date:   Thu, 17 Oct 2019 16:05:11 +0900
Message-Id: <20191017070513.13445-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 17 Oct 2019 07:05:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 17 Oct 2019 07:05:21 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Inner if-condition in following code is redundant:

	if (outfile) {
		/* ... just referring outfile ... */
		if (outfile) {
			do_something();
		}
	}

We can simplify this to:

	if (outfile) {
		/* ... just referring outfile ... */
		do_something();
	}

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/checkpolicy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index f928ec06..e18de171 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -682,9 +682,7 @@ int main(int argc, char **argv)
 			}
 		}
 
-		if (outfile) {
-			fclose(outfp);
-		}
+		fclose(outfp);
 	} else if (cil) {
 		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
 		exit(1);
-- 
2.21.0

