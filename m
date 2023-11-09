Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A64C0018C
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjKINwE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjKINwD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:52:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF230CF
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:52:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so1503122a12.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537919; x=1700142719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGsW4jPIN3bnjXGBOVHb9DCVW8iQyZ5+EpLySpunDNQ=;
        b=BCAD8UQCFge7PWJG6plzPuYZhChRWW2kKFDW37/kcWPHLD8lQ9LOkIrmkzR+698gfN
         MGcGffbSPcMc7l0epXIbYgJtzqT16BQjidPbpUc/23LY3gX3XvPWy9KZXOkE/d+IEQX2
         TzTVtKqLCjZUVSu/qDr7lAKLfEGYkhogUGzhxzy9PWRHTpuEnxv/7VriLKY2fckNODoW
         Kpb5oUpRuA3mjgnuvdqWpZyQUazyLW170Xda/U0Jc//CWOeLRVT9dvhecE8+xpnoExnt
         cMtqa5F0F1zmDY+GxZ5XMzfE9A+F44a2tFraBQ/G4QCjsMUEAu9xGNT7Hdc640tAVxnu
         +clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537919; x=1700142719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGsW4jPIN3bnjXGBOVHb9DCVW8iQyZ5+EpLySpunDNQ=;
        b=Ef6Z0ebIrx+geddQVq9i4GQKGKzFtf5mmPzXltGjLHf7ktI3rGgO0+PNMqwqGVN27j
         xrl+YZZP1nPGdgoswchw+J4gve9QemJQnAYW7/oZZyLF7Y3p6iV0D5JmjZa+lX21FXSf
         Cnf0caIGoXHrzLqLuuvHv7z3L5fy7FOAWqbiuk1xz6kh886bd6oNyrRMN5GYjZEHE2sP
         xkUdUbVpo44PmtSCO1ZnWMS7YUhLRagZAcDwS0pYGY7Al7Zde6kZ44RziH4EbKW8BpXy
         oHz1r9huoM4HDHb+6p0Bpvv14wKcf4MEvQBLmEtWW78xdBsRlU6Q+25VcPmsFcMRjNfX
         d2og==
X-Gm-Message-State: AOJu0YyqTNyTtxJp5IXr4eUWhFWRqAOgXPG5xIiEGFXx4tcKi+D+/kdC
        JvXNfpMu4YwzH/SkVfiqVWYt7hOi+C8=
X-Google-Smtp-Source: AGHT+IETvz4/h2nYzDJRcSpmcjq8ot9Xa4rdo4ZQ34iiOQSoEvejpgEZuLYCKLHC5jjhXQOfb0Izvw==
X-Received: by 2002:a17:907:94c3:b0:9ae:74d1:4b45 with SMTP id dn3-20020a17090794c300b009ae74d14b45mr4863334ejc.65.1699537914200;
        Thu, 09 Nov 2023 05:51:54 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009829d2e892csm2623563ejb.15.2023.11.09.05.51.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:53 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/7] scripts: ignore unavailable interpreters
Date:   Thu,  9 Nov 2023 14:51:44 +0100
Message-ID: <20231109135148.42688-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135148.42688-1-cgzones@googlemail.com>
References: <20231109135148.42688-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Skip running and setting environment variables for unavailable
interpreters in the env_use_destdir wrapper script to avoid output
like:

    $ ./scripts/env_use_destdir $DESTDIR/usr/sbin/getenforce
    ./scripts/env_use_destdir: 59: ruby: not found
    ./scripts/env_use_destdir: 59: ruby: not found
    Enforcing

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 scripts/env_use_destdir | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
index 89d989a2..e8069be8 100755
--- a/scripts/env_use_destdir
+++ b/scripts/env_use_destdir
@@ -43,17 +43,21 @@ if [ -n "${SBINDIR:-}" ] ; then
     PATH="$DESTDIR$SBINDIR:$PATH"
 fi
 
-NEW_PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '/usr', 'base': '/usr'}))"):$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))")"
-if [ -n "${PYTHONPATH:-}" ] ; then
-    # Prefix the PYTHONPATH with the new directories
-    export PYTHONPATH="$NEW_PYTHONPATH:$PYTHONPATH"
-else
-    # Define PYTHONPATH
-    export PYTHONPATH="$NEW_PYTHONPATH"
+if command -v "${PYTHON:-python3}" > /dev/null ; then
+    NEW_PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '/usr', 'base': '/usr'}))"):$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))")"
+    if [ -n "${PYTHONPATH:-}" ] ; then
+        # Prefix the PYTHONPATH with the new directories
+        export PYTHONPATH="$NEW_PYTHONPATH:$PYTHONPATH"
+    else
+        # Define PYTHONPATH
+        export PYTHONPATH="$NEW_PYTHONPATH"
+    fi
 fi
 
 # shellcheck disable=SC2155
-export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
+if command -v "${RUBY:-ruby}" > /dev/null ; then
+    export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
+fi
 
 # Run the command given on the command line
 if [ $# -gt 0 ] ; then
-- 
2.42.0

