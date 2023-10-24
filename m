Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10120C25B6E
	for <selinux@archiver.kernel.org>; Tue, 24 Oct 2023 21:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbjJXVjZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbjJXVjY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Oct 2023 17:39:24 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07610CF
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 14:39:22 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778af1b5b1eso297811685a.2
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698183561; x=1698788361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTx+DIfzldeq2eksqP2wI1c/+N/k0A9DAE4XeLDgNso=;
        b=ZFCwqRdWGhlcBGQmTi8dpw/weAW5Scr4HzaUx9mEvJJ6kohx3dOBprFhmtr2ph4AGf
         d3An6SjyG5jGAsZNUzggGg+IshdMbPT0gvYO+QzucbgRMxJO3yUd3Qb7d/v4ZLIIPgWf
         83Qk/4sYrwc0XIoqjQyjGRHoypGuxxv5pde/Qi02BJISIDCKk3xnKK00ANXiIwfIa3r2
         Bng0tVqypbfcIDmsMU6dqNHcIW/oyJDm/o7xRRhAdCOC75ApUag6Dp4YBPMoAmfmX2bF
         CsfvFNw66kuU9YLO3gNHjbI/UaFXlMSMmQV2bWS3n1W3ED/7ZA1tlGbNtqB/VwUV0tVO
         Ltcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183561; x=1698788361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTx+DIfzldeq2eksqP2wI1c/+N/k0A9DAE4XeLDgNso=;
        b=d69Vl5ThwXxESE5M47r0aBzyFUleTVoqkC0z1+o/+biTXfDzFGJaDwCQnTPAM3QBe2
         ejQvPN0t58d6SPezFvopLwt25asFgNkBwvJABU6JCCo6cAj7zTgwT77gmqtMPhq9T7yO
         /oS53Qs9rEHSJU98R3WQJ6k0UU/k7b8HrbopXE56YUp94ycCriWczqxZAMmMSKPjOeWN
         m/rp1nwI7SJBaW+SmGWG2kRBC/PrUlDQHNWX/lKHLupA2Tho+VBkDhKWnJVTA+IZU4UE
         CANxgzibTXcm57yXDCW/sYAhIBpozJVBzegngyaoTpZteSaOQ3o1tT5fet/7kRwYwVjG
         QkwA==
X-Gm-Message-State: AOJu0YzXl27a2nW1eGpTg5riebWocy8c/1TozVLkh+TXcMazpvGGAnOE
        18BmgnB1hPIOAjOulWpi6k2H
X-Google-Smtp-Source: AGHT+IH2vXirvG66RY5GJljwobv0W8adgDMxAyjbEXzXm/HabPb9i6fcmcHpcNXBAOZf86IeIX4M0w==
X-Received: by 2002:a05:620a:c44:b0:773:a028:71b6 with SMTP id u4-20020a05620a0c4400b00773a02871b6mr16505512qki.65.1698183561628;
        Tue, 24 Oct 2023 14:39:21 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a132500b0076d08d5f93asm3717190qkj.60.2023.10.24.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:39:21 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [RFC PATCH 2/3] lsm: correct error codes in security_getselfattr()
Date:   Tue, 24 Oct 2023 17:35:28 -0400
Message-ID: <20231024213525.361332-6-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024213525.361332-4-paul@paul-moore.com>
References: <20231024213525.361332-4-paul@paul-moore.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=paul@paul-moore.com; h=from:subject; bh=ugmNzfzXFsYvckNvX1aV6BAeCvMbabcAjQNIQgYTuco=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlODijlub3W8kIgCE1sgtbxoM/CkMFXdZjbwjNM nW5DjAuiKGJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZTg4owAKCRDqIPLalzeJ c8FTD/4lOcUYhpZNUihf5dlWbswCIms6JVFNXf1+CzvmYz0/RooImhZPCETqhdfR9V+Ruff9qDa MhUEMO1rAgjnY/02/tU+qSUS0yL137LR2Q2zcrR1HAfnZLQgsSidsbL2u70DCdOUvlhFr96p5b5 j7T6wNjDO5HvUt/DuUnJBhoK779Uii9zHAEJoxJvWd9uwVMRAvE3shsl32O9docivyWMh1roMgT b78VW42g21zdZxs7j2YUXud08raTVD8SYbSt3P4wbUy2rODDqclkZvn0fZc18gm08omuPY0SI+/ Nu5pxCisJ2oMgMNghjOmZthbfFKkVB+1Bs2QVFGaaSxEVIZ/GsXk2gGRG0g3AX5O+uwk1gIgbDO Q12a9/0MPdGaC7uDxXYH7y7eRMXJ73yLIZTC2uX71feSbQUJLlW2pFqPrhgMIqdCmevs9oN6fQi zEeq13PBO8wuXpn7AVY+kxyVzPrThwi+KbgbD6l7droMbDKXSs7YHZ0xNkQGRiga9XXVUmEBeN1 a95EqUE2De0B7RidRQUCZHy7kIEaxuCwY7h+gV7WaWYbFNl3wuOPYQNLN/MOWg5qOqx4z6LknUO z755PVVtrgmTcIpEb9M4EpQOw32HbsfmGrL5a4S97EksDGuPg02OBSfxA4XeBXqa7E7I12i3IGR B6CkhPqoDOLPAlw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We should return -EINVAL if the user specifies LSM_FLAG_SINGLE without
supplying a valid lsm_ctx struct buffer.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index 9c63acded4ee..67ded406a5ea 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3923,9 +3923,9 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 		/*
 		 * Only flag supported is LSM_FLAG_SINGLE
 		 */
-		if (flags != LSM_FLAG_SINGLE)
+		if (flags != LSM_FLAG_SINGLE || !uctx)
 			return -EINVAL;
-		if (uctx && copy_from_user(&lctx, uctx, sizeof(lctx)))
+		if (copy_from_user(&lctx, uctx, sizeof(lctx)))
 			return -EFAULT;
 		/*
 		 * If the LSM ID isn't specified it is an error.
-- 
2.42.0

