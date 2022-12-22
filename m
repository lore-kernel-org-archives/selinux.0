Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0866C4332F
	for <selinux@archiver.kernel.org>; Thu, 22 Dec 2022 06:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiLVGpC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Dec 2022 01:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiLVGpA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Dec 2022 01:45:00 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B72655C
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 22:44:58 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 82so765456pgc.0
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 22:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qdKW6drgjaAKPQctIZGm42tB4XxXiboA+UGu0Tw1Ck=;
        b=ofev30Kh6yN9Pogeb6TuMkYRrxQNLmTUMOkx7eoNGX3CwaWhT6fItNGpPsiNcyfbQd
         YA+WHLqessi5tUofXpp7BBFkCtkqTcYwlGzCV3gRO4brMLmKdNqjRs0lxXMx3Nke6F3t
         akRyrWN8RN0lTlO1hrRpt7FCV62lGuYXnP0RoFrzNQ8mgj+4ziDlX2j+thu2saLn0OT6
         oPhN1Xgf5OoC62z3atVRmX9VGe0+LQu0+DKMCBxmgBhZkLLluG9miH3E2qAg3BWEVtHj
         kqlBlyLIfRD8VPYGEq3ckljwZByo1E8l+wD51W0EBHjgEuVhZ7T189OCZJ8V84GKzB/h
         PaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qdKW6drgjaAKPQctIZGm42tB4XxXiboA+UGu0Tw1Ck=;
        b=5cSafjuSDUUzgVvFUyUwtqKsFsS1CpBJmPLxN3SWrp4NqalVmyvFBbfJqLr9/Higq5
         ImyHWE7YMkf2fgNulLgk83Tt8FOIv1ACFd0Xyx8t1dRkij7hy+7UO8P+LBK6fwqtX953
         4/w6pGiViOZ0QRslKtKxQq7f4RtXQgYdLlV1HwzGU3kEnHy6+mnRZvmEXv5/qS9KrUzB
         /v75KJrz1NTLiME5sHvl4a43hVSjwy5HxtSspPGjHlx7M4cCFhbDQIiLmFE7k3UDhkaH
         52ROYdPSHiq/1CwiOss8XsvOp/EMQs5ZcgG8vMNCA2jXEF0UT13Xi7+m5YdrnH8W7Qcd
         /SpA==
X-Gm-Message-State: AFqh2koF64/1o6V54ZDVCe//jJPzF6LcoDuQqPptQEiXHWXAYVySN6kM
        kEb49V/3n0+X03K1i/X51VNfqjwyySp6G5naLU0=
X-Google-Smtp-Source: AMrXdXuQqw4uNkOBllt6nNxMflOZXMD2BkBekmsxn2hoyEdTNbzOylhR8p/aZ3TgXgErEEDiXJHKQw==
X-Received: by 2002:a62:1c8e:0:b0:576:ddd4:6a02 with SMTP id c136-20020a621c8e000000b00576ddd46a02mr5174115pfc.22.1671691497652;
        Wed, 21 Dec 2022 22:44:57 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b005754f96f89fsm11752653pff.76.2022.12.21.22.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 22:44:56 -0800 (PST)
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: [PATCH 1/2] libselinux: Ignore installed when installing python bindings to DESTDIR
Date:   Wed, 21 Dec 2022 22:44:51 -0800
Message-Id: <20221222064452.13722-1-jason@perfinion.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When the python bindings are installed to a destdir with pip install
--prefix= --root=, pip tries to uninstall the existing root-owned
package and fails

Fixes:
running build_ext
python3 -m pip install --prefix=/usr `test -n "/tmp/selinux-release//build-master" && echo --root /tmp/selinux-release//build-master`  .
Processing /tmp/selinux-release/selinux-master/libselinux/src
  Preparing metadata (setup.py) ... done
Building wheels for collected packages: selinux
  Building wheel for selinux (setup.py) ... done
  Created wheel for selinux: filename=selinux-3.4-cp310-cp310-linux_x86_64.whl size=725511 sha256=b35e9cdb2a6efce389eeece45446826b4ac6b41f81fdc128893f947036f27e8e
  Stored in directory: /tmp/pip-ephem-wheel-cache-kemjh99e/wheels/ca/2d/1e/d1ab52426d9add92931471cfa0d2558bcbeed89084af2388c9
Successfully built selinux
Installing collected packages: selinux
  Attempting uninstall: selinux
    Found existing installation: selinux 3.4
    Uninstalling selinux-3.4:
ERROR: Could not install packages due to an OSError: [Errno 13] Permission denied: '__init__.cpython-310.pyc'
Consider using the `--user` option or check the permissions.
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 0f6396ab..70ba063a 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -187,7 +187,7 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
+	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
-- 
2.38.2

