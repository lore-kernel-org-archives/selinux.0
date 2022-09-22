Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80220ECAAD8
	for <selinux@archiver.kernel.org>; Thu, 22 Sep 2022 20:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIVUc1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIVUc1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Sep 2022 16:32:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C910D65D
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 13:32:24 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g23so7188891qtu.2
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc:subject:date;
        bh=AcIt+Uo2hHnaWSk8mGnHuxcNdaymRwOwuOWYYFJ5zHQ=;
        b=4lmqvnuaFRIJa8Iyy7ht6Nz3wazv2mf5vew2ntDogZ3TPfZ0vKwrSksBTQPjkhPYHE
         ko2m6xecLjv8ukh5hsSQ5pkh86TuBfuihroJtvT2SsC/rWL2bsVvKxV/bX1u+4yBzeA7
         HB/++TyeBZkO9ezmO+aK5k0wIKANeGb3ScAyiKjzW1h01ViM2uSG0h2+V5M5IyryC27b
         vx2CAunPa9C0Fv977/WnzdVbOBY4qi6pRhS1LCxas67wXgq0CD2vQqqU4Yhz73hK/rIX
         kRDNCCdt/BO0mvfuLSE3aRHfD3pZWsvuZ+BAMoK20g0XLHaoclXEnnMtoihDII4hYQpW
         5spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date;
        bh=AcIt+Uo2hHnaWSk8mGnHuxcNdaymRwOwuOWYYFJ5zHQ=;
        b=15ENUoddTtomlbFhr3s0jaZOOIlhC362tTaHkXKmuM00tUECphRvdmeUebATVqPvl4
         3yXQH3C43PAU8XVJoFOcJ15TgkiftOe3h1Ak2+R6FtUyhXovmIqbhzNclNsTsI9CVU1u
         SaL6R7NWZ+fzv+MP4ifIoO6Qt2IU3BL4gifeXK7KI5KVwkpS2bPfJOXS7Rb0LP227Xko
         sajOKetYnp+BhW79EmRFoiVWs1MSXSLwl2I6DxWGre4CxmbC+z2/MT1PnOTC+QrhPpf4
         OSz5t33x22Mr/9hSCCb8/W0e6nveqmgAm+/LUXISnH2G9LZ2WPqTPbWd+ZME0Yxnws5+
         AG4w==
X-Gm-Message-State: ACrzQf2BxsFRIuhK6ZceKVoQfHLy6kBLEwJRuc5H1PA1SwmaXlAp41BW
        Xaf87hG4sUP8xO8pf1L8rlbTYKrBAB6j
X-Google-Smtp-Source: AMsMyM7PZ4atDvTLZX7b/7DN5tw9MYb5dLn3APV4xhQ3SgLo9sy0/blv52or6W1l/tALoTUTp29pKw==
X-Received: by 2002:ac8:7d11:0:b0:35c:f5c4:324a with SMTP id g17-20020ac87d11000000b0035cf5c4324amr4495986qtb.400.1663878743177;
        Thu, 22 Sep 2022 13:32:23 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id fd6-20020a05622a4d0600b0035bb732ac93sm4311457qtb.88.2022.09.22.13.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:32:22 -0700 (PDT)
Subject: [PATCH] docs: add Paul Moore's GPG fingerprint
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 22 Sep 2022 16:32:22 -0400
Message-ID: <166387874213.1884920.6973035378183003234.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 SECURITY.md |    1 +
 1 file changed, 1 insertion(+)

diff --git a/SECURITY.md b/SECURITY.md
index 37630585..c817eac9 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -30,6 +30,7 @@ the issue as quickly as possible and shorten the disclosure window.
 * Joshua Brindle, brindle@gmail.com
 * James Carter, jwcart2@gmail.com
 * Paul Moore, paul@paul-moore.com
+  *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
 * Jason Zaman, perfinion@gentoo.org
 * Steve Lawrence, slawrence@tresys.com
 * William Roberts, bill.c.roberts@gmail.com

