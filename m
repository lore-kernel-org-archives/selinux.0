Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C6C433EF
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiDHNOS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiDHNNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 09:13:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5B3303
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 06:11:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so17285628ejd.5
        for <selinux@vger.kernel.org>; Fri, 08 Apr 2022 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NPLpZl5DvVIoDrnwUgSvG/88FIuXOJmswdKKRUd+6jU=;
        b=YAx1n4auSSolBBtedpuzBNYvtnupLTgo2TDGcJrE+69dgV1fsfMfB73+HTR6cSmCL0
         TOg8Ii0BcUAejsGfW4v7DXZX04r21zA+G/D1QDZgogrjDCNqo/sG/DZCq1mywkBXcu/1
         QgV6SAvLQmlqSTLTIteFNOPt9PCNt1E0hMiM+03mDiIjOdfdai3f8VGuO8tCQp8t/Kdo
         x9QyAr34AFyjrXY3Q+u0lEKFp/Dy3nE9n82AinYSVECmPF29TJZk9H2rGhzNh4lhJWD1
         bflNHwRmiTr5bpEadSAJ5QcroS5v9Y1R43hyBSOOzLCfysoZG5N6AIxYhQkjBSCb5Syq
         DHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NPLpZl5DvVIoDrnwUgSvG/88FIuXOJmswdKKRUd+6jU=;
        b=3U6x4SwYVfMJXt+TCSpskF9nMnt7tEfWD4rQdkSXCW0DUggdgijlZWg9PQLTUfEIvv
         v5MpJRMcT0sXRvMVcD7ORjYs6GINsbdomV+vr7d8NfJ8/Z7abfx4gh7c/tRf/3i1mh26
         gopU+Zc59i2iFAPdmCKEEmf61mQVkNlWNXimWiwK6z+pO8EQHRknhNjY/3E9GIbcefp3
         f50/6nuO4FAmdmZJ0gTmXy6f0glODsAmK2GLR4egRdOqkY5aUZOGewWag0ZXis/D5066
         aOJOd3YDT4eCos5ILHCvVfL2JgcVZaLUgr/DaRXZ2xWNrWvNSNImhy07yw7+Z/wULDom
         hGug==
X-Gm-Message-State: AOAM5338eKkJl5E9dUU9QLUribY8m+xcLCVRmhGMxMyqs26b95TOme6/
        gbivN4PdoE0PbyHA4qmJVzqfjdAMuf4=
X-Google-Smtp-Source: ABdhPJzwIB10qKOXlv2O4I9bXhvBFs4071RlEcnBOwFoIyUxcB7jIWy9JI/gUc/wvUUlwhgUsohJDg==
X-Received: by 2002:a17:906:a2c2:b0:6e7:efc2:17f2 with SMTP id by2-20020a170906a2c200b006e7efc217f2mr17374746ejb.542.1649423460147;
        Fri, 08 Apr 2022 06:11:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-032-209.77.3.pool.telefonica.de. [77.3.32.209])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906111a00b006e778bd4fc8sm6398601eja.38.2022.04.08.06.10.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:10:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] libselinux: limit has buffer size
Date:   Fri,  8 Apr 2022 15:10:53 +0200
Message-Id: <20220408131054.7957-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408131054.7957-1-cgzones@googlemail.com>
References: <20220408131054.7957-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The `struct selabel_digest` member `hashbuf_size` is used to compute
hashes via `Sha1Update()`, which takes uint32_t as length parameter
type.  Use that same type for `hashbuf_size` to avoid potential value
truncations, as the overflow check in `digest_add_specfile()` on
`hashbuf_size` is based on it.

    label_support.c: In function ‘digest_gen_hash’:
    label_support.c:125:53: warning: conversion from ‘size_t’ {aka ‘long unsigned int’} to ‘uint32_t’ {aka ‘unsigned int’} may change value [-Wconversion]
      125 |         Sha1Update(&context, digest->hashbuf, digest->hashbuf_size);
          |                                               ~~~~~~^~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 782c6aa8..82a762f7 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -57,7 +57,7 @@ int selabel_service_init(struct selabel_handle *rec,
 struct selabel_digest {
 	unsigned char *digest;	/* SHA1 digest of specfiles */
 	unsigned char *hashbuf;	/* buffer to hold specfiles */
-	size_t hashbuf_size;	/* buffer size */
+	uint32_t hashbuf_size;	/* buffer size */
 	size_t specfile_cnt;	/* how many specfiles processed */
 	char **specfile_list;	/* and their names */
 };
-- 
2.35.1

