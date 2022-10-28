Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E97C38A02
	for <selinux@archiver.kernel.org>; Fri, 28 Oct 2022 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJ1UjD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ1UjC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Oct 2022 16:39:02 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9058223643C
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ml12so4874749qvb.0
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uygWuYBy9wdgTo+YR2Pf2NOhXJWrZ17lCvPJoA4UBI=;
        b=PqRsziP7kLfjEB8PEeFrjJUupnok25sbEoll1fo9/N3eKIj2kAQXHn9h0ODmEc88i/
         gdqcpx1OX6Mj3kFBOMVf1c/kozNd4tC8M6IC4juOz+wNo/U82C+MFyg4t/wyC49iBls2
         xvp949Vy0iZFa3aZSF/FgtHhF5bn2bgRnScv5fGYoj1MOoFmtR5rAz5MM5jV+CfjG37z
         MTJilKD+ITnjxnZMUpksdvH7yLaziBMpq3byD5188BqK/RsAcB0XSSIfrtyRM1MyLBHW
         I8VA+RXdnAQ27RagPcVLH7Em0aVTIikWVw/Sik42T4KdTZsX4lKtAtEtcKR3AhdZoqbj
         1LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uygWuYBy9wdgTo+YR2Pf2NOhXJWrZ17lCvPJoA4UBI=;
        b=OuSt+39hPGF3O4YU6PEl8Z3S/MoKg0dElBoEiRo5wh9Vihq6j7weoDG09MaJ5NFIl5
         Qy+R0SnquxdFhIr8xBlMt7l7JOp38LlD+0gC0xMu1tVxK598dPpkg8h3gmmAKuG35jxh
         gCNxJ9eCh/WvcZXOnX5yx0agJgfmvE7hn6bjF2zinGBFbdiMkLTkPTIEpe1MUGaUpzV0
         LQRo/Owd1pphgYTnQXnoUB4H3HO8EuNkFDrvlx2ycTPMQwzv7yfBozc85F1+oQ+8k/GN
         nZdZmHafSv05Cwh8gtNgwsxqYyyZ9UNxkaL1ek2v0tQMv0LNISIzBNwspJamJi7qgMqC
         zY9w==
X-Gm-Message-State: ACrzQf1nJXTMBJ10alJ0moSEJD6RuYdQ+9hLj2qt7Zd9SCpVqvpN92FV
        i2gX0p4tl844I77Xk6MT8OTfEFVUJ3E=
X-Google-Smtp-Source: AMsMyM5pEqsR4UqvKxxZhMvCd9CpFEh5x+KhFQYOAEtwLm4baW5MDP8yjaLiZphNmzZQ36t4Z6Cxsw==
X-Received: by 2002:a0c:979a:0:b0:4b7:4a8c:a80d with SMTP id l26-20020a0c979a000000b004b74a8ca80dmr1371975qvd.42.1666989540374;
        Fri, 28 Oct 2022 13:39:00 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006ecfb2c86d3sm3606642qkl.130.2022.10.28.13.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:38:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5] libselinux: Remove dependency on the Python module distutils
Date:   Fri, 28 Oct 2022 16:38:48 -0400
Message-Id: <20221028203852.526472-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028203852.526472-1-jwcart2@gmail.com>
References: <20221028203852.526472-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The distutils package is deprecated and scheduled to be removed in
Python 3.12. Use the setuptools and sysconfig modules instead.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/Makefile | 2 +-
 libselinux/src/setup.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 49b7d60a..dc284832 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -14,7 +14,7 @@ SHLIBDIR ?= /lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
 PYCEXT ?= $(shell $(PYTHON) -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
diff --git a/libselinux/src/setup.py b/libselinux/src/setup.py
index 71e69a10..6cbe3a0e 100644
--- a/libselinux/src/setup.py
+++ b/libselinux/src/setup.py
@@ -1,6 +1,6 @@
 #!/usr/bin/python3
 
-from distutils.core import Extension, setup
+from setuptools import Extension, setup
 
 setup(
     name="selinux",
-- 
2.37.3

