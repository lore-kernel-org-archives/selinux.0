Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D0C2BB48
	for <selinux@archiver.kernel.org>; Thu, 17 Dec 2020 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737C32396F
	for <selinux@archiver.kernel.org>; Thu, 17 Dec 2020 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgLQPBX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:01:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727246AbgLQPBW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Dec 2020 10:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608217196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=raN0Ur+EFR1arJPFvwRdfXBSFOwKaJVXdzU/1qGnebM=;
        b=Wcpns4FuNFmVZfWAi1mqUq1SWBaoEDXyl+i0RsqtY3+VWwRg4Yb4YI2Fx2xvp3YD55pli/
        YmD/yahmzYPL1VFrJjoWfxNEGGdySJWKb1RQcF8PMJFN1+GsP+rylJRrEqRCbpus+W4JSU
        i5v5Dzn+1wNXgzVVI98H+sEqjaeebr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-UsSkzZu7M5iVTqMVozNJKg-1; Thu, 17 Dec 2020 09:59:53 -0500
X-MC-Unique: UsSkzZu7M5iVTqMVozNJKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95093107ACE6
        for <selinux@vger.kernel.org>; Thu, 17 Dec 2020 14:59:52 +0000 (UTC)
Received: from kyubey.redhat.com (ovpn-113-165.ams2.redhat.com [10.36.113.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D632F10016FE;
        Thu, 17 Dec 2020 14:59:51 +0000 (UTC)
From:   Jakub Hrozek <jhrozek@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Jakub Hrozek <jhrozek@redhat.com>
Subject: [PATCH] libsemanage: Free contents of modkey in semanage_direct_remove
Date:   Thu, 17 Dec 2020 15:59:49 +0100
Message-Id: <20201217145949.1230098-1-jhrozek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

semanage_direct_remove allocates struct semanage_module_key_t on
stack, then calls semanage_module_key_set_name which allocates
modkey->name on heap, but modkey->name wasn't free()-d anywhere,
creating a small leak.

Signed-off-by: Jakub Hrozek <jhrozek@redhat.com>
---
 libsemanage/src/direct_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index d2b91fb2..9a4e7938 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1951,6 +1951,7 @@ static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
 	status = semanage_direct_remove_key(sh, &modkey);
 
 cleanup:
+	semanage_module_key_destroy(sh, &modkey);
 	return status;
 }
 
-- 
2.26.2

