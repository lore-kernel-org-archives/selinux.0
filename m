Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D7C43219
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiKDOjI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiKDOid (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 10:38:33 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892D630F5F
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 07:36:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e15so3134151qts.1
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJgLaJIHQwsJdTBM+S8HMlIfnDte9qMBTNt2CXSUjDg=;
        b=lWolexwFNbT4+HF5JFTyHdz15g00Xfyd1yP+zzHIDr96P3npInYOpMmVkb3SSRvTD6
         ykEpO/V1pnOp8g0TUmoZHXrN+zg7KplKX6Zv4vpJz6nyV3b/WhkGW3GDup+iDThE/cCg
         IeGiBudU+W8+tgZx8poHt2BpW45aFCKVaiG45tmX0i9Z5lNFn/fhqSehKsI9aMeiea6M
         TN2LQhED46X8hm4022Joj92+LMkEwthN/98BkglYiisW+RQOO9PoHSg7zRHXIHgbMIMa
         EU0iGrp41ZQlLmdfWmaA04AD4cD5dAAOq6JQ/oDtaKC83DY3e9OoFShuzu5yBudidS6f
         Vq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJgLaJIHQwsJdTBM+S8HMlIfnDte9qMBTNt2CXSUjDg=;
        b=C000ezoC4AetThFRkrkcbRtOMgwDJID9b++Zh7O1eHD389xkmzGvGfbse3KdO44Vwz
         kkQmTp9HO79kw9P3rZEUfajjgBI0ZhJiAddjLjGOKKPdV7+ZNV6KVkiPpBGNZL+RvQxO
         vqzhj4Eo0AO44TNuOhr+Q2l3SGV5ezMrAxrNAWdUmZYgIhfmYfPbRDxmA1tU77/Ec1Gc
         727uShLZS2Zs9OkD0Mm9fNdmisKkU6T/eNr2YYVB2WumOqhtWDCi/fQpFNjUv7jgga+r
         LwlQu/aGhBj6RX2hcwcszoPxJSfSc3zCtkUjy6HfZXvp1atVADJV2uSfiHEQ00269s6p
         sobA==
X-Gm-Message-State: ACrzQf1GE11q6dS2CfkdmEZkvmbETYQitGmHb9to7sEX9XvBwP2uo/F9
        l5QkAFquDux/v5AHv4rxf606pi9hH7k=
X-Google-Smtp-Source: AMsMyM6t84LOAof7pJ74s/ZlQgf8DEBlFWReuphG/9aYRGACM/Y2DhZ+sEx/fdjlx7A1B9oFQ51zRw==
X-Received: by 2002:ac8:5814:0:b0:399:39ca:fd63 with SMTP id g20-20020ac85814000000b0039939cafd63mr29262375qtg.0.1667572583314;
        Fri, 04 Nov 2022 07:36:23 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b003a50b501a01sm2479324qtn.87.2022.11.04.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:36:22 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5 v3] libsemanage: Remove dependency on the Python module distutils
Date:   Fri,  4 Nov 2022 10:36:13 -0400
Message-Id: <20221104143616.1089636-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104143616.1089636-1-jwcart2@gmail.com>
References: <20221104143616.1089636-1-jwcart2@gmail.com>
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

