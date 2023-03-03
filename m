Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA5EC678D4
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 14:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCCOJh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCCOJg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 09:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0381714A
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 06:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677852538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QtGvsJ1cDwCnysKk0ZTjXqMejjfHzfnthZARNTdSf7w=;
        b=aDiRw85K4Vveaft/8pQ1PJR4zHNxTvD0ECJtiTj1jHaq4+ZO6d29DxxHffKRs5snUH2sIh
        xaaMPemYtK3F+RNvWszevVyUd0U+qIsEyKDS7FPaG5nlhO3rA/vbx7/lmnzpuHnTufr6rG
        XMx6z0R1KsYU3IBqxZ5Ph33NTdQd570=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-O_22ow_MPp-R-PMunZ3LVQ-1; Fri, 03 Mar 2023 09:08:57 -0500
X-MC-Unique: O_22ow_MPp-R-PMunZ3LVQ-1
Received: by mail-wm1-f71.google.com with SMTP id l31-20020a05600c1d1f00b003e8626cdd42so982018wms.3
        for <selinux@vger.kernel.org>; Fri, 03 Mar 2023 06:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtGvsJ1cDwCnysKk0ZTjXqMejjfHzfnthZARNTdSf7w=;
        b=su4eHcfi0fy1ihcrEEVunRNM7bY0vuR5T/RX3L0ayspTC+/C02n+whMoGH3wjugL1z
         ZWHrFJdk8p+2VAyzkBI2Iy7mpzB4QlqaAnDqhxF9wxZ8Y9jdL1nAKdJSvsM5Jqv85UD/
         9mZzgnuP4Nb0PsvHl876WzHyMEQ2mNOuPDrOcd06J5PRQMMC+b+MR4jUjFqBgWk4Hc2t
         AodtbZxUrHeoxcqiaUSm5GdGSiRb48xQrefXigot/rQhU1ax9bOqLY34Q8pPlY1fuwxw
         pT12mIrwa9833udrI+267tlOtx69Ct8xfGex59EVacFkJCqch6nf5QyR0HymTVIb0Hhk
         EMUw==
X-Gm-Message-State: AO0yUKXJhjkvQml9+3mmVny1gAK2bUA7SW3EDO2qcZ4Op+tnpejRHmdh
        7yhpYwDxUR5aJNX72gCJbZ/u5ltGVOGVqt47w8JFXfSFIrRyDFCyajnUQYoKFeZ0YyEExYO8Xop
        E1Wdhz8l3fMPQ30DBXWkFELEWbhjwA65nXfuRbPET8cRTgU45+VKDcbaT7expnvm/rfGtfaNPcT
        IOnw==
X-Received: by 2002:a05:600c:4746:b0:3eb:36fa:b791 with SMTP id w6-20020a05600c474600b003eb36fab791mr1663228wmo.31.1677852535752;
        Fri, 03 Mar 2023 06:08:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8sR3x59YYwonxz5RLfzEh/uyN/GeqynN6/HyXxklXzPF6G25mQVIVBNBrFL1yn0XGo5RKwrg==
X-Received: by 2002:a05:600c:4746:b0:3eb:36fa:b791 with SMTP id w6-20020a05600c474600b003eb36fab791mr1663201wmo.31.1677852535468;
        Fri, 03 Mar 2023 06:08:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c41d100b003dc4fd6e624sm2423650wmh.19.2023.03.03.06.08.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:08:54 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/3] Infiniband test fixes/improvements
Date:   Fri,  3 Mar 2023 15:08:50 +0100
Message-Id: <20230303140853.1276325-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add missing policy rule needed on systems with strict resource limits,
add another missing rule to reduce AVC noise, and simplify how IB tests
are activated.

Tested on an aarch64 machine with an IB device and RHEL-8.7 installed.

v2: add comments explaining the newly added policy rules

Ondrej Mosnacek (3):
  policy: make sure test_ibpkey_access_t can lock enough memory
  policy: allow test_ibpkey_access_t to use RDMA netlink sockets
  tests/infiniband*: simplify test activation

 Vagrantfile                   |  1 +
 policy/test_ibpkey.te         |  8 +++++++
 tests/Makefile                | 11 ++-------
 tests/infiniband_endport/test | 39 ++++++++++++++++++-------------
 tests/infiniband_pkey/test    | 44 ++++++++++++++++++++---------------
 5 files changed, 59 insertions(+), 44 deletions(-)

-- 
2.39.2

