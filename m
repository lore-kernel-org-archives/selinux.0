Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C5C4332F
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07E561108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhKEPs3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhKEPs3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8763CC061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j21so34368043edt.11
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FDAgIT7NldBuqTY7NfEQiDBUAYm/yPMvcAW+0H2wqiU=;
        b=OBd03s6Y792fNbwooo9CeOaQeUOKhEaP1ARmDzcN/d+GcJn/+7dfQij9NTBWj3+bGn
         R6My26knmhib7vdTGdGejwUuiCYLRS1Kg4qJLXPvxkhyiKezsSULgOqKxAfLBVxukIh3
         wBvuvzs7LSjOsioLJYMV3Jw9nLX2cikRsvHKXEFnEGmVh1+cx5nEIWxKkWnODD+G1FDT
         WvuadoHTmca6Nw994JLGW0iO3nATXyEhr6IsUWTlzulJz3laiMz44Hh8vd9VZqfuE+30
         aAUKiRQatIZ69srhwINSUMDNk3+F0xDWI/9M8JvwkdzFxTuih89El7h73kqJL8tUMDG+
         uPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDAgIT7NldBuqTY7NfEQiDBUAYm/yPMvcAW+0H2wqiU=;
        b=ESollLCx3dx7uMPn3MNYIjeLyk8m8ib+ucWocUPyKs4vuavCdgP/BZmQ9PowLGOakv
         rEu/7wYA8bUEe7BX73pXeLC8d18FuUGh/YJNefqLoa0WNQa9GXP7Y33YyHsyla5OMG8X
         a2tvw6VFHORGRqrUb2G6nLc0t16+dD9Hx+WQZ9Gr/lZKUZYk2Hh3NJytPYCbdHd3x+9c
         3kvkoGgmTthENYIFD85V1daacUB8UTYyrK03glkuukfhX9rGO1/nEOuVLlKTBD1YrGfy
         uh1DfPXa0Xz+BMJ7myl4QIXZV0VSlLeFsr8t9CXpA1zdTpL91XBuomzdIziR/SY0blIg
         d2Jg==
X-Gm-Message-State: AOAM530RcklQBvV/x4K5dhUNWZk/HG2puuxmvAQiw7iqZLNaIgfjImwd
        Mp+rNqU2IDPpmDrseRFoaaIMqcd2ltw=
X-Google-Smtp-Source: ABdhPJzurQ78NgIiGO+OrbUQGdMVQScS16F2n8s32iNwXGPXF/o4ua8eZMG9sXRMOjrzQCSaCTvaGQ==
X-Received: by 2002:a17:906:184a:: with SMTP id w10mr73646014eje.273.1636127148055;
        Fri, 05 Nov 2021 08:45:48 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 03/36] libsepol/fuzz: silence secilc-fuzzer
Date:   Fri,  5 Nov 2021 16:45:05 +0100
Message-Id: <20211105154542.38434-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1

