Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2976DC4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 20:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKIUJz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKIUJz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 15:09:55 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1D013FAF
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 12:09:49 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id y14so49902944ejd.9
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88dkEESf74uOPQD+Ep7kFRL7dhGn1rE7tgjTDSD876g=;
        b=A+VEqpO3v1pdzTSFBgKpFe9PtM8FSnKxDmY55XYH8g91DH4tpC3sJ/zGYZgSM2t9MC
         5L3vrqMsA8ByZJFbT7UGxqDC/6RQaXu68iVBMyw0t6ka7TRQsvolcriW72kFr4wFeSJi
         s5b/mqcLLYIBMZkyLC1HfIvVBTiasSmoI8WNFSFu3RQkorhEUaKuvAOdKAYK9hQB9209
         B8crGJF9mmP1xRkwRJwMEwOIHUH5g3/qHPEvYTFD3G5SJuUi1rwGDHEvkgdEuyx9YTtt
         eaLM71Kv3ixW+i1ezTLS5UAF0/r8rgDCwtzBwDHOfjwEvO+QhNooXn4VaHkGqfWjIczd
         zraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88dkEESf74uOPQD+Ep7kFRL7dhGn1rE7tgjTDSD876g=;
        b=O6PY9FAiJr60rTSRmFkxrqs/chEJLwf7dmMZjt2LFsiLBjpMP5c/kNbYXLni3NAJii
         ZlDzEvZiYmDDu2VnbtSlFYXGlEMKfKJ568W/C2T3tyFNgVqDipMuRblF7ox6Arva+S3F
         6szU7kE6H3Ke6AHurkirR4n66C9gvMuv/p9cGAC/nZPxtpeigLZSNL6M3yB84QXZ4VyP
         kiH8Q4voyFw9s3qzdpdVzEmkIPAQLx5k537WSQ88/YM6GJnTOBBuVkfFhyaUGIdLbw4R
         XhspC4v9kjdRy8qmMWqbWsEElTv+83kXpcaLWxpPjQDlZB49c4sdsAlU+baCpBalvRzI
         UYCg==
X-Gm-Message-State: ACrzQf1ZSZLnfjXfoC9cepTNko5RyeT51YAhN07C3FtrBJ1agyaScjbG
        2G/ST+Vm6xiZT1gb3GsMnIAf7SfLebk=
X-Google-Smtp-Source: AMsMyM5qOtV2YgT+hkJoEKLxGLAmBrsJtJTVW36e8tMr05P5hPKAfo+g/UO7bnpuabA4KjPg0vFO8Q==
X-Received: by 2002:a17:906:1c52:b0:7ad:c6c5:eae8 with SMTP id l18-20020a1709061c5200b007adc6c5eae8mr51653469ejg.439.1668024587709;
        Wed, 09 Nov 2022 12:09:47 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-185-019.77.10.pool.telefonica.de. [77.10.185.19])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b007adbd01c566sm6386115ejf.146.2022.11.09.12.09.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:09:47 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol: simplify string copying
Date:   Wed,  9 Nov 2022 21:09:39 +0100
Message-Id: <20221109200939.62525-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109200939.62525-1-cgzones@googlemail.com>
References: <20221109200939.62525-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use strdup(3) instead of allocating memory and then manually copying the
content.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 8a65df05..b79c19b9 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -776,12 +776,11 @@ static int roles_init(policydb_t * p)
 		rc = -ENOMEM;
 		goto out;
 	}
-	key = malloc(strlen(OBJECT_R) + 1);
+	key = strdup(OBJECT_R);
 	if (!key) {
 		rc = -ENOMEM;
 		goto out_free_role;
 	}
-	strcpy(key, OBJECT_R);
 	rc = symtab_insert(p, SYM_ROLES, key, role,
 			   (p->policy_type ==
 			    POLICY_MOD ? SCOPE_REQ : SCOPE_DECL), 1,
-- 
2.38.1

