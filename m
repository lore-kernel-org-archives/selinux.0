Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F28C43460
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484CF61244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhECRzA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhECRy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04877C061342
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gx5so9154030ejb.11
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LbwZlbBVV6DpLBBhseCMZpwc2EMISvQSBHBs+9MbTM4=;
        b=irB2tP8dDORuIOExOh8vb6S1H7eHJN+uQ+uf+ABSq9JKzpZrk/HHLpAt6su3mLkoAU
         6TT67efcmLh06dnyB+f6/VblooLRslGqOdhG95sdeHEZyTjVK+wOcJDxiLN8IjAihcJP
         w3YKgmGq+UxjBZbwxcyLIUBLIkRVEE3i3BsY2uqcogHMqbeyFoxec4HDiU4ZZfLjsp6I
         BBb5W+pL1+/y17FpHfxDA/n3bzKhR6jTIhR1hoQD60PD/VhHYbZuogbRJrQ4RD+AZ6kr
         g7jY0nHKZZHpNsHpJYC/MYVdkBhiIdtyDbijh+FqDF0cLuHaRQoNBXKhgEbU9p8JDbo/
         uJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbwZlbBVV6DpLBBhseCMZpwc2EMISvQSBHBs+9MbTM4=;
        b=B01KjSGlQyxMfwJUBXaan7PgEBddTw7UrnykANWx4Zg2XnpUSwk1IH1aIz7UksmlL3
         sFE6WZJ0+EiqxtLcOcI/Ygz2fhqEW7r9sOOoGn5Nj5njb6uBu7LYgLkSHd3L8SyCDRjT
         iyI58w0mrgxdQGfrz93nR1feCOnrWeyx7dtdAUEWGhe8djX8gvQctGb+WKz7n8GyMJK3
         CrCrRggWpsm0uwtHfB3f4mLZfeC252Tz4hey3y79xg/a8jjoXkKidWeaTtuajmIKGvQC
         LScTgzvLaz/RLAAxqmIb/1Cht0/Bre+k9v7ysOMExUncPQG7dgKwyxM/QEB61MsUAJXk
         VZmw==
X-Gm-Message-State: AOAM530dgQdlF9qBH+zrcichU2w47WudF8jgMU/6Xdhs1/Cj+rmiU2l6
        /9V//4TYb8HbDLntVnT+DYGosmDxORt1gA==
X-Google-Smtp-Source: ABdhPJy2L4CWIGHDwPtQHRUScTRL2/BaXZaqbVvXvuphImDK9Y0aqAPyZ4r6iYxVn1NERozoglLetQ==
X-Received: by 2002:a17:906:1185:: with SMTP id n5mr18230153eja.468.1620064438724;
        Mon, 03 May 2021 10:53:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 10/25] libselinux: exclude_non_seclabel_mounts(): drop unused variable
Date:   Mon,  3 May 2021 19:53:35 +0200
Message-Id: <20210503175350.55954-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `num` is never read from.

Found by clang-analyer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 249c361f..6fb9e1ff 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -230,7 +230,6 @@ static int exclude_non_seclabel_mounts(void)
 	struct utsname uts;
 	FILE *fp;
 	size_t len;
-	ssize_t num;
 	int index = 0, found = 0, nfile = 0;
 	char *mount_info[4];
 	char *buf = NULL, *item;
@@ -245,7 +244,7 @@ static int exclude_non_seclabel_mounts(void)
 	if (!fp)
 		return 0;
 
-	while ((num = getline(&buf, &len, fp)) != -1) {
+	while (getline(&buf, &len, fp) != -1) {
 		found = 0;
 		index = 0;
 		item = strtok(buf, " ");
-- 
2.31.1

