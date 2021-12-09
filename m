Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5694C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhLIQzT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhLIQzT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647BC0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o20so21703229eds.10
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lSrwhiJ2ZT1Mzum6DIUxM597iA6Z7ZtmZsNVPeScfFM=;
        b=lAzzZ+6hMcZ2als8csFFL9MqQiVBcPLLXwVuezSmqmq6B1Pnb9ZL6NEe8pCyFrykER
         HtQohGPC5xHdKWaCU7j1e2evrEWo/N4L6Wn9WTMKNcuhrVsvppfV5y5QdfdoVHf8g+22
         XVxRKuTZZ2JBrAJo1KHRcVwVi0Sw4KpDlU5rEf3z/JqOcHum1965T3BRG5oJ+XXJsEV0
         10CHBbuTN4mWQf3CwNRhOJEZBXuowx40tCJ7dvJekjcGwo+gabojezoMxKX9xhm/D3WT
         K1toA1p3RYn34QVACly1huLtdAYNZJae/pLo3Q4nPMZ49m/jZ/fWKkB/5+e777jAQoMg
         wdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSrwhiJ2ZT1Mzum6DIUxM597iA6Z7ZtmZsNVPeScfFM=;
        b=FbeiJ8tQ+tm1snNKN97CTYUmjg/O1O1q9EmGAZi362pPt5qAZUwECptM11OHYG/Kt0
         XpSBZHKRIDxrSpYB5UUm0+nqqG07ferlIYo8l5dQlZU2BzpHk07mAUl5o6YpG9jgvVV1
         hznJYoDIDqcFydsiNQHCVVWEgCIhsgmuVYEGi6xIEj2U5/YESkpHKOWE4vILJMOIvE/8
         g8075GzM5mjbbE95MsP2tTDqLuJubenlSWcVIYfqRgc8GWAzXlD65NvSh5xXzlQzR4eX
         aXAZmYBlD9vlGl/OGQ0YtljuzcfAT+z1/vyUM7A9tWIlUDPul3uR3lOTlTD/v8eHoLQY
         wTog==
X-Gm-Message-State: AOAM531jV+B2Zk9xnoHOp3XNesk8B5oOuLiEFtlsqS2zN1H6iz1gDpg6
        9KKH58z5vSa8KvdSqABEDVE2Jxfh9XI=
X-Google-Smtp-Source: ABdhPJxGgR/jP4XU0cI2pEthBhoDWycHAX+HE5yjZzuRghbLa0Tx0ib+0cOcbN/HIkh5RcOyVbPMog==
X-Received: by 2002:a17:906:1be2:: with SMTP id t2mr17293129ejg.399.1639068588750;
        Thu, 09 Dec 2021 08:49:48 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:48 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 20/36] libsepol: use correct size for initial string list
Date:   Thu,  9 Dec 2021 17:49:12 +0100
Message-Id: <20211209164928.87459-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the number of categories not levels, which might be zero, for the
string list initial size of categories.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b2ad4e02..09c08618 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -918,7 +918,7 @@ static int write_category_rules_to_conf(FILE *out, struct policydb *pdb)
 	unsigned i, j, num;
 	int rc = 0;
 
-	rc = strs_init(&strs, pdb->p_levels.nprim);
+	rc = strs_init(&strs, pdb->p_cats.nprim);
 	if (rc != 0) {
 		goto exit;
 	}
-- 
2.34.1

