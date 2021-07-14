Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787FDC07E9A
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7F613B6
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhGNSQl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhGNSQl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 14:16:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31DDC06175F
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id v20so4750460eji.10
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGXCye1wzhx6cEy5saUUtptQ0sSoOPPYrtxHCjbwWLw=;
        b=VSkpWYc2o4FlbFtBIYftl6QXHF1WA3EYF02o03jxLeKi7LiEUD1UxTmVfglFy8Y8qd
         V2RZvtLqCz5mLQSM2s72SC0Ej632jUw1xDbrWAQFNgFoCG242t+qdq9pYz+AdyrXK4FK
         Wl/MV27icRsdKtHjDhZLFNZcRZyF65aZMw9xc3ClLB/mkneOkVNBGi1pjZkO7gLDQ9dK
         +4Yg8Kdefd7nO3kNKBzlsTOTMmzwslAa+K/svgk2/0kBVIK/955aaSPEWirJ4rxXWUzd
         jlw1b7XWceEdOHONe8/RDt4FWkXHd4ib0lFep9C5vkeLAM/LyCKlZMDwgrfZnE9yiU7j
         MLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGXCye1wzhx6cEy5saUUtptQ0sSoOPPYrtxHCjbwWLw=;
        b=q5kFmz6fAnTpYbpanVyHZ8+kZzfOuj/+t/60h2FNsLlAX4991fyU88wJgEbPcHTpOv
         9OrRY5qngqYihR9Yis8mb2bYkaX+b14eHQOVPpoyfzWG32Uukws41T7hYPQsmAeH5e1A
         dx+FHGBFMdDCqKamZ+pFB6NFcEp/TatNMsw6TPGAkom+0DpDsV70k0VBSdXUi/3ST4Tf
         SWW2ZL5Kkus6oT3vQjVMNnBRUpXNjFlMHh686BfRLPmWigkR1hzCcijWjPyQXlSvHms4
         V+iBDwp5iJd86juvK6Ghg2shGacJy/Ab9ZFZKm6VWpOQ82N4Itmo1wgWZhJzrgOZ/6Pi
         7/SA==
X-Gm-Message-State: AOAM530U8d3wIwf43d4UX93Kf0LzTeiX9eymL6hnpzS8cpLedRplIlJK
        kzCGvOBiqxsswbX5OQfgUQ+o6f+FxCU=
X-Google-Smtp-Source: ABdhPJzoQDup+458DFxoGxhvLKHSTiQO0QZT2WHcQdlWkCnBod5jgouuzP6YEEtHPyaaSvIz79Pt5w==
X-Received: by 2002:a17:907:20b7:: with SMTP id pw23mr13428520ejb.198.1626286427182;
        Wed, 14 Jul 2021 11:13:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-198-161.95.116.pool.telefonica.de. [95.116.198.161])
        by smtp.gmail.com with ESMTPSA id ot18sm1020975ejb.109.2021.07.14.11.13.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:13:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/6] scripts/run-scan-build: update
Date:   Wed, 14 Jul 2021 20:13:38 +0200
Message-Id: <20210714181343.58880-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- use multiple jobs
- define _FORTIFY_SOURCE=2 to enable checks on standard string handling
  functions due to macro/intrinsic overloads or function attributes
- allow to override clang and scan-build binaries, i.e. for using
  versioned ones
- set PYTHON_SETUP_ARGS accordingly on Debian
- enable common warning -Wextra
- print build result

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 scripts/run-scan-build | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index ae5aa48b..ef07fefc 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -1,6 +1,10 @@
 #!/bin/sh
 # Run clang's static analyzer (scan-build) and record its output in output-scan-build/
 
+# Allow overriding binariy names, like clang-12
+export CC=${CC:-clang}
+SCAN_BUILD=${SCAN_BUILD:-scan-build}
+
 # Ensure the current directory is where this script is
 cd "$(dirname -- "$0")" || exit $?
 
@@ -20,14 +24,24 @@ export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH
 export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
 export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
+if [ -f /etc/debian_version ]; then
+    export PYTHON_SETUP_ARGS='--install-layout=deb'
+fi
+
 # Build and analyze
-make -C .. CC=clang clean distclean -j"$(nproc)"
-scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. \
-    CC=clang \
+make -C .. clean distclean -j"$(nproc)"
+$SCAN_BUILD -analyze-headers -o "$OUTPUTDIR" make -C .. \
     DESTDIR="$DESTDIR" \
-    CFLAGS="-O2 -Wall -D__CHECKER__ -I$DESTDIR/usr/include" \
+    CFLAGS="-O2 -Wall -Wextra -D_FORTIFY_SOURCE=2 -D__CHECKER__ -I$DESTDIR/usr/include" \
+    -j"$(nproc)" \
     install install-pywrap install-rubywrap all test
 
+if [ $? -eq 0 ]; then
+    echo "++ Build succeeded"
+else
+    echo "++ Build failed"
+fi
+
 # Reduce the verbosity in order to keep the message from scan-build saying
 # "scan-build: Run 'scan-view /.../output-scan-build/2018-...' to examine bug reports.
 set +x
-- 
2.32.0

