Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB1EC48BC2
	for <selinux@archiver.kernel.org>; Sun, 27 Jun 2021 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9704619BF
	for <selinux@archiver.kernel.org>; Sun, 27 Jun 2021 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhF0Ubm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 27 Jun 2021 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhF0Ubm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 27 Jun 2021 16:31:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D073FC061574
        for <selinux@vger.kernel.org>; Sun, 27 Jun 2021 13:29:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp27so2855032lfb.9
        for <selinux@vger.kernel.org>; Sun, 27 Jun 2021 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXb57i8n7HkUMwZqKpXBQ2YaO7TI3yJAfln+eYi3vVA=;
        b=a6r/SStCsUQMlVxHAbin8aLodTAer0kH8/TqtidXJztF6cU6KHXrcL+I9M9HV72xaa
         697FUCtOpZtCCVsXRsNuTKiIE1DXEU7kt5ZroVCYSo9bi6WKBCuWXuEqYcEn17qSjnNd
         b/wmFiHYVnpMqE7yA8BKePgodozSBiunKaWenfSofZHU0c/F1NOBadO0xC+efnD3Ihte
         DXDRzmt5oyxM0sch8sQgHiyIcF5qHih5KSsSYKtydwP8um3tm8I8dII30AMhJJneCoCB
         YRESobC0UzbY6Rb/aSFFTHxdJAjDH0lp4jJIpf5EatFkyi/Jf7Gw3XgN1W7conjnDNpE
         +XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXb57i8n7HkUMwZqKpXBQ2YaO7TI3yJAfln+eYi3vVA=;
        b=HX+lT+PlTb17re7cDW0SVaFyl2LSFfQtN6EbIJRwnZkGcqujtGB/VHDIT/0Y5QLi6E
         V0BgA8AUzpqxp+fV/hP+WPxOHoJd50UMtA4PaXODryMSZbkNNDWnqrbfzL4c1SlBVbbb
         yV+Vi5qj3zFvmoxcDyJNvbEgD20Kyv/9pZX2NPJU3ZBW/MBaBHUp9+vocfY/9jLaO/Vo
         19KIw4vVjksfwCjxeKUFbUkwHK4wSVQedf6D9xm9uWWoDw64xSlWau3l8etHCy1bWgcF
         6gjk32BoR0w7g2u9ch1UQyMcyEDTdSTFzs9qcXMlKpbp312uhuc2kYrKNK7FJ4Mr2Dsx
         hvbQ==
X-Gm-Message-State: AOAM533KsCfmgTlPEyae7lx9A87AnjysVqNeI3SfovOFhRuRRShFB9mS
        4EIEvoPY+OU5ejNu2We8DZqNxyChi9w=
X-Google-Smtp-Source: ABdhPJwsVWetXKsMmaEmSp3HYob3T0GQWc3030DA4BB0pPjysKDlrLG1HrvTUjlw8hjWClf7K/fAJQ==
X-Received: by 2002:ac2:5e86:: with SMTP id b6mr16478911lfq.241.1624825754938;
        Sun, 27 Jun 2021 13:29:14 -0700 (PDT)
Received: from localhost.localdomain (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id u21sm935295lja.81.2021.06.27.13.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 13:29:14 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] selinux-notebook: describe nosuid and NNP transitions
Date:   Sun, 27 Jun 2021 23:28:59 +0300
Message-Id: <20210627202859.5124-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Describe cases where nosuid_transition or nnp_transition are needed.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 src/computing_security_contexts.md | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
index bb946b5..ca514d7 100644
--- a/src/computing_security_contexts.md
+++ b/src/computing_security_contexts.md
@@ -84,7 +84,18 @@ Processes inherit their security context as follows:
    *default_type* (policy version 28) or if a security-aware process,
    by calling ***setexeccon**(3)* if permitted by policy prior to
    invoking exec.
-3. At any time, a security-aware process may invoke ***setcon**(3)* to
+3. If the loaded SELinux policy has the nnp_nosuid_transition policy
+   capability enabled there are potentially two additional permissions
+   that are required to permit a domain transition: nosuid_transition
+   for nosuid mounted filesystems, and nnp_transition for for threads
+   with the no_new_privs flag. If nnp_nosuid_transition policy
+   capability is disabled, such domain transitions are denied but
+   bounded domain transitions are still allowed. In bounded
+   transitions, target domain is only allowed a subset of the
+   permissions of the source domain.  See also
+   [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
+   section.
+4. At any time, a security-aware process may invoke ***setcon**(3)* to
    switch its security context (if permitted by policy) although this
    practice is generally discouraged - exec-based transitions are
    preferred.
-- 
2.30.2

