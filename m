Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86A5C4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 14:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiKDOjM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKDOif (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 10:38:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08557748FD
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 07:36:27 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id l9so3128703qkk.11
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGtzrxIutUYob6LwzVdL1wyAuWgx7uTaMGUCm6wkCiU=;
        b=lsRECDJuIEK6r78cAGONUHg8G3v1+qRn+cb5s+lfIvJP9ekKe6Cu7JtVqALFfYN1xf
         ct5U019rcIfjYIeyYBM686+tr7mN2ZJDdZjOv3dxmtNHB76YbljjEcIBRaMQRLer9cHu
         2DYvhbXM61SY3M1flaA7Mx+JtZWk7JgsvgnGfzs6r8Y3SVdML0NKfc95TrxlF4qizvmJ
         2xT2wtNwS1Lp2D3X720JKLAqUejgFo6BH3hwudbDoOQW2Ua0XrseY8lyI7HUpb1Yntx4
         OMWXchDI6ejGN8OdxdEQtI2nUhGN7w/52lVW3gt+8syMSxoOzm8Npsp+HjcYER3tvfmS
         sUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGtzrxIutUYob6LwzVdL1wyAuWgx7uTaMGUCm6wkCiU=;
        b=3KEXy6PDNkGvDm05OZVoarxvm0YQ/zuMJ0LB/OFmnm9DmsMk+v4WVgCg/IHuScccLm
         NN9l/uT+sYeT+HdZPXy+5J9Yuv0UbQ+8OpFPFXTPsni8xZuw048oVBdOi+Q/giYxzBkA
         ZAil9zGQ5mfl/raoNitcWCdlJwDl97CZBmX6WY0VEKqAi+WtZ9Q6p8A7YyegiQZu6/g9
         nzDG/1uhZuHJc+7mf+cEnm7y34/JhiBniJ7vt2cuZ0zFZoVRtgFn0s+iLjVoPvv31xc4
         GB6F2rIawmvzT3fVwas3NW4IBbbg3Zpnhrrnedn5tvJmDzCbtZfulLPy3X+/wN6pUmxb
         DV/g==
X-Gm-Message-State: ACrzQf3IYaPrP73rWBYSoBvRT/5Y75tOxWQPkI5PAde3S66v4KSkbAkA
        WE7/9zQIlZ0SKCMkod7SIkHhVJbJxP8=
X-Google-Smtp-Source: AMsMyM6XKH8tTMuw6wIE0o05n9ngXT4bguxh1e3siCB2a6aeBNb7o9YVf/7fr1stvTRJEdXMPn7ssA==
X-Received: by 2002:a05:620a:284a:b0:6ab:9cc5:cb4c with SMTP id h10-20020a05620a284a00b006ab9cc5cb4cmr26530779qkp.609.1667572585694;
        Fri, 04 Nov 2022 07:36:25 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b003a50b501a01sm2479324qtn.87.2022.11.04.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:36:25 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5 v3] scripts: Remove dependency on the Python module distutils
Date:   Fri,  4 Nov 2022 10:36:15 -0400
Message-Id: <20221104143616.1089636-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104143616.1089636-1-jwcart2@gmail.com>
References: <20221104143616.1089636-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The distutils package is deprecated and scheduled to be removed in
Python 3.12. Use the sysconfig module instead.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 scripts/env_use_destdir | 2 +-
 scripts/run-scan-build  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
index 8274013e..89d989a2 100755
--- a/scripts/env_use_destdir
+++ b/scripts/env_use_destdir
@@ -43,7 +43,7 @@ if [ -n "${SBINDIR:-}" ] ; then
     PATH="$DESTDIR$SBINDIR:$PATH"
 fi
 
-NEW_PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(plat_specific=1, prefix='/usr'))"):$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
+NEW_PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '/usr', 'base': '/usr'}))"):$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))")"
 if [ -n "${PYTHONPATH:-}" ] ; then
     # Prefix the PYTHONPATH with the new directories
     export PYTHONPATH="$NEW_PYTHONPATH:$PYTHONPATH"
diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index 77e02ca9..931ffd2a 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -21,7 +21,7 @@ fi
 # Make sure to use the newly-installed libraries when running tests
 export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
 export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
-export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
+export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))")"
 export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
 if [ -f /etc/debian_version ] && [ -z "${IS_CIRCLE_CI:-}" ] ; then
-- 
2.38.1

