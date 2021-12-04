Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62645C433FE
	for <selinux@archiver.kernel.org>; Sat,  4 Dec 2021 10:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhLDKi7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhLDKi5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 Dec 2021 05:38:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CDCC061359
        for <selinux@vger.kernel.org>; Sat,  4 Dec 2021 02:35:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so21698648edq.7
        for <selinux@vger.kernel.org>; Sat, 04 Dec 2021 02:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1WmDh1cJv8QCLCqmGr3r0sl/OFP6mPHXCEXM+PmEjc=;
        b=lIUPYoVEkOtwK33wAyB/BwdZcQu5ltCsLZKTJUTPckmafhUCnTHJ0+rgQmP35Ce5cz
         //COtJZMegpWP3Z6Poi5x/aXxshM7/m6jh4G0Imjm31A5Cp/e/CXIufdqlLBhlY6T6x8
         iAT7agjGzZCzfMLCAq6iaYwxePARiS1yEcnbHPS4NQzVx0DYSUZbhM+wUA2rmRa2chAu
         WRSI7HwStt0AOGZvaXK8cniBP5Ff/EsOH0k1LznqWN4U8BG35rJCVv4U0ed+b4zVNmvF
         5vpXGndmM8x+zZCP2GklaTGCpgSNvmKOy31jY09LpcV2n+cKo5Ct9ihVWucbJR52PM+/
         GA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1WmDh1cJv8QCLCqmGr3r0sl/OFP6mPHXCEXM+PmEjc=;
        b=s0Pp8GkWA9sLnAW1mn9oQXb62sBUT/2LrvDW28BKoM4F3aT5dw9u6WvLeVEgi34XWL
         4rfiJaNs3D8D2ZPVRWxSyKHKUDZTCcbpfilSixNrFfPvrB8np80dWpS4v89h0EBIq0lK
         0PIyRgn/EwuknnX9eWFTejgh5LYgsjdDTteUGSpqJPhToNQroC3IvadbW3p/WcU8W+FG
         iniypL0BVHzWZljX0+o+5NXCF+SuqFkUiQsqqEuG0JrQJ5Ilktu6TrhKKUXeHEJZ1Zg4
         goHh7STVgJunX0JY7Ug2QYAROG2VXrS3HEui9TZWYcbSqU+HOUbkENegSNQ9gVYVzJwt
         Ixdw==
X-Gm-Message-State: AOAM531DAsSq0iTI6P8nCtJneF8dEt2hyGeEd8D1X+UBAi86kFiiZQDS
        JOayE98xqvWK4XqYl4lVQMr97kcOL+0=
X-Google-Smtp-Source: ABdhPJwrQjLpaoOAXGOBcOVw9n0L51tWkGPeFSJAQpfDE9fG89ZHWTPeO2eCm12rypSophut3sUfFg==
X-Received: by 2002:a17:907:868e:: with SMTP id qa14mr31334371ejc.564.1638614130676;
        Sat, 04 Dec 2021 02:35:30 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-110-042.77.6.pool.telefonica.de. [77.6.110.42])
        by smtp.gmail.com with ESMTPSA id hc16sm3192756ejc.12.2021.12.04.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:35:30 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH v3 5/5] libsepol: pass avtab to report function
Date:   Sat,  4 Dec 2021 11:35:16 +0100
Message-Id: <20211204103516.17375-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204103516.17375-1-cgzones@googlemail.com>
References: <20211124190815.12757-1-cgzones@googlemail.com>
 <20211204103516.17375-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Populate the avtab member before passing as argument to the report
function. Without the avtab avtab_search_node() is unable to find
allowxperm rules and this results in false-positive reports, e.g. on:

    allow TATTR1 TATTR1 : CLASS1 ioctl;
    allowxperm TATTR1 TATTR1 : CLASS1 ioctl 0x9501;
    neverallowxperm TYPE1 ~self : CLASS1 0x9501;

Reported-by: James Carter <jwcart2@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/assertion.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 4600be41..a0eebb93 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -304,10 +304,12 @@ static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avru
 	args.avrule = avrule;
 	args.errors = 0;
 
+	args.avtab = &p->te_avtab;
 	rc = avtab_map(&p->te_avtab, report_assertion_avtab_matches, &args);
 	if (rc)
 		goto oom;
 
+	args.avtab = &p->te_cond_avtab;
 	rc = avtab_map(&p->te_cond_avtab, report_assertion_avtab_matches, &args);
 	if (rc)
 		goto oom;
-- 
2.34.1

