Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFCC43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697DE217D7
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeLSLpH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:45:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeLSLpH (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 19 Dec 2018 06:45:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB5DA753F1
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 11:45:06 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4C7D5DE8B;
        Wed, 19 Dec 2018 11:45:03 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] mcstrans: Fix check in raw_color()
Date:   Wed, 19 Dec 2018 12:45:00 +0100
Message-Id: <20181219114500.22113-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 19 Dec 2018 11:45:07 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

raw_color() uses color_str as an output argument which is assigned to a new
allocated memory. Therefore it should fail when color_str is null; or
when *color_str is not null in order to avoid a memory leak.

Fixes:
>>> selinux.selinux_raw_context_to_color('system_u:system_r:inetd_t:s0')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
OSError: [Errno 0] Error

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 mcstrans/src/mcscolor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index cc6174bb..6ea1aa97 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -292,7 +292,7 @@ int raw_color(const security_context_t raw, char **color_str) {
 	size_t result_size = (N_COLOR * CHARS_PER_COLOR) + 1;
 	int rc = -1;
 
-	if (!color_str || !*color_str) {
+	if (!color_str || *color_str) {
 		return -1;
 	}
 
-- 
2.20.0

