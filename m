Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63BC4332F
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 18:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhKWSgq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhKWSgq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 13:36:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA6C061714
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 10:33:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so62263317edx.2
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I4sDP8/bSZDAprJ/n86yzKBh6HcJB1WpRKRAM4Ql7xU=;
        b=qTcdmWHs1gdjgiKr+GFuAqzqK/CHBFJfUBYHOWOSgyws+1hphjJ9YQWf6NePQNhilq
         XgfPDOX6mR2nOJuhVQmd3jvFigH/TgZ9FJ8GNLO2GgfJziymPPbbo49FN4zrxHjDH1DR
         qA59SjG3srckthJYBHbU5/VH4W8DNkJzzKbFQf7OEsYJlcbbt6ue/D/MlWIlUBR1Ri+/
         cF9Qa24rw/Otm6UHb/FYBv/3nNvVqOC/fSdt15kz5CWjO2m+oaluJpm9hqTnsFAGSHkI
         BiAc+mUaj1hEwkAFnO5KOZKnQ2aA7IdZi+KbdPNzVeg0tNQSWfO1JBmUHOO8iKocVqb2
         HSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4sDP8/bSZDAprJ/n86yzKBh6HcJB1WpRKRAM4Ql7xU=;
        b=d9/sPA5mrrpZQYQ139wGx9w4sj99HGudC4bTbUbtqBFrxMuoOFiyhSOQfvvzxISQAd
         b8PMdp9Ed1ful1VV449C5ZdsEUH20oi5ox8Rfi4pnZo7gvO0sg5JaVV3jyxSLtpEyWoS
         4xp5OCZR4tRY3rROCx6QXkdATIek8FW95X9ZfdTjomIaQvKlEBEfyjFTAwj/KROP7T9D
         b9hEETNwJylaqy1VtJNrkc2BN1nOi0/MOVJUsGFUtNzFs006aiURqOIRbMwOz0g7wanw
         ruhHoHT1upu8RcxqaMKXHIv3aqmJuD3nR1rX1lJPJaRtTO+OGkWSA/t5oziteiniIEeS
         oL8g==
X-Gm-Message-State: AOAM532AJLBWzvU2gT4fU9dTk2V5nJyMacQdiv88HBGUfPqJHBx1iW8H
        IUtN21Ec1AOu+JKhv7W0FKOKHB6htyM=
X-Google-Smtp-Source: ABdhPJyvmQwKxSK05tHkIW09pK2zFM4q0PT3Qhe6S9VQapjEtO9LzDQfpoHCy7Jw22gnlHgPdAImFw==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr12728480ede.57.1637692416312;
        Tue, 23 Nov 2021 10:33:36 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-244-006.95.112.pool.telefonica.de. [95.112.244.6])
        by smtp.gmail.com with ESMTPSA id k16sm6159714edq.77.2021.11.23.10.33.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 10:33:36 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: use PCRE2 by default
Date:   Tue, 23 Nov 2021 19:32:48 +0100
Message-Id: <20211123183249.6133-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123183249.6133-1-cgzones@googlemail.com>
References: <20211123183249.6133-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Quoting pcre.org:

    There are two major versions of the PCRE library. The current
    version, PCRE2, released in 2015, is now at version 10.39.

    The older, but still widely deployed PCRE library, originally
    released in 1997, is at version 8.45. This version of PCRE is now at
    end of life, and is no longer being actively maintained. Version
    8.45 is expected to be the final release of the older PCRE library,
    and new projects should use PCRE2 instead.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/Makefile       | 2 +-
 libselinux/src/Makefile   | 1 -
 libselinux/utils/Makefile | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 439bc6a9..6d9e2736 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -23,7 +23,7 @@ ifeq ($(DISABLE_X11),y)
 endif
 export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X11 LABEL_BACKEND_ANDROID
 
-USE_PCRE2 ?= n
+USE_PCRE2 ?= y
 ifeq ($(USE_PCRE2),y)
 	PCRE_MODULE := libpcre2-8
 	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 52c40f01..04bf4f24 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -98,7 +98,6 @@ override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
 LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif
 
-PCRE_LDLIBS ?= -lpcre
 # override with -lfts when building on Musl libc to use fts-standalone
 FTS_LDLIBS ?=
 
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 36816155..801066cb 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -44,7 +44,6 @@ endif
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 override LDFLAGS += -L../src
 override LDLIBS += -lselinux $(FTS_LDLIBS)
-PCRE_LDLIBS ?= -lpcre
 
 ifeq ($(ANDROID_HOST),y)
 TARGETS=sefcontext_compile
-- 
2.34.0

