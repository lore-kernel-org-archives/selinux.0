Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D8C43217
	for <selinux@archiver.kernel.org>; Tue,  8 Nov 2022 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiKHKU1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiKHKUK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Nov 2022 05:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B49915FFC
        for <selinux@vger.kernel.org>; Tue,  8 Nov 2022 02:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667902743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gu/ECkESM+xQDRq9pPm6TrqhWJf/+njaHX9rY9wR6I4=;
        b=Pqb8PktcapMyWC8i5Ou0PlYG9GXPOIl6RKXLX8QDyE9t8l8Nzc+bNR3X5S5q4t7yQpJzqF
        bwftPyxlnzJaA0iJwhMa9hiV3LeEnWrBv/xO3IdroNwb+BiFsb+PHF+IgR9I4i4E0XjUNl
        z6dj89cFY5faI5q/ZlAlUP+WENHTWhE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-Bzi97aRlPxi5F9J1Uw1GYA-1; Tue, 08 Nov 2022 05:19:02 -0500
X-MC-Unique: Bzi97aRlPxi5F9J1Uw1GYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE8103C10146
        for <selinux@vger.kernel.org>; Tue,  8 Nov 2022 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-193-179.brq.redhat.com [10.40.193.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E6D72166B35;
        Tue,  8 Nov 2022 10:19:01 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python: Fix typo in audit2allow.1 example
Date:   Tue,  8 Nov 2022 11:18:54 +0100
Message-Id: <20221108101854.1136685-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/audit2allow/audit2allow.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
index c61067b33688..f1a4b8ea33b3 100644
--- a/python/audit2allow/audit2allow.1
+++ b/python/audit2allow/audit2allow.1
@@ -151,7 +151,7 @@ policy_module(local, 1.0)
 gen_require(`
         type myapp_t;
         type etc_t;
- };
+');
 
 files_read_etc_files(myapp_t)
 <review local.te and customize as desired>
-- 
2.37.3

