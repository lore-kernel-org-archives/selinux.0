Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F1C47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3070E61263
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhFHPjz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 11:39:55 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:33595 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhFHPjz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 11:39:55 -0400
Received: by mail-ej1-f41.google.com with SMTP id g20so33384740ejt.0
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6VHZ2CpBOxzJtERgZjFSsOJnHnIuO2oFgV/eZZ7eBU=;
        b=hyoTKZaO7QvnfpMgsaHYdpv5Z16aEaFC4UPEBpVclbqyXdanXC+SABL8vX1ue1UssI
         m2dU8ZSyvKdv16EYfHIIXxzpmU73Tf8ky6Tbk4luTA9mB51MoNL5p3fED+PTVpdMW9Za
         V/gHhKPx8wHeIngc+rNKl4UMDmt0AGL5TXeqosePx43jO4/SW2MXu0Swp9o7MM/DOS8F
         OmuBLNofM4egzmROIlwIMJqhsUUcPMr04bqqmSO4NLSsplqTwZCFQC2mOLQnlGjO87Or
         +fR2ad2+TsBY94cw6ZlsgsjjDxIhqCn4OkAsk5ntp2i3Adl1echjwtVaGZ3H6A9WeGjK
         eoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6VHZ2CpBOxzJtERgZjFSsOJnHnIuO2oFgV/eZZ7eBU=;
        b=OQPtX5jl1iagO83wQ97FY04nr76HftV9Ppb7ROxiLovXoXWCxrH4poUjBkqvOY+qLo
         J9BuQpr8BziJ8OPlGHp/quXD2fAn4UkygBP9PoMkyJQcE/k6c1EYiU3lifxG8RRnb0n1
         t99VzRHocmZwgOWP7k2FcmuRcaDJKMw7G8vyJt/6i1RlWAUtcxU7XTYq6jYzxidQm+KH
         Ng4kAfLiQ8jXPdqkcFFO4V/W7a+7b0qPeTZNaZAXNxP9N4u0etgnC07M6p7S000qJYW5
         cI0Lp3KC15b+INWRHNfajwdGB8Y3JocLK85bnRnwyHqbTdtpx9SdO6jJvVNV6GXy4X5E
         wXpQ==
X-Gm-Message-State: AOAM530GoaqOkpU4SFYckoBHnKAOrZ3+nxD6XPGhbNZxbzxNnei+hxkC
        R2Ceu09wnacBCaze+EM88bzn4DIGC+o=
X-Google-Smtp-Source: ABdhPJwj5oQYZJ/fCp/fudTBlvXEc5GPICfpP2JCKITNeYVhIQFp9MOoyudj0EN2FEhXilHuHG7A1A==
X-Received: by 2002:a17:906:2f0d:: with SMTP id v13mr23984782eji.321.1623166612750;
        Tue, 08 Jun 2021 08:36:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id qq26sm43310ejb.6.2021.06.08.08.36.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:36:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: fix typo
Date:   Tue,  8 Jun 2021 17:36:44 +0200
Message-Id: <20210608153644.29176-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
index 10c3df78..2dfa2534 100644
--- a/libselinux/src/regex.h
+++ b/libselinux/src/regex.h
@@ -44,7 +44,7 @@ struct mmap_area;
 char const *regex_arch_string(void) ;
 
 /**
- * regex_verison returns the version string of the underlying regular
+ * regex_version returns the version string of the underlying regular
  * regular expressions library. In the case of PCRE it just returns the
  * result of pcre_version(). In the case of PCRE2, the very first time this
  * function is called it allocates a buffer large enough to hold the version
-- 
2.32.0

