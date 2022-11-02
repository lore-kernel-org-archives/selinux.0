Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D06C43217
	for <selinux@archiver.kernel.org>; Wed,  2 Nov 2022 14:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKBOBq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKBOBR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Nov 2022 10:01:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77C10063
        for <selinux@vger.kernel.org>; Wed,  2 Nov 2022 07:00:48 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a27so8029242qtw.10
        for <selinux@vger.kernel.org>; Wed, 02 Nov 2022 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DhZGRX+p1iUD7EHdIOR+jbU30eqoodFG8zNguMuk9Q=;
        b=KTTp2XZR1ytVOBk7lm/+96WHszquSWcAlI2g6CUtqBW1hlzAQOZUv8KAIzg+h0qAlR
         XOaAyxVkCb5eN8wDIkuNDWSLAWqGlEiG6SmtVkJHWKh/u1XDOcpu71TAge2tcoBIMB8a
         CJ9tiSpXW72YN+cknyXzydGv096tAYVR1mYJQUduuaOLvY/R4ihW4cIvQ+RFhk5h0137
         JBlqjeKbjE/mj3ZqZgb9YT+oFd+yo9HBECv4pcbJWTdmo+C84uRNFCdrh0wPuWq13yOg
         tDMLOsqoGgTNlBzGfq7xHNpRTuz7gI478ch+hy7tbHNGHjEKEYGTjzvsmrZyrOjMuLKf
         VYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DhZGRX+p1iUD7EHdIOR+jbU30eqoodFG8zNguMuk9Q=;
        b=FTMyXl4cYRRbedhV39RACqcbKM08X0uSKkGNaLPc8OhIP0/zHEiA8tenlM3uBPQRX3
         1nryEQRJ/3dPgN0bvd2aKBXQN9siCZ+P7fWRDRbCD0LNP4NQNA+2UHfoHmlPMyA3RX/H
         CYtMIMIgOiWlxUEZYFxF/7fp56XXWS56gwV7e49fUssb6lwm8MEM03cM8p6Ob+cayPfM
         7Hf2nQQ/K1wVk4Dmt7s5nD+HqtMI4zaJfcNKCrhCo3/s49NUqzIiCgbtU7EhLkKc0ZYV
         CaZpBoBH8lYrC+5nIDwozzrMZQoEXTBokLf89VihbrbTSHK+futE9QuXZJyq6ZU0W2Js
         90mg==
X-Gm-Message-State: ACrzQf36KPyaoMEjh7Uf8j9fNa9dGFDZa9TVMz8siNq1KD3lqWyxE/It
        RaYEbVLN2zrNBZXRzlz/hcjr6tClPw0=
X-Google-Smtp-Source: AMsMyM6PcIgvPypI9jZRpE1BGOBRk3WZjlNbL8qJPo9tg/IPRnqPF1jtzRIbN8GDVeVrDhDKLe1+Pw==
X-Received: by 2002:a05:622a:429b:b0:3a5:2a82:7742 with SMTP id cr27-20020a05622a429b00b003a52a827742mr10791935qtb.524.1667397647580;
        Wed, 02 Nov 2022 07:00:47 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b006ce0733caebsm8449846qkj.14.2022.11.02.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:00:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/5 v2] README.md: Remove mention of python3-distutils dependency
Date:   Wed,  2 Nov 2022 10:00:39 -0400
Message-Id: <20221102140039.914518-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102140039.914518-1-jwcart2@gmail.com>
References: <20221102140039.914518-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the removal of any dependence on the python disutils module,
Debian no longer depends on the python3-disutils package.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 README.md | 1 -
 1 file changed, 1 deletion(-)

diff --git a/README.md b/README.md
index 74b0a0c3..f91cb7d9 100644
--- a/README.md
+++ b/README.md
@@ -81,7 +81,6 @@ apt-get install --no-install-recommends --no-install-suggests \
     libpcre2-dev \
     pkgconf \
     python3 \
-    python3-distutils \
     systemd \
     xmlto
 
-- 
2.38.1

