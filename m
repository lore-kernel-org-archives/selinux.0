Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D071C43217
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 14:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiKDOjM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiKDOih (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 10:38:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7252748FC
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 07:36:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i9so3131533qki.10
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DhZGRX+p1iUD7EHdIOR+jbU30eqoodFG8zNguMuk9Q=;
        b=i/3I4IopzBwR2y/ZaIPsL3sn1plEkEjhUXYJe6s3om/t7evYDEygKoZx4PIyr7Zi3T
         76M/8VtShc7POi96S8u9QlPe3DRhGD59JN8O1lx303K0SRLuXBVm2Y6OAXO64cYGEY8v
         8r+XsTf7BXrNA+GTL2f0WLLKbDwWj3LMkKk5W4lqk/b4vlInq8FOWJ5V4FRBBviVqwQk
         CrPFyWTilJCfYw/BRIyng5ngtbv+Dv1mLllwmpsr5GoBn9l9morCr4JF9Tw7+rLBotZj
         yEbBmqtI1G2T5vgvJGpgOIy/eYcR5xfZULfj8VHnm4+6beGp+KY4/BRI0L3oH+j9tAPv
         OVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DhZGRX+p1iUD7EHdIOR+jbU30eqoodFG8zNguMuk9Q=;
        b=AbgEfGEYNNdraJkublhDLIp3BzX2g1llNAoiABqoetJL2hnJAm7Do5CVqtGPPJZN6m
         1PEDMh6ByWjhR6R6IcUlwK9lAXYaw4xQH1hXE+XEXmGzEzmPGeiAwqW1QoOQhn/j47s/
         zkC8ymCdaDOJW+z1BDGqPucmtW/NHcyOtpiF+x/L4qoA4aMgtmMNy8em0LotrynW/zC7
         g198/nq65hZdXSgd1vSIRkCMNIEyCglO+hs0gejBFnfjLuyWDWXSUNOwWOn1jyxcnMOV
         RKazqHTin+y2SdlF1dOkvFbWT7RE5pPOEYz6+NAVczB1o8+++uq9vZGohdWVBkXQKMnp
         dmrQ==
X-Gm-Message-State: ACrzQf3D+9AiDMR3svNgPTvxV5NidKwqUZXy6d8gb8Tp+XFxT06tkXPg
        d67DYiax3JYyxA4ouZpAAKSCLwEYs/c=
X-Google-Smtp-Source: AMsMyM7PILU6qDGwpvRGA3oHBTbLszbduG+CtnpSEbBlEw0DCw+LVhTKeddqcYhgXOnKrhCj5cQh7w==
X-Received: by 2002:ae9:e70b:0:b0:6fa:509f:cb2d with SMTP id m11-20020ae9e70b000000b006fa509fcb2dmr13814646qka.181.1667572586687;
        Fri, 04 Nov 2022 07:36:26 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b003a50b501a01sm2479324qtn.87.2022.11.04.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:36:26 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/5 v3] README.md: Remove mention of python3-distutils dependency
Date:   Fri,  4 Nov 2022 10:36:16 -0400
Message-Id: <20221104143616.1089636-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104143616.1089636-1-jwcart2@gmail.com>
References: <20221104143616.1089636-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the removal of any dependence on the python disutils module,
Debian no longer depends on the python3-disutils package.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 README.md | 1 -
 1 file changed, 1 deletion(-)

diff --git a/README.md b/README.md
index 74b0a0c3..f91cb7d9 100644
--- a/README.md
+++ b/README.md
@@ -81,7 +81,6 @@ apt-get install --no-install-recommends --no-install-suggests \
     libpcre2-dev \
     pkgconf \
     python3 \
-    python3-distutils \
     systemd \
     xmlto
 
-- 
2.38.1

