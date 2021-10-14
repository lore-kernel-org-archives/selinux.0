Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1511C433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C611560F23
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhJNOza (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhJNOz3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 10:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634223204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sw9AyOM2fnUVdoGnx7vC5NrxnM5onpdxqgZxIXEGFfw=;
        b=HZ1lcaHQKd2o+fVUo6ECSZ0HlBPBI8wMhN22at8dcdpc0IwBVEw5e8/CRC8CFGDxNqXLwZ
        RARbh7BF0kWjUKe9u8RGV815FE1kHpJlo8CNqwyX3+qxyQgGLRL/upbi399q/dMsoO78cn
        wBgrQGt6uvJJ4aP74ztQh4iSGNXm/PQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-3NcFiP8pPQ6YY6tDB8FCGw-1; Thu, 14 Oct 2021 10:53:23 -0400
X-MC-Unique: 3NcFiP8pPQ6YY6tDB8FCGw-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so4739506wrv.19
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw9AyOM2fnUVdoGnx7vC5NrxnM5onpdxqgZxIXEGFfw=;
        b=YUdJD6Jpu0dr7d2oVIVd8Vd1t1hnTPpC0cuW7THxgvcHsseEG8QmEEh6nk9tAYXPYt
         n+mC7jYpI0iNWpNWlmjbT9X9Y2VcGnqwQcTG8aripFvg/CNPDdCI7lpYx6wS/MSOFsVn
         x4TnNaYlZt7SFNg84FiNOglgjFx8gN3PN0FkmvPOPKiaqLaVxupzAmoghB48d9/q0wNl
         TZFVLe8+M9hY8PSjcxsKTo9LNf4eVTVU2K2BDDblWox+Z5bi7WIAgJn7VpC66r3kziaH
         1JaDxdwqf/xBBzxTnEdH/EXgAsGM8EMI0WJP4xxUrT0PF5nMFHaqVbucDPCY4S04s+J8
         nhVA==
X-Gm-Message-State: AOAM533VWOpRXymRhCna0Uc6LxfPSPMsup1EpbCqU2PtdxC8EUq3fVRO
        nAnqnz+mTEYcDsdOIsptdOP2eapb6nGWsr4WQgq4u33+MvzT38Als4JGFdC13cUi1BsTtQFDLsy
        SI1yl7qy2GGrceYnOrs4shLdHqG6ffkWOFnqlDItisCYs6ZKySMwsYeA9fPOFIGS4OD3fEg==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr7307131wri.356.1634223201864;
        Thu, 14 Oct 2021 07:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt/ENmLwaMH3Jru3wabo+Up0vhOtZB/f6NV71fMBk8fjrzEV7ZS0dImpqbjOb40eEcKGRq5w==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr7307094wri.356.1634223201539;
        Thu, 14 Oct 2021 07:53:21 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k17sm2485489wrc.93.2021.10.14.07.53.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:53:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 1/6] selinux_restorecon: simplify fl_head allocation by using calloc()
Date:   Thu, 14 Oct 2021 16:53:14 +0200
Message-Id: <20211014145319.798740-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014145319.798740-1-omosnace@redhat.com>
References: <20211014145319.798740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 04d95650..15129336 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -425,10 +425,9 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 	struct stat64 sb;
 
 	if (!fl_head) {
-		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
+		fl_head = calloc(HASH_BUCKETS, sizeof(file_spec_t));
 		if (!fl_head)
 			goto oom;
-		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
 	}
 
 	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
-- 
2.31.1

