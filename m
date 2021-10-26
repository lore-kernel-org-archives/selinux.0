Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB0C433FE
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAB160F0F
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhJZLzM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235575AbhJZLzK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sw9AyOM2fnUVdoGnx7vC5NrxnM5onpdxqgZxIXEGFfw=;
        b=DockSA04ZxpOo4YW78PqFhoeG03KnF105TKAPSpF8gVx8CRH3JYsU+A1pUEfLNj/Z+Fzkx
        Zgq1byYguqcxBYaxBEF+puKkOfNrpT8OhxvGocmWT4ltW+IGsuysSikYCUi4c13+F1lHWT
        je1Y599OuzPqfFMkh0s6bFSOX765XyU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-8JM8CrNOMKyyzGTEAVKa8A-1; Tue, 26 Oct 2021 07:52:45 -0400
X-MC-Unique: 8JM8CrNOMKyyzGTEAVKa8A-1
Received: by mail-ed1-f72.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so12787776edi.12
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw9AyOM2fnUVdoGnx7vC5NrxnM5onpdxqgZxIXEGFfw=;
        b=5pROejFp31YEDpKxNxIh5j7NxU31GGG8qFxTh0JbDZWGcc1zE7vns1n8Mxvh39V3SB
         eIAuNVViVWn1kHvMniL4qYfK++GFkKCCzesVtg0YV3a7fPeB5GRFqFPMzXSOoJQ8Q6aS
         27AnvfH9GFMPWbRSPysGq66BONZ70qdgNUApQ4Z1+VBrVW22g7fa8fCCIBwUL2kuTgUY
         TGVagQHyjDC9nk3J6wMPcr5yNfg114QuV0MW82xPqoRbpwZdl2eteW1fooz7YpCwDE0K
         a/jhur1BaLhqwQhqGa4dM+FwSpMWEPIIsAs5Yovc6gR8DNGzu+kyOmmI24QUB7hBXu5e
         Kl2g==
X-Gm-Message-State: AOAM531FWc/eh+Gf8S3zI+VuMNrhEHBn72tJ6YTQp7QlRFO0rnUWSvT2
        /zKNWyja+XYHeBeGpttoemJvCMEZxoe20Fnki5qy99BGhoOYjUdkbFjLlhjp9HI2ZJBmhD2vWic
        egtzuvz0YzagMTUan8UeFS454NlOd6oVLGctvNjgjsvkvXnsB2uo+7fFdMuXL0IVbPhr+Kw==
X-Received: by 2002:a17:907:764c:: with SMTP id kj12mr15539923ejc.290.1635249164282;
        Tue, 26 Oct 2021 04:52:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxYBaZXcZsiF9cVQKUVRSnfgEZ+3UK1dFyz2pydV1QVIaTIKgvGVaRY4xhfTjYJ5HMBr312Q==
X-Received: by 2002:a17:907:764c:: with SMTP id kj12mr15539894ejc.290.1635249163976;
        Tue, 26 Oct 2021 04:52:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:43 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 2/8] selinux_restorecon: simplify fl_head allocation by using calloc()
Date:   Tue, 26 Oct 2021 13:52:33 +0200
Message-Id: <20211026115239.267449-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
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

