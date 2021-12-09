Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AFEC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbhLIQy5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhLIQy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:54:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D45C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so21954225edv.1
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mfU3j7D1K4WGnf9Gm5ayLdHZ+SYqwAp5jBV+TmdK+aw=;
        b=TJnU/x7Eu0rdYff/CjWaYb5II8T2xoOUK3Ghk9yenfgYWVWTZlfUaswF6cpgANkFzw
         EkW3gYGIIPvpfXN8jGvcIBfEzxL5SUWf2W3110gf8Rvck2Mmkj/q9em7hAq4k76iki3J
         +44VOA3FQTnh/cUBdFdvoT1OSrIbWTOpZ9XMY1UvGgmz/+llIB/2V93NewbyGZuAQklF
         dQ+U/UJ7Gn4CKEbcKpYxMLsluJWq9LKrfoOQ/AsaH7tHVHqkaa7G4CJILN4rKgG6mnGF
         2OhVvtZfkEtuARt4nIUTY0w3xS9FW3hRKjXxm9hSv407QZ8Ud2zp+2fR/Fm1KydDgE6T
         bD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfU3j7D1K4WGnf9Gm5ayLdHZ+SYqwAp5jBV+TmdK+aw=;
        b=IGqGSk1mLnZ9cqlwPVjfWy4UriHc4d9eq8nt/Kz8BzwLmQ06/A5jiQEof1xdDLsZd0
         U9rCmYm+69wYhn3ecnWuE+JQvEcYd5XQqXS3f9Tarvwp9zG4OJTi6Taw+YFcs/16QSzp
         MQnTV06MBv3KukYwD/lwQOd+57hBS3y5ZzECLq4vQ0e3N+8d2kfqtIKlFk9mONfZdFTY
         j1jKcSIuwUKfWvBrnyC339spwZyypbygypr1Fe/R2Ze8UV62ljrknGIngg7JREERycBj
         yN1Q7IL3rQS4VuMm0ZUXata0QHJF1LGUKxn7uqgS2zhOEyWI675Q38TJFvrEMoUBf3bo
         gSrw==
X-Gm-Message-State: AOAM5332DmZrpDZfpXlUxWVwERsMfI2ycRXwFfvEQqbduDCgVdOicnsN
        l9AgJ8xaYaehKq1voXSxTJzenluSsyw=
X-Google-Smtp-Source: ABdhPJwMVpidcma+uvJ78DBtr8ZmRkoIrlLa8nHumKd3Cc09n+tEuO4oPVNbYVZumDbB+vS8V+tJQw==
X-Received: by 2002:a05:6402:4413:: with SMTP id y19mr30436751eda.26.1639068585342;
        Thu, 09 Dec 2021 08:49:45 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:44 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 15/36] libsepol: zero member before potential dereference
Date:   Thu,  9 Dec 2021 17:49:07 +0100
Message-Id: <20211209164928.87459-16-cgzones@googlemail.com>
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

The `next` member might be checked against NULL and dereferenced before
it gets assigned, due to jumps from failure gotos to the cleanup
section.

    ==31017==ERROR: AddressSanitizer: SEGV on unknown address (pc 0x000000579654 bp 0x7ffd3a07d110 sp 0x7ffd3a07d000 T0)
    ==31017==The signal is caused by a READ memory access.
    ==31017==Hint: this fault was caused by a dereference of a high value address (see register values below).  Disassemble the provided pc to learn which register was used.
        #0 0x579654 in filename_trans_read_one ./libsepol/src/policydb.c:2874:55
        #1 0x579654 in filename_trans_read ./libsepol/src/policydb.c:2902:9
        #2 0x5771b7 in policydb_read ./libsepol/src/policydb.c:4509:7
        #3 0x55a1f5 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:24:6
        #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #8 0x7f2a4e7f97ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 25ffa07c..79aba3af 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2780,6 +2780,7 @@ static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
 		if (!datum)
 			goto err;
 
+		datum->next = NULL;
 		*dst = datum;
 
 		/* ebitmap_read() will at least init the bitmap */
@@ -2797,7 +2798,6 @@ static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
 
 		dst = &datum->next;
 	}
-	*dst = NULL;
 
 	if (ndatum > 1 && filename_trans_check_datum(first))
 		goto err;
-- 
2.34.1

