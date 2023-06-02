Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378BCC77B7A
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 13:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjFBNG4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjFBNGz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 09:06:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F41B5
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 06:06:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9707313e32eso308667566b.2
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685711212; x=1688303212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2eARRnyZV76Uy8yX5RYFo2vMk0XePRi3nwsBg0QgTI=;
        b=RAvrHNawb9cLEhBZUYXUi5wy8kF6TlpEuS12+eEsmX8YgrcvwPL91AeYbfocQv6oT5
         UZym27yEbgFA//sAifvBFEYhxrLr0CGbfwnFzHGU9paRMC8IH1uet2kMETfn1reE43qD
         4+eYIYvp/g2qILjOkZt1ceuunLZO9hFtxViwd1MZln/IFrCbRLSsvd76IAQWAy+5dRiH
         NPOi/uJ6FS0+XlQf5RAFOVhFm48E3GuFl7g85lBLcQiN1vveH+U+1qr4kCyXpMDcEhYx
         PzfUF/SraUvbnf6KnM7P3ePOJGFZb1KB3woaxtnIK8nOY7MD3bRndX5dfOetISqLUGkM
         ErBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711212; x=1688303212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2eARRnyZV76Uy8yX5RYFo2vMk0XePRi3nwsBg0QgTI=;
        b=QqGro7ZBhoErY1JXe7f2/b1+EhgUgLUYm4kNpeVAD6MH/gOGm92tYSuEV57TnzSQyi
         IAeLbirfp5hMsY93K21vKCE46UZSAscICNaR2/d3vAalbu4uaRvdLvHl2lmbwuXM26z1
         n98yXNLLiAjfQ9c5F0OWYR+2Cma04BTRdi9VoA3jLsLRxserlfmT0fYFPRZflrvYY9Fl
         pbiN7zMs3DKkzD2NwrjOTnMjs9uBrS5VDxTvog/WQPdc4mlEvR6Hc3dbdtNlnw/PLL4f
         2OYXj8ZFVddgmVbUIRA4gxp+F/u45rGokFBbgHOzPhjv82xS5wtL8JF7AoO+5OOGi9eQ
         2Vbw==
X-Gm-Message-State: AC+VfDzwkHeLi7L57vNhqffDkL7pEptVJEjv33Lkpsq36Sw2fwhoKAj2
        O9janowhXXlwcZ5N+5A9pnP90m65W/iStA==
X-Google-Smtp-Source: ACHHUZ7EIsiQbVlU/NigF6HqNut5rF4t0F6rMYfWgAEBh0v+wSiQNs/swmjSXgT+a3il8sb33Y2iSg==
X-Received: by 2002:a17:907:9305:b0:974:1c90:b3d3 with SMTP id bu5-20020a170907930500b009741c90b3d3mr10872634ejc.12.1685711211724;
        Fri, 02 Jun 2023 06:06:51 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id gs20-20020a170906f19400b0096b3f72b1a0sm749546ejb.107.2023.06.02.06.06.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:06:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsemanage/tests: consider DESTDIR
Date:   Fri,  2 Jun 2023 15:06:46 +0200
Message-Id: <20230602130646.24835-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602130646.24835-1-cgzones@googlemail.com>
References: <20230602130646.24835-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the script `env_use_destdir` to preload libsepol and libsemanage
from the DESTDIR location to support development changes like policy
version bumps.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/tests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 69f49a36..00f2fcf8 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -18,11 +18,11 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 %.policy: %.cil
-	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
+	../../scripts/env_use_destdir ../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean: 
 	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE)
 
 test: all 
-	./$(EXECUTABLE)
+	../../scripts/env_use_destdir ./$(EXECUTABLE)
 
-- 
2.40.1

