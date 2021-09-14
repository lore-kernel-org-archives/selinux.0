Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA06EC43217
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD24760F70
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhINMwD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhINMwD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB7C061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n10so19678151eda.10
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4018gBXnpw2V2+Rsdr197n0FQegQy70vC//idsvaing=;
        b=Z5RUpYzpwodlQBmHbbAQlJxzhOn3FQ+iG9dmNCwQDt0Ti+y5DNLsiAsucTS2Oi4Evm
         54Qq8xCetka8gA+3APGeRza7tESBthSxtswHjb9proKIYp6F+DFJD0sqz41acVfZ95mQ
         76w10ysjb3YbFlj5Z93KWnNWKgk0xmEucjI+GlO38CBLeuZY/R1/WZEkhdXWN1MFZU9d
         NJNtQheIYoPXQCBA0jLierI52X8EwXrE2uAE8FlRI+q0HcC7CFWor3Hr9ZCtW/ExS7i0
         Fl9RX026VRtZNScCw4sAcoyM5TW8tgAjyIBSwaYlRGmU6xUZYnA/nhslCY2u8d9mnIaq
         IBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4018gBXnpw2V2+Rsdr197n0FQegQy70vC//idsvaing=;
        b=SC4dh20BQi2AX1JYCU+yB5QGj/m8mC7yG22fxzhJkKXNzIBJNp9qoFBd89yzXplhze
         PBns9ycnUSWfvXGWWUHl6pg82Ebt/STYBzP640RL7RkDQM+0O3dvFUBIyjhUGwrvOqDG
         IUI7sSqv4f+dzGdnNkkTMuealGizs31eNtqEd3dPHl0ZSaAjcSSuIQoTqgLjbmzyoE5o
         ldQrVwnDB1diCoz0Yx5fp81MRhO+Eqp7G/iHA0yOQKKH5fEqZzPjzspuB+8Iwj9fkRDM
         hve3ZwN3bW+ROREwGSUrjDA0aUI8kzpYfTA3gT4h2j68Dvpjw2BX53NY5IQtasulwGvK
         SeZA==
X-Gm-Message-State: AOAM530QasYTbunPxqxF5fRZfWT/XEOJjtcBgCgF1SZ7Vc/JsuGWeUrj
        WToLesPOy1gEVEuDNsN3lxmTSgccuq8=
X-Google-Smtp-Source: ABdhPJyH5EBkn7s58ml3MAy10f+oF6vdMoJC67K83Z3KxXCMKb+o2FluAWTEYhGi7ZG3MJr1SX1TXQ==
X-Received: by 2002:aa7:d78e:: with SMTP id s14mr6612269edq.171.1631623844208;
        Tue, 14 Sep 2021 05:50:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 03/13] checkpolicy: enclose macro argument in parentheses
Date:   Tue, 14 Sep 2021 14:48:18 +0200
Message-Id: <20210914124828.19488-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by clang-tidy

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 75a67d5c..7e7801d3 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2143,13 +2143,13 @@ out:
 }
 
 /* index of the u32 containing the permission */
-#define XPERM_IDX(x) (x >> 5)
+#define XPERM_IDX(x) ((x) >> 5)
 /* set bits 0 through x-1 within the u32 */
-#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
+#define XPERM_SETBITS(x) ((1U << ((x) & 0x1f)) - 1)
 /* low value for this u32 */
-#define XPERM_LOW(x) (x << 5)
+#define XPERM_LOW(x) ((x) << 5)
 /* high value for this u32 */
-#define XPERM_HIGH(x) (((x + 1) << 5) - 1)
+#define XPERM_HIGH(x) ((((x) + 1) << 5) - 1)
 void avrule_xperm_setrangebits(uint16_t low, uint16_t high,
 				av_extended_perms_t *xperms)
 {
@@ -2189,9 +2189,9 @@ int avrule_xperms_used(const av_extended_perms_t *xperms)
  * dir, size, driver, and function. Only the driver and function fields
  * are considered here
  */
-#define IOC_DRIV(x) (x >> 8)
-#define IOC_FUNC(x) (x & 0xff)
-#define IOC_CMD(driver, func) ((driver << 8) + func)
+#define IOC_DRIV(x) ((x) >> 8)
+#define IOC_FUNC(x) ((x) & 0xff)
+#define IOC_CMD(driver, func) (((driver) << 8) + (func))
 int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelist,
 				av_extended_perms_t *complete_driver,
 				av_extended_perms_t **extended_perms)
-- 
2.33.0

