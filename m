Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610CAC3A5A7
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 13:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLHN01 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLHN0Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 08:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D6181D94
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670505933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nW44aju1qfI1gxJAPS2WTlQCjEVlhWUW9iP6OGUExJU=;
        b=D2eK1SJYFv8gdjXDVt5nA9ZzP4fpx1UcNukQZfXq0XebBOrmPe4zccThEqDgPR+NxTO8D5
        gaFJ8FQtJr3d645wnfgLx7KFa8pMOJUF9mbyo+nKQA8Pze3jbDxvILuVxcwM/iL4snuySa
        HH3pBHSyl+uT537D8dbh56GenQFgcaw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-APmgWZ0yN66676F4nCIvgA-1; Thu, 08 Dec 2022 08:25:31 -0500
X-MC-Unique: APmgWZ0yN66676F4nCIvgA-1
Received: by mail-ej1-f72.google.com with SMTP id sb2-20020a1709076d8200b007bdea97e799so1074355ejc.22
        for <selinux@vger.kernel.org>; Thu, 08 Dec 2022 05:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nW44aju1qfI1gxJAPS2WTlQCjEVlhWUW9iP6OGUExJU=;
        b=RuhmzyOL/gONStW+III4uO840t0cETPrK+d9AAkFslti2Vy38gEAm37fArxF9O/k4s
         cCxe2o4L1vOS9uLoXUX7+IrccK+zMgS66RFZVh6AqtGBPgQhHv8KYAY1m19uWxnsYo+A
         hW18LxaPOb3PT3ZZeYX/TrFih7+afKmBFH8cT2Wt+zvZRSw0ILzePI32rWcahtsisU37
         g2cnYbWHhvAu+EtId2VRgcTDeEkFfHer8ImCnPLi4Pv0LWdlmBg+6g/5EKFX0Hl/a9Yz
         vZW5H138/nSe13ojX4YqIdPvGPWyyCU7HzdT4gEhRsLaNuYtdAVR1h9NoRo092LnrqM5
         nyrg==
X-Gm-Message-State: ANoB5pn/ohqzwle+8PA3y81iuVKbjKRO3mHLptHBY75ElTCHCJWc5d0M
        qWxxhiXtBtNftssoh2F2ZtvaRoxyvxNv3YHk18Lcu7S/n5UzGSAt2Fz5MmjpmL9KE0sjo7bTsDR
        6xORfcXHbiiHyA0TXknUs4sDn0xJPjxtMWbreUnHm0NODcXIjB85VrtZZRxRnMhsBL44Ovg==
X-Received: by 2002:a17:906:4d8f:b0:7c0:e535:13fc with SMTP id s15-20020a1709064d8f00b007c0e53513fcmr2237377eju.37.1670505929979;
        Thu, 08 Dec 2022 05:25:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6b0qU9MflPnbzr6xSk2a1VM3Ga5NslnfPGDeiA7wqJ+VnndcXUSjl249ZYh8beffiUoO9Eow==
X-Received: by 2002:a17:906:4d8f:b0:7c0:e535:13fc with SMTP id s15-20020a1709064d8f00b007c0e53513fcmr2237360eju.37.1670505929682;
        Thu, 08 Dec 2022 05:25:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709066b1200b007bf988ce9f7sm9753959ejr.38.2022.12.08.05.25.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:25:28 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 4/4] ci: bump Fedora versions
Date:   Thu,  8 Dec 2022 14:25:22 +0100
Message-Id: <20221208132522.309657-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208132522.309657-1-omosnace@redhat.com>
References: <20221208132522.309657-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fedora 37 has been released, 35 will soon be EOL.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/checks.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index ae81925..b1b93c6 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -17,9 +17,9 @@ jobs:
       matrix:
         domain: [unconfined_t, sysadm_t]
         env:
-          - { version: 35, kernel: default }
           - { version: 36, kernel: default }
-          - { version: 36, kernel: secnext }
+          - { version: 37, kernel: default }
+          - { version: 37, kernel: secnext }
     env:
       FEDORA_VERSION: ${{ matrix.env.version }}
       KERNEL_TYPE: ${{ matrix.env.kernel }}
-- 
2.38.1

