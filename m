Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B402C33CB8
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126A22465B
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6ilF9xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVPrF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:47:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgAVPrF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 10:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579708024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AEQROmI1rYNcfex/ub9JvmWDAcn867q7P2H/yW8vP8U=;
        b=H6ilF9xh/ZSbKQW+73Vatm1KQGAOoC84yUbBmk5ZgrOTethpLY7XDd4HQ0EFs365fWYUnP
        YcOGZHsXmC8MSlHD1r3F8jKBawI4GAt+GV4cJAmhg2gLvnbL4WQm+ywIaIDJCSqQw7CfpI
        FkmGwIxEy/n/QnVuUHNU9bV/BC2JaCE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-jvgkadv6PbSF0VZHggMo2w-1; Wed, 22 Jan 2020 10:47:02 -0500
X-MC-Unique: jvgkadv6PbSF0VZHggMo2w-1
Received: by mail-wr1-f72.google.com with SMTP id f15so3297837wrr.2
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2020 07:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEQROmI1rYNcfex/ub9JvmWDAcn867q7P2H/yW8vP8U=;
        b=OXeJDgFpazEyOXaDg6ALlG/L2M6r2nniI3Al5VG1NzK376pTQBwzNfb+5XUlo+Qqzm
         JWcfbWLCPBBq1evP5H6A77gOKSLmV/ogFoY+hLkvZFVj7TIOSeQlkyVlCKbSWvFgD0Rb
         38ZAi2+LeSy/bvlJyOweavnfuC6LajyVz98E3Dbzhbzv16nXN7yGbpoXFqOJYBDpgKIg
         iMqm6Uq8mUfuPNCBK5IqPQPiWeCf3hlIWojbBifTXR4LjN2thpzQ3awtqGPBGhs4LKSb
         KTZMwx3gHj514ytu+2lwWoYujuHHf0/ov8f/FBcMQBzz9vf8fNrIpKMKZHzwjZd2Slv8
         8k3A==
X-Gm-Message-State: APjAAAULE94H82p1hRQSK7BUDxQMdWWMVzO3lVGONa4/km6SEHNAzlC0
        gt8v6jkOt59YlymWS0JagUVLVf6bkgcv32RamI8M/aL2s1eao7glQ89duhVY6g4eZAcd95r1N6v
        5nhEHaVqGts/yNeyglA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr3552693wmc.173.1579708021402;
        Wed, 22 Jan 2020 07:47:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqypjlyIFaNoMRmP/3Uu3vKBSUowl/D0/pZia07ifYj15VpyhoZ5Q0sulGp+HmPxXvdZlMU4tA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr3552684wmc.173.1579708021249;
        Wed, 22 Jan 2020 07:47:01 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c5sm4811788wmb.9.2020.01.22.07.47.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 07:47:00 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 4/4] Makefile: always build with -fno-common
Date:   Wed, 22 Jan 2020 16:46:55 +0100
Message-Id: <20200122154655.257233-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122154655.257233-1-omosnace@redhat.com>
References: <20200122154655.257233-1-omosnace@redhat.com>
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

