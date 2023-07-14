Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0AEB64DC
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjGNSxp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGNSxp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:53:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A135330F8
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:53:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so33903221fa.1
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689360822; x=1691952822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xj2s60J3+h8i7urGmsuDKVcid5xQo6YFvIMFhXiJJKo=;
        b=fvKWT2eEAGHi0Plve5tHh4mhYu6h+EYS/S551Zmngr1O/jrKGcIjua8uUPWlmTne3A
         +/9sDExq+LK/aOVfTzH7XS23Bf+/OPPJgIWKYMX84Vt909d4x4pieK3/YtadCWGLSFzc
         zA8YBU0ZAKpFoYa8cGC51C7Oy0yCN5EJluLQZRhjXxRRMd8b0l+Z+VAm+L7t5xJxKIBo
         i8L+ir0AdoEn/JM25jwEogCLvYTcTQefx+ulsDzHyqmHvOwmjM9bIV+aEDW73SV+27pl
         mClxTJTssoDyZ4FahMdrpgEBpXCHrjkghTd1knfCTqV6ZRdIlQNQUOAfdAa+9FPxn7Ww
         VZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360822; x=1691952822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj2s60J3+h8i7urGmsuDKVcid5xQo6YFvIMFhXiJJKo=;
        b=Rpn/T+VCoVj0g8zhN7zvZhNUVcumy77SdFrqzBfXvXGXX5BDd5r0kpuNxUt9+/e4LY
         B4vhTtD4r6zxUtSUjeFCNneW3yTXQT+6X4NDgm1b1/TIq/E10GM4bybS5bThgjGpi9a/
         A0XPrh30ts2MqCC/S1jXxKNbzay7E6d4JlEVq+CKscCfnwdyr6BQLBBz1Vj4WuEAIW2F
         SZJ3o1TWV+mArcu6DkTanE1dWIkYKPfJJpA/ymm6VBqxcWuIjmmyZ/Qp644eJ4G9bMdY
         7iWibfEsORgK0cy3XLd87tQg4fZKXfu2DRto07iOHABMsc+8lhf+r238791/vqTUe5Op
         8AFw==
X-Gm-Message-State: ABy/qLbB5yr0VrGSEDdH07aoi5XlPMQmOMN+p4SyUwDU4V+STw0UipTg
        zxi5By23Em01n9eg4eHf6xOt2/qeH/FQ6A==
X-Google-Smtp-Source: APBJJlEU5l60VNI/cx3M+h0SZGzGzQn7xIW2WprUVaXqqthazAL01gowgNh8p4d0aCs3YCYNqE61lw==
X-Received: by 2002:a2e:8885:0:b0:2b4:6bc2:a540 with SMTP id k5-20020a2e8885000000b002b46bc2a540mr4976167lji.15.1689360821608;
        Fri, 14 Jul 2023 11:53:41 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id j3-20020a170906278300b00988a0765e29sm5729201ejc.104.2023.07.14.11.53.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:53:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: free potential transition tables on insertion failure
Date:   Fri, 14 Jul 2023 20:53:38 +0200
Message-Id: <20230714185338.46147-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If the insertion via the callback insertf fails, free the potential
previously allocated transition hashtables.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 99fdaa87..6c74eff7 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -715,7 +715,12 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 		}
 		datum.data = le32_to_cpu(*buf32);
 	}
-	return insertf(a, &key, &datum, p);
+
+	rc = insertf(a, &key, &datum, p);
+	if (rc < 0)
+		avtab_trans_destroy(&trans);
+
+	return rc;
 }
 
 static int avtab_insertf(avtab_t * a, avtab_key_t * k, avtab_datum_t * d,
-- 
2.40.1

