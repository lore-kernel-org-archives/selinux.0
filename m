Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1586C43219
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E34060EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhJKQ2k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhJKQ2g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C9C061768
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d9so46038123edh.5
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YXdIaf8BZVgkvF8pv1il9HYwdhvEGYJUq/hszZK8Q44=;
        b=Pofmt67r8xwn9GWYdhWlTvKbRG4FuE0NotKhNpGa2eidvGFzyDmoD/pGWy90p11eNF
         LAE+JKmw0obpFLa00Ei3hWa6WI/fUvc72njElGGZy6oQJu7Zv/yfpyRZdxTcoIKb179J
         vtrj3CePCBbzDI6sN2l5AOQ28wY10ky5w88ars9XDwr+MhyfGoLlj4HLC3Fn/t1vBlWw
         bBg24p501qy9SMzZg0AC1frQchdP6jy/lS+4U1R33/pp5I7PoDgfaMfnfrC9epC1DZdJ
         yAJTYehclIUCYjV+A/tpYVfSzec9HUg/KUU676PgVtv/pmmYojpfHZmwSJkV76bi4tEA
         4ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXdIaf8BZVgkvF8pv1il9HYwdhvEGYJUq/hszZK8Q44=;
        b=tZuTP3zhoXB7DIRz+99keUPoDKlfE7QU1EHJKTZc9UW6J6xny3t51TqnV25LtE80YK
         D277E+zwBr0WMJckoj7Eq5IB0jlz+NTgUtsp+OiDQhJYf/ZtMloX2zy/jIaTcE95vcJW
         2mFlAM5EOxAVF4QwxNiBgHKHDLspIUggdiEagQSUHbuuIot7J7ZFTRDOyKTmSyFGDbQw
         2s8mplmFqfzaOhFzBM6aCPJr6G44Ox7Fv+WNBn0zNb/Otk9kLN2jPaEii3f1kgbwOEgS
         0UTX35rWaQWlkwXlF1vCqZI4nxWdaBPIlMK7hLJaXr3FzxPzMFMyRRItBFR5dH9UA9YC
         BKrA==
X-Gm-Message-State: AOAM531l4ZMc8A2c5nuWMT1D/FcFZOYvii7nc1rCGXagC9tkNsC8dDYt
        FtCsU0V5FPg6owUzo4NzdRIt1OX2RmM=
X-Google-Smtp-Source: ABdhPJx4uYdYbsvVH9GWHVhPdCnSxwmCWaIN2e4YMRI1oCaI7d5bvSf7LddBN9kC2VqWfLaV4aFtFg==
X-Received: by 2002:a50:d8cf:: with SMTP id y15mr43556383edj.66.1633969594744;
        Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 25/35] libsepol: validate avtab types
Date:   Mon, 11 Oct 2021 18:25:23 +0200
Message-Id: <20211011162533.53404-26-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check for invalid avtab types.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fa128794..89830ff3 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -441,6 +441,20 @@ static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
 		goto bad;
 	if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
 		goto bad;
+	switch (0xFFF & key->specified) {
+	case AVTAB_ALLOWED:
+	case AVTAB_AUDITALLOW:
+	case AVTAB_AUDITDENY:
+	case AVTAB_XPERMS_ALLOWED:
+	case AVTAB_XPERMS_AUDITALLOW:
+	case AVTAB_XPERMS_DONTAUDIT:
+	case AVTAB_TRANSITION:
+	case AVTAB_MEMBER:
+	case AVTAB_CHANGE:
+		break;
+	default:
+		goto bad;
+	}
 
 	return 0;
 
-- 
2.33.0

