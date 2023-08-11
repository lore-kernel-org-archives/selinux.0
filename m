Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206EDC04E69
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjHKQ1x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjHKQ1w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A319AE
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c353a395cso302071466b.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771270; x=1692376070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRlSHmOv3URj2X0zO+/PjgKRlSp4lVJgKRtEMaqdh2M=;
        b=ReEPdydgX0FoYN9fKUtdHI5aWzlzguJDNLADHF6JOk8zOAnRoXiB6qqdRrmrNCPZq4
         LmJajd9wRc5qWHDHv6g9leik0PGnufsNxlPlTeQ7SHWtoPTOuVKB4uzWD+AtxdAotLWF
         EgrslnKHywEuaooHSl3YhA0A6YXP9sHrSSdr+OTrv4nBVh8BHv806yRFyja202IkpZhB
         DIPO5pYcoqvdORd1Mr0UEkri0f/FfG5Z6FRYpZ8PTeT9f4RwwUP7zLa3bLD3+ZKGivoY
         xMf6h4X8eXoKs7JYlWglv1Wo8bmFSylxFc5J1NZae+W2UGbOMT+aAbYiARhY1CmuZD0J
         Wlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771270; x=1692376070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRlSHmOv3URj2X0zO+/PjgKRlSp4lVJgKRtEMaqdh2M=;
        b=AafN5eVlekRvtP8Cj9WNmsjGdmGFnmYCGVYO5qH+RKktnu4YHz5jfUULma17ztQFb6
         MrmEHpe3vtnpp9r/gZNcLzIIYCeUIfi4KoT7oLSiAehEZ62bwFMQh8qjm+VKJFCOm0cd
         oIqwVxTBdJ3Xmuqpnx7e0/M4+rp6vBcou8almjzt/FZUPV+8TnMaskykDuULBtm7/3M8
         uSI+JOesX3srI4cHiUYWKYbMYa4ovYxHwYm0yplkavE+pxIcikjhDt78sHOy4SaTRn00
         RtSQ350RnBV+FHTNiefNgcq+6I8FUhFB7DXjcoQgLbDWCd4DTCHhLQYNthtfnWgFcRO5
         Z3Qw==
X-Gm-Message-State: AOJu0Yyx/fMrjyfBSKu7+RPG8ke38Fk2u2OsVA1+6I55dxCQf7OkyQTz
        Dh2UH6TsiWMMmQAMvpqTPvZNwZtaRCFDUA==
X-Google-Smtp-Source: AGHT+IEa9HrVJnEpc2+8igPRFhgovO2Lat/hBx5CQHINA3lXcNu59ze4XoESL4AjVzU3qfdSl4sHIA==
X-Received: by 2002:a17:906:21c:b0:99b:65fa:e309 with SMTP id 28-20020a170906021c00b0099b65fae309mr1889382ejd.74.1691771270174;
        Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 04/24] libselinux: drop unnecessary warning overrides
Date:   Fri, 11 Aug 2023 18:27:11 +0200
Message-Id: <20230811162731.50697-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

