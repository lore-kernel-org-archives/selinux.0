Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C0C6FA8B
	for <selinux@archiver.kernel.org>; Wed, 21 Sep 2022 18:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIUSyg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiIUSye (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Sep 2022 14:54:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62FCE0E
        for <selinux@vger.kernel.org>; Wed, 21 Sep 2022 11:54:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so6926826pjl.0
        for <selinux@vger.kernel.org>; Wed, 21 Sep 2022 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ViFWE8rUGPahmQO2QhLJH1++s3o9nLBPv3NoSy15NQg=;
        b=J4XLQhN5fJick2CTLnFgqVsB0WVB8mRp9qiiQPvIe01XWRbwaf930Sn/GDQt74GgtV
         TVd3gUm7LnVgQgUjjvji+omlUDNpd/gjm7njKbdP7eRexBMe5KBryOQI0q/fsIS5y2VS
         4pgACHUyqD2Ny9cT9DE5WFvQHjECWKqPAxjrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ViFWE8rUGPahmQO2QhLJH1++s3o9nLBPv3NoSy15NQg=;
        b=d6kKh1wwaQE7WTnllWP2pk8X5bMfpNfu59bmYdP9RHmlzFrA8W3afvBtq8agFBVWrF
         a66dZ6GTNR8YVAhHisW2Gpb5lJvKGw3NMwZlZLl56HWJjKRmxjnKlkMDUywOTCoevuUD
         +kg0KH+8KNl0dbvXlWR6AWai1yjN7x8aUwOTpGmYiRVcT2N2Uw1itg8JBUjs3zVZGaAx
         v7aVMxETnQiEjmVbpUpPGv5S7lKabm3lSMuW1Xqoo6LzdWUxeJv6P/KX8st5AapptQlD
         4qgxKzAlIBD6h+4OA7BXBAZImtryq79BKDizDKnsH+XPt3Y1gLiVW4X0rz5x5Scxz9FZ
         c19g==
X-Gm-Message-State: ACrzQf0tP0JvIVIzbHhaXTb5akdxNbqwn9PrrtGxE218ta94EgFlRJl+
        1VCRaGlJx+FeLAIk7psH/mZEggx8AQENog==
X-Google-Smtp-Source: AMsMyM5L2SYyoILQbW6sygnDjWLiJfwJGmrsuK6GFOlavVJgsCAQLpcTf9B5Q0vd1FNnph12l1t5gg==
X-Received: by 2002:a17:902:f68e:b0:178:3ede:a147 with SMTP id l14-20020a170902f68e00b001783edea147mr6029297plg.136.1663786472993;
        Wed, 21 Sep 2022 11:54:32 -0700 (PDT)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b0016ed8af2ec0sm2430838plg.29.2022.09.21.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:54:32 -0700 (PDT)
From:   jeffxu@chromium.org
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 0/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
Date:   Wed, 21 Sep 2022 18:54:25 +0000
Message-Id: <20220921185426.1663357-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

This patch was originally developed by Luis Hector Chavez
<lhchavez@chromium.org>

For systems that use SECURITY_SELINUX_DEVELOP=y and allow permissive
domains. The audit log from permissive domains can be excessive in
practice, and this patch is useful to avoid the log spam.

Luis Hector Chavez (1):
  Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT

 security/selinux/Kconfig | 10 ++++++++++
 security/selinux/avc.c   |  9 +++++++++
 2 files changed, 19 insertions(+)

--
2.37.3.968.ga6b4b080e4-goog

