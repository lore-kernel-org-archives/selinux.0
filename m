Return-Path: <SRS0=gAxo=SG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A4C4360F
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 21:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A609220882
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 21:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfDDVTv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfDDVTv (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 4 Apr 2019 17:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35D1B307D986;
        Thu,  4 Apr 2019 21:19:51 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 255BD608BB;
        Thu,  4 Apr 2019 21:19:49 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Bogdan BOTEZ <bmbogdan@gmail.com>
Subject: [PATCH] semanage/semanage-boolean.8: Fix a minor typo
Date:   Thu,  4 Apr 2019 23:19:38 +0200
Message-Id: <20190404211938.24183-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 04 Apr 2019 21:19:51 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

boolan -> boolean

Reported-by: Bogdan BOTEZ <bmbogdan@gmail.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage-boolean.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage-boolean.8 b/python/semanage/semanage-boolean.8
index 99a6260b..1282d106 100644
--- a/python/semanage/semanage-boolean.8
+++ b/python/semanage/semanage-boolean.8
@@ -45,7 +45,7 @@ Disable the boolean
 
 .SH EXAMPLE
 .nf
-Turn on the apache can send mail boolan
+Turn on the apache can send mail boolean
 # semanage boolean \-m \-\-on httpd_can_sendmail
 
 List customized booleans
-- 
2.21.0

