Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89424C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbhLIQzz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhLIQzz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39143C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x10so4327881edd.5
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PwEtZwwXhuDHJLRC2ZP8P3LRIB6TXkGzitxoJYvbelE=;
        b=Qu0HpiMuHIivCBrz7bsNLuD+Ez8Ahkt/bXaK0z/hcra5qSfgEtUhZKDyM6AW1hUy1S
         jY0hjFkG/QNZT/Ic/nNPgcmQgHouY7hYLmq30C3R+h2t7uN/usgFQneN1MOZOiWvx6g6
         pXgaQn/UnrhNKDjjPcdTdevEwaNfffl/76pGtQwVdSYcxZ2Q/vSenHoUsajpSmNE5E/o
         4rHKBBkOkNh/0u0kIHNtDn9t1d4BKzWBl6xd8AP0/Gyx3blG5XFI3T284x9S5Ge4YMU8
         65P2jW8us5tqm7pYN/yaYshcy2KMncAVwUBAFvrN+ktGDaRkmoecP2gjpw1or5jU45Am
         EOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwEtZwwXhuDHJLRC2ZP8P3LRIB6TXkGzitxoJYvbelE=;
        b=KeIOiRfISce0RHM2+5KbwxHnWl1Wf3ii5otaojqPCeFecH756nwumhdf0I/DwC+a7u
         BBHuhy1U+LeKM4ZkribBRgeKd4H/CXaw/BowuUZCm9sPZa2kmu+VQzwI21vrs1cWJ6BG
         BSOLsxK3W99nZz3BUC5dwvMQYuy4fuilJuG4YnF7zGeeQAvMe+X227ViGVcuC/QJmLe5
         +erb2bgQeCzXHtEGQNdB5zdUm25710NlQi5q9e72ndLJf2y/lMvIpsvojnYOih+9nyBe
         wpJ27041CqUMIrYe2Yzw+t0ZyVHRWF4xpL8sM1ywlHvXHRff0LS6pOoq48ctlOZ1+wRa
         lWwg==
X-Gm-Message-State: AOAM531dPKYgolIv63HWbiAixvsoNLo1hdEf/rhxsCn6h2KRj+6YLPW/
        7iM26bDsZWpsBY1t7Edka8YhPyaq3bU=
X-Google-Smtp-Source: ABdhPJzNxS1BahqytADPsxOBviUl2sKsIXBbxJSKwVa3v/93UxntOx9pUJL+4npkYBXmwSsmMtvkeA==
X-Received: by 2002:a17:907:608b:: with SMTP id ht11mr17554636ejc.80.1639068577399;
        Thu, 09 Dec 2021 08:49:37 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:37 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 03/36] libsepol/fuzz: silence secilc-fuzzer
Date:   Thu,  9 Dec 2021 17:48:55 +0100
Message-Id: <20211209164928.87459-4-cgzones@googlemail.com>
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

Do not output CIL log messages while fuzzing, since their amount are
huge, e.g. for neverallow or typebounds violations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/fuzz/secilc-fuzzer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/fuzz/secilc-fuzzer.c b/libsepol/fuzz/secilc-fuzzer.c
index 255b3241..9a1a16de 100644
--- a/libsepol/fuzz/secilc-fuzzer.c
+++ b/libsepol/fuzz/secilc-fuzzer.c
@@ -8,6 +8,10 @@
 #include <sepol/cil/cil.h>
 #include <sepol/policydb.h>
 
+static void log_handler(__attribute__((unused)) int lvl, __attribute__((unused)) const char *msg) {
+	/* be quiet */
+}
+
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
 	enum cil_log_level log_level = CIL_ERR;
 	struct sepol_policy_file *pf = NULL;
@@ -24,6 +28,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
 	sepol_policydb_t *pdb = NULL;
 
 	cil_set_log_level(log_level);
+	cil_set_log_handler(log_handler);
 
 	cil_db_init(&db);
 	cil_set_disable_dontaudit(db, disable_dontaudit);
-- 
2.34.1

