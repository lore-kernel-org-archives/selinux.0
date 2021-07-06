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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A165FC07E9C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8485061C3C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGFR5W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhGFR5W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC178C061760
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v1so1029017edt.6
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e7Zc/A3tC6K8Oj6n+eRJnmhAokCQ1P/4q9JUXZAfPjs=;
        b=aFEubR5W17BCIvvrZCdCzjqlod1rVPro4cWK1CMUbGEotp7ifN8M1s4ThTQZca7LQ5
         9V5g4og34BtsNR9pt1T0gdal8/buLRewkOZGh0ikdNR+75ecaxuhBKaqrs+oNjnxfrI3
         2WrBUwiPG+I8/dezevOfuiFVFhZRNzKD7hxhDg1qU6i9PV2FlO/s/Y84rFadDVmqCNLM
         liff7CY6KMTcwUxQtryD35ftyhIZHlUe22dovcJIXawqn8FLoJ4MZ52Jn3HsifEvk4tb
         zVSjs3D9DWUJficvuWpuOphNbha/2WwHeEr3zxpjaKB66Sg7ph4L5+lvilenc3CTXSNx
         yMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7Zc/A3tC6K8Oj6n+eRJnmhAokCQ1P/4q9JUXZAfPjs=;
        b=Ml2KFWtsHwh4VWDa2hBmXTeAbudRPpxnNpwoNTOwaoZMk/grPo8G2Ahv7B9YrI3a9k
         N9OMf4v1MHT7EvmkRRqIAkxUmVHHFh9ayagTnznbXkfMbAEb0JUCgqEbSjCC4HBMFKT2
         diko+miBZju9hPcpzHvzrcB3JXRaFYLJpICFJRp7jjK6HN8su9ewNkl7gTe07UtVg+7g
         LciRzJKeUuAWkQjdXSXm38vDjS/cb/ioc009emi6MuiArH2xfcZwXknq0ZII6dph584/
         zaoCMcJq/C0o1aGUEf//iyKOpEeEpE8PGUlza7bqLGsDMPJVeEHlQXs4+PkqhXPWoD1H
         D46Q==
X-Gm-Message-State: AOAM533ZhK61E0ficaMxbwadQYnRSoSfnXCyJ05rEw96KM1gtqD1kY3k
        LlTHTLX0TwuIbKxN7WKqszT/ZXKsQx4=
X-Google-Smtp-Source: ABdhPJwqGC19N2UGdTpqudGVfMJciF1dG/mMnHiTitR89pFmltcuQsDC0xWNVEygTzYlqOcbZ/TFQg==
X-Received: by 2002:a05:6402:18eb:: with SMTP id x43mr13737605edy.98.1625594081374;
        Tue, 06 Jul 2021 10:54:41 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 03/13] checkpolicy: simplify assignment
Date:   Tue,  6 Jul 2021 19:54:23 +0200
Message-Id: <20210706175433.29270-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

checkpolicy.c:504:20: style: The statement 'if (policyvers!=n) policyvers=n' is logically equivalent to 'policyvers=n'. [duplicateConditionalAssign]
    if (policyvers != n)
                   ^
checkpolicy.c:505:17: note: Assignment 'policyvers=n'
     policyvers = n;
                ^
checkpolicy.c:504:20: note: Condition 'policyvers!=n' is redundant
    if (policyvers != n)
                   ^

Found by Cppcheck

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index acf1eac4..9627275f 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -501,8 +501,7 @@ int main(int argc, char **argv)
 					usage(argv[0]);
 					exit(1);
 				}
-				if (policyvers != n)
-					policyvers = n;
+				policyvers = n;
 				break;
 			}
 		case 'E':
-- 
2.32.0

