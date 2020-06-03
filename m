Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC2C433DF
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 10:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97809204EF
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 10:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzlowv4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCKPn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFCKPn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 06:15:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1F4C05BD43
        for <selinux@vger.kernel.org>; Wed,  3 Jun 2020 03:15:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c11so2019736ljn.2
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2020 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+gVml31BB5v4M3vY/NkNrC1CqQzdVWxnZ81ZxoMyvY=;
        b=Yzlowv4AYKDHw3a/nDLIo8Ge0Cftuy8UuXlT34h4vwXfi6QXSUatntd6FDqKVAuQGn
         tjLzueAVfJeiV1MRLjuwj4+8Wp3rKi8E6IlRKXWd/h+eiKD9sQSjP8tHxb0uEBFnGWWR
         FDCTFXA0c1ThLek0RioBcuXhS8J+npOlq5Cp0bjELDA6hm+fLqK9NTca9hFUcMckX4pz
         FFBfqnt5GCYvjsyaMgq8saMHDWkyUBbOZE3NmuEWTF/WiaYCBSUeLLZVDWqjTLVH3VY7
         41+jh7X8MZtEIYh3lyn/3k1g+R6Qnlc6n6bhd3iaANyN5bkY1wsO40e2nkwefr3qPuS2
         6A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+gVml31BB5v4M3vY/NkNrC1CqQzdVWxnZ81ZxoMyvY=;
        b=CjMvC3X8sFOTs1r3a6B3qXYiAAQNUu/btywnfSVUMNv9u9IIbvTd48US7o+N4mio2C
         brQ2fqOmZ3wAq/YrSil8PXYgl04x065rQDiGfToHo59Br9NMvnc4nOYOKKFNMs/7FtVE
         wIlRBhIPzfJ7OsFBHw1xRNenRudTomnHoyT+uGnmPk7dntldSSMQORCJ7pv1G+Bg5R4B
         rvAilvDHs51hO9MmiOkm8suwsRYxZXrViYXcp24bCODzb5GOe0DFJ6xxEeCBBcZqPUq8
         D7YCtvime2I9A+C4W7X9jUTaxdxM3o2auMTy1hSpfHQ0bn7KV890S6fx5yq1J2Ky97dJ
         WIGA==
X-Gm-Message-State: AOAM531Qdvk4vKINQKU/qHr0Fd7Q35MFoyp0ybPdS5SEj6U7yS9WjIDp
        rbLgHNWnqmZKyoBuhwqK7PU4etr3
X-Google-Smtp-Source: ABdhPJxKKWaGpwMXjQYfntERabonweTYSmEE8XyCVsmfvCCRr6mlMr1wDE04ph+/WGZvl1bV+7m55Q==
X-Received: by 2002:a2e:8687:: with SMTP id l7mr1127890lji.246.1591179340643;
        Wed, 03 Jun 2020 03:15:40 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id t30sm481541lfd.29.2020.06.03.03.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 03:15:40 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] semanage-node.8: describe netmask
Date:   Wed,  3 Jun 2020 13:15:34 +0300
Message-Id: <20200603101534.4666-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Network Mask argument for `semanage node` accepts also the simple CIDR
mask format, so let's document it.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/semanage/semanage-node.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage-node.8 b/python/semanage/semanage-node.8
index e0b0e56c..a0098221 100644
--- a/python/semanage/semanage-node.8
+++ b/python/semanage/semanage-node.8
@@ -45,7 +45,7 @@ Extract customizable commands, for use within a transaction
 Remove all local customizations
 .TP
 .I   \-M NETMASK, \-\-netmask NETMASK
-Network Mask
+Network Mask, either in CIDR (/16) or address mask notation (255.255.0.0, ffff::)
 .TP
 .I   \-t TYPE, \-\-type TYPE
 SELinux type for the object
-- 
2.26.2

