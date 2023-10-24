Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4AC25B6C
	for <selinux@archiver.kernel.org>; Tue, 24 Oct 2023 21:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbjJXVjZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbjJXVjX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Oct 2023 17:39:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B28A3
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 14:39:21 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d0f945893so1871726d6.1
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698183561; x=1698788361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjTMEISiQyqSL5KoF43HD/+4pfQYcxZ2sBm71VjlMpk=;
        b=VdAQLuQXMQRy04wS5BlH+OlEbocd1N1O5tLm7p/DN6ah9TxiwsgXEFtbxDN4dPCS/5
         6d1AkMPQ0DcVnzaY/yuyVwEQ30Vc5qWbbsj4GXknsmQMCIm1vcFDJ6ndMV+fVJtzzsVB
         mvPHSNDW2gAvrpt5F8WJMI7c7jMBoGIKYiyoxzbFi1rfIVEkGZqnGKJKBcOiP8BD+JkL
         h/F3M2QiWFr44fJ+7MWX5h91dcf1lr2Yfqx7P205mJeTBM/m60I15aWXooxve+7CUhAF
         Kl/Dvw8ZvybFplvC2BLmYo+eW+2XeJVEAjdeXj9zOBo+DfZ8ARGmNjZWq/32X+vxIBbP
         j1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183561; x=1698788361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjTMEISiQyqSL5KoF43HD/+4pfQYcxZ2sBm71VjlMpk=;
        b=k/IO8ycKrAwvj3fvenY6jxAtjZUpw2Q1CjRBHBfuvtpwA/4n4azY6kIIevpTxRnk6M
         G87Y3OAwXPsMs1f7zdbM5utFIsPaZxKc0pLvK6W/P99HW+MhzbvfBNe8nARcGIVZdvpZ
         ZfkmCqEkOpIBLIjG55gtJvt8VdAG7ZG1bk1N6O+mXHpFsJ0ccYgg9PqcRzajA95xMNPk
         983YIEHbqq6JLCtz2Bs71NiS3EGMInSBd2JhSr1ZEtSPTpV4Q3pjNF2AAiqje4ztSJWe
         0jsF2j+DLUZL91d468lBIGGkCuSi8MXf6qs4LafxbOJqFPedavEyxtfuQDwzwxyfVn6I
         z9WQ==
X-Gm-Message-State: AOJu0YzBpSbY6jKINlWq8HzFxGEVHQfQ5IVxYXq/dyFZo5fdzDzZNgxx
        DwVlrLVwVcCKZTVl5gZiUmDk
X-Google-Smtp-Source: AGHT+IHOuQHns/GYhmCR03t6WsVY/oOoqhUbLX5QdnzhAK9ktwgZ0YVg7twVBLUunFkqklLULJNZZA==
X-Received: by 2002:a0c:fa0d:0:b0:65a:feb1:ec46 with SMTP id q13-20020a0cfa0d000000b0065afeb1ec46mr20501400qvn.6.1698183560677;
        Tue, 24 Oct 2023 14:39:20 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ej17-20020ad45a51000000b0065b17ec4b49sm3916793qvb.46.2023.10.24.14.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:39:20 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [RFC PATCH 1/3] lsm: cleanup the size counters in security_getselfattr()
Date:   Tue, 24 Oct 2023 17:35:27 -0400
Message-ID: <20231024213525.361332-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024213525.361332-4-paul@paul-moore.com>
References: <20231024213525.361332-4-paul@paul-moore.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; i=paul@paul-moore.com; h=from:subject; bh=bjn4ACkmuLnd0P4W632t3EraMA+01QVS8C0h2ClX7dM=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlODidDFq8xVpew9e/pzfh7bWOcq9bF2LodQJma O9/Hs9w9r2JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZTg4nQAKCRDqIPLalzeJ c1fAD/9s/boix7BEfKNfA4LbTNzZlgF6gVOl6VEENcrRBO2hy9Fd9mDEvEzWg1cNfjND/sAUoHm 4y5Iw3c4Y6ZB+CBD7gN/nwYr205ctThe7dh6qyryjEtxXkV3m1CBMJboM/VmPEp1kkDtf6etwIg FXrZ51fWish9WDE9Gzg3L1bNUZ61Qu6Na99LgtMohr2Pp9MqBBC3p5VKvoOjFt+uW1EJzi2f55O 4AcoyWxlKtvwmBMuvy8jKRJzSNVAoXYqmFWVXYyO1S9QpKaY4Ov6p/Zkmz0gEPiWmdwq6ZbzacN eZXj+a6yX6IQyX8NGcyOHo9zyeO/5QMDz4SOyii8IgLPtmCGXNSvLW/btM5lj0LagsKzEPpN6Oz 7MpLsSlG3AFJkBk9UYYBrMecZJTl+chn25H0SHBFOadgMenFk0hsuBkfvj2mQEkzBgLGytQeRVj zx6+GPeeRKELy/r8Bf/yY96UjkRBdbYyfnQqD3QMbYBP+lx5BZ78CY1YzqifEZ0723F7i3sdxu7 9Cb5q8RWGtAy+PpXphufItC19sYU5e2+hDVKKvGzIkkarYf6relzu4HYHS7jsMajagxXVnf8GvB o350djYM51dF8vrRRsQA4d+wDEkUpGd9i+BeUzYac/1JEqp0DK6AYG2v34mvOZfBp15BXatC5e7 4e0SXWYjaKupY2w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Zero out all of the size counters in the -E2BIG case (buffer too
small) to help make the current code a bit more robust in the face of
future code changes.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 988483fcf153..9c63acded4ee 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3951,8 +3951,9 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			continue;
 		}
 		if (rc == -E2BIG) {
-			toobig = true;
+			rc = 0;
 			left = 0;
+			toobig = true;
 		} else if (rc < 0)
 			return rc;
 		else
-- 
2.42.0

