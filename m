Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5CEC282DA
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154DD218AF
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfAaTsf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfAaTsf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 31 Jan 2019 14:48:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A060789AE6
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 19:48:35 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD39554504;
        Thu, 31 Jan 2019 19:48:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/2] libselinux: Change matchpathcon usage to match with matchpathcon manpage
Date:   Thu, 31 Jan 2019 20:48:24 +0100
Message-Id: <20190131194824.4944-2-plautrba@redhat.com>
In-Reply-To: <20190131194824.4944-1-plautrba@redhat.com>
References: <20190131194824.4944-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 31 Jan 2019 19:48:35 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/utils/matchpathcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index 67e4a433..9756d7d9 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -14,7 +14,7 @@
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-N] [-n] [-f file_contexts] [ -P policy_root_path ] [-p prefix] [-Vq] path...\n",
+		"usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_file] [-p prefix] [-P policy_root_path] filepath...\n",
 		progname);
 	exit(1);
 }
-- 
2.20.1

