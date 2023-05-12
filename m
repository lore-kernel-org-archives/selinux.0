Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22978C7EE24
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjELJaM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjELJaL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:30:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475BD8
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965a68abfd4so1834099566b.2
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883809; x=1686475809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0If2pepsqik4t85PEHjhB90HWHLvXo9jxqnqdDSP4U=;
        b=P0a4u7V+4y4ySa+ALLMYkXbFLZVikIAorte0VIOezVhmSXnDTPs6SlxEWU71kEXuC3
         hDbj8WeSCagNa1bMrGUa7d/rTnxWcqeupoZ/+wy/cfLRYuOrvnRbAFW+GdMepN6ZA4Md
         /mHxt46yqxxqnzI4syugYsv88EF9Sdh9xrIwSkaPegY/vtCFydU6L3qwD0Aqa07hHcxp
         mZD+dUf9G3TrffcP7Az6NoeLsZQEpM5+xcCFHK6COLRE+CcS8AXiJx7IKkbKfHZvLtk0
         Lwv4TyMtRPrBTJ2phMjb6l4Ss6kSA8Va4cZUfsMQQsC485xrkvOob++hMLLH4lZnMKlL
         VpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883809; x=1686475809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0If2pepsqik4t85PEHjhB90HWHLvXo9jxqnqdDSP4U=;
        b=cIKf4u8tvj1LFYG69lYME2eMXrw/Way3e2VEQCNzZHOrLFW39hXxhHbAXgCWln0U8i
         xLNKGEEimMgdeNrMT8NNj239tEzTmrz/v9Q/+rgDONkt+RSEVaP435bvuI+3iNxIcx+h
         Fc0ui1DhTEoyCMsFMXKX6ve7V2PzyzY0AoIOBINmHz1rF8wIMENJAx0vBMPCk0xjjRXi
         XKsoOpkXie1U2hwDyLGOsZEIXY19amANyC8b/alUiHsp4lNSTyuSqsGTmT+0+6EoDTlV
         6jLzhEdl7dEVR3zno11VmRsfsjavmeKxkPIzXbliudb2wjXnzYl14JXY0GHTGTHL4o3u
         xE+Q==
X-Gm-Message-State: AC+VfDzce7WJLEzeEMkfwEdL7HZb53qLujnxQAAglnc2C7MsycoSLbOs
        d9FrGPwL5xonz/aItx+25uhgEeChTh6uBQ==
X-Google-Smtp-Source: ACHHUZ6nYuBHQ/uIiZjiFSJz4C6yfbRFIH04wv4EMe6dpDQ8k/T0RdM/XeKL9Qr95EC6u6nI24fmYw==
X-Received: by 2002:a17:907:2d0c:b0:966:5c04:2c5a with SMTP id gs12-20020a1709072d0c00b009665c042c5amr16945747ejc.69.1683883808576;
        Fri, 12 May 2023 02:30:08 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id tc19-20020a1709078d1300b00969f2d5267asm4636356ejc.114.2023.05.12.02.30.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:30:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/5] libsepol: validate: check low category is not bigger than high
Date:   Fri, 12 May 2023 11:29:59 +0200
Message-Id: <20230512093001.49208-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512093001.49208-1-cgzones@googlemail.com>
References: <20230512093001.49208-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index e0d290ff..b34f83ec 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -545,6 +545,8 @@ static int validate_mls_semantic_cat(const mls_semantic_cat_t *cat, const valida
 			goto bad;
 		if (validate_value(cat->high, cats))
 			goto bad;
+		if (cat->low > cat->high)
+			goto bad;
 	}
 
 	return 0;
-- 
2.40.1

