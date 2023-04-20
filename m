Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C6BC77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 16:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDTQ1J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDTQ1I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 12:27:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC8593
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 09:27:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u3so7558695ejj.12
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682008025; x=1684600025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=euVhsQ5WblzJmtt56AaigUA96LVyQnX3WMfdUWyEQOA=;
        b=otHVLMiNKHSXdg5a+S8xHINyfKt2HYS+k0vI2RqwtMhnMfbBxF1MJ/nl+fkfcYpG/Y
         piA5RhS0ShQvSA1s2obcmaNOudcCzYmd+dnTFz4HjIPTFA1Y0jqTnofTBSLC6hcmTGMX
         i/DmUWo3A0kjeRLjMgZgDjCEqegrLlHw9OP8z3gvzXUnh1FYAUAvGddAA1JPl/NCsPPj
         /jhfOw8+YWzt+YCBxaGEtzGxHdSUk7+KLryyYmFO+1pJEopusdz9CGRY0Tp2zjSLbDix
         2oh4NpGRZ/M1dU4jlYBn6qV/eoC3xxCBxWyPMw05tVWYjeTEjdnTqtzWQDFNry5qyl8I
         TTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682008025; x=1684600025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euVhsQ5WblzJmtt56AaigUA96LVyQnX3WMfdUWyEQOA=;
        b=FL71ovxIf2+f0WLmIL228jQHywr9LZtGhDzVQY5/lbHOCFGkTglAMmdZZ3SVhjYwUp
         tqvEDZ0hAdcMJNVZZxBB1hu8EgzyfmyEwz5lkk9rj0evYU8uZ6iB7ee8sLTFHtkNIuzK
         gnuX6JbrocntVabGTazbRJUVQQny1HuJ+PyNzWj6SFIHd3m1i9ncqQnTA5kXbnbg2vY7
         zQtZFOCjMW2fxhuqBmpVBHQrbVHHtgMk+7MUD4TKNSXz7VTnGd0Zn5KHZKl1mO4gOu58
         u7lg4RD50RIcklr5IBb7VnLbRB0B/BmKldMnv6peWTlj4jJ0aSEXUhxlrj4ewuB653NH
         Nx2A==
X-Gm-Message-State: AAQBX9fZogT3IWNh/Gdx6SS7WiamA9IRBMwb7pEvSzOplCe7ThW8L9n4
        GEhdgKSZuth1R58PtZzByC4Mouo6mqc=
X-Google-Smtp-Source: AKy350YbALcwsWZXUNEezFObQgyX0ISQaKriFdQBQyf68za8N9qNXOnHsDBlGcn9lPOU5g6obMI8Xg==
X-Received: by 2002:a17:906:e91:b0:94e:dea5:acea with SMTP id p17-20020a1709060e9100b0094edea5aceamr2190644ejf.36.1682008025494;
        Thu, 20 Apr 2023 09:27:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709063e8800b0094e4684e5c0sm902749ejj.25.2023.04.20.09.27.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:27:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: set CFLAGS for pip installation
Date:   Thu, 20 Apr 2023 18:27:00 +0200
Message-Id: <20230420162700.41974-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Explicitly set CFLAGS for the pip install command, similar to calling
setup.py, to ignore known compiler warnings treated as errors, e.g.:

    selinuxswig_python_wrap.c:3593:19: error: 'sidget' is deprecated [-Werror,-Wdeprecated-declarations]
                result = (int)sidget(arg1);
                              ^
    selinuxswig_python_wrap.c:15024:1: error: no previous prototype for function 'PyInit__selinux' [-Werror,-Wmissing-prototypes]
            SWIG_init(void) {
            ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
fixes GitHub CI, see https://github.com/SELinuxProject/selinux/pull/388
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 36d57122..f9a1e5f5 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -187,7 +187,7 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+	CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
-- 
2.40.0

