Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD5EB64D9
	for <selinux@archiver.kernel.org>; Mon, 19 Jun 2023 06:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjFSGcX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Jun 2023 02:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSGcX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Jun 2023 02:32:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE7123
        for <selinux@vger.kernel.org>; Sun, 18 Jun 2023 23:32:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668689ce13fso363483b3a.0
        for <selinux@vger.kernel.org>; Sun, 18 Jun 2023 23:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687156341; x=1689748341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbXcbJwtlki2wtAesQlLjzw35F52nbQuFOz0INdOJlE=;
        b=SGXy2npSIgQgPJlp+rgGHx5aRB8uYs0pRDT01fq5GZ50GiTo0pUNKGncWytwCKHlzF
         BqbommJgUfCJGcJ5Eh83wr/H6ZlPokKiEjlFb8O7WdKrWSeiWtlYLdBMiizIHchErRLx
         gXQqj56QPnI6vc5SEe/WdfkzRzBStpwc372jeEE0TMEA4V3l/Y++t5sNsQr1RSkM0fmL
         Wx+zxkoogruYlPKLCas8gt+BVzwTtjA/uqOVhYNaCOtRVFb1svxcG/CeiQB2x4uppTlj
         jjw4XXfciyLFatySjfLMUDUz2LSRaY+7N8vo8vogUys2v/NPnrCxw4+xq+4jLNiMLouJ
         HIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687156341; x=1689748341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbXcbJwtlki2wtAesQlLjzw35F52nbQuFOz0INdOJlE=;
        b=bZg0yBdanbzV1uXF84boQoZ0JbkgK+DvAPbBlHakN2pu8Wxl5XBkXQHzeEbe0uX8ZO
         iexzsxhOWhCtgT1gNLQ641Z8kDUrgyi01TWE0Z4vePeL4flPq/3WiCyV5yM/p7UCmtsw
         oVrHcL6Qcw9mUyd0JOMDn9uU8FRMHjU/yQy/HpOnkMQ0mN3iFb4OEx2Uvlwao+FABU6C
         rrtmkToSrg/95emBNsDBs+D2rVdQJowMsrTh0IPeQ6LaYcmPus6D/Gk6z253dnxZbtPK
         qCVspOYpFvLOxH+At76V0IXLIuMdskTvm8dnUWj7p9MhAKdTCwN+d6z6Dt5lrAc1PGJ5
         xV4A==
X-Gm-Message-State: AC+VfDzet61Zmr15Cb3Q1SY9eqzSTnazZZolZY28bgiKnXeKygQAeYiW
        4pLCp0XbhiUmn3NmUIPIwky1H5hOXPQ=
X-Google-Smtp-Source: ACHHUZ6Uy5D5xSP8b8tyqPJA2KhbcRfPlQJ1haI7hoflBg9snCevAnz4LtxEooQvNls5Z+u0bZzhSA==
X-Received: by 2002:a05:6a00:1309:b0:662:2b1c:be80 with SMTP id j9-20020a056a00130900b006622b1cbe80mr5226321pfu.28.1687156341542;
        Sun, 18 Jun 2023 23:32:21 -0700 (PDT)
Received: from computer.fishbiscuits ([78.156.70.6])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b0066875f17266sm1421434pfa.135.2023.06.18.23.32.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 23:32:20 -0700 (PDT)
From:   Jeffery To <jeffery.to@gmail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolicy: Fix get_os_version except clause
Date:   Mon, 19 Jun 2023 14:32:17 +0800
Message-Id: <20230619063217.3165462-1-jeffery.to@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This adds more exceptions to be handled by the except clause in
`get_os_version()`:

* If the `distro` package is not installed, then `import distro` raises
  a `ModuleNotFoundError` exception.

* The distro documentation[1] lists `OSError` and `UnicodeError` as
  exceptions that can be raised.

* Older versions of distro (<= 1.6.0) may also raise
  `subprocessCalledProcessError`[2].

[1]: https://github.com/python-distro/distro/blob/v1.8.0/src/distro/distro.py#L749-L753
[2]: https://github.com/python-distro/distro/blob/v1.6.0/distro.py#L726-L728

Signed-off-by: Jeffery To <jeffery.to@gmail.com>
---
 python/sepolicy/sepolicy/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index c177cdfc529d..2d526c94a0c5 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -1240,11 +1240,12 @@ def boolean_desc(boolean):
 
 
 def get_os_version():
+    import subprocess
     system_release = ""
     try:
         import distro
         system_release = distro.name(pretty=True)
-    except IOError:
+    except (ModuleNotFoundError, OSError, IOError, UnicodeError, subprocess.CalledProcessError):
         system_release = "Misc"
 
     return system_release
-- 
2.39.2

