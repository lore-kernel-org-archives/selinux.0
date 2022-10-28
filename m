Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE075FA3743
	for <selinux@archiver.kernel.org>; Fri, 28 Oct 2022 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ1UjE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1UjC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Oct 2022 16:39:02 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497FF236411
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b25so4238357qkk.7
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1//3EjPXUygil4S96s4E9Xj62821VC9xZkBYGGEd9M4=;
        b=Qq7XRJUokVUtmYIOAupdEuf03j5YlycjfhjB/Ob008MOvUfbeU1EnwAaRNexL3ZRZL
         gc/uGyfRvbxWKKRJChQPhqj0lkGKSEbkiPLl5GlW6VuQ4iXUl6WsN0anV/gW7LK5Aeoq
         cq56r7YUFto3HL6SYRTcLFoAqzY4jA+R4V3AjW+2uQqV6FpWyy6O3aqSaqullf5LV6RJ
         ESxULORPzGAivd//PinIEUxEvuz2DBuxwB7CCVlPAkNLdjDYyPSEaVbO7Obxkx6AscnI
         PrW6uiU6dReyhzGPVzphfML+GrSOTqLRc2MRF05Yu96aeB64fZZsHMd5acti4AHzqYM0
         O7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1//3EjPXUygil4S96s4E9Xj62821VC9xZkBYGGEd9M4=;
        b=2/enCL6KXf0rvvtBwTJs/cVcbGNY9H/WAMJEc7yO3vff6G14uv6LTTyUpvX4i3We0w
         VxhK2kHRiSmFX6BdcL8TJMEHa+OheVexQAS7Ml+z89Tej+Ljt4dqlO1kP0WEZQopSFd/
         ZQHmUCZ0U14o214EaGF1eZq2XL9vOk5POW9LCt33V3LOWTR4g0qpACWSo5na5SqseM2R
         r4totlz+Rm1nYOJjS5hn6MC5Fwx+d5jNsIlkCbFGV2BangT87T11Vpa8jE8cys3lUT32
         NAc38G0rNgKZga7gyIWlVlRapUC1AOmOb6Oh/1sKuQYc0J2mihtbHpv/77nQB8lQ1Ezf
         c//Q==
X-Gm-Message-State: ACrzQf1DOdyDulRNUgx5uIHfDxnowP9T4S2X7fcgDBe9iQopIqdn0w5V
        kpr2rN46tQ663vH0Sxw4G248HZqB3ME=
X-Google-Smtp-Source: AMsMyM62FQcJQySzFIeKa+G77px1RwQtJVWWbiP/db7nbS2FoUiCTITKZVYe3K8l+WzhBLaR6JfvVg==
X-Received: by 2002:a05:620a:440a:b0:6ec:d931:652d with SMTP id v10-20020a05620a440a00b006ecd931652dmr923243qkp.344.1666989541259;
        Fri, 28 Oct 2022 13:39:01 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006ecfb2c86d3sm3606642qkl.130.2022.10.28.13.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:39:00 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5] libsemanage: Remove dependency on the Python module distutils
Date:   Fri, 28 Oct 2022 16:38:49 -0400
Message-Id: <20221028203852.526472-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028203852.526472-1-jwcart2@gmail.com>
References: <20221028203852.526472-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The distutils package is deprecated and scheduled to be removed in
Python 3.12. Use the sysconfig module instead.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsemanage/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 01df0181..589e4a70 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -14,7 +14,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 SYSCONFDIR ?= /etc
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
 PYCEXT ?= $(shell $(PYTHON) -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
-- 
2.37.3

