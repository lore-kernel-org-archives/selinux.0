Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC4FA3740
	for <selinux@archiver.kernel.org>; Fri, 28 Oct 2022 20:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ1UjF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1UjE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Oct 2022 16:39:04 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A36236423
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x26so4252354qki.0
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19AE9+A9622PSs8MFLOsASoysosQHzardGYfNLeCNOw=;
        b=K7LLgA3TZYMAXsGy16fsrRVVSI8yH74rQrocVn6NU95qlG7mG+nEUfzZPDNdGBM8bT
         FPyYrrEDsUIxQxnrL2pQAe1YPLYJe/0QF51EBev4KBpzPM9X8KTg/lXAQ2VpMRw7H+XY
         Ya0hZwLwgRM9NMf1VMff7NuwTWVJ2Lb77zySlZ2VjkvaKl3VXByWwi3WUqo/m2PA+P5p
         rcCJFQrO519An8okVUl2krX7hpKgcgbZ2m5XbmHJBHpSww+H0G9yS3XK9InfXk8qQsEb
         k5RPrW4xlM/lb+IkO0isBt9TXKFVKKYEyE+JfkSHcogzy8ym68a6DEB9M9OHIi3mh9iN
         GlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19AE9+A9622PSs8MFLOsASoysosQHzardGYfNLeCNOw=;
        b=yiL0El5uIxqh34NVk5fXloTh5rnWbsmySg7FUJ39lZS4sD+4NxgBmMkNAuUigB6sXN
         WTIIdPDdCaZvu2ib+rZU8PdbXKcLDMEjN1pXAI9ZAakF67Zh4hVVGYUSmaN0FQ5GAJoA
         AC2X+d9qw47VRJ+OkUxaiBeAl1AAOCK7Q6IIZbFX7pVDvgP+i0EJnUekkXCm5z+A9Mre
         bP8WlQGxLlKkxXkQ8sFXBOTReTJMAGp07xFS+HiQhCPQ8cgZ7QWNi8DWM+mhkkxfMqdP
         tSMNzSX9EjLxzPqWg6zfBmzmrXXlzyLLCGgCo9eAYa6RMfUpC5/akclIgTr+3SQ1UJGm
         QdcA==
X-Gm-Message-State: ACrzQf1TkLR6XD0xAlpQCZVTuKEiyyinbu+sZ7HL09UgCEurByJgvZ1F
        J8lDfqpUjOE9LgvXdpLVoJzkZXz4wSU=
X-Google-Smtp-Source: AMsMyM4SrhvL56aYFiDYomomMH679e15vcXaZXnaEuN9PHi/dp2C42KVkBNfdnXY6F6hT/aqj44GRQ==
X-Received: by 2002:ae9:e895:0:b0:6ee:74f7:d0e6 with SMTP id a143-20020ae9e895000000b006ee74f7d0e6mr931967qkg.398.1666989542224;
        Fri, 28 Oct 2022 13:39:02 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006ecfb2c86d3sm3606642qkl.130.2022.10.28.13.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:39:01 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5] python: Remove dependency on the Python module distutils
Date:   Fri, 28 Oct 2022 16:38:50 -0400
Message-Id: <20221028203852.526472-4-jwcart2@gmail.com>
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
 python/semanage/Makefile              | 2 +-
 python/sepolgen/src/sepolgen/Makefile | 2 +-
 python/sepolicy/sepolicy/gui.py       | 2 +-
 python/sepolicy/setup.py              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 024e9640..b1f1bd3a 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -5,7 +5,7 @@ LINGUAS ?= ru
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
 PACKAGEDIR ?= $(PYTHONLIBDIR)
 BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index cac8def7..9578af23 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -1,6 +1,6 @@
 PREFIX ?= /usr
 PYTHON ?= python3
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
 PACKAGEDIR ?= /$(PYTHONLIBDIR)/sepolgen
 
 all:
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 5bdbfeba..63f2371f 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -77,7 +77,7 @@ def cmp(a, b):
         return 1
     return (a > b) - (a < b)
 
-import distutils.sysconfig
+import sysconfig
 ADVANCED_LABEL = (_("Advanced >>"), _("Advanced <<"))
 ADVANCED_SEARCH_LABEL = (_("Advanced Search >>"), _("Advanced Search <<"))
 OUTBOUND_PAGE = 0
diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
index b0f9650d..c8220664 100644
--- a/python/sepolicy/setup.py
+++ b/python/sepolicy/setup.py
@@ -2,7 +2,7 @@
 
 # Author: Thomas Liu <tliu@redhat.com>
 # Author: Dan Walsh <dwalsh@redhat.com>
-from distutils.core import setup
+from setuptools import setup
 
 setup(
     name="sepolicy",
-- 
2.37.3

