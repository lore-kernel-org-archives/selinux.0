Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F79FC433EF
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0271A61BF9
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 15:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhKPPOl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237853AbhKPPO1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 10:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637075490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=usPVQ82+W8Q9OyO/j1kWbK2myizvRvveJalHHNfdPbQ=;
        b=YEtE0Jr88EvQqCIdO77A9mocJJ5ZGVqSC35GTejlttslcIofMreLvZT9v539gWGY2e/5+M
        /jBnEyEJjVpdr8O1hQgWdGa7041V+ivinS5IAMyQ78ofvV8qizHmpECGfBvW58zqt8ywcn
        UUmprzjPte/mbvC3QzLOGSQJObGNZQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-ZyHG8GuEMByUeJz5XkEjqw-1; Tue, 16 Nov 2021 10:11:27 -0500
X-MC-Unique: ZyHG8GuEMByUeJz5XkEjqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A28780A5CF
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 15:11:26 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.40.193.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B662419D9B;
        Tue, 16 Nov 2021 15:11:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] semodule: Fix lang_ext column index
Date:   Tue, 16 Nov 2021 16:11:22 +0100
Message-Id: <20211116151122.172831-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

lang_ext is 3. column - index number 2.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semodule/semodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ddbf10455abf..57f005ce2c62 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -684,7 +684,7 @@ cleanup_extract:
 						if (result != 0) goto cleanup_list;
 
 						size = strlen(tmp);
-						if (size > column[3]) column[3] = size;
+						if (size > column[2]) column[2] = size;
 					}
 
 					/* print out each module */
-- 
2.33.1

