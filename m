Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471ACC433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 08:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiDMIv3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiDMIv3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 04:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C504C50466
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649839746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhhDi1lcDscWFHofSNZJGIlPWP5ka98Qtg9pAVP3SRU=;
        b=U/BUsHcRG5emIEwRJYpLVX85UghHI1PW7G0tTcH5OjOH5MZyF1Wu0LqThzc08MqUZHrSXY
        BVJvktYfKfpLHW/f5TTAC8wSVXMu5kJ+lquO0CnjVDUzJjNSQ7TqKQq5uaPA+9VjpifqNq
        A9RGBy95FBRq/Z/0BLEHqQwS3TD+4PM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-3ihcCNA6N46ORgkDhMrXxw-1; Wed, 13 Apr 2022 04:49:02 -0400
X-MC-Unique: 3ihcCNA6N46ORgkDhMrXxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C6D2185A7A4
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C96F8C44B1D;
        Wed, 13 Apr 2022 08:49:01 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [HEADS UP MISSING PATCH] Update python library and binding versions to 3.4-rc1
Date:   Wed, 13 Apr 2022 10:48:53 +0200
Message-Id: <20220413084853.158546-1-plautrba@redhat.com>
In-Reply-To: <87bkxdnesk.fsf@redhat.com>
References: <87bkxdnesk.fsf@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

I forgot to update python libraries and bindings versions in 3.4-rc1.

If you're building them, please apply this patch.

Given that 3.4-rc2 is planned on the next Wednesday, I don't think it's necessary to merge this.


 libselinux/src/setup.py  | 2 +-
 python/sepolicy/setup.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/setup.py b/libselinux/src/setup.py
index b79b27507480..4dd119aca32e 100644
--- a/libselinux/src/setup.py
+++ b/libselinux/src/setup.py
@@ -4,7 +4,7 @@ from distutils.core import Extension, setup
 
 setup(
     name="selinux",
-    version="3.3",
+    version="3.4-rc1",
     description="SELinux python 3 bindings",
     author="SELinux Project",
     author_email="selinux@vger.kernel.org",
diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
index e81b6cc73380..62cf7dc47c5c 100644
--- a/python/sepolicy/setup.py
+++ b/python/sepolicy/setup.py
@@ -6,7 +6,7 @@ from distutils.core import setup
 
 setup(
     name="sepolicy",
-    version="3.3",
+    version="3.4-rc1",
     description="Python SELinux Policy Analyses bindings",
     author="Daniel Walsh",
     author_email="dwalsh@redhat.com",
-- 
2.35.1

