Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677BFC433FE
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 14:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiKDOjL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiKDOif (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 10:38:35 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F7D748EF
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 07:36:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l15so3124293qtv.4
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8LoObgE/y/k7pQq/IkvKwNJ4jpgV16XqK/OGNOTMrE=;
        b=VAGvp0py74EMfjFjFIM4YtxPHxHBZrECKJub/a2mSm2jlyOvMp6GuNR9z+68uNhnMI
         znQpwpHjPqEc+Fq/o6Lj7NTLKaoRU/F9P2mee6Rcsr3lrAOqHTxiv3cW5GMWT6kCcBuz
         6tUxDQBNxsylYP6jdACjOA5J6NP7dHoTJDLBNGAewZv5HWAGojvHcJIncpaZzzmS0zW2
         LR8e42M9JVDUEdVsuXfk2TcofKOAHycuPeKqFhwZAA/exCwFv5c8YLdV05fUqQn2N4bN
         Wuhs/JcA5u6fx77aUUUgMeaqO8WoG7i6TCAmgsZ8TF5CPUeZf+khLtBQhzq59sjLvMnT
         33Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8LoObgE/y/k7pQq/IkvKwNJ4jpgV16XqK/OGNOTMrE=;
        b=FEJ6ogPkW9zcQqAZWBF2kUHw8VbTL4xfOdFrpCXSlSp3hHM2ouJKxU0FfPaxoEBVP/
         /lFR+6jGcEri99/013zgOTpQqaqpoqpoXko/lGZ6iFkD1NdT/erwI0m1l0rqVa7WqaaH
         8wELKzZpdzCY9x2sI8zHwGiBzECN+FxgrhGMueqMhlS3/0uPHEaVVpKC8TjImevUkj14
         UUl4BzWFFfporv9tyZlwVGVVE754GJ/i20NwGLgrCFuvTJpMGQZmT7EXiw46uk7NZtZf
         6D+rVb1NSt3K9MT/RK9u2PDCNuJAfN9ahGDBfSDKL81X1eeVfvqE24SKmDrVjMWUQqRS
         kpdg==
X-Gm-Message-State: ACrzQf0gY1y9cQxHiWFq80QsZM3TE4fHkhLoeSVwUN8gzx00b+iRy+Ha
        c+OC2s708WtgFU6QD2zW/blpJaSwusY=
X-Google-Smtp-Source: AMsMyM7bn+tGsvmBsJR41pYU5ypYRBAdXN+Xli/no6K0/txe2A4hGESA9i/SGWmW4fE6Lga8it9Q+Q==
X-Received: by 2002:ac8:7e8f:0:b0:3a5:5bd5:f95c with SMTP id w15-20020ac87e8f000000b003a55bd5f95cmr5685549qtj.83.1667572584540;
        Fri, 04 Nov 2022 07:36:24 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b003a50b501a01sm2479324qtn.87.2022.11.04.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:36:24 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5] python: Remove dependency on the Python module distutils
Date:   Fri,  4 Nov 2022 10:36:14 -0400
Message-Id: <20221104143616.1089636-4-jwcart2@gmail.com>
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
v3: Removed another usage of distutils in gui.py
v2: Use sysconfig.get_path('purelib'... since original used
    get_python_lib(prefix=... instead of
    get_python_lib(plat_specific=1, prefix=...

 python/semanage/Makefile              | 2 +-
 python/sepolgen/src/sepolgen/Makefile | 2 +-
 python/sepolicy/sepolicy/gui.py       | 4 ++--
 python/sepolicy/setup.py              | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 024e9640..b53ee33d 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -5,7 +5,7 @@ LINGUAS ?= ru
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
 PACKAGEDIR ?= $(PYTHONLIBDIR)
 BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index cac8def7..a1039227 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -1,6 +1,6 @@
 PREFIX ?= /usr
 PYTHON ?= python3
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
 PACKAGEDIR ?= /$(PYTHONLIBDIR)/sepolgen
 
 all:
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 5bdbfeba..335be582 100644
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
@@ -130,7 +130,7 @@ class SELinuxGui():
         self.application = app
         self.filter_txt = ""
         builder = Gtk.Builder()  # BUILDER OBJ
-        self.code_path = distutils.sysconfig.get_python_lib(plat_specific=False) + "/sepolicy/"
+        self.code_path = sysconfig.get_python_lib(plat_specific=False) + "/sepolicy/"
         glade_file = self.code_path + "sepolicy.glade"
         builder.add_from_file(glade_file)
         self.outer_notebook = builder.get_object("outer_notebook")
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
2.38.1

