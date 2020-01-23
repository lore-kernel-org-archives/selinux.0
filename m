Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4396AC33CB6
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DF524673
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYPdka9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgAWM51 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:57:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726227AbgAWM51 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 07:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579784246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AEQROmI1rYNcfex/ub9JvmWDAcn867q7P2H/yW8vP8U=;
        b=IYPdka9JTgVxev2a29k2aL5Qdytp4vALKK1fcHw92RTVH5R/cqkPCImaOKBuFP7wEolgha
        9a1JBVcGAXWUKtI3H6VeQ1fb/D9wvA6lPZJqhFmtwOZnSiZkBsm0tNZ+z4huVNZ8D3AMov
        QOAsWh+aWnjRk5T07ebuNYrnaxlrF1Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-LZ58JgZ6NSGK91CuSLlFwQ-1; Thu, 23 Jan 2020 07:57:24 -0500
X-MC-Unique: LZ58JgZ6NSGK91CuSLlFwQ-1
Received: by mail-wr1-f71.google.com with SMTP id t3so1613901wrm.23
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 04:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEQROmI1rYNcfex/ub9JvmWDAcn867q7P2H/yW8vP8U=;
        b=Xxza8CJJPSi6ksT8NXMKcJIUtsLxG/bdAZZmi4Vtg3h4/EvHq7R+FwWw7htodYMV5o
         SvCKMc7NYSXuHoK1P+taaHreXFI3I73VuLSFF5nfaytOP8rUGyDs1ph+0eveI4164ZPp
         FEVEzTeZjStS+1t7JkSQnw4QbvAcGRiXPD36vmdDqL2z53HwqCZumCFBvhCXiTkfnkNf
         IsWp4RwjRFmuEL/tWSF7wW4u4PyZu4A0563Ce89KmO2KxOLwC/0++RzIa6TxU5SJLx1w
         +y/oNaoSdxutAbgBSQdT/CIDOcWbAHpmeWvk5vNDPrPWUB6mHYvFiWEWilxMqACqQHMu
         um7Q==
X-Gm-Message-State: APjAAAXPVwVi/BM/i9e1OwWPsx9fuMV6iCqLQt8bzhUhUWHhGGnFz6Jg
        79sVYJU5gm0cMC26CzdiTl41gzpJDSDHCgq5X/fzrBMYtZsJD+4MYiUV0ITIvdZ0nVVcCS6ZZJX
        YgbDQa27+vp7mNAdw4Q==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr4116979wmj.130.1579784243211;
        Thu, 23 Jan 2020 04:57:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVYtds6UetVTLFLMBOFGPQN1nJuD1UhwW6rzH5KQcdYxJ2HsTl20JBaUYOjmgyfsukEVY5Pw==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr4116957wmj.130.1579784242952;
        Thu, 23 Jan 2020 04:57:22 -0800 (PST)
Received: from omos.redhat.com (ip-46.34.233.121.o2inet.sk. [46.34.233.121])
        by smtp.gmail.com with ESMTPSA id d8sm2821028wrx.71.2020.01.23.04.57.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:57:22 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 4/4] Makefile: always build with -fno-common
Date:   Thu, 23 Jan 2020 13:57:16 +0100
Message-Id: <20200123125716.12662-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123125716.12662-1-omosnace@redhat.com>
References: <20200123125716.12662-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GCC 10 has it enabled by default and everything now builds OK with it,
so add it to CFLAGS to avoid breaking the build in the future.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c238dbc8..298cd2b7 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,8 @@ else
 		-Wstrict-prototypes \
 		-Wundef \
 		-Wunused \
-		-Wwrite-strings
+		-Wwrite-strings \
+		-fno-common
 endif
 
 ifneq ($(DESTDIR),)
-- 
2.24.1

