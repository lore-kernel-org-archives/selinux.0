Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC4C433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 13:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiDANht (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 09:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDANht (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 09:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2007E182DAA
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648820159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jyOpF8iXSL5FtcGfyQ/43tJ/GA+/2R5Khbv7zgwvl0M=;
        b=e2lfddlSFBwEM9L9Rur0487+Yx91Cisdo9uRhJ1ametL3fiCfid0TgmdeFM54DeFMGjUUl
        HIf2qyOXPPiuxfQOjjVAYV/Fnwmr98Ccf9pbBzGaUtZf5+2uHJzbOjK5Xtd3ncclVs5Ggk
        RC5naj9cQDR6o2MNoqccwbeJK+4mY0k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-jCKZqlqpORK3kwF02CDUQg-1; Fri, 01 Apr 2022 09:35:55 -0400
X-MC-Unique: jCKZqlqpORK3kwF02CDUQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2E68185A7BA
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D5E34010A2D;
        Fri,  1 Apr 2022 13:35:53 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/3] libsemanage: Fix USE_AFTER_FREE (CWE-672) in semanage_direct_get_module_info()
Date:   Fri,  1 Apr 2022 15:35:47 +0200
Message-Id: <20220401133549.122069-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

>From fclose(3):
Upon successful completion, 0 is returned.  Otherwise, EOF is returned
and errno is set to indicate the error. In either case, any further
access (including another call to fclose()) to the stream results in
undefined behavior.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/direct_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index d83941b05ca1..d5716ce579e9 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2293,6 +2293,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 	tmp = NULL;
 
 	if (fclose(fp) != 0) {
+		fp = NULL;
 		ERR(sh,
 		    "Unable to close %s module lang ext file.",
 		    (*modinfo)->name);
-- 
2.35.1

