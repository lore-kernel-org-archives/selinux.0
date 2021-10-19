Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEBCC433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1B96115A
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhJSPDq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232827AbhJSPDl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sw9AyOM2fnUVdoGnx7vC5NrxnM5onpdxqgZxIXEGFfw=;
        b=PKLNLgKPJnHXA0NSRLwyvy+/H6PCHOAlTwbdHBVHuGwLrWly9Cyi5UkXYxe+5PEJNxGNZn
        3Xseq6PiqYCJxr13ahfiB/Ozl+8cxNzsCbY8GSufFFLyr0iElhKfIBmoVGjooxyFgnVm3f
        FW+VUw9UlmX7dbFvTo1n0fR/2a6W9hI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-vdaqW-37NZGXRA_gOcVO0A-1; Tue, 19 Oct 2021 11:01:27 -0400
X-MC-Unique: vdaqW-37NZGXRA_gOcVO0A-1
Received: by mail-wm1-f72.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso2606120wmc.1
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw9AyOM2fnUVdoGnx7vC5NrxnM5onpdxqgZxIXEGFfw=;
        b=qBZWWSrWx36bW3o5SvxrXnkMBWcEV4YF86faN5dAlWEjAgWFCdASFmqdFCkib8AK8c
         JLgNxVwNdsDAWhP4jZS/ZXdFUztQ9PN1nkkRub3szLdwZxyj+tCouGcCqQEfGeoO9tcG
         KcAveZ9VMJ6kv2Xn+1HXxAeQpNP4TBC2xLKzb6bWNs+bsiKrrzv1TBWcLaFWUVU4KhRj
         zLQMrCXyOmfGiY5Ms1Zb0VpsXaB34aBKNlXHHoQy6LDDanSjnIw5fc5eYCfWjVWA/ZrW
         maBrgOItEEePbJqbsy03du394awT7zi8bmvFLtcb6VTW/7MfPgyAEbfh7FnMItzE4V0J
         yT+Q==
X-Gm-Message-State: AOAM532z9LKI1LHG5mKc5B0qswhu4E/m676991NMA6D/Xya7AgNkeaMg
        kLHn8gCCTdR+ViqWHPgw16DmNJ5YOIg1Xw5r+WByiXhZe/cd5h6q/z7OOQDW2wNAwogMw5TTi0y
        194T/Rc/Fj6BUUc5RtjjbwINklfW3GBAn+n+Hb01GiUlqU8zW+/oxDBAN3Pc6lllY4TjwNA==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr44654731wri.253.1634655685612;
        Tue, 19 Oct 2021 08:01:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcrQzu6VP6wzEfJYq43qzP+ZJ1v6yV+uD2vThIpyHBOKnvr12x/BqRGCsFkOEuB9h4sM61VQ==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr44654691wri.253.1634655685358;
        Tue, 19 Oct 2021 08:01:25 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r4sm19271630wrz.58.2021.10.19.08.01.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:01:24 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 2/7] selinux_restorecon: simplify fl_head allocation by using calloc()
Date:   Tue, 19 Oct 2021 17:01:17 +0200
Message-Id: <20211019150122.459722-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019150122.459722-1-omosnace@redhat.com>
References: <20211019150122.459722-1-omosnace@redhat.com>
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

