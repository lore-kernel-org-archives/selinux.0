Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42181C43334
	for <selinux@archiver.kernel.org>; Wed, 13 Jul 2022 13:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiGMNny (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiGMNnx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jul 2022 09:43:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC020BE9
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 06:43:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so14140234edb.9
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R+C7f1K0/GyPwWwNwIoeMTgBASKEbixLaqwNLscmI9A=;
        b=oJjnanyrioVGwFmlXIyogpZsxvGew0IbIBvKATVWtgzhU7RlHGwl27WdvEd+yflyvb
         oN4SVcTp7/t104xeWQNbjJl5Yx0R0shOKr9SdjSI0vpisSvwxJF/I1e1F8HUAezhtcqC
         wGWbWYzjqEMicSB1YeV5wcFW78CVoC+ajc54LgSy7lNrX5FZkdR0r9xwCBM/UHmD6oLg
         rVFg3dC9uapwb3xvZKLsYBnIv9gmFTyBM8SLwZRgxBW6fpu/gBLLJxmPDo04rSodVFwQ
         jQs338WEqsPuJRV/sOz6RK/mqUIbugBa6WBMN3ehMjR63KlxW28vBBkA/NW9pq80JjA6
         x7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+C7f1K0/GyPwWwNwIoeMTgBASKEbixLaqwNLscmI9A=;
        b=BwFYREhIMciBndiSeO4ead9eBOLHpleEa6qDlPM5elNRr5vcl/SS02d86EoxttCkPA
         UdiniQk/86K+R/EhgDr/bgwKDbBLKE+PMino3dbKS8FYRJXKy+VoY7Ubu9J6KdeGmZeX
         c6/AV5RY0XyKdZCsihtHT+Np5SbPv5TtZp2zULfF4WfhayjWMZGhaMvx/dVMI3FscQE8
         xA9QVNiWT8NEW/F5pz0e04Y7t8WBCU+hxn6ZT2OQhl+qWNNpSLu5mO5iO5WAYI9Ymycd
         7ewd+b+iAEP078EY6py7JKGSKA7jHOCetlxrPHpCCYf2waEhPMUQSLrG13ocuBbcYi9B
         cdsw==
X-Gm-Message-State: AJIora9cAe0XUO47+4KBxng8GNPK0gXXMQrlOpx4fat127UVQDbJkKBs
        hE0bNxtIjSIoQcpKos7tE2TLjnUXFCykhw==
X-Google-Smtp-Source: AGRyM1sGWg4AJQGVR1hH+mYfWBvuaYiH7ZGTI04mHRv6YhDj0rIatPXHW9y/cKIPucBLvw8tFyak9Q==
X-Received: by 2002:a05:6402:5008:b0:437:7f01:82a with SMTP id p8-20020a056402500800b004377f01082amr5165710eda.220.1657719830147;
        Wed, 13 Jul 2022 06:43:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-213.95.116.pool.telefonica.de. [95.116.83.213])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906539200b00722fc0779e3sm4973763ejo.85.2022.07.13.06.43.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:43:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libsepol: include necessary headers in headers
Date:   Wed, 13 Jul 2022 15:43:42 +0200
Message-Id: <20220713134343.19811-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713134343.19811-1-cgzones@googlemail.com>
References: <20220713134343.19811-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Include policydb header file required for typedef policydb_t.

This is for example helpful when working with an IDE, which needs to
resolve those symbols.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/util.h | 2 ++
 libsepol/src/mls.h                     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
index ee236a25..db8da213 100644
--- a/libsepol/include/sepol/policydb/util.h
+++ b/libsepol/include/sepol/policydb/util.h
@@ -23,6 +23,8 @@
 #ifndef __SEPOL_UTIL_H__
 #define __SEPOL_UTIL_H__
 
+#include <sepol/policydb/policydb.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/libsepol/src/mls.h b/libsepol/src/mls.h
index eb4a1cb8..befd12c5 100644
--- a/libsepol/src/mls.h
+++ b/libsepol/src/mls.h
@@ -25,6 +25,7 @@
 
 #include "policydb_internal.h"
 #include <sepol/policydb/context.h>
+#include <sepol/policydb/policydb.h>
 #include "handle.h"
 
 extern int mls_from_string(sepol_handle_t * handle,
-- 
2.36.1

