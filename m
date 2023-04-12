Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B969C7619A
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 14:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDLOAc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLOAc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 10:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967887ABC
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681307965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m5UTmvkfbu6Nz22Y7PYLLtkwli0hFUBWxr4+39ZMvTM=;
        b=ZJKpFbHswKuvOwvoFqU2LDZGZOpe7aa8jhXI1Yuv8/bdevmyF24tmddc2Hy9jK7TS4u0An
        Quy6MkECZbPUUtZTIYmL2FzDoTtCfO8vg7svqYwdhfQOTYvubJceMY9ZBMDOgQwRnLAizO
        3Mr9OcRZHFNm49HE5iLW2DV51lC5WsI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-kUhVCh_yNwSa5NVbN03YXw-1; Wed, 12 Apr 2023 09:59:23 -0400
X-MC-Unique: kUhVCh_yNwSa5NVbN03YXw-1
Received: by mail-ed1-f69.google.com with SMTP id t27-20020a50ab5b000000b0050047ecf4bfso6524763edc.19
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 06:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307962; x=1683899962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5UTmvkfbu6Nz22Y7PYLLtkwli0hFUBWxr4+39ZMvTM=;
        b=cUfeNwzBCTYDsu7hsqu/S6Pz2T8o5SLslx4UqOC+wTwjjxYDIxgeJ+kkaqj0a/CPus
         +Q7cQWrilY+mP3NHLupQ5jSvTxU8Y28RO++gUO7AGJiAOppeBdjdE8ILENHH6OiYdODC
         6xZ8ADn4WzY8HhyiTEiuHzzOO3CqKFHUDMYvBUf7v+Z4/3RxI+hPxzS0/LyvRIqyrUoC
         vsNiM+kQfcE6zFgi8w1GA7mIbWeAihhFn3QUNWPKpRLS34kMIru5qCendRL7gLP0Oem1
         x1BWRA44WU4srU/SR1/xB9100n2NNw+0nbI7z8wFyg/Xz9S43z/HGMgGx1oh6nQfOi1e
         q4Bg==
X-Gm-Message-State: AAQBX9d6y7qqngEODyuSmvZeO73jCwXl7AXsagtd6imqh13Yshtp7qya
        YfNnUde4lksE3tUuhpkDs7XVt8yiP7+E5vETb+HW0cC2K9eW+z/ruyaqMucZkRdAe28uPLmYMEO
        qGEqe8WfcuIfXBUdUoQ==
X-Received: by 2002:a17:906:57cb:b0:94a:88aa:e23d with SMTP id u11-20020a17090657cb00b0094a88aae23dmr2920624ejr.24.1681307962506;
        Wed, 12 Apr 2023 06:59:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZxfExF5w5lEz7Ii/4kkPJtIs8Rue1kFynU40R0JF6lDtucEVbIckcPwzCtravIE6EwGOZ5UA==
X-Received: by 2002:a17:906:57cb:b0:94a:88aa:e23d with SMTP id u11-20020a17090657cb00b0094a88aae23dmr2920605ejr.24.1681307962126;
        Wed, 12 Apr 2023 06:59:22 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b0094a558c41f0sm4264018ejb.221.2023.04.12.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:59:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: [PATCH] selinux: fix Makefile dependencies of flask.h
Date:   Wed, 12 Apr 2023 15:59:19 +0200
Message-Id: <20230412135919.582613-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make the flask.h target depend on the genheaders binary instead of
classmap.h to ensure that it is rebuilt if any of the dependencies of
genheaders are changed.

Notably this fixes flask.h not being rebuilt when
initial_sid_to_string.h is modified.

Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 7761624448826..103c2776478a7 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -23,8 +23,8 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
 
 quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
-      cmd_flask = scripts/selinux/genheaders/genheaders $(obj)/flask.h $(obj)/av_permissions.h
+      cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: $(src)/include/classmap.h FORCE
+$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
-- 
2.39.2

