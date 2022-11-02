Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F7C43217
	for <selinux@archiver.kernel.org>; Wed,  2 Nov 2022 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiKBOBX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKBOA6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Nov 2022 10:00:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AE464EF
        for <selinux@vger.kernel.org>; Wed,  2 Nov 2022 07:00:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id l9so11727181qkk.11
        for <selinux@vger.kernel.org>; Wed, 02 Nov 2022 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqDtXeFfWv2gZhDvQ4womtLYb+MTsxI4bWvw4H/ch84=;
        b=mAr0tvyFlIeiabYazfKYJoTrABSThe5+eYLaLG4bqCj03smD1r5SmVHlmxNlgMIHJP
         eXPXKCUzzeBDKoPofB9HTe4JbggJS6Haron8NB1KR+pvpoG97Wdos+rVfCVGme8DZRn1
         e5fye2iIaGCNmcXaLmFmKTaD5sle7sxD5eAa4ER+SEXMPWz7awafEXSvU8rpKERgcDfG
         ItXj+AXKmQ7n+vn/v8sX0QUTVuQn/Z53YjOJLr7z9Uv/LEycybqp6S8NAx+/XKt3ZSn/
         3ljiGf3qhDhu/VPEAUhajgiQjKLUuGYVCLM4YWqDG2nNyT8wVJ3qsZLwyEVaXMZuAlYn
         69JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqDtXeFfWv2gZhDvQ4womtLYb+MTsxI4bWvw4H/ch84=;
        b=U+ZTOUduGd5E5csBqCYsEurPde/PulY65EjxY6WT43582HfBo793CDAX/ifdOAPwBA
         0j9gkxxbGkFypL8dtgmcz1kqv0MomBEFnMDUkqQb9MEf4hsCWAiwbl+x3T7qrV5pd2Dd
         FFV3x+erPctS+OwSZp20hWrpgK41zuOPQAtz0ilGMLnjIUzKKh+yn5KcwdxUya4KLjVM
         /ujYFsxKvMpmdF/lX14lZ0VTStjImmvziQ9T/WY9Ev6PFppYJ6rh2X5BZQvba5XePPiE
         x92spzLVjUZqzDVqKJ2gtitDavhEfqHN7COJY/pj6bGkek+ztYGN/TtrKrf53BJyys7B
         ljow==
X-Gm-Message-State: ACrzQf0PuNZoDGTIFi8qSSpT0tiQhpZNCNxaV6Ku6FeZc5UIUibE+XRf
        pi0U5TEuIbOtu/3SPOKMqG3lE5hR06g=
X-Google-Smtp-Source: AMsMyM7OzM/2a8mqBQLhkzAd1aUaMalinHOXYi5ss+n+E+Hq2NLPRlgVxey1TpbZomrYTW+koPy/7g==
X-Received: by 2002:a05:620a:132e:b0:6fa:5082:f870 with SMTP id p14-20020a05620a132e00b006fa5082f870mr5279442qkj.391.1667397643629;
        Wed, 02 Nov 2022 07:00:43 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b006ce0733caebsm8449846qkj.14.2022.11.02.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:00:42 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5 v2] libselinux: Remove dependency on the Python module distutils
Date:   Wed,  2 Nov 2022 10:00:35 -0400
Message-Id: <20221102140039.914518-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102140039.914518-1-jwcart2@gmail.com>
References: <20221102140039.914518-1-jwcart2@gmail.com>
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
2.38.1

