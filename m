Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0499C4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjKINv5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjKINv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:56 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D78D30CD
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:54 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so142917766b.1
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537913; x=1700142713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjVqQGVKhasBg01e/d2CLbqMagiHE/MK9veSrf/c2y4=;
        b=EdEqNkH3Df7x2CKXmVSbBx03NPzZyGh9PUOzjctR1n04Mj+bnazq4tAbgTCVdQYxap
         9XLpxEbYHzLoXDAHPt/J3Cw7umN5+QNofB6IqlXQz9y7Nn9ZXoehFGI3wFKi6tUKtb21
         e4hk8RPvm0VdP/qzqqFCvzMtbR3i2vtwK5rcJyjmNe9xfuWYomuPlqphbvek1YU8Hx2n
         AbPebm6zATyHvTAeupOcQg9fYpFF7DexmCj4coeJfWnGUhPR5bUcBTuWxfiHFwm6Mjzx
         vnYZZBbOQkckJIKfPXr2Wjlk9p+QHR87xPCyVaqoHKnnNAvJAjnNVJ+90Sm8TRjh8/AV
         bu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537913; x=1700142713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjVqQGVKhasBg01e/d2CLbqMagiHE/MK9veSrf/c2y4=;
        b=h6PEuiECDkYV85wgX/sF7kWnigV0KZFlLrMmTl/SlpmzdZx36H53XvJkJFZLnuwaiD
         yYDXQk2mv0kinKat5R1dlgHBxwWLxSWv3ppPr5lPDTa9kSTB5+HbGhRdlTlAV0gbjWLH
         M9dju1HJUZ8sVACzPGNx/FlCIVAe8hbeLhvpL7+KCX2/dpymqD4GqDtrNR0UnuRXikll
         4skKdUQlRD4Ew0CkUqZBSZ9Fw7lguHgZW/J2zh2HAFked4KfIASXXf9MZ2w3WRkCCuXx
         YojJjUMt3ADj+lIFad4hrNh0iZRdq4qZuYJLwjPIkVySIyenHYy6He5ki4eHnhxNQ5MJ
         MSnw==
X-Gm-Message-State: AOJu0Yxp5hYJ9sRAOYlLq3gP4RLXdwR+JDsLuQVC8fabqCHiJ/1lhhKV
        Ou98DzInyUIp/jzlxWGqMkJ14zdiTWM=
X-Google-Smtp-Source: AGHT+IF48bdftdm5VIJFyX+pY+Pvg31Q9NmVdW1mOceIe7kpEp4gzbnjWi1A1iNsI8NE3J/9QUnhmg==
X-Received: by 2002:a17:907:94d6:b0:9d7:1388:e555 with SMTP id dn22-20020a17090794d600b009d71388e555mr4298276ejc.21.1699537913011;
        Thu, 09 Nov 2023 05:51:53 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009829d2e892csm2623563ejb.15.2023.11.09.05.51.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:52 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/7] Drop LGTM.com configuration
Date:   Thu,  9 Nov 2023 14:51:42 +0100
Message-ID: <20231109135148.42688-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

LGTM.com has been discontinued in 2022 and replaced by GitHub code
scanning[1].

[1]: https://github.blog/2022-08-15-the-next-step-for-lgtm-com-github-code-scanning/

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 lgtm.yml | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 lgtm.yml

diff --git a/lgtm.yml b/lgtm.yml
deleted file mode 100644
index f80bf146..00000000
--- a/lgtm.yml
+++ /dev/null
@@ -1,5 +0,0 @@
-extraction:
-  cpp:
-    index:
-      build_command:
-        - make DESTDIR="$LGTM_WORKSPACE/destdir" install
-- 
2.42.0

