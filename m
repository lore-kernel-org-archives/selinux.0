Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A23C2BB1D
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 11:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1731B20731
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 11:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H9Kxf6bA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDGL66 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:58:58 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38034 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGL66 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 07:58:58 -0400
Received: by mail-wr1-f41.google.com with SMTP id 31so3559774wre.5
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upR5yrFqFH/BUsP1gSrlmgJlHZ2CFPV5tWXlaaiNU0E=;
        b=H9Kxf6bA20PNlQVqpm+MBINzXGown9PEBMPX068p3DlpQgtGvbPeEaADmz0V50RPs4
         w1vs2FtGLMXGmk+MjRNjmbX2gkzcGbZtTib9Iq2zRRVrCb2oS2py+vxo3eZ4bOufFHqC
         K8ZPKEh4NlowyFT9c0AaVn18kzaMTzQ9X+FPpGNQfqpiCmzNpkh39NeELgBNr+S3/8Zm
         J+o+A3mXtJzbfqQIzi/JuoUIj61dv5mJNs39f+lohMoQUX7ps1vNuabTtYl3bBDYhDuP
         CpvDCbB1YX2soGSuZaMwYCVPwI1WxCo0gRebQLKfdMEQ8TDjN95LkvqIZO3BfuAYUqnk
         RByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upR5yrFqFH/BUsP1gSrlmgJlHZ2CFPV5tWXlaaiNU0E=;
        b=E6Phh+56A4jo9halOpYfcWi8XEgOxzVRyHWOjdhIpVJhhFtXJ306JCNYlD836qxvn2
         yLL1i4J8DqtG+XUrop+pFi/cwPIu84a2JZwIQB9k7+gh9rgMZZ9m5u8RrOwKJYJ4ESC9
         rADKPs21h/dTZmBabEghRMKSjgsEHCEbpADmfX08fxgYJibvMhNkhG5h44vB9zkBoyPe
         qL2MBBWzMlf5lq4Q/ULE7xfsq+b1zI1V1VRsiFqxGtHL3YloTzxHyNZ1dZitYaFhHtn3
         Kq/ZB9iEdLYX6iShhYvY8cIsyUS0NXfjGz22yWa1CB5rzO40kxiAy0ecK+ahCEMNxqOa
         mDfg==
X-Gm-Message-State: AGi0PuYI0ado3S/zmKjFeTzWuz6+WUyhSAQamgXo0mtDXxxk0jHR7zDG
        6/SMYSL4NzfRYCYmCTPH2luwwt3r
X-Google-Smtp-Source: APiQypLGmkCTCRKVuugHoXvNaL/Mx9WszbEAUinr3PeUSclDioR2pHYNtpV2pF8laI9xe/Lu9ncuCQ==
X-Received: by 2002:adf:9168:: with SMTP id j95mr2311326wrj.145.1586260734644;
        Tue, 07 Apr 2020 04:58:54 -0700 (PDT)
Received: from debianHome.localdomain (x4d01eb9e.dyn.telefonica.de. [77.1.235.158])
        by smtp.gmail.com with ESMTPSA id i17sm1599674wml.23.2020.04.07.04.58.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 04:58:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] tree-wide: use python module importlib instead of the deprecated imp
Date:   Tue,  7 Apr 2020 13:58:49 +0200
Message-Id: <20200407115849.41225-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.0
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

python3 -c 'import importlib;print(importlib.machinery.EXTENSION_SUFFIXES[0])'
.cpython-38-x86_64-linux-gnu.so

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile  | 2 +-
 libsemanage/src/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 2d1c654e..ddb5e013 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -15,7 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
-PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
+PYCEXT ?= $(shell $(PYTHON) -c 'import importlib;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 606ce1c6..00aee063 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -14,7 +14,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
-PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
+PYCEXT ?= $(shell $(PYTHON) -c 'import importlib;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
-- 
2.26.0

