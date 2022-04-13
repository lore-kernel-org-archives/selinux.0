Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1828DC433FE
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiDMP7H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiDMP7F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 11:59:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137D66214
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 08:56:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z99so2945928ede.5
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HuLg8f8pZbmkqb/v3WkUOjdERKhjDbjrk9tEUH/CIMI=;
        b=nhwatVHeQYBrGYuTm+uOlvmmPCfhXucPo/27WO2EI7QKH/wUooL7jH6NxaP+8/8GvU
         8jSsaT2YRJOY7zJxr4bcZlwWCPWy4qYC5FdiNHNIohhU8lRFbXcStTzEeqSdohq+pRnx
         6GIUSXqcd6YFkPmmOmO/CJbMksmcYC1QSsOkuORQ8AEWlq9T1zL34b4GGUs8MvQ7zn+p
         H1B/F/2a07NycP3lazkJkB1jHzcf8U7WXpkz6iVBnkNVUiY+46Ag9kjF3VTJXFI8VFYH
         MtuIqAEoesU0Eeuf4CD1XeT3aJCEhrtrUhqb/p8GodVMjjA/Ialm/AKVDw6zTdnqW43b
         +WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuLg8f8pZbmkqb/v3WkUOjdERKhjDbjrk9tEUH/CIMI=;
        b=DWuPhmL4X1in4ypoW4UycOrG44nYLsz4wACnDuC9Y0lrGrXXtiFnJSacIcaOWq720k
         rOEqv9VX4qRRFj45XqRSoILnff0fjzpIzPZTgrgqjV8xEklRelMBVU6N56qZUP/6f672
         o2X4jolprfjB6DaUER0Sa04DeSUs8hSTQOv0LWYyJFk9EdAgklWzm6Vw8jbpTQ/Ed2sB
         Qgfd7d1mrGeA/y454LtlSa+VmbfkPoK/zLxCAStQAKUqf4+Vs4KZQGYhbFVySh4RNl68
         H8Ca+iD9KrUvXFcfUgvqZq1U0t/AJaBAgj6wuWtABUNP9d42WtzHvdyqNiuruk20cKi8
         Fo+w==
X-Gm-Message-State: AOAM530//t4gzDOcK4t3TYGQAG8YIbfT3wpfSMG9VFuk9rkhXdDaLBp/
        hXwV9zC8SmtiUZuj/xIhBuEmAsTfLuk=
X-Google-Smtp-Source: ABdhPJxUWvlw4iqkTTHh0V5uipEM4ACiPlyv5+ZO2OVZWaGcC4yNcbVLzUlDKM9TSe+vBgCBcC2S9g==
X-Received: by 2002:a05:6402:1e88:b0:419:746e:fb05 with SMTP id f8-20020a0564021e8800b00419746efb05mr43466541edf.307.1649865402251;
        Wed, 13 Apr 2022 08:56:42 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-215-252.77.0.pool.telefonica.de. [77.0.215.252])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm121296ejc.42.2022.04.13.08.56.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:56:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: free memory on selabel_open(3) failure
Date:   Wed, 13 Apr 2022 17:56:32 +0200
Message-Id: <20220413155633.62677-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220413155633.62677-1-cgzones@googlemail.com>
References: <20220413155633.62677-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If selabel_open(3) fails, e.g. when a specfile has the wrong file
permissions, free the memory allocated for digests.

Fixes: e40bbea9 ("libselinux: Add selabel_digest function")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index a03192e5..586e5e5e 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -226,6 +226,8 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
+		if (rec->digest)
+			selabel_digest_fini(rec->digest);
 		free(rec->spec_file);
 		free(rec);
 		rec = NULL;
-- 
2.35.2

