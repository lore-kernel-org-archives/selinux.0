Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B187C04FE1
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHNNVR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjHNNUs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69EB172D
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcf2de59cso569769266b.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019242; x=1692624042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRlSHmOv3URj2X0zO+/PjgKRlSp4lVJgKRtEMaqdh2M=;
        b=FJu6ACM+EQ3OQO8q7mlOtK7SZ45V6af+yioWaGAJ7Hm+snl8i4JxSoyQBU5hcpJOGL
         YBe5bdZF1MEb7klwwes/OdQDi4vNj49jGq6iYc9OhuFQBuQJ+PT4XvGC/6iDHz9IxG2Y
         w3G5krdk7fN8AwybvNWONCJ7JAJC/jEsnM+zkgiroY+SLJe/JeQTNglFZ7xNdCjJWUlH
         Bzbk0gW8u+a/zHFTeIz+fAiaUVtZMG7Aan/UWMjohPkp7ignDdNvLvMPnzFXo1TAUNOO
         Y5aVBZT7LBm7BuhK13X/8zrIV+odI5LuE0Mdsq8LFaUSwWgzTESiZuORarSJPCEjjLMy
         Bqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019242; x=1692624042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRlSHmOv3URj2X0zO+/PjgKRlSp4lVJgKRtEMaqdh2M=;
        b=J6G2b48AEgxy/XWHyX3FI1Gr3eo8ma6AjdjjH1JzT/gLEZt0xufyF0JYuHbjRRNL48
         sOLZRKqQSocDIO02p++vkNeVusQG4jw/y0IkeN7dm2fK3MGI/7i9+6+RNOyH6GU/qe2k
         H7qry7v2gIw3rb58ndqb0IAQJSG8+ztj31z3wJwtUAgHDOPCJftAQjDx/eYP9htPfZXy
         Xj0yesKRMrF1cVRPOxJ8id7+aLj0DEwv3sMZcMxA72mTjnrEyYv77jyMfSSt3sFmKu1I
         vf6zTNnQWeNb2+/21QdG8II3Ts/TF162P1YOO5OGrQ+E9UHGtrKnFFz7+rjSZ/kJyIhz
         wgsA==
X-Gm-Message-State: AOJu0YyfwkdCynHZVl2M3vSaf7jjzIFdG2vjpfma8oV5t6bDHmeB7een
        Sbx/0wnk7ef81drngSP4OGCu/z6FVJH+tW45E1o=
X-Google-Smtp-Source: AGHT+IEmOB/z0Y/7zdxTnQoOUkOKow4MkwgGFsFoi3lWowoaZboYtXIq0LYu8IDBPeEIwqpHP/S4Bw==
X-Received: by 2002:a17:907:7846:b0:99b:f50b:d7d5 with SMTP id lb6-20020a170907784600b0099bf50bd7d5mr6823229ejc.44.1692019241895;
        Mon, 14 Aug 2023 06:20:41 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 04/27] libselinux: drop unnecessary warning overrides
Date:   Mon, 14 Aug 2023 15:20:02 +0200
Message-Id: <20230814132025.45364-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
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

