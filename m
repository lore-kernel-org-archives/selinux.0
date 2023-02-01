Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751CEC636D3
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 10:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjBAKzS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBAKzS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 05:55:18 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C646AB
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 02:55:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k4so44730192eje.1
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 02:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fmxzi9YU0yGJa/7PWv45djUUY/6e4nAFjFt4tjmPcA=;
        b=UmeGk8MXbcMwZndB8PhMTl1tbgQc5y1nhtE48rkANc3D/8XvXKhWXGut/lCNfENA1i
         4cT1+jEuqcvJawa21IbQNj0/B2z2iGYBbQTh+Y+7CmscVab6tTZEOjqm6aVDWATAUuQP
         nMGrgkMNh4QFXDqsj5gk5tWMkdkz/myd9Xb1TuK4Gti1sl69qxmUkwDxX88WmSMVG4b7
         NPiHMel/NrJLrVEyZqKTQgvDWA7VbQB3b1t+By2C7R1rDr35fvvM1xefva8aU4omfsbV
         6wcE9vddEU85gk3/gWx60H6fkRPKV+EvhHjcK7lviJyDtSDhMMUCWmUUdSKIOEobBrZw
         wV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fmxzi9YU0yGJa/7PWv45djUUY/6e4nAFjFt4tjmPcA=;
        b=SmhypQEP+Z3pTyZDWxt5+tnE7MQOfrpbzvQKGd0YwnMNk4xOhw9Se8Pjmz8QRhye5q
         OOed/hRrSkuMOcDKTWEhMt8Y1jdy9Jl1NyldUyShaq+A2pLK852ZNGGS3eULFHnH2M91
         O90OiXePDUqR3Hn6WZzjypLOPPyF2wcBICy4JfeD7z2a/XYXGoRkkOmUKadmJ3ec0M7D
         uz+MY4UoDICMydKNCXP5gOa8RFNGUptcNHmzcPC05aRbcceGRenoEB+mHU7BSPuW9t9W
         jXK6gpty565Yt/g9X11TKsw+zN7TbK7xl57/JSoI+L+U6IAZxH/kjCVxKpp7tcuSiwVW
         zQsA==
X-Gm-Message-State: AO0yUKWltq6KgvRpdyStP9QWwnfkcc4EPAM6Azxaoe5xDUd/SSLHD5DL
        urt4IKv11Oh9FtYmHV2X8AMXbL6yUM+1pA==
X-Google-Smtp-Source: AK7set//PYrD2TBT5DM7nmERdXQED3MeinTr20GeCFeJLaNamQbnKcDtDMVSrVgue/RpY2PBxPevCg==
X-Received: by 2002:a17:907:98f9:b0:87b:db62:d659 with SMTP id ke25-20020a17090798f900b0087bdb62d659mr2056166ejc.19.1675248915452;
        Wed, 01 Feb 2023 02:55:15 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-178-099.77.8.pool.telefonica.de. [77.8.178.99])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm9927632ejg.221.2023.02.01.02.55.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:55:15 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libselinux: drop obsolete optimization flag
Date:   Wed,  1 Feb 2023 11:55:08 +0100
Message-Id: <20230201105510.14125-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The optimization flag -funit-at-a-time is enabled by default in GCC[1]
and not supported by Clang:

    clang: error: optimization flag '-funit-at-a-time' is not supported [-Werror,-Wignored-optimization-argument]

[1]: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 70ba063a..36d57122 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -86,7 +86,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-missing-field-initializers -Wno-sign-compare \
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
-          -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
+          -fasynchronous-unwind-tables -fdiagnostics-show-option \
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
           $(EXTRA_CFLAGS)
 
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 801066cb..f3cedc11 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -32,7 +32,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-missing-field-initializers -Wno-sign-compare \
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
-          -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
+          -fasynchronous-unwind-tables -fdiagnostics-show-option \
           -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
           $(EXTRA_CFLAGS)
 
-- 
2.39.1

