Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274E6C433F5
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhLQSTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhLQSTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:31 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55710C06173E
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:31 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j17so3523964qtx.2
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKkkiiUDqwq1OYvg0uY4Xt71sAL2w73EZu6KhmwpUWQ=;
        b=SqZEn2AOSJn+oUSjHmOUEkqqC5R2WwLAmQsUd43ZVYZXgkEC2c5LkYyaa5R/lHYCWS
         keirutLbnhuzhU7hN1V4Yaj9Hb5BxUIQAPQIlrn1J+o3famiQ6cWnUsUIThPt+bAuczD
         uNfr3gbE0CSNeSPXyiXb4+7fB0FedpaTC6gO7ICTEfa2QpP4BMhDvLkdv68503F7m44B
         VnjoxnnrZQBzNqfZLcQD+jSjAD6WpmcxULBv5EpMWWaQQHYSSrER8T38V6+ajbPrPspX
         0rOkqmfq870+RG0ghFStD5OXg8rL5RpAO5c4xqoPUXim3QEvpFowqAyFmkDv6C+CYmV8
         IEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKkkiiUDqwq1OYvg0uY4Xt71sAL2w73EZu6KhmwpUWQ=;
        b=4EjLtEvPgCl4Ubud8rbCbtonFoevQU+9kvvkfav/S6j7QR1kqmcoN1QSS+T672J254
         qLOSVSMEUOUpLLUHreOLtrsVFQiGHoDsKwWuMgnvinE8U23Xkw6iLh/BuhUUBBdUYri4
         zt7n+xNqItaTKFlsNcIQGcBt0ZAjYAovZcV4iApOusDmdvjCa923V4k/XJQ2DjAIBpFJ
         I0+p65yfc/uy6tAXkb9SsqqL9t9KJ9EG84oNLPT+3JbLz9pDyoD61MUmwZFLBF0cPLaK
         MNyYawd1QCD/0PT5yIeMpZRuDoCkgSMu3d8AMAEG1Hf6N6BA7Hn3JcNPrSF/A3b6qB1c
         c4Dg==
X-Gm-Message-State: AOAM531MfA/qj0r4+lJffKl6tq/bnjFyJ5IBQQCKAg9vayuXD02xbaBz
        SqCjfNYK2c4F0y7gj1APiPBOtaDW+rU=
X-Google-Smtp-Source: ABdhPJyC7yHaEJVyCD8yC/mv5D93CR9cgvBfTJYfLeAG/XLBAhmjMuQjxpuEzsEQXXjcuTzTN4Tuvg==
X-Received: by 2002:ac8:5e47:: with SMTP id i7mr3577256qtx.600.1639765170410;
        Fri, 17 Dec 2021 10:19:30 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:30 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 10/16] libsepol: Move assigning outer loop index out of inner loop
Date:   Fri, 17 Dec 2021 13:19:07 -0500
Message-Id: <20211217181913.336360-11-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Assign value based on outer loop index in the outer loop instead
of the inner loop.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 7aaaf303..d3711b01 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -158,8 +158,8 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
 
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
+		tmp_key.source_type = i + 1;
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
-			tmp_key.source_type = i + 1;
 			tmp_key.target_type = j + 1;
 			for (node = avtab_search_node(avtab, &tmp_key);
 			     node;
@@ -334,8 +334,8 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
 
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
+		tmp_key.source_type = i + 1;
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
-			tmp_key.source_type = i + 1;
 			tmp_key.target_type = j + 1;
 			for (node = avtab_search_node(avtab, &tmp_key);
 			     node;
-- 
2.31.1

