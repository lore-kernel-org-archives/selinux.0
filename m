Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B8EC04A6A
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjHCQXh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjHCQXe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 12:23:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8430D3
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 09:23:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4876319a12.1
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691079812; x=1691684612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRlSHmOv3URj2X0zO+/PjgKRlSp4lVJgKRtEMaqdh2M=;
        b=WNYYUu40VkuIVHtZvSTvWL+AAiZh1wrRoHtV4pew5XmUPNETGSNGXUwoaFPwPsNi6O
         t9LuWoBfdpTRjCiOQyFigJI5OLs5uQdcBb9YrX6l8IF0Ow5I7DOVKeeBoRk7+Lzl5NTT
         QkLYgBYZQFTaVeCKWLicxt4Qn8ZTc+uS2TGAIeQLqwcEfgAWsZYwgYb+lFjcQ4yPgIZE
         IBiDXZp1L0fr6pcOLlB8tosMGHlUbNX9SFkQ8tc5tDPkisd8eHZll+N3TzrfaIvJTdHp
         czc9RX4OdIEp1xiRp+UMYuT4eMilX9sCkVO5bdVijgUWdFBj2/Ezrciqg/6xSb6EBRAl
         xSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079812; x=1691684612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRlSHmOv3URj2X0zO+/PjgKRlSp4lVJgKRtEMaqdh2M=;
        b=P4DjfHX66G9hgAAgXKWCQahOKSLdKCgwZ9CG3MgaMfAVOyoFTxLXMlb2Jwtu/tU+79
         v2j7h8wF3DHsr+v9wzqwMSs3NMU6vM3LwbRgBE4YqxKuOeNSqmHOTK0j9THfbTXCcNe7
         wvQ1u+O1m1GWVXaNtL41vkMgz0TX5cNxrASYI69LeCbtIjzceDPQwr52dp8y8dSuP4zr
         HyW696jkULwXoEv0STZpx6fTuWOl4KklBX7VZ82tUGRIq6E0tZksCbVNt90Pa8cuajJW
         7D29aHMooEajTstdg/i0T4hugcNox0YMWZeAOiKXsFuClJ/7zZKAeLXpUokFoZ8xdVPc
         Lsrg==
X-Gm-Message-State: ABy/qLbscW8Hc9STun7TFjVIn396ANijqQxDaSCTsjCDYqfdzleZWUGX
        fPHMVnxCbsQ+IZtSw5K+lhu/bRNk2OA9OumyrD4=
X-Google-Smtp-Source: APBJJlG53KinwEdoOAOMwMMjK1OaIwU7X/sWKxrUFkJrzzhnEQgXHJlBc5BtVGT/PPngTtAOuBIFUw==
X-Received: by 2002:a05:6402:3507:b0:51e:5aac:6bad with SMTP id b7-20020a056402350700b0051e5aac6badmr11405668edd.11.1691079811916;
        Thu, 03 Aug 2023 09:23:31 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-150-191.77.0.pool.telefonica.de. [77.0.150.191])
        by smtp.gmail.com with ESMTPSA id u4-20020a05640207c400b0051d9ee1c9d3sm348edy.84.2023.08.03.09.23.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:23:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] libselinux: drop unnecessary warning overrides
Date:   Thu,  3 Aug 2023 18:23:26 +0200
Message-Id: <20230803162326.302824-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803162326.302824-1-cgzones@googlemail.com>
References: <20230803162326.302824-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop overrides of warning flags which are not triggered by any code.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index b1620113..20d79312 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -83,11 +83,10 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \
           -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
           -Woverflow -Wpointer-to-int-cast -Wpragmas \
-          -Wno-missing-field-initializers -Wno-sign-compare \
-          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
+          -Wframe-larger-than=$(MAX_STACK_SIZE) \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option \
-          -Werror -Wno-aggregate-return -Wno-redundant-decls \
+          -Werror -Wno-aggregate-return \
           $(EXTRA_CFLAGS)
 
 LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
-- 
2.40.1

