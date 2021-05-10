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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B324C433ED
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B86613AF
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 10:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEJKN5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 06:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhEJKNv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 06:13:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424ACC061574
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:12:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b25so23619816eju.5
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qY3MZRwVqmXvIF4V6EXz9Ow5HamgQHh42jx2L004hKM=;
        b=RiCR+5f5gLpQNUxQ3A2HzljUXAhXsDPdYUW1YYHQ/XJECyxgejrKBoXN6EfUJEmGAv
         +29PcZiwZrnYI/hKCr4GDgYJrVw6SR05rblJK4bi07rlS3qJjpwiJ5VirfTU+3Nc3kj2
         eXDB8D3FvMWByXQquYyqrPloUVP58pj6R9E2jgS2ho16huSt3Lx1nrUi7lqBQXdWyztH
         Pis51+sU7AAhXc3J/o7LYv/tu7bDXOMF2tHtqob/J0j6Dde9NOE8h6YeJUnCI4Kwr0yY
         gunrfGn7mNh1mr6AtzwjZ8VGW6ACFA0AfQlGTqRWjFN0u/22LQeQVLJha64T8aHoMNFe
         Mxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qY3MZRwVqmXvIF4V6EXz9Ow5HamgQHh42jx2L004hKM=;
        b=G+nZAkeVGXiwbciQ0Cqi7/98agGzi0jJfxkDehJHg/5XINUehu6JJXw3SDQlvoB3RY
         HOCsJ2NgpfJE2GhhyVkb09NCW2I0r16qhZ7K6VAMw9BXs9Z0SZOeHyLSFwyL3HOmvrcs
         M55H6SHOI93FEZzdPJlEx5IiJ8v5QauPdN2Je949pnt89WVPT+wlqZZFdcCtGO3Drkmb
         042ntd4dPVo7HBBSah8gSXQXGZi1hyPCmxXVMiNpKPtzg1kPQZBXbo+Z2/jBtNfPvvi4
         P8Tsrq3fYykyi/rCBjjy6a3nel5cZeASJts1cio39r+SF/a/6sHzGi3qr7y8cE1MWWXk
         7Rgw==
X-Gm-Message-State: AOAM531KcE9wIHhE7rcWb2iqdEezQRBA7WwUpvOZAzUph/cKLYKnIz0m
        jHGI+bBgLlVFVB1jX2IOt8Lk2gsoH3eAzxYk
X-Google-Smtp-Source: ABdhPJyBSTvXW9bL7NCsDv/iAMne9qgRQGanisLeKlRaVfxQWZof+2Jaw1TYX5TbKVNzoRbyR0ycSg==
X-Received: by 2002:a17:906:b816:: with SMTP id dv22mr24841490ejb.193.1620641564025;
        Mon, 10 May 2021 03:12:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-162-005.77.3.pool.telefonica.de. [77.3.162.5])
        by smtp.gmail.com with ESMTPSA id y21sm10125442edv.77.2021.05.10.03.12.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:12:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: selinux_check_passwd_access_internal(): respect deny_unknown
Date:   Mon, 10 May 2021 12:12:38 +0200
Message-Id: <20210510101238.6741-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503174636.54579-1-cgzones@googlemail.com>
References: <20210503174636.54579-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`selinux_check_passwd_access_internal()`, and thereby
`checkPasswdAccess(3)` and `selinux_check_passwd_access(3)`, does not
respect the policy defined setting of `deny_unknown`, like
`selinux_check_access(3)` does.
This means in case the security class `passwd` is not defined, success
is returned instead of failure, i.e. permission denied.

Most policies should define the `passwd` class and the two affected
public functions are marked deprecated.

Align the behavior with `selinux_check_access(3)` and respect
the deny_unknown setting in case the security class is not defined.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Fixed function name in commit message, spotted by Petr Lautrbach.

 libselinux/src/checkAccess.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index b337ea64..022cd6b5 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -78,7 +78,9 @@ static int selinux_check_passwd_access_internal(access_vector_t requested)
 		passwd_class = string_to_security_class("passwd");
 		if (passwd_class == 0) {
 			freecon(user_context);
-			return 0;
+			if (security_deny_unknown() == 0)
+				return 0;
+			return -1;
 		}
 
 		retval = security_compute_av_raw(user_context,
-- 
2.31.1

