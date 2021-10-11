Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57652C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4115D60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJKQ2a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhJKQ2a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8539C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d3so42460105edp.3
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FXStbGqz/wV9AkuhE6zzk1UhkuY82+ILKcE9+4X7Eog=;
        b=na1/SwBu+NFW2Twq35/ilMchjFW9s3PRkLutCeiYzvS+rxmJFfTEj3VCtrmXZTD8HN
         c+oELBZEcZFhdjjilt/wYwdjmGkdxN8D4KL9Q1knvk09ZhntEWkg2SY0GzvIBVwC0rS5
         wn1ufZYWe1ais16gSNSjji66ITFMFnJz9M7IcXivHjVxLgUV+hIQIu2ikIDp6HA2FtOO
         hmC2BcJDiDQ1Qj1k2devIJwgrck9bRpVa+wAJOv6FDnlUBPEZMCdDEaJWR2a2rNCjd/H
         /REQ2kPh62cNC07kcvgir/yFB4qJvyyVHwA49KZmECmkuC5W1z+hpZoWEsCEI5yNfm2H
         NprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXStbGqz/wV9AkuhE6zzk1UhkuY82+ILKcE9+4X7Eog=;
        b=OLo8HC1OqAAbJxQelBgFB10rfmgWL00hg/KIglCIrMYS3Tz811Vk6bLg60V+Jf/wdq
         MvbSO6T6ulb+c9g75idn2Pb97jEOI4kDTrMP32LHLUqwfHTD3zeA5mPIVcvUAeH2KHCJ
         YtYhOpSdWcFlFo/aqEhXrfzow+SeePoeTBrzcSPLkdk43YsmCURyHP0yfq/KaUm3mu4G
         TtB+tVqv1GgY7sDy2rR5IOPMCcdNhHxeilmzpXI+WSZm5mXJBHaGLrqNKs9OVIE7n25w
         ftIYlrnKlGYwTXX7y3/mhl7amZsMe1HWs4fHLHHjbzx0qfgDtY+kXYm3MKzt4gQeAQzU
         TnZA==
X-Gm-Message-State: AOAM533XVF5RVAllQ3d1RFaPHMJYchmp6F/kX0Fsf96JecWnrk0mGYpd
        pmQ42BLKqfbsIqwx+0ipzQATyPvgOSs=
X-Google-Smtp-Source: ABdhPJwWxkH5iY4wQfXz1fzPUhz5L/8feNJWyETZJCIyr4zw0NfwI8WELHwb9zi4an9e82b619USVA==
X-Received: by 2002:a17:906:f8d0:: with SMTP id lh16mr25718615ejb.367.1633969588374;
        Mon, 11 Oct 2021 09:26:28 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 13/35] libsepol: validate MLS levels
Date:   Mon, 11 Oct 2021 18:25:11 +0200
Message-Id: <20211011162533.53404-14-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Validate the level map of the policy to ensure no level refers to a non
existent category.

READ of size 8 at 0x602000000c58 thread T0
    #0 0x568d2c in cats_ebitmap_len ./libsepol/src/kernel_to_conf.c:1003:14
    #1 0x568d2c in cats_ebitmap_to_str ./libsepol/src/kernel_to_conf.c:1038:19
    #2 0x55e371 in write_level_rules_to_conf ./libsepol/src/kernel_to_conf.c:1106:11
    #3 0x55e371 in write_mls_rules_to_conf ./libsepol/src/kernel_to_conf.c:1140:7
    #4 0x55adb1 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3103:7
    #5 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
    #6 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
    #7 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
    #8 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
    #9 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
    #10 0x7f741d0d67ec in __libc_start_main csu/../csu/libc-start.c:332:16
    #11 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5804d247..ca0dcca3 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -310,6 +310,29 @@ bad:
 	return -1;
 }
 
+static int validate_mls_level(mls_level_t *level, validate_t *sens, validate_t *cats)
+{
+	if (level->sens == 0)
+		return 0;
+	if (validate_value(level->sens, sens))
+		goto bad;
+	if (validate_ebitmap(&level->cat, cats))
+		goto bad;
+
+	return 0;
+
+	bad:
+	return -1;
+}
+
+static int validate_level(__attribute__ ((unused))hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	level_datum_t *level = d;
+	validate_t *flavors = args;
+
+	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
+}
+
 static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
 	unsigned int i;
@@ -368,6 +391,9 @@ static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate
 		}
 	}
 
+	if (hashtab_map(p->p_levels.table, validate_level, flavors))
+		goto bad;
+
 	return 0;
 
 bad:
-- 
2.33.0

