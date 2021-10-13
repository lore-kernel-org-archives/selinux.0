Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6534C433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 12:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF29060EE9
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 12:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJMM4K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhJMM4K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 08:56:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFEC061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 05:54:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t16so9777777eds.9
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K23LruNxFcvr55p1RLGLS4KQdNomICr7OSUUE982vP8=;
        b=c4xj1wL+CA0OM7fxF9GhF61VqpMM/jHfIC3r7Bf9nJE8kWbJlJcN1uPGgs/FUWqFTf
         EKiIZZmZUS7Y5JXLeeOzsVnBi5Cpj+ZHkGAqgqrhOOpA7cMRg0ZuDM47PdgbfwMdgC7N
         7GwVUNiSKMD06a4oy3YqSCqfAQ6HayXutSlYb7Fob5P9twne+Qa07V2lPeaDmCqVSe62
         xQzgIl6QmHL3/EqlVyfCeRVOiMRzCRrQaw2TraLH/v0gYZfpITZLXXG3yFNj0lYfpXAV
         VUNpOeJZNLH2YlwH/onDlR9/BR1C9J46o1qLMnS8a+Ta06n/DPcCDTW3QcoHjS+flQV+
         wybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K23LruNxFcvr55p1RLGLS4KQdNomICr7OSUUE982vP8=;
        b=kBYiVQcCEGUkSQrMUd3frcb5NyRYcItgMED0K9y0K1DkG7svUG5Yi9Ltj3YHobvJN1
         IT2RQw3+qYKFkWDkRDF9orAR7jKndrQQkJHQ9mY1RbN7ag/yKu5nwWl5n0YWjYnENxuX
         MBampLFWXzvrU6mRWl1LvU6IxrxaT/IXunWZl/L5UFWqBPOB2K4TGY07K9M3CG1YVCKb
         Ft8Bzk1Kc0j5FYLcluZueXMpHzA6eBye/NfHJqR/kpYFTDbekFU7OJjH3ZLxke7roiqu
         b6vYhdHb3EInSxPUfnIYlAvU2LdMrQqcGiXqGTX3QwB/yIuDMQ13nIP8kBLKwfAi4V5q
         8W8A==
X-Gm-Message-State: AOAM530CaGC78q7DNzkEAgnzRyKypiXNIEJiElkEbt7E4ce78jL+ls6D
        +0W8kt4a65ZTDzMW/cxTSj2g8iV7JVc=
X-Google-Smtp-Source: ABdhPJxqBKJc6NPc0ShnGwkQrOLbvpq0z8r6PHVH5stgLSmeBVlXopDtkALSdYqNA+r6yF8QGd9+xQ==
X-Received: by 2002:a50:fc8e:: with SMTP id f14mr9466464edq.87.1634129645273;
        Wed, 13 Oct 2021 05:54:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-105-029.77.3.pool.telefonica.de. [77.3.105.29])
        by smtp.gmail.com with ESMTPSA id u16sm6745880ejy.14.2021.10.13.05.54.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:54:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: do not pass NULL to memcpy
Date:   Wed, 13 Oct 2021 14:53:56 +0200
Message-Id: <20211013125358.15534-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For the first iteration `mod->perm_map[sclassi]` is NULL, thus do not
use it as source of a memcpy(3), even with a size of 0.  memcpy(3) might
be annotated with the function attribute nonnull and UBSan then
complains:

    link.c:193:3: runtime error: null pointer passed as argument 2, which is declared to never be null

Use a realloc + memset instead of a calloc and free to increase the size
of `mod->perm_map[sclassi]`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/link.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 7512a4d9..75ce2b20 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -185,14 +185,12 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	 * may have originated from the class -or- it could be from
 	 * the class's common parent.*/
 	if (perm->s.value > mod->perm_map_len[sclassi]) {
-		uint32_t *newmap = calloc(perm->s.value, sizeof(*newmap));
+		uint32_t *newmap = realloc(mod->perm_map[sclassi], perm->s.value * sizeof(*newmap));
 		if (newmap == NULL) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
-		memcpy(newmap, mod->perm_map[sclassi],
-		       mod->perm_map_len[sclassi] * sizeof(*newmap));
-		free(mod->perm_map[sclassi]);
+		memset(newmap + mod->perm_map_len[sclassi], '\0', perm->s.value - mod->perm_map_len[sclassi]);
 		mod->perm_map[sclassi] = newmap;
 		mod->perm_map_len[sclassi] = perm->s.value;
 	}
-- 
2.33.0

