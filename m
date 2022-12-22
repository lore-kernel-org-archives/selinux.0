Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BADC4332F
	for <selinux@archiver.kernel.org>; Thu, 22 Dec 2022 06:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiLVGpF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Dec 2022 01:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiLVGpC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Dec 2022 01:45:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131126139
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 22:45:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 17so1192998pll.0
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJyOJwM5s/tx+bEgWo/Px0r5bcG0YdsjOJ0qsV76vlI=;
        b=fdY9s7M4theQ15sqisNEUDJaIZVhqf1JK3/G+sKUvH1axrYGuEKwe6uphwfiGVlBIc
         epn7tK1ctVsDBM5RaPwMcvreiT48QiLmUNdbJ7St01YpurpdaBuilXR/k61xKmxZsQNq
         X9Bvmrt9PBltIJ6KfvIBuNFbP3QMRqbTfLTSzsyhm8o6HCNG6R69T+eYHMrFb8m5+xgV
         uvQ4wG3v7gREQX3BFqReJ8njDftEtIDfiCKd4V9l8uiN/9Gi6pkaBRqX8CRYXTkCI2zd
         Oava0K2jiqM2O+zDvEv3VRi2oXfJDMUoyFVxeBFQa5PMe2Iip4BQs3vaQgu2mxe9fZ5m
         wrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJyOJwM5s/tx+bEgWo/Px0r5bcG0YdsjOJ0qsV76vlI=;
        b=Jkqyf8MVyyK2iiAQeLl70KPww9dvJTUb1cDiEpu7tWE/CmhBtEbXjD2lUHyzHgGq3L
         jKA/KQHGatI8rJx1OVNjCJ31kfst+Zq8fMk+q6PwHyBxT1MkQYMyNrfRmtK9ZXr1qhNi
         Yb9vUf0mKokltAHiMb/ALLxCckBNfuvDbJV+uoDuD0zt0cYgd02y+1IEJujHgMPoxWNY
         vzzZuYr+yr3Aw3H2079qn5TqWp2pEGhlSHvNgIRzalIL22+cMvx3ZWGNi5X3h1mDn8w8
         tzsxmW/oqZ93GbjRqNcoNHcTRBuXwYkzLXvKxyDDBN1flG3wyEtSEb2HYs5xxoO0tdMk
         xLeA==
X-Gm-Message-State: AFqh2kqeIfbcHFmUw5c/qyEmQpgtMAh+WvrTlyvxr9D3+zyS43vwr7cJ
        Px+PqfFOx2TxNO1u4lrJY6Zr7sjLGbjfZrOlaYI=
X-Google-Smtp-Source: AMrXdXu07c2036dElu+ROjT8e+vz92pAIxbG8ky4kcEFi3UFXzdBbtviGG+hu24U9Fa4V4YpEiwFFg==
X-Received: by 2002:a17:902:8d95:b0:189:5265:a647 with SMTP id v21-20020a1709028d9500b001895265a647mr5068922plo.41.1671691500082;
        Wed, 21 Dec 2022 22:45:00 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902db1000b0017854cee6ebsm12637632plx.72.2022.12.21.22.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 22:44:59 -0800 (PST)
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: [PATCH 2/2] python: Ignore installed when installing to DESTDIR
Date:   Wed, 21 Dec 2022 22:44:52 -0800
Message-Id: <20221222064452.13722-2-jason@perfinion.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221222064452.13722-1-jason@perfinion.com>
References: <20221222064452.13722-1-jason@perfinion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When installing to a destdir with pip install --prefix= --root=, pip tries to
uninstall the existing root-owned package and fails

Fixes:
python3 -m pip install --prefix=/usr `test -n "/tmp/selinux-release//build-master" && echo --root /tmp/selinux-release//build-master`  .
Processing /tmp/selinux-release/selinux-master/python/sepolicy
  Preparing metadata (setup.py) ... done
Building wheels for collected packages: sepolicy
  Building wheel for sepolicy (setup.py) ... done
  Created wheel for sepolicy: filename=sepolicy-3.4-py3-none-any.whl size=1663564 sha256=229546db123e7d84613d190d49c192291b1a4f7f2a037657b39283b04ac391a4
  Stored in directory: /tmp/pip-ephem-wheel-cache-50r2x4cn/wheels/b2/9e/63/6a6212a84d65a709923228719d065ed34e66a90c7fed01e8cf
Successfully built sepolicy
Installing collected packages: sepolicy
  Attempting uninstall: sepolicy
    Found existing installation: sepolicy 3.4
    Uninstalling sepolicy-3.4:
ERROR: Could not install packages due to an OSError: [Errno 13] Permission denied: 'generate.py'
Consider using the `--user` option or check the permissions.
---
 python/sepolicy/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 57a2e55e..4e9e93d0 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -27,7 +27,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
+	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.38.2

