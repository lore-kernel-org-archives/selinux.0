Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48330C433EF
	for <selinux@archiver.kernel.org>; Wed,  2 Mar 2022 10:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiCBKPH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiCBKPH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Mar 2022 05:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EA3C60042
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646216062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eyLCK5dXWkNJLaOZi8H/weuxJenjJLx3k7u6npF4obY=;
        b=i2/w4q41cIok30dit6PNqiqiaKISWJsnw95VJNMvLxbAotCUmnwmhRC6bHMuGZ/DI/FvnD
        P9Wk3xOyT8ODSb7xT9qnHbIBJfhCeihr9XR7GTrq6uEPL3Gcp3JTgbgBhvtvlrHIj7JN4I
        vqLByrH/7BLhu2y0lLjJTJhheIfdDXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-BC5ArQafNmaeknOHI30IYA-1; Wed, 02 Mar 2022 05:14:21 -0500
X-MC-Unique: BC5ArQafNmaeknOHI30IYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D90801AAD
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73EB36F965;
        Wed,  2 Mar 2022 10:14:19 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] semanage-fcontext.8: Drop extra )s after FILE_SPEC
Date:   Wed,  2 Mar 2022 11:14:15 +0100
Message-Id: <20220302101415.431161-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes: https://github.com/SELinuxProject/selinux/issues/340

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage-fcontext.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index 49635ba788f7..1ebf085faed8 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -3,7 +3,7 @@
 semanage\-fcontext \- SELinux Policy Management file context tool
 
 .SH "SYNOPSIS"
-.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) | \-\-delete ( \-t TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC ) | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) ]
+.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC | \-\-delete ( \-t TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
-- 
2.35.1

