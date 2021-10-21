Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC64CC433F5
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 14:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9AD60F59
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 14:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUOLF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUOLF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Oct 2021 10:11:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B5DC0613B9
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 07:08:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u13so1684739edy.10
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdCQW1G10YZSzDINt9UwuwFtc8qP1S8JJjUvMo0BMqg=;
        b=fCJBtEhf51lcd5QVvVqNEpa1FjhIHIgCh4V6kZ6B0AWqH+mgx/skzWA6NUMiDelyNi
         QRsak8x6BoHrt4L7+MBj9oBFlDro0RBT3zhmIpteLEgFvIHnhDrk40AQruD5jp8MI6bu
         daQSPO7IgMyZFujMLYDIzdF/GALxYs+kktOhFjUNB/m+ozd5Q3nEVpXFTaZpjw2LSS6E
         pK9uO1NZymD/C8VnE+UM6gAEMVcOpoOgauAQxd8ry8ttXD1YM207Zua36lJxBO4supXX
         szA/30+7j6MGhTLy36TElm3QMnj2xqQZ9lkOU+8or7dvRB0zjLtSkTw1KCUJA+FQzD+z
         7skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdCQW1G10YZSzDINt9UwuwFtc8qP1S8JJjUvMo0BMqg=;
        b=5tXpv9GX+9sShTYqQk+UVZuVnKVloeKSVDqfRUuAmL2M0NNyI5rtdwf+tmEJaVRShq
         zbGt/myyqARyAq1U7kvd05uwa8VUytAJtU3S7oH0qr+VFJfuw4CbKsuHxdaH1Li3yBq2
         vV36Xa1GOC7BScxrwYo7M6k2faZGsFeZ3l6XosCgQYRYQuXnUiRRtRd6/DDVyyJNP/F3
         hLIsYQjWLj0fVtINvFRN2KBZbc1X5T9qWWqtAsV3usMu5EkTkdhx2y6O5tPA7T/V/TJE
         PrN6kxXMLNYRIp0BilRWFviJavzqAdVOQvs93YmnlbZVOA56ZbUlZCP+cv2VJOu7+N02
         JiNQ==
X-Gm-Message-State: AOAM531LzJ6Gy8fjRKtX0yGYLZLYcufxcAThXcT+6yKQWLBMaO97By9f
        oXKEIphYp5cLaZxFNYM2tW4EAYI0LRA=
X-Google-Smtp-Source: ABdhPJxOH8fZT6zLKs0sdXzZBjhjiXEz4EuCwKZf2Q/JnDe0sgAxKit6u2iC7yhxCrLukmuCjpnUuQ==
X-Received: by 2002:a05:6402:5188:: with SMTP id q8mr7868029edd.332.1634825325076;
        Thu, 21 Oct 2021 07:08:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-131-102.95.116.pool.telefonica.de. [95.116.131.102])
        by smtp.gmail.com with ESMTPSA id w1sm2561096edd.17.2021.10.21.07.08.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:08:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: avoid passing NULL pointer to memcpy
Date:   Thu, 21 Oct 2021 16:08:39 +0200
Message-Id: <20211021140839.7439-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

memcpy(3) might be annotated with the function attribute nonnull and
UBSan then complains:

    module.c:296:3: runtime error: null pointer passed as argument 2, which is declared to never be null
        #0 0x7f2468efa5b3 in link_netfilter_contexts ./libsepol/src/module.c:296
        #1 0x7f2468efa5b3 in sepol_link_packages ./libsepol/src/module.c:337
        #2 0x562331e9e123 in main ./semodule-utils/semodule_link/semodule_link.c:145
        #3 0x7f2467e247ec in __libc_start_main ../csu/libc-start.c:332
        #4 0x562331e9d2a9 in _start (./destdir/usr/bin/semodule_link+0x32a9)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 02a5de2c..ed777f8e 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -293,9 +293,11 @@ static int link_netfilter_contexts(sepol_module_package_t * base,
 	}
 	base->netfilter_contexts = base_context;
 	for (i = 0; i < num_modules; i++) {
-		memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
-		       modules[i]->netfilter_contexts,
-		       modules[i]->netfilter_contexts_len);
+		if (modules[i]->netfilter_contexts_len > 0) {
+			memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
+			       modules[i]->netfilter_contexts,
+			       modules[i]->netfilter_contexts_len);
+		}
 		base->netfilter_contexts_len +=
 		    modules[i]->netfilter_contexts_len;
 	}
-- 
2.33.0

