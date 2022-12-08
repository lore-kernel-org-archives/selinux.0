Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1140C63708
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 13:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLHN03 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiLHN00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 08:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D4D880DA
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670505931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GslMNphCWjDPbOzNMaKjiaeLnw+UPPkn3Rb2PQVRlo=;
        b=LOiSt1rhAk5WDcNPwP7pBhsyJwsleUUHvxm5ZtNbvP1mIN2Z2+plwxGIboWj3BYwD8WETe
        2fguWkXdlNUw3Dun+mqwBT0b9935sNyov2RUZ4s7280G96vrHeJMJ4on6Mx8SmyRHflbnc
        i/WT8+qACWu0SGAUc1cINlZAqRDWaaI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-wraMLpDnOI-rg9f4V3YEIQ-1; Thu, 08 Dec 2022 08:25:30 -0500
X-MC-Unique: wraMLpDnOI-rg9f4V3YEIQ-1
Received: by mail-ej1-f71.google.com with SMTP id sb2-20020a1709076d8200b007bdea97e799so1074293ejc.22
        for <selinux@vger.kernel.org>; Thu, 08 Dec 2022 05:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GslMNphCWjDPbOzNMaKjiaeLnw+UPPkn3Rb2PQVRlo=;
        b=vfT52a1Wz50rJ5H6G72rXf2qcEle80auYp6FzqzgDOfsDfvQ5aN8WEFpk3Y07EEuLW
         GfjZulSBzjQDuxkMlPmcUniOkcVgePkc0b6vk8843H+/OJVsMxoC13AHOQlP3POjmcMc
         Mnwlx0WQ8JDRnnMkiTYQCUN0Yq5OhEvx6SAi0xYcDEAvdo/75DIgdGHLzETMlmt7xoUV
         EPERxX6X94RVFH1oo9PD0cln4oLZbgWiAzIaN+shewlcSOdV4GWjY90MzVQc+ab6moSa
         WE/IKOEuAfzUHneuvGrkJxDA5efoT39uNFnEU3GspCJIVrb68PGqi5qcrY+940KUlONV
         KooA==
X-Gm-Message-State: ANoB5pmkVBpLhvRwMRmWTfdqHcVUpldT2fnK3Q3SczG4+SPQr7CCfWSq
        js70W2Jj0weVccfhXrhGwJ1KeKTSZKmgTlHtYwgHDNAFHutimoWk1XhWSR/5VHBkxs+n+ZJfqIk
        quLE24gggQUhASFoI8X52WwdMCgR/Xar6Ol4u5+pDkLRXs/dp8drMMdE9jpGHX5TQkEzkhg==
X-Received: by 2002:a17:906:65cf:b0:7c0:f5d7:cac9 with SMTP id z15-20020a17090665cf00b007c0f5d7cac9mr1856805ejn.11.1670505928662;
        Thu, 08 Dec 2022 05:25:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6wA/DiTGenAIlHZk75TE3lKq0aDewpS6kOcdf3MlAdWyVqO+OfNPaXy9nF8CxZ5C/cq2RMkg==
X-Received: by 2002:a17:906:65cf:b0:7c0:f5d7:cac9 with SMTP id z15-20020a17090665cf00b007c0f5d7cac9mr1856797ejn.11.1670505928442;
        Thu, 08 Dec 2022 05:25:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709066b1200b007bf988ce9f7sm9753959ejr.38.2022.12.08.05.25.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:25:27 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 3/4] tests/execshare: remove special cases for arcane architectures
Date:   Thu,  8 Dec 2022 14:25:21 +0100
Message-Id: <20221208132522.309657-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208132522.309657-1-omosnace@redhat.com>
References: <20221208132522.309657-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Other tests don't have them either. Hopefully contemporary versions of
glibc provide a common clone() prototype on all supported architectures.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/execshare/parent.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
index 7c689fd..db2e127 100644
--- a/tests/execshare/parent.c
+++ b/tests/execshare/parent.c
@@ -76,14 +76,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-#if defined(__hppa__)
-	pid = clone(clone_fn, page, cloneflags | SIGCHLD, argv);
-#elif defined(__ia64__)
-	pid = __clone2(clone_fn, page, pagesize, cloneflags | SIGCHLD, argv, NULL, NULL,
-		       NULL);
-#else
 	pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
-#endif
 	if (pid < 0) {
 		perror("clone");
 		exit(-1);
-- 
2.38.1

