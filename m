Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FBAC77B7D
	for <selinux@archiver.kernel.org>; Wed, 17 May 2023 13:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjEQNus (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 May 2023 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjEQNur (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 May 2023 09:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F87A83
        for <selinux@vger.kernel.org>; Wed, 17 May 2023 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684331393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kdieih6G2RTw7sT+yNPDct8v4R+ouLHJVELNMvv+Dag=;
        b=SXdL7uLUB1/DZAPMkXowzUtcfQMZDljyn2dRSniPC5eFRv7oeomeOcSEYOXGJOTbo0qfzn
        4ONqwLcGmxszgIWTnjv1AdsdgeFfEnl/nP0yUpNvgNl9ycuAN1A8qHj2+U0WSDaqcY1LRU
        UuSyoyqlOpKN7rpm3P1AUUO3M2RFAUs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156--G_9uZe5N96kJRtRNqp02A-1; Wed, 17 May 2023 09:49:51 -0400
X-MC-Unique: -G_9uZe5N96kJRtRNqp02A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90EEA84AF3B
        for <selinux@vger.kernel.org>; Wed, 17 May 2023 13:49:51 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.224.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10D3F1121314;
        Wed, 17 May 2023 13:49:50 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 3/4] semanage: Drop unnecessary import from seobject
Date:   Wed, 17 May 2023 15:49:33 +0200
Message-Id: <20230517134934.709059-3-lautrbach@redhat.com>
In-Reply-To: <20230517134934.709059-1-lautrbach@redhat.com>
References: <20230517134934.709059-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sepolgen.module is not used for permissive domains

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/semanage/seobject.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 8a891ca23bca..124bb431464e 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -504,11 +504,6 @@ class permissiveRecords(semanageRecords):
             print(t)
 
     def add(self, type):
-        try:
-            import sepolgen.module as module
-        except ImportError:
-            raise ValueError(_("The sepolgen python module is required to setup permissive domains.\nIn some distributions it is included in the policycoreutils-devel package.\n# yum install policycoreutils-devel\nOr similar for your distro."))
-
         name = "permissive_%s" % type
         modtxt = "(typepermissive %s)" % type
 
-- 
2.40.1

