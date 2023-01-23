Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A9DC27C76
	for <selinux@archiver.kernel.org>; Mon, 23 Jan 2023 01:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjAWBmi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 22 Jan 2023 20:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAWBmh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 22 Jan 2023 20:42:37 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F339E193DF
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:36 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v23so10052122plo.1
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slm8XjcjYvNjgwx53H5Ona/2b9KpunvWm+4x7ES0oDU=;
        b=WswCDjWeWJ4W/ZKuVXhdlEqceKzmirthC9CFaAuxlncrHf8s/ug5NSqKrG33+5a0bE
         1gQCtxUdOspjlKMjIGgYfE/AqEO4jnyB+nvakbV32l4MO+GvdP0r7IUxM2CNQ3eqFwnr
         3S5KDRwc6VBDqKZj3t4d5qT/vFriCeDTX80pk/aKO4i/c8C1yc8MfGy09C32PCwrwSsf
         /DIuT9aWF2fXmJYS3DzIzmjwziwV0H2PPuyMww87cN78lcmYhf6Bn67mE0FemqlY0cuq
         5cJtVSX+ov1wlmU3MfIwV/+UHLGM57OyJrT+Q/SKw2nRJqwt8SkkeCrW078HJKDy/0ss
         yGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slm8XjcjYvNjgwx53H5Ona/2b9KpunvWm+4x7ES0oDU=;
        b=aSFg+hPcltujEShcVZrbfZYanIh6I3ISlVPt8fwE18y4bA50tKN7LIBBfytpQSxdJt
         ZGs4ThPc9QRWsQCsApeym2aBZbMcOQ61iouXjXpkJ8eGPllrmzsqj6JQKCekG11s2tFu
         rEEtG2w/chxSjLlghdWV+0FsVLOrBTy6WGD3rhqYm83i8noPV5s6nu7wY0yp3aMl0bDQ
         Z6tZjGq5P0zSspFd3jQWioSxxwAHe6sGCyC7GERGOIzOW7rG6+SKGRt0ER/yEFGskzhm
         uCW55EQrYvIGDpkHuP8rzhGzebOK0xiy7E3JelvQVF1zBtDivIkUVOApuViQdtb0LIrg
         wwnw==
X-Gm-Message-State: AFqh2krkemFaBxqI4GbxrVww4WBO1V5YeGNa/SbRIyZbyM8lMBXR9Wy/
        EQSpV5yg0XcV7q9UWJSIo5rOHSWGCGw=
X-Google-Smtp-Source: AMrXdXtmJYDdcL98fk+ErpaDtXCIt/VAKpdjaR2WodkgZvA7tMFflzNoYEhK9Wjw0pgyRIZmnAsSag==
X-Received: by 2002:a05:6a20:2da7:b0:b6:a9f3:4f8c with SMTP id bf39-20020a056a202da700b000b6a9f34f8cmr23381983pzb.13.1674438156111;
        Sun, 22 Jan 2023 17:42:36 -0800 (PST)
Received: from localhost.. (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id z18-20020a63c052000000b0049f2c7e59f5sm25857491pgi.27.2023.01.22.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 17:42:35 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] scripts: respect an initial LD_LIBRARY_PATH with env_use_destdir
Date:   Mon, 23 Jan 2023 01:40:45 +0000
Message-Id: <20230123014047.84911-2-carenas@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123014047.84911-1-carenas@gmail.com>
References: <20230121180318.11853-1-carenas@gmail.com>
 <20230123014047.84911-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the highly unlikely that you would need to invoke a tool with
an out of tree PCRE2 library, it comes handy to set LD_LIBRARY_PATH
to point to such library and not get your setting blown away.

As usual, if no LD_LIBRARY_PATH exists previous to calling the
script, nothing will change.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 scripts/env_use_destdir | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
index 89d989a2..61ef7b26 100755
--- a/scripts/env_use_destdir
+++ b/scripts/env_use_destdir
@@ -21,7 +21,13 @@ if [ -z "${DESTDIR:-}" ] ; then
     exit 1
 fi
 
-export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
+if [ -n "${LD_LIBRARY_PATH:-}" ] ; then
+    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$DESTDIR/usr/lib:$DESTDIR/lib"
+else
+    LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
+fi
+
+export LD_LIBRARY_PATH
 if [ -n "${PREFIX:-}" ] ; then
     LD_LIBRARY_PATH="$DESTDIR$PREFIX/lib:$LD_LIBRARY_PATH"
 fi
-- 
2.39.0

