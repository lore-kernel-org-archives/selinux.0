Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510D7C433EF
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiAKVzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiAKVy7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:54:59 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD75C061751
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:58 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id i8so907076qtw.0
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKn85cKJmtY5fpLVgW6csAcITiSKsyGMOP6Hjw9OQtI=;
        b=VmRfFsYDSRLZVbrud+dCFYQDVLFT3xhALaL0NHzAay5gpV2mQM14XUE8onbP91kLQ2
         Ryhd3HVEI9cHGdqTJwPIqT41OgpYNBeOcpJj0oItTJKRVtkEgExZUPRlQ2pcWDSf3MiF
         sQMZmn2XK2FNwX9ulEKxbrlIj3aNMoCEKl41C74QCyB3NqsCriQgFj7vVjsHzWP2cFvN
         BMc43JD9NBxiw7TgrOMb1o7IqkOUUGyOIEEfBfIyyavRRd0t4gmVvIMf/qImek5pFXmY
         yOuZNoPRrdZOacaWxD19L/hy2lTjpQqHEG0DF8r9zW/VmtEbAXz3GJ9JhF7q1XdbsNzP
         CrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKn85cKJmtY5fpLVgW6csAcITiSKsyGMOP6Hjw9OQtI=;
        b=wi1Tl+pzufZZ0Fxrk00namqBhNKQOzd7BtgO8wl/WFl5huehLy10E7x6p4ay4yUJUT
         idyDiUIQdumi9Q9qZlF6WTyRD3nWBQ1zvHdrHMNPBYJ0w4HfdFP3V+RiBypaSy154o+q
         WvCfdUoVYitALLOn1y+GcW+b39qAmt9hktikjNbeoal4gT3GOut3cFQP68qL9ofMCmjL
         fSPj0T14rp8EGtmdyPYoHWkaKTbD+GdrKz3IjmbLIcXyJHhjimBn6bP51Lz5ZWeztvyi
         orumpuM4d7aWQE+L1ey/1T+D6y+ZRPh57UbUrrQhrQgVXAP4ZqEFZnQqnJCOeMEIDt0+
         QL4Q==
X-Gm-Message-State: AOAM531FKOWbu5cC6CI/NH0xA0C207Jmv+dM9OpoRMVfMajc38L1RFEl
        Rl7x7bEqvPrT7Oy8fekfxKgY/8u62yw=
X-Google-Smtp-Source: ABdhPJx5PSJBo8K7DUnnoa6QASMYVaKNs0ArN+3pPRO2XTxULDUuSwOMHN5BFXqFiNbdnyE13U2b7w==
X-Received: by 2002:ac8:580a:: with SMTP id g10mr5441127qtg.515.1641938097524;
        Tue, 11 Jan 2022 13:54:57 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:57 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 01/16 v2] libsepol: Return an error if check_assertion() returns an error.
Date:   Tue, 11 Jan 2022 16:54:31 -0500
Message-Id: <20220111215446.595516-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Instead of calling report_assertion_failures() and treating an
error like it was a neverallow violation, just return an error.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index dd2749a0..ba4a204f 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -538,6 +538,10 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 		if (!(a->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_NEVERALLOW)))
 			continue;
 		rc = check_assertion(p, a);
+		if (rc < 0) {
+			ERR(handle, "Error occurred while checking neverallows");
+			return -1;
+		}
 		if (rc) {
 			rc = report_assertion_failures(handle, p, a);
 			if (rc < 0) {
-- 
2.31.1

