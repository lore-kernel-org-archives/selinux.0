Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F97C433EF
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 08:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiDHJBg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiDHJBe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 05:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E80FFF9A
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649408370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K50EA3tV31RxxtbjjSlrFJBdUa8TIqGqVyTq6NmKqw8=;
        b=AbSUEAazIIA4ZeN5XiU7e6ux6w6ba4ewzl/Tgznc4W+HUQIWzIG3+yj/exe1O0ACKLfRi3
        VpM8QwU2f7xqKuWhz80Il3rzbkeVrI07GsqrDFz/GARdxUV/KhbtkFrPajCHiAJCHq2UNO
        b0S4pT/pVJkdMwBekVIm/KWPK5i3Oe0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-yujopStVMVaDbD_LItzzNQ-1; Fri, 08 Apr 2022 04:59:28 -0400
X-MC-Unique: yujopStVMVaDbD_LItzzNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DB5E805F6F;
        Fri,  8 Apr 2022 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEF1540D2962;
        Fri,  8 Apr 2022 08:59:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v3] setfiles.8: -q is deprecated and has no effect
Date:   Fri,  8 Apr 2022 10:59:07 +0200
Message-Id: <20220408085907.463960-1-plautrba@redhat.com>
In-Reply-To: <20220405071735.251995-1-plautrba@redhat.com>
References: <20220405071735.251995-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: James Carter <jwcart2@gmail.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/setfiles/setfiles.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 15f939d1bee0..19b59a2cc90d 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -124,7 +124,7 @@ and
 options are mutually exclusive.
 .TP 
 .B \-q
-Deprecated, was only used to stop printing inode association parameters.
+Deprecated and replaced by \fB\-v\fR. Has no effect on other options or on program behavior.
 .TP 
 .BI \-r \ rootpath
 use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
-- 
2.35.1

