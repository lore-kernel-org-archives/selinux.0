Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B77C433FE
	for <selinux@archiver.kernel.org>; Wed,  2 Nov 2022 14:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKBOBe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBOBA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Nov 2022 10:01:00 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA406FAC1
        for <selinux@vger.kernel.org>; Wed,  2 Nov 2022 07:00:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cg5so2578025qtb.12
        for <selinux@vger.kernel.org>; Wed, 02 Nov 2022 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s45UYosyp2pmL626PE9So0JOZBWS1orQGfOv5LNw67c=;
        b=IxnRr6Vs7C5OnbYQ/d+61UvENf/hSvl4uX9+PCVYvsdagCilAL/zRe7qxs1BC38Dtv
         Ph88sS6JRZWKASTTzCVG7hfar3obmrRv8ixjfU78F/fB5fEkfutfG2n/hRgOUn4wvOtJ
         CrJyw52dSvPDAvd2XBj82UhzuYo+FN9LamsAT29F98Qag2pcux75H3FQkR5G+xSzbQzR
         3aLe/m/yGQe9PrCj4Nl1rUaXwAKIHoe9Jyw0QBhBTUMuJ6uuyZP7/fmifhndlkvGlFKR
         FF5HcTE/4fI22DsLrNcTHciCGpcBx4XW12pM5mWaoe5TsxAns6cX9P8K5OtmZaH0Mwk5
         n2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s45UYosyp2pmL626PE9So0JOZBWS1orQGfOv5LNw67c=;
        b=aOJJv7gnwcgr7y7u86KpVp1em4qUsZS5xreOe5Kq0cLJYhSQGlO8YGVpeiwVydyF6X
         oDUuYJ2jVKDiEohQX0VnFSmOpeNpZ11YzsbSMfeDwE8SAJn+f5E++yeXArtLFK/d6j/v
         TZDU/2LB8ycxX6lpNohLH8xLTXFZPmF4EPfH+1WUnE6kLDf/7CZULbarP9D8Qwjh1c5r
         7habiOy7GyILg8OWyoG3wyZkzGOH9OyE2t4DQfNt9I+fJkwdDQRnhXCVBfyQcy9jdko3
         nKadNkuhNdtiGtEn+oc82yt3D+7DStfz2s/gnRUgz+V8HVp/TRptlfwOUSx8FBNfKnbv
         zerg==
X-Gm-Message-State: ACrzQf3O51fC8Y8y7eMLkGOk935/0ekCCRegJK7H815eDeTsOqOrO87X
        0hjkwsh4jumc2XZMH3e/AkGh4VQr+Ns=
X-Google-Smtp-Source: AMsMyM6MBVWI4Qc5KxfhwH0c0otLZRKoaQJkoLcQnEm5pT7zsHjJNZtMkUE8IkotBOQSmXLL0eoIRg==
X-Received: by 2002:a05:622a:2590:b0:3a5:456d:6740 with SMTP id cj16-20020a05622a259000b003a5456d6740mr2473087qtb.560.1667397645562;
        Wed, 02 Nov 2022 07:00:45 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b006ce0733caebsm8449846qkj.14.2022.11.02.07.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:00:44 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5 v2] python: Remove dependency on the Python module distutils
Date:   Wed,  2 Nov 2022 10:00:37 -0400
Message-Id: <20221102140039.914518-4-jwcart2@gmail.com>
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
v2: Use sysconfig.get_path('purelib'... since original used
    get_python_lib(prefix=... instead of
    get_python_lib(plat_specific=1, prefix=...

 python/semanage/Makefile              | 2 +-
 python/sepolgen/src/sepolgen/Makefile | 2 +-
 python/sepolicy/sepolicy/gui.py       | 2 +-
 python/sepolicy/setup.py              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
2.38.1

