Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA579C04E69
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 16:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjHCQXf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjHCQXe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 12:23:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB3330DD
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 09:23:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5230d2b8128so1392407a12.0
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691079811; x=1691684611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctTkIdOjUgd2oh0NelDXrU+PaUXy4eDCWNhDrSSQWFo=;
        b=Fy904Jog177MqOrUVW8ij0JBLV4ctR2mMHDnS801zpqw7SUjQpAfJMkoeTtDWpwYir
         EMlg7/eVqu5/RggfymyDFsm7IYl6nODm+2Ai81/lZA8hmwfD8MaTih2bMEAqhv+6Yfvv
         w2V0t9e6SDhtWSjpovhRpP/8uFpzC/42QJhxTbUmLyWz2D5Eo3CoyPJ7Cy3wGdo4iUKa
         prM/Se7bdQ0b7ydwk2w6QzxCMy573dfu0MKuTJbv6HUza8oyEYR94a6/aKxT9PVJukcL
         UewV5yue/VPhrU8RUUNZXcyUX+PfBD9he/QTRPRHtyINCwbVVFH9pwi4lKODWD0fMsGi
         0LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079811; x=1691684611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctTkIdOjUgd2oh0NelDXrU+PaUXy4eDCWNhDrSSQWFo=;
        b=Qf7vH9IS0diLSvPYuXAJd0fvyj8N2nW8/WwNHBCkmGOFP2Ym4655riEgkNAgShXw1q
         bc9zIyUI7s+fYkqGNahdagutUSiJo5ERmhCwjHAToePCAIH2FVdPyiYGIFtj+IMF37Wg
         Rwah94ugtymmDX6WkTehfwtjESBQMCYU6avXior4qyLD7EY6FpsNpQaWexoN4dvMoQ/O
         uYl2gsTF6lIFR8gWWDaLvj9c8b0On9YpFvmCNxyfaeVFcG9Liq/KpqRXvQ8kDNdseWk3
         rlClOZQWzMdS1RQYlHyXBYyRxCpzbphFG/9dpiC8CYAMwjZUY0zdeDqQpVfpWCKVoOo2
         EI1A==
X-Gm-Message-State: ABy/qLYZgXMUpnw+cU/B8mRfmGse0t8gxh62J6NNJzSHT/rrVTsYHhOr
        j6VmFobjeQxufThtQOSDY7H/8vWaUlQbsbXM9wY=
X-Google-Smtp-Source: APBJJlHy7EvdHwJElzlbbAOkRINVD2HecMkFgznLmmMJ6BITUuHgfulZEWNoyh/neRfyJQ6ZO7jfdQ==
X-Received: by 2002:aa7:cfcf:0:b0:522:abc0:2f1c with SMTP id r15-20020aa7cfcf000000b00522abc02f1cmr7173176edy.42.1691079811466;
        Thu, 03 Aug 2023 09:23:31 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-150-191.77.0.pool.telefonica.de. [77.0.150.191])
        by smtp.gmail.com with ESMTPSA id u4-20020a05640207c400b0051d9ee1c9d3sm348edy.84.2023.08.03.09.23.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:23:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] libselinux: drop obsolete optimization flag
Date:   Thu,  3 Aug 2023 18:23:25 +0200
Message-Id: <20230803162326.302824-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803162326.302824-1-cgzones@googlemail.com>
References: <20230803162326.302824-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The flag -fipa-pure-const is enabled by default in GCC at -O0 and above.

The flag is not supported by Clang, which might result in issues if a
compilation database was created via GCC.
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index f9a1e5f5..b1620113 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -61,7 +61,7 @@ SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 MAX_STACK_SIZE=32768
 
 ifeq ($(COMPILER), gcc)
-EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
+EXTRA_CFLAGS = -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
 	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
-- 
2.40.1

