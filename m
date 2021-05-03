Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56BC43618
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1EF61244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhECRzF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhECRy6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63363C06138E
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t4so9234689ejo.0
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=osNyx1FIPkAa/wFyAagZJAoLCmCuby1zL1yHhVFkfCs=;
        b=gsXqDDEFNKBAVxaFOgzGZrkd0qe/K7CP/tO7YMBdzAv5Ul1OxrOHXP4FQjIzxILU0N
         txtzxKmNBApvkAiEgffdUJMZ6SEe42sheF+291Ng2pqcv324SoAmowqRJQFpB0d/LsCS
         q1zynCFkxw3yJsClP4cu0v/QKhbpXRGWpK4Y21bKeSp/LmX/Quf7Hhyer+QGe+eKBTkX
         EDXL4WMwSBlYgY6p7kRdEW+SUwSKSFxMQYgRjPWaiGOGqBzZ3EncR7SzvyiiqzgDV2sN
         NZF7oSHld+QwnZ6aRBjt4KewJ7sbXTS6hqUc4BnKzc/hmyLSSY/ay+rtXL97KIMvt00Y
         /tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osNyx1FIPkAa/wFyAagZJAoLCmCuby1zL1yHhVFkfCs=;
        b=It4n4prDsrSlh35XAmJ3sWVnJWbtnAWKcOUCH5FmQmqRqXIiDQGhxA8bUc+4uGW187
         0jQ6RiVXxVsc1sNpICzt6f8OirfLsx2QB2gv6I6odyYsxlA4hlF5HSsMJvo7Iunkiz/W
         aKDjVHYDJiD88xwO+aOkePkHUsvUUuGQuKkRRljUnPliPnnQUX9Emkdf/kqbyPRbFdX7
         yckvTVo+R4M077FfTDAqzJN4MoWI1PHNC8j3W4brow0/sAOayWd+2mXJH1TLp3pOylGf
         qGDjYWj3qXgy4sSpmc6cDnSXlRHOsnl6GiOuvpMS6+iN0N2D/ha/yKjNey89+lC56Sxj
         kBPA==
X-Gm-Message-State: AOAM532fCFX7PyfrPF88zNObSMkzlnxw09k5BzhjlBwC1kW59uYfTm6H
        c7oioN1GGqQna8wuWgrXtnx26CGS6lFQtg==
X-Google-Smtp-Source: ABdhPJxrpzPK/jYeD00MY/B5EC640O4PyixwZe7fj7W0TgnP6B6IsAO0xmIZ33yIskKZChJtm3eHYA==
X-Received: by 2002:a17:907:3342:: with SMTP id yr2mr18133267ejb.325.1620064443137;
        Mon, 03 May 2021 10:54:03 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 25/25] libselinux: label_file.c: fix indent
Date:   Mon,  3 May 2021 19:53:50 +0200
Message-Id: <20210503175350.55954-26-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by clang-tidy.

libselinux/src/label_file.c:374:4: warning: different indentation for 'if' and corresponding 'else' [readability-misleading-indentation]
                 else
                 ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 39a56133..8139b38c 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -371,7 +371,7 @@ end_arch_check:
 
 		if (stem_id < 0 || stem_id >= (int32_t)stem_map_len)
 			spec->stem_id = -1;
-		 else
+		else
 			spec->stem_id = stem_map[stem_id];
 
 		/* retrieve the hasMetaChars bit */
-- 
2.31.1

