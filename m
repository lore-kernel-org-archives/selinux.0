Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E147DC433E1
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C104B20738
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d42aep4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgFWMhM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:37:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21528 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732597AbgFWMhM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 08:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592915830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qp+2dD8mc/Q81/qimrHzD/csfblw2q5C6Rz/aFEaQ6M=;
        b=d42aep4JRqRyqLv8T+Ww8LKNvjQAv7L0hlya7mJWAfKHYwEFjQYLD92Gho8EPH/rGtx3Gp
        kZnD6JEghsyN9YZ3pShQalDyv4o6Lkb/IpthMEXnmmOy2rkIaOuscH2mnpdv1IXbInWHty
        tKxISVTUAZ15F8qlvbAWZ/DIg/BauxI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-cF_8C6_dM7qvUrWbC0W5Yw-1; Tue, 23 Jun 2020 08:37:08 -0400
X-MC-Unique: cF_8C6_dM7qvUrWbC0W5Yw-1
Received: by mail-wr1-f70.google.com with SMTP id p10so15508493wrn.19
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 05:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qp+2dD8mc/Q81/qimrHzD/csfblw2q5C6Rz/aFEaQ6M=;
        b=S908PUDyhq/d1N++kyhkMKc+VJVRwmeS54Ug3CbeWODseDf8nRLnK74AJ2mJsYoK9X
         8F4i17y7TZ9aWXgxJGXV3S8uLfdXM5KMm4JNyZbm2y9o2ME3wQFf4WtEbUNoAnxdRP7L
         eP1hNcAbpXFSzg5zRtQN0pc8BS++TanY/k2mOhGolY0wl623RLTNuI+ONnfjeclRoY6d
         nOhU//OEze1xYWfL9q1pY2zz29u3sOcU8ecIC+5plszH8eCkj3ytbZxkqVyFSLof22zF
         1qlkQTgeN6yRrHpNreyHbwVrK0ecLHuGhjhyNlxZZ+YfZ6jTfyiAKDiCDGPLptEAfU90
         fTpA==
X-Gm-Message-State: AOAM531/VQsUl+RT9C1ppcFgHv5YIJou9td/13itzGHLqlw+0KFzJZyW
        shnTxLa6XVU85ylgR8VV1xD+XuOK1Gd/srTjC1EzLxFYL6wKsVZnH6lTVw5yA1ZSitiqJv9B/fJ
        bKi66LGVBBOF2RwBpCQ==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr23285730wmk.21.1592915827484;
        Tue, 23 Jun 2020 05:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypN4XQEb+6n7NPWyARB3l5dYV8MQujGiPOopDaZgUz94YCV0iBlhUr+avkX8kF58r6OXzrsQ==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr23285711wmk.21.1592915827184;
        Tue, 23 Jun 2020 05:37:07 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm3449729wma.48.2020.06.23.05.37.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:37:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/4] travis: add missing node to fake selinuxfs
Date:   Tue, 23 Jun 2020 14:37:00 +0200
Message-Id: <20200623123702.401338-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623123702.401338-1-omosnace@redhat.com>
References: <20200623123702.401338-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since commit e95fe9503816 ("Add tests for default_range glblub") we look
at $(SELINUXFS)/initial_contexts/kernel to determine the type of the
policy. However, this node is not provided by the fake selinuxfs created
by our CI scripts, leading to non-fatal errors like this:

[...]
make[1]: Entering directory '/home/travis/build/WOnder93/selinux-testsuite/policy'
cat: /tmp/fake-selinuxfs/initial_contexts/kernel: No such file or directory
[...]

Create that node and fill it with the ussual kernel context to silence
the errors.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 18ab6b9..ae08c66 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -55,6 +55,8 @@ before_install:
   # establish a fake "selinuxfs" mount (policy/Makefile just greps for selinuxfs)
   - mkdir -p /tmp/fake-selinuxfs/policy_capabilities
   - echo 1 > /tmp/fake-selinuxfs/policy_capabilities/extended_socket_class
+  - mkdir -p /tmp/fake-selinuxfs/initial_contexts
+  - echo system_u:system_r:kernel_t:s0 > /tmp/fake-selinuxfs/initial_contexts/kernel
   - echo 999 >/tmp/fake-selinuxfs/policyvers
 
 script:
-- 
2.26.2

