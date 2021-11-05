Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0537C433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A261108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhKEPs5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhKEPsw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F87C06120E
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w1so34807495edd.10
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DbM3DHnKmo7NJMjpOjkVy2r7vuSfzXt7aqmLghgXwzY=;
        b=XgWEPPY3CaVh/NGp4CntDU5g/HKgb1pCs6sUdQBxl444N5rAT1dn9LE7To3E6wzLHR
         ykYaaKJccqUKRBIoJqPD0pbcH+7LoVAlRKQ+nAIItb/xOz4AhbFBJrF4TXmtneppt420
         mLsVT+k4Ptxwjxcxxy8aPNEUaWzrAG1YOOktwaV9y++gDo0PYY0YoSbBj4WWhyk+j2nQ
         SK9LhfBAQsbXUEvNch6fw1P5PBnAPRmTN3bw8FVq6H/kwzInjZSuKqC5Hdj0lEgxqOjH
         PjIKEvc3iiNdam9TDbQrh+si5ncGCiixUyxnkhh5cLOecENY/tnNX4NSVdBo73qcyPGV
         F5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbM3DHnKmo7NJMjpOjkVy2r7vuSfzXt7aqmLghgXwzY=;
        b=Qx9tvMtQQngz4F80tqriYFSfOr/bHjw7KdSseD07xglyWtKuzmau/p1D5PXx8eLX+L
         KS60mGKc/zUma1QHQ6KtfTCMoLx/PT42koD8IM946RysfEo6blvd4CxXpxgRTwrY0ub4
         nILXVsx2R7YhYLiP2w/3NBSfme4NXvpNgCTyfiKyBaXbhDO6rXrPZaHMMdvQyFm1uGdB
         7P4nP+qINo/NBb8YsITgLOnjUNZMmjS0nUVxo46cwJQ7cs/kuNnGNZKvjtdMVnANkn4v
         R3OWihj1XVoj0frbp1R4JkGnbt17O09+VXOO0xARMSF2oQBQuWf102K/Yl0Cx0eDhWQs
         M52A==
X-Gm-Message-State: AOAM5336am2VYZhd+0XxUoKgNv1LuZZdQ1DELR3yaqzdS1LWElRJe1f8
        34mLtOX1eiOMXLt7eTnDrkQXOiktxpU=
X-Google-Smtp-Source: ABdhPJx7bnp41kRKujHSan2CxEMNa03GGbnXgn5UiUR2AL1NQ7viyuboLarvpAMl5VtAgdDxF+RJOg==
X-Received: by 2002:a17:907:8a20:: with SMTP id sc32mr46674579ejc.65.1636127170531;
        Fri, 05 Nov 2021 08:46:10 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:10 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 40/40] [CROSS-PATCH] libsepol: do not pass NULL to memcpy
Date:   Fri,  5 Nov 2021 16:45:42 +0100
Message-Id: <20211105154542.38434-41-cgzones@googlemail.com>
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

For the first iteration `mod->perm_map[sclassi]` is NULL, thus do not
use it as source of a memcpy(3), even with a size of 0.  memcpy(3) might
be annotated with the function attribute nonnull and UBSan then
complains:

    link.c:193:3: runtime error: null pointer passed as argument 2, which is declared to never be null

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   drop realloc rewrite, just check for 0 size

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index bd986b7b..dfcb0673 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -191,8 +191,9 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
-		memcpy(newmap, mod->perm_map[sclassi],
-		       mod->perm_map_len[sclassi] * sizeof(*newmap));
+		if (mod->perm_map_len[sclassi] > 0) {
+			memcpy(newmap, mod->perm_map[sclassi], mod->perm_map_len[sclassi] * sizeof(*newmap));
+		}
 		free(mod->perm_map[sclassi]);
 		mod->perm_map[sclassi] = newmap;
 		mod->perm_map_len[sclassi] = perm->s.value;
-- 
2.33.1

