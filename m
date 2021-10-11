Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0790C4332F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B55D60EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhJKQ2l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhJKQ2j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1900C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ec8so20271178edb.6
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LNEcH2BVojNhAPW0dk9x+vN5dXFVO/AhbO3elN6T2yU=;
        b=mFUp6x+yxXnvs/SMPI5jSDo4jsAEqoyrWTp/yEMK4bh9tPi94l+t9+AJOD922WkSXg
         U4LOo8ZeVibouafBI66D/s/M/caybxv/CbEGXVsaP7MYWDMkuhmWdoLEUIERol6cA7fk
         WbWyP7ghYNNPEv77uGANNV6BdVIcoVrvb7fE3rnO2mR3QCB3MsSICWmLeGvKPGVpByYo
         tJ/zPLawbkGzxnSCaPaljpXyz5XrIigJ9nxGnGIgTTY/bJSNoT78beJgGYsMHziiFs1k
         QayMNNG4rCJ7iyJL62vMZwz/3MFL1r/UE7pirmbfQgYRVy0v4PEZx2Dk6oTSXA/1RCbd
         P/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNEcH2BVojNhAPW0dk9x+vN5dXFVO/AhbO3elN6T2yU=;
        b=0EUBFO2AsDhbT4fLVjujK7AVOUuFsOYPD/BVbO3ZwJ4iq2hXEuc094PZBJ/dh133og
         zCGuvsclGX5tvjXlMhNy5vWM8OzZPrEQ9ugZup5ZQgc7n5iGfQr6/QxFCM2l8yuXE6co
         yAB6gYl1LTEvu+C2wr0P3iO8y3deXoDMkOt413DdCIkdMgB7QpOkP8u3kxFkD4Uc0Eey
         ZQPEbfedXL4qW/iFciAkqzC0uJeRqTkN3QQSPO+O3kUzyHv8BmP/oxQal2UdqvrydMfs
         yRwLZAQYpTgnW24G7sAQNLkFhyuEkVZ6MNyf3QjSEeGNsVoIKHHTnQ6p6TOFCanoWMPE
         Xfjg==
X-Gm-Message-State: AOAM533plewtm4zdmxI3nAccL2/ONLW/Yrm+M7lWquDMV/yEQNM/GtU9
        eSfBg+9ykTpNneSLInyT2PBVuQ0dgew=
X-Google-Smtp-Source: ABdhPJxOLuvWrGSi8/MD/2d8Ed2pB6oFUMuGgSbowCk7LXTtUpYBNH1lJM6kGoMX1XxjatT2Y5i/4w==
X-Received: by 2002:a05:6402:785:: with SMTP id d5mr13086863edy.117.1633969597216;
        Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 30/35] libsepol: validate permissive types
Date:   Mon, 11 Oct 2021 18:25:28 +0200
Message-Id: <20211011162533.53404-31-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 63fd935c..b1dacdad 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -886,6 +886,23 @@ bad:
 	return -1;
 }
 
+static int validate_permissives(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	ebitmap_node_t *node;
+	unsigned i;
+
+	ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
+		if (validate_value(i, &flavors[SYM_TYPES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid permissive type");
+	return -1;
+}
+
 static void validate_array_destroy(validate_t flavors[])
 {
 	unsigned int i;
@@ -933,6 +950,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_datum_arrays(handle, p, flavors))
 		goto bad;
 
+	if (validate_permissives(handle, p, flavors))
+		goto bad;
+
 	validate_array_destroy(flavors);
 
 	return 0;
-- 
2.33.0

