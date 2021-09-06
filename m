Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4A1C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D0360C3E
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 10:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhIFKzp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233720AbhIFKzo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Sep 2021 06:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630925680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NDg2JWNmPGrUZ8wcBOxG8hXhZYxcWaiBkonavT/JT14=;
        b=YfILst+rtY2dtTnHQciqYiDFwYafdMUGSPuKFfSFgH1gqQWKZ9/PuqzA5Tm1SxaP0HiKMm
        qSPKI6ZYlPQ0LqgF+PbPT8UgyaWnNZeUlTXHfHN9S2e8Qxi833EZG5lWfE4hYUJ4hH2YuG
        EjH6oex2OwQVoHJpqsTHuwKgom4QYTY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-NuSkzA9_NGqwVVq8nnqycA-1; Mon, 06 Sep 2021 06:54:39 -0400
X-MC-Unique: NuSkzA9_NGqwVVq8nnqycA-1
Received: by mail-wm1-f71.google.com with SMTP id r4-20020a1c4404000000b002e728beb9fbso3748721wma.9
        for <selinux@vger.kernel.org>; Mon, 06 Sep 2021 03:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDg2JWNmPGrUZ8wcBOxG8hXhZYxcWaiBkonavT/JT14=;
        b=Rh9alyLWXifWsPcDSTd0MZIMTGjUMUZJrrE/EBjdIZ+TIanRQTJFSJQFNkXxoKVbVF
         yFp68ddowm0yUAIeNfk23piRg7zNzr7Z4WJejIwpUritd69/hsvtD/fQKh5v6ea7NnMD
         H94jibZAdL4zlqfeCbyPKKPq6U109kX+uDdPOBHfGgqvVSoJD9nkHAtuQEyfjqGJOK/Z
         PgyLCHc+IQ7ocIS8f6q0y485xkoAu+WDD0S4EFwBCn5sonL6Shql+Jol/qXUZxhMm4gk
         kRHjYNlJgw5UhA0pqN0hAMVsAilJg/2Y78TKyQobp/wRZzndAkmJAs/pLyvDqczG+NTZ
         zGEg==
X-Gm-Message-State: AOAM531CuCPTDec4zAvOq/7UmI6j3DX0RotJkiPdJ01emcoa4Ads5QzK
        F56wCjS19WPvxrJFs6qPXBlHWUZnLTsKQkt7SLaRpGhtjagKviE3eA8ZOUL2zUoMuwomj3tmUTJ
        T8VetRshL2jgl4dbDjBs8l2qZLIsUKGspqpvbBfKk5dg5G/ER6isHVos3g1Rp64q7CUWBvg==
X-Received: by 2002:a1c:98d8:: with SMTP id a207mr10448809wme.16.1630925677590;
        Mon, 06 Sep 2021 03:54:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2yFBFXV8303fzDLt1/bR7kvH7DWkFePLU0HolT+2mOTMw3x4Q/eFqSpmKkINWOyrLGItSbQ==
X-Received: by 2002:a1c:98d8:: with SMTP id a207mr10448788wme.16.1630925677364;
        Mon, 06 Sep 2021 03:54:37 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m12sm7461878wrq.29.2021.09.06.03.54.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 03:54:36 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/2] tests/module_load: simplify the clean target
Date:   Mon,  6 Sep 2021 12:54:34 +0200
Message-Id: <20210906105435.96417-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

No need to guess all the wildcards to remove the intermediate files from
module build - we can just use the kernel module build system to clean
them up for us.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/module_load/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
index b6eba25..ce34241 100644
--- a/tests/module_load/Makefile
+++ b/tests/module_load/Makefile
@@ -9,4 +9,4 @@ all: $(TARGETS)
 
 clean:
 	rm -f $(TARGETS)
-	rm -f *.a *.o *.ko *.cmd *.mod *.mod.c .*.cmd Module.symvers modules.order
+	$(MAKE) -C $(KDIR) M=$(PWD) clean
-- 
2.31.1

