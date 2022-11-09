Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC50C433FE
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 10:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKIK5P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiKIK4h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 05:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A35F77
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 02:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667991261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E1hwoXowoNq25GhtQoNO9P8P38+oCIaOmuGfOssaaA8=;
        b=U1goSI3LbKhbvjTnMr4oG7R0tQGRivRmiLr1yQjVjWb7fLmXxXurud2/OvrKCnxXDovasx
        JQrnDRcPYxqyfFf7ILK713c0qfrkHx7DhOjeEHQhXgoUOWxrOzZeyR+7cA1IioiYw2RpoB
        zmagLE6axccSBAdyzXPS7G6aBYFsJLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-BVdtz6U6ObqA7oqMcG8U9w-1; Wed, 09 Nov 2022 05:54:18 -0500
X-MC-Unique: BVdtz6U6ObqA7oqMcG8U9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CD8881F30D
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-193-8.brq.redhat.com [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D656140EBF5;
        Wed,  9 Nov 2022 10:54:17 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] python: Fix typo in audit2allow.1 example
Date:   Wed,  9 Nov 2022 11:53:28 +0100
Message-Id: <20221109105327.1181753-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/audit2allow/audit2allow.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
index c61067b33688..04ec32398011 100644
--- a/python/audit2allow/audit2allow.1
+++ b/python/audit2allow/audit2allow.1
@@ -151,7 +151,7 @@ policy_module(local, 1.0)
 gen_require(`
         type myapp_t;
         type etc_t;
- };
+\[aq])
 
 files_read_etc_files(myapp_t)
 <review local.te and customize as desired>
-- 
2.37.3

