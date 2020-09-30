Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F643C4727C
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAA1206FC
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adY+uRYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgI3OvE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 10:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730427AbgI3OvE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 10:51:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601477463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gjR7A43Z0Pv7yuo/qczca/yad5OMKgL+O04+FVd61w=;
        b=adY+uRYOu8bJZEFswUBuDsfBcMAKONllNlxNX6IVjQbkSN7ziKN2T3pN8r3V5ZXnOvxb/s
        CJ+mBp/iqoPhYH+pXMce3Fs8qZvWCuPwrsSmfk1KmL5L8gW8SHMYn3dMk/OZhkL2xyp8xP
        ndHynXFIrwaGFnoevQ3c5IelTaEig30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-6T4UT-zpPtaxR_9npqW-iQ-1; Wed, 30 Sep 2020 10:50:47 -0400
X-MC-Unique: 6T4UT-zpPtaxR_9npqW-iQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F2618BA280
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 14:50:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 207E65D9D3;
        Wed, 30 Sep 2020 14:50:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 4/4] libsemanage: Bump libsemanage.so version
Date:   Wed, 30 Sep 2020 16:50:31 +0200
Message-Id: <20200930145031.910190-4-plautrba@redhat.com>
In-Reply-To: <20200930145031.910190-1-plautrba@redhat.com>
References: <20200930145031.910190-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It's due to the previous ABI incompatible change

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index a0eb3747d74b..ab6cae51f5c3 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -32,7 +32,7 @@ YACC = bison
 YFLAGS = -d
 
 VERSION = $(shell cat ../VERSION)
-LIBVERSION = 1
+LIBVERSION = 2
 
 LIBA=libsemanage.a
 TARGET=libsemanage.so
-- 
2.28.0

