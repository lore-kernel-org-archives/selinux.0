Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21519C3F6B0
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiHHRhI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiHHRhG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:37:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87D4140B5
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:37:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kb8so17908919ejc.4
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=q2QMLo0GZQ/LpQ00Gynk/V5qQy3diQPKRJdbhRTfjco=;
        b=b2LOx9u6fI4Hla0zM1Yv4ZbDravAKyemfkyO+/+CVnuLaRXO0StQeCPveCXk/5X91H
         xs++mXwnmlFWi1PIsFI572lw61X/8X5Ds/dr2SZMudvgFLHt++s/gKUrK/2LSubteiQ/
         73PTNK41UiHUfId7aN6Pyda9wsyq91zhyx/R2XnRPc+HmGrWYJ2cx0n7vImDMpZme7Lu
         AMjZNkiatgNZV8SB6UtdKXS9KPoijSqJOW8sh4xBgR8bVfRZILxLjEw0utv08KXpOPFw
         iuGlgV3UJorrUrnpkihoavf38z6bn6viFnFPy+9gUVYhXlBDzagKAEjp2Sa9/9Bw99if
         tYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=q2QMLo0GZQ/LpQ00Gynk/V5qQy3diQPKRJdbhRTfjco=;
        b=xTjzOX3nClZ10MEuW+Tr35DMtXfYumlewVZPC8kNWhZ4ogPp0XWofb3oE9d3JT1Cor
         f4fRX9mIcCClRuYyD6gHYM7EV6EtVhSqnfOwkI5iYjJ6MOk/6hslV+k4JH7cPP5d+C4+
         UdvO/t9NBGaKc2ST5T792dytykGxqwKvvalTCnSay0SB9kUM4FVC/9hhYB0yKE01fLO0
         uNtKEbYu5YEyV9Ot7DHsyYK9/g+qaYPSHOdTNymF6OQ9ZyEghY0L4DEcoWHrYIZOtptD
         c4Knh3qYJu0nMiz3RBojkyHNQk48sco5vg1ntjmovl6r0dZZ4gKanwnxRva7xjw5/LYJ
         H5cA==
X-Gm-Message-State: ACgBeo2IIcfCpHiF7+yxfCoUeLcTe/p6n/kdseibBnAECztCKzEQW+jR
        c7MplC7D9DeClH+i2+qLYfFN94Ig39g=
X-Google-Smtp-Source: AA6agR5+7Mn/ijSmpAQYfTOQdYaGDYaCVUqNczbCEJ3Ttkt2k0gvhyyZsXbDw4bVzVMKDNr6h+SvgA==
X-Received: by 2002:a17:907:7b92:b0:72b:67fb:8985 with SMTP id ne18-20020a1709077b9200b0072b67fb8985mr14093555ejc.569.1659980222214;
        Mon, 08 Aug 2022 10:37:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id es25-20020a056402381900b0043a61f6c389sm4851900edb.4.2022.08.08.10.37.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:37:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] Ignore egg-info directories and clean them
Date:   Mon,  8 Aug 2022 19:36:55 +0200
Message-Id: <20220808173655.16867-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808173655.16867-1-cgzones@googlemail.com>
References: <20220808173655.16867-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    Test .gitignore and make clean distclean
    error: missing .gitignore entry for libselinux/src/selinux.egg-info/
    error: missing .gitignore entry for python/sepolicy/sepolicy.egg-info/
    Error: Process completed with exit code 1.

    error: "make clean distclean" did not remove libselinux/src/selinux.egg-info/PKG-INFO
    error: "make clean distclean" did not remove libselinux/src/selinux.egg-info/SOURCES.txt
    error: "make clean distclean" did not remove libselinux/src/selinux.egg-info/dependency_links.txt
    error: "make clean distclean" did not remove libselinux/src/selinux.egg-info/top_level.txt
    error: "make clean distclean" did not remove python/sepolicy/sepolicy.egg-info/PKG-INFO
    error: "make clean distclean" did not remove python/sepolicy/sepolicy.egg-info/SOURCES.txt
    error: "make clean distclean" did not remove python/sepolicy/sepolicy.egg-info/dependency_links.txt
    error: "make clean distclean" did not remove python/sepolicy/sepolicy.egg-info/top_level.txt
    Error: Process completed with exit code 1.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/.gitignore  | 1 +
 libselinux/src/Makefile    | 2 +-
 python/sepolicy/.gitignore | 1 +
 python/sepolicy/Makefile   | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/.gitignore b/libselinux/src/.gitignore
index 001f20b0..94400e81 100644
--- a/libselinux/src/.gitignore
+++ b/libselinux/src/.gitignore
@@ -1,3 +1,4 @@
 selinux.py
 selinuxswig_python_wrap.c
 selinuxswig_ruby_wrap.c
+selinux.egg-info/
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 88aa32f8..49b7d60a 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -201,7 +201,7 @@ relabel:
 clean-pywrap:
 	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
 	$(PYTHON) setup.py clean
-	-rm -rf build *~ \#* *pyc .#*
+	-rm -rf build *~ \#* *pyc .#* selinux.egg-info/
 
 clean-rubywrap:
 	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
diff --git a/python/sepolicy/.gitignore b/python/sepolicy/.gitignore
index 3186c860..32fb47f9 100644
--- a/python/sepolicy/.gitignore
+++ b/python/sepolicy/.gitignore
@@ -1,3 +1,4 @@
 build
 tmp
 *.bak
+sepolicy.egg-info/
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 3361be4e..d983e409 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -18,7 +18,7 @@ python-build:
 
 clean:
 	$(PYTHON) setup.py clean
-	-rm -rf build *~ \#* *pyc .#*
+	-rm -rf build *~ \#* *pyc .#* sepolicy.egg-info/
 
 sepolgen:
 	ln -sf sepolicy sepolgen
-- 
2.36.1

