Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD6C0018C
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjKINwB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKINwA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:52:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A3272C
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so147101566b.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537916; x=1700142716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWzqq6/bpIFYiqr3ZqZdeCyg7SgG9SRuKL1/3MfHjww=;
        b=nJbb/Xrn77I6skWaV1yQ6vUXjXcGxWRJB26DR7RIf0XMtkc4Wpl5H34QUwtrudib4k
         qC+l3MMMTAr90Mz9CHFRfiqeRhJUD6H7Xy2zPZ4MsYicsPg9Fq2EIRhet9HLFmV5ONj1
         wW1tKg/RfgM8XpT7UAYG9csY5W+SfMy8xVJc6LNy/9M+/Oo0MNyl0QWow4xQZQWyrY/M
         m1IkjV9nu/Bhr6pB6TbrpYYPUpOouqByLpWMwaBNyowwujypXvqGc6ikHBUrb6lA4q54
         IY5YeB/Qbe2l36LKCh9m93mZOFbgGeyfe/85yyFblLuEy6VOQANJhf3+pTt03r4ni3bv
         l+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537916; x=1700142716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWzqq6/bpIFYiqr3ZqZdeCyg7SgG9SRuKL1/3MfHjww=;
        b=wnM8b4MqVE1ZMEjCDHikLbdOhX8I02IazInUk+QTaWW6tfy3J/2X3Xr4XIoCWE5a6Y
         D5a/URjs+MIAEyEhvOWU8sn4O+3V+ayAkT/qOqRvnqRogyw+speN4xzNCwS/VY6H9zxa
         HSGKyyFBdGVYpg7kasG1aV71zDWFliaw9cqeT5Sc4IUhw0sQYM29vVl4MK7o0PgUFn/6
         fX4ixLaTbOytY1nGf0PYUIfDgMWIk6pywd6CtVy3CuAGKL6agoSkLbgG/Ydb3uLXmDr4
         HjFPx5i48sC8Fvg5cLbeeG6edZ0tOC8VoM2NgX3C/5WPKji/BS8brR1fATW+fjBY4MnR
         9uIg==
X-Gm-Message-State: AOJu0Yx7ShcSjoNO3PApBOtpPS3Zvbs/86/lPAm+j6d1LJi5wCUNt/Pz
        lOP7QkbdJ4RK2Sd/ktwwLw2SfvBqPBY=
X-Google-Smtp-Source: AGHT+IFgpwm+Jggt2sMdrS80jhx+kmR3Qm1tpuyO9CprS+x+N91//clncR7MDmF+Z7efY0fnaLGRjA==
X-Received: by 2002:a17:906:787:b0:9e5:31c4:f5f8 with SMTP id l7-20020a170906078700b009e531c4f5f8mr131372ejc.53.1699537916059;
        Thu, 09 Nov 2023 05:51:56 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009829d2e892csm2623563ejb.15.2023.11.09.05.51.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:55 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 7/7] scripts: update run-scan-build
Date:   Thu,  9 Nov 2023 14:51:48 +0100
Message-ID: <20231109135148.42688-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135148.42688-1-cgzones@googlemail.com>
References: <20231109135148.42688-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Do not build test target

  Building the test target breaks the whole build since the tests for
  libsepol require checkpolicy to be build already:

      make[2]: *** No rule to make target '../../checkpolicy/y.tab.o', needed by 'libsepol-tests'.  Stop.
      make[2]: *** Waiting for unfinished jobs....

  Since issues in the test suites are not critical do not build them.

* Update build status reporting

  Since the script sets the option -e scan-build will immediately exit
  on failure and the informative message "++ Build failed" is not
  printed.

* Bump to fortify level 3

* Fix typo

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 scripts/run-scan-build | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index 7b731f3e..e4f13a2f 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Run clang's static analyzer (scan-build) and record its output in output-scan-build/
 
-# Allow overriding binariy names, like clang-12
+# Allow overriding binary names, like clang-12
 export CC=${CC:-clang}
 SCAN_BUILD=${SCAN_BUILD:-scan-build}
 
@@ -32,15 +32,12 @@ fi
 make -C .. clean distclean -j"$(nproc)"
 $SCAN_BUILD -analyze-headers -o "$OUTPUTDIR" make -C .. \
     DESTDIR="$DESTDIR" \
-    CFLAGS="-O2 -Wall -Wextra -D_FORTIFY_SOURCE=2 -D__CHECKER__ -I$DESTDIR/usr/include" \
+    CFLAGS="-O2 -Wall -Wextra -D_FORTIFY_SOURCE=3 -D__CHECKER__ -I$DESTDIR/usr/include" \
     -j"$(nproc)" \
-    install install-pywrap install-rubywrap all test
+    install install-pywrap install-rubywrap all \
+    || { echo "++ Build failed!"; exit 1; }
 
-if [ $? -eq 0 ]; then
-    echo "++ Build succeeded"
-else
-    echo "++ Build failed"
-fi
+echo "++ Build succeeded"
 
 # Reduce the verbosity in order to keep the message from scan-build saying
 # "scan-build: Run 'scan-view /.../output-scan-build/2018-...' to examine bug reports.
-- 
2.42.0

