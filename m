Return-Path: <SRS0=VpXZ=YM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A06CA9EAB
	for <selinux@archiver.kernel.org>; Sat, 19 Oct 2019 10:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B6C20854
	for <selinux@archiver.kernel.org>; Sat, 19 Oct 2019 10:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfJSK1F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Oct 2019 06:27:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfJSK1F (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 19 Oct 2019 06:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 942734023022
        for <selinux@vger.kernel.org>; Sat, 19 Oct 2019 10:27:04 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.242.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCE87100724A;
        Sat, 19 Oct 2019 10:27:03 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH v2 2/3] checkpolicy: update the description for -o option in the man page
Date:   Sat, 19 Oct 2019 19:26:55 +0900
Message-Id: <20191019102656.22972-2-yamato@redhat.com>
In-Reply-To: <20191019102656.22972-1-yamato@redhat.com>
References: <20191019102656.22972-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 19 Oct 2019 10:27:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 19 Oct 2019 10:27:04 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Write about policy.conf and CIL files.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/checkpolicy.8 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 1552f497..db57751c 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -40,7 +40,8 @@ Enable the MLS policy when checking and compiling the policy.
 Specify the policy version, defaults to the latest.
 .TP
 .B \-o,\-\-output filename
-Write a binary policy file to the specified filename.
+Write a policy file (binary, policy.conf, or CIL policy)
+to the specified filename.
 .TP
 .B \-S,\-\-sort
 Sort ocontexts before writing out the binary policy. This option makes output of checkpolicy consistent with binary policies created by semanage and secilc.
-- 
2.21.0

