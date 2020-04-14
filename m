Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E3C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5C520732
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ehES+TnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438122AbgDNKGt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438097AbgDNKGp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 06:06:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692AC061A0C
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 03:06:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o81so6758560wmo.2
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=il1BSP4B82kWHEdRf6Qm9ONq370SsTup8MsCaJizDI8=;
        b=ehES+TnHM350jdbDAZbjRHdng2+KX1xGnAkKvV9idpWKrCbIUwddvVRW8RX2RS6fEI
         FIugbKB8ATqF6CO/wJ5pdlapi/WHdtzomKPwK2pqBsLfjXO8xXnJGiYoFDuRzPzLS2II
         nveh5Vc7VdZTzhiZgkZP84KDGCdHszp0lZTgwsQ88AGyM8qIZkFpQeKB+Fz2UD2fanin
         BhlhB6b9pftGvXdDHM8bjRRbTbgtcSPh+ZV2t2I1FoZBCm5ybSIxvYyZOA7RI0cc2VnQ
         xsEwvI/v1SL15Pp8Iz1nVE1i1tzy7aU8LBVZB0rJ9jbrXEzKvEzJZQJOZasJqGnjgRNL
         Lo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=il1BSP4B82kWHEdRf6Qm9ONq370SsTup8MsCaJizDI8=;
        b=LD9cyeqMoqZEMbaZJDSs8yZaQPW9EcwCgj9JKiExEpwzwkXanbUTIfKy2FyGYa7URU
         Gg61zbsjD8iPnwzFiIm+sv010twObc39/jkrrEf3aTBNaHaEnO8Cq4AHMDoCBVuAA9MV
         Sbrnl84UEJCFYfJkhwj2BNWsdpAIyFN62BGSV7ydeUevdj1C/KE+ool6FEbwGtpBzOeE
         tMM7cFZ7nPDhV09bZyNbSNdOM+ywViaPYzAE9Nxd7DsGuIWVHw+zgQDS76CI8Bsdc7z8
         YASF0hXxRCrxlPN4SiN9fmcsWOogFwMnj2c3R8kHzU4BH/hDB1gnYvLL+LUJWQfqwqP3
         z5+Q==
X-Gm-Message-State: AGi0PuZkIqDK19AnwD7blC4EpWXZlDjNbSnCTs3jqpd4Y3HlQpnKDd4J
        GN6We0ZTFS+llMA4fyfJEt385Cb+
X-Google-Smtp-Source: APiQypIXt12HkHS3wYNDnqmJVTqeEUn2udqkVaiTNRARRrYoNXxB4IxYBEx/6Oram7dUHkdsGdQ7WQ==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr19844220wme.0.1586858803821;
        Tue, 14 Apr 2020 03:06:43 -0700 (PDT)
Received: from dlaptop.localdomain (x4d000dcc.dyn.telefonica.de. [77.0.13.204])
        by smtp.gmail.com with ESMTPSA id o11sm18065825wme.13.2020.04.14.03.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 03:06:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] tree-wide: use python module importlib instead of the deprecated imp
Date:   Tue, 14 Apr 2020 12:06:06 +0200
Message-Id: <20200414100606.14601-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407115849.41225-1-cgzones@googlemail.com>
References: <20200407115849.41225-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace

python3 -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])'
<string>:1: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
.cpython-38-x86_64-linux-gnu.so

with

python3 -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])'
.cpython-38-x86_64-linux-gnu.so

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: use 'import importlib.machinery;' for python 3.5 compatibility
    thanks to Nicolas Iooss

 libselinux/src/Makefile  | 2 +-
 libsemanage/src/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 2d1c654e..9992221f 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -15,7 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
-PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
+PYCEXT ?= $(shell $(PYTHON) -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 606ce1c6..a0eb3747 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -14,7 +14,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
-PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
+PYCEXT ?= $(shell $(PYTHON) -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
-- 
2.26.0

