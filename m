Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E978C433FE
	for <selinux@archiver.kernel.org>; Wed,  2 Nov 2022 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKBOBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiKBOA7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Nov 2022 10:00:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB6DFED
        for <selinux@vger.kernel.org>; Wed,  2 Nov 2022 07:00:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 8so11749997qka.1
        for <selinux@vger.kernel.org>; Wed, 02 Nov 2022 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJgLaJIHQwsJdTBM+S8HMlIfnDte9qMBTNt2CXSUjDg=;
        b=mGIxBPssMn8sXzUhHSoWFBhwxO+z+AMcOa3zZLPXv6wbBZMvhB0zG4MO7SRaPezpfT
         ptiQeW2gmH/B5toP8FQ9399wbM7me1INTcdNgPgjKg7GndoUaS/TVZtNknaE13uhQddR
         HzFasS4demOM9mQqBKjcC8KEOPglloDiBlZ6nUCz5e0UIQRHwcv2QZaxj83NtwT07PD+
         +40iw4ygNBcmMMcgAjcTafR68/1pDcrVRaLxhG5+aq2RlmGJdDENNlKIbiORyJ470ybM
         2LxxssE+7GouRjGlCZhD89HN1QMFxMgefa5iGrGVOWfMyYI4phlqXqgx/4AodRTQ22mm
         468w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJgLaJIHQwsJdTBM+S8HMlIfnDte9qMBTNt2CXSUjDg=;
        b=EYolX2S7pPUrvphQSZz4G0ICwdGF0o/RGLa4IhujnM4uSZrjQk5ydlJcdyXJDipvnx
         M0/k5fI30+DsYc/mYr155bgsSJdrOcl0izkBnUO7AQthpcjWrFJIp3ifeEj5ddQ7gn+t
         VsggZ8yjyrm3BZTswTsaIPDkIqSBDXYu/Aj6EEgE8bg8/Im1Vs+HvuBEmvSTP4JGeFnN
         6eVDPunb38p69xBG1Iiv17HttUKcSTR/RYLTLjK9Us44kr+9Njsl9e9N4a+99gDinZhV
         ImvN/zd7AgJeVvo6INukim/KtXRa3UunkCchLtAKyL9L7BcNsMpv1Tf8dxhmaIaEJ7pI
         jx3A==
X-Gm-Message-State: ACrzQf0fNfS1Rk9NXkB/P/Px2t+VlmPdDuC6EF7qWwtThH5R/6digTvY
        F2NCd/mws4XcK8WBwsgygFnY2GJ9nFQ=
X-Google-Smtp-Source: AMsMyM4qjwaBbEnF/PH1Gd6XXdmg0qRLPjzpo3EMfUltlfTo8ZXiIVWtisyz456eE0+0iBlU99KvqA==
X-Received: by 2002:ae9:f406:0:b0:6fa:395d:1480 with SMTP id y6-20020ae9f406000000b006fa395d1480mr9533754qkl.555.1667397644591;
        Wed, 02 Nov 2022 07:00:44 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b006ce0733caebsm8449846qkj.14.2022.11.02.07.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:00:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5 v2] libsemanage: Remove dependency on the Python module distutils
Date:   Wed,  2 Nov 2022 10:00:36 -0400
Message-Id: <20221102140039.914518-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102140039.914518-1-jwcart2@gmail.com>
References: <20221102140039.914518-1-jwcart2@gmail.com>
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
2.38.1

