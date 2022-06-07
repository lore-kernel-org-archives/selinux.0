Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABABC433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 17:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345312AbiFGRAs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345319AbiFGRAr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 13:00:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489F102750
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 10:00:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bg6so16639771ejb.0
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tJfUtbZ/t8nRSw8R2AEUFydGIk6UvKuNFj5I7SrIoRg=;
        b=YiiLDvnYcDvj/jkFDn4XAwH539d4PSHoS2OI08QMEFjl3WvoTAMnMb0kFkZE1L42px
         geJeIPRPg0bkWO9gG2BDwTs8N4n7xnuxoWPOP7L6Ubmy15gK4KC0iyHGKWGZS1Ivq1yL
         nc1WGZtRxRqEfsuu+/NjY4AZy2nitt546KsgO6cj1bX3jHTtaqR8aLg/cv7crpfJ8/d7
         1QervBHX+tOAATAZCMo91gq6JKp4aTmeVcnC0mLI+G0N9dleudPVTFYYMxrZqO6QOCm+
         aKOTEJwbRGKBRBeJWrhMR6ASNujONQivQwdtb+a14VRHnkrWPuHPGqcmIJ+Rv/swuWAt
         zsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJfUtbZ/t8nRSw8R2AEUFydGIk6UvKuNFj5I7SrIoRg=;
        b=FnGh6XgM+ydd63SNprtbzuK+qPhqJSciOHlAQ4V1DjO92CHuF/Zo5DgdjJgU4uXC4u
         GPgDFjpzmYj9UwnoT5nYF5UGakGqgNtEyZvW/O4AFq+zl25RrM8Svi5Kh0fNexlrwqNS
         UkyXbB7B4uSFh5naFTXfb5dS+YKCkTfJkns0y309md6E+DUlvgRTjQi5NMSY2+plwMlh
         t6dHWB+Cn7JUbfD4QjEHJ1rYmunS/FUpKsIXsdVueFVR5W5HuWAA8INYvZ36oAfvzj1d
         Ns84yePznEDc2PFLPyD5DZ9aFk6Yhmwxs7CUbbYf7wbOidXzp8A9SQrhbx7SUDVjr+Lk
         szRQ==
X-Gm-Message-State: AOAM532KdnkqdlishIPuG0s+IM+Y9O4+qyBrRTcu2jpGKD40YLk/55zC
        1ocEePZVXuu1Z0LKvLQVUDsudJ1rG2s=
X-Google-Smtp-Source: ABdhPJxGGOMflRJAE3xlx1qJOLo4Cexuakf4RXTVNADAO4GWeLVgwjQMVlsZZP2Evo63z077x4GrWA==
X-Received: by 2002:a17:907:c23:b0:711:ea32:afce with SMTP id ga35-20020a1709070c2300b00711ea32afcemr2183080ejc.174.1654621243000;
        Tue, 07 Jun 2022 10:00:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709060dcb00b006fe9f9d0938sm8056247eji.175.2022.06.07.10.00.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:00:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: restorecon: avoid printing NULL pointer
Date:   Tue,  7 Jun 2022 19:00:35 +0200
Message-Id: <20220607170035.40090-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517140748.24238-2-cgzones@googlemail.com>
References: <20220517140748.24238-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `curcon` is NULL in case the file has no current security
context.  Most C standard libraries handle it fine, avoid it nonetheless
for standard conformance.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   print "<no context>" instead of "(null)"
---
 libselinux/src/selinux_restorecon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 9f5b326c..3c441119 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -744,7 +744,9 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			selinux_log(SELINUX_INFO,
 				    "%s %s from %s to %s\n",
 				    updated ? "Relabeled" : "Would relabel",
-				    pathname, curcon, newcon);
+				    pathname,
+				    curcon ? curcon : "<no context>",
+				    newcon);
 
 		if (flags->syslog_changes && !flags->nochange) {
 			if (curcon)
-- 
2.36.1

