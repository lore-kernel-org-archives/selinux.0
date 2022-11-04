Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801CCC4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 14:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiKDOjH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiKDOic (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 10:38:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866204AF36
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 07:36:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hh9so3092688qtb.13
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqDtXeFfWv2gZhDvQ4womtLYb+MTsxI4bWvw4H/ch84=;
        b=p69Fmw7lUBo7JKNyXOAkUt45d26XQPhEGaA9bo8eXp1r7hmikL5f0IrYlAQY/4E/R3
         XZckpt9/cGTzfpUf9dJiImk46rGMlLH7dsZw4KU0OMhQywsKmqkCZWJPRR9zXZ45YN+Y
         oErjk/ossu3VfhXUyRE0R+7Oq8VFsq8qoG5MKiSFrb2ngRrX09pK2YT3p1R1rdO0p4Bj
         B8aJkYvmOR0hwNRPjnsjMjv7DG953oBZ/o9iagiOq4hcE3Rn8fhQJ0ZAqGbOAI15EAbl
         qdNgM6eGFmrSxjhZH5/DHNxMGpll8fo1ZeJO2FI8ZmceWf2oyQRR8INwV803Gbzu4nbe
         KXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqDtXeFfWv2gZhDvQ4womtLYb+MTsxI4bWvw4H/ch84=;
        b=KSRxuA58Ax3QFgGiAVqjgv5CFkUIHdoc9S70BzxWbou8AMJOBbCX7rQ9p6pskRiOXD
         jFVZ51WhGeFy6ouk01a2EM9dISZEu3N6xn9iF2U7G1ptXy3DCYzqcgbHb4i657Q/P9C1
         BG6I+n70F5UbqPClTctrMNDRTJJ3LApynM+wNPhDTiAhsMW44VYIsgqLEejF//XWoDMq
         PsqBzhkzEOXJ65xKu6AfyHqvRLQy5t97LhXFfNzFnN3JJvYe5MfPnpGaL6zytFVwkCl2
         yN5bQowE2BtSBwcnkZZOVpSuOMBypDa5jU8zbyl47Z//oyUWnU/vWKmEbeNv7PlgnWPr
         lhYg==
X-Gm-Message-State: ACrzQf2nUDzajsbiwL72DsFJhZvji23+TARRA/LN6GicyYUcoQI2guXk
        +zzF/6wkfXHEQ4nBp9G3/K3UF+4CHn8=
X-Google-Smtp-Source: AMsMyM5+BvmYh1GW0T1acEIJds/0zKlTHPeqCaXd6x7+6a3ToBR5nheIlY2TrMyCQ1PwsWfMw5jpCw==
X-Received: by 2002:ac8:4916:0:b0:3a5:283b:22c7 with SMTP id e22-20020ac84916000000b003a5283b22c7mr21372198qtq.64.1667572582280;
        Fri, 04 Nov 2022 07:36:22 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b003a50b501a01sm2479324qtn.87.2022.11.04.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:36:21 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5 v3] libselinux: Remove dependency on the Python module distutils
Date:   Fri,  4 Nov 2022 10:36:12 -0400
Message-Id: <20221104143616.1089636-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104143616.1089636-1-jwcart2@gmail.com>
References: <20221104143616.1089636-1-jwcart2@gmail.com>
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

