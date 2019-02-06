Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEA1C282C2
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750942080D
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBFTlZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:41:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfBFTlZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Feb 2019 14:41:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D63A9804FA
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 19:41:24 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 886474521;
        Wed,  6 Feb 2019 19:41:22 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux/selinux_restorecon: Skip customized files also without -v
Date:   Wed,  6 Feb 2019 20:41:11 +0100
Message-Id: <20190206194111.24729-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 06 Feb 2019 19:41:24 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the original code, customizable file contexts were not changed only if -v was
used. It lead to different behavior when selinux_restorecon was run with -v and
without it.

Based on an initial patch by Jan Zarsky <jzarsky@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 42a48f5a..0f0fd6ca 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -672,8 +672,8 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 				selinux_log(SELINUX_INFO,
 				 "%s not reset as customized by admin to %s\n",
 							    pathname, curcon);
-				goto out;
 			}
+			goto out;
 		}
 
 		if (!flags->set_specctx && curcon) {
-- 
2.20.1

