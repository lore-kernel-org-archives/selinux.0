Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B62C4338F
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE2C60EBB
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 09:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhG1JVs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231282AbhG1JVs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 05:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627464106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OXRzQDeZwbL0jVzAxH6lepbxk1M99F1ux+epcOMenhw=;
        b=RnL1HCgbXyjG6lN4nPChAnd7AuSb6AQycox94GOYCL/Uo/rr7KriFPQkk5TcG7cAsgkLGm
        8pyfD6NtLX/qOOZPcZGrYjavigurecFrZrmgNn+wweO5FbBZAoIzHVcZnkw6y0Jk5tXLNX
        34W1keCSViL2nnez+5waYLxqX9oZ0dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-p5mFtntuOpC2vb7qXJtA4g-1; Wed, 28 Jul 2021 05:21:45 -0400
X-MC-Unique: p5mFtntuOpC2vb7qXJtA4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C32C1026200
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 09:21:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AFD960854;
        Wed, 28 Jul 2021 09:21:43 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libsemanage: Fix USE_AFTER_FREE (CWE-672) in semanage_direct_write_langext()
Date:   Wed, 28 Jul 2021 11:21:35 +0200
Message-Id: <20210728092135.132957-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From fclose(3):
Upon successful completion, 0 is returned.  Otherwise, EOF is returned
and errno is set to indicate the error. In either case, any further
access (including another call to fclose()) to the stream results in
undefined behavior.

Fixes:
    Error: USE_AFTER_FREE (CWE-672): [#def1]
    libsemanage-3.2/src/direct_api.c:1023: freed_arg: "fclose" frees "fp".
    libsemanage-3.2/src/direct_api.c:1034: use_closed_file: Calling "fclose" uses file handle "fp" after closing it.
    # 1032|
    # 1033|   cleanup:
    # 1034|-> 	if (fp != NULL) fclose(fp);
    # 1035|
    # 1036|   	return ret;

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/direct_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 9a4e79385b69..f0e2300a2f58 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1022,6 +1022,7 @@ static int semanage_direct_write_langext(semanage_handle_t *sh,
 
 	if (fclose(fp) != 0) {
 		ERR(sh, "Unable to close %s module ext file.", modinfo->name);
+		fp = NULL;
 		ret = -1;
 		goto cleanup;
 	}
-- 
2.32.0

