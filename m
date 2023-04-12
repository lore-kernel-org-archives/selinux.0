Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE3C77B6C
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 23:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDLXtq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 19:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLXtp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 19:49:45 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7A5B88
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 16:49:44 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id qh25so3575993qvb.1
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681343383; x=1683935383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eec8RTrWGooOqxsajEh1YIdQn3+QpRiV8qSMJOqAsuM=;
        b=CbNu5X+ifsgpbleOS4cp8Goe2qWnq2Iy1td+g/SnFWU022Uehs7YZa0fLe+R7/V5Sa
         mgBKFUi+OKEoKUhGp5w5CW9Sq+RTroio/vFwhQXKV0gg3RkLgrrE/LPjYAFTRleiPKFk
         HKS+Lq9P8D96yTn0tsbX78dLJ+B+MkqlBD9yceEvtPzl9EHsrFdvJedA5KKMyj3IU6gW
         ydNzwrIZM3o2IXI8VDhuLFNBWD97Xxk9jdE7bSaTZZztlwCpGgJH6c+X57z11iRh9n9m
         62p2K85+F00g5lvq24EJ5N8BnhkYC901+7GyNnjtwUpzfW71RPLZg1VsZZIAuI7v9TAX
         xSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681343383; x=1683935383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eec8RTrWGooOqxsajEh1YIdQn3+QpRiV8qSMJOqAsuM=;
        b=gN/gnvGba25mllt5vmvbKhH3iMqDzVjKE0z1KV12stcaW/QFszZ1MTvTJnyJAgWWEf
         DfGkNGUKpx9cwt91eNOyxMFgakXPQzBNA8PkHNXnlxMzmPwqbqifEEKWhdEXyDoBx1G7
         eVxjJek/Sgp5w/NJKnkY7I/pUMv2x2vvHE5KKm+Us5+CvigRan5Uxe04IUfjpDy2OZ5l
         EyxuUGwDeiQZc0oqxdiPC6aejG578Uu5hfi1PF2xJa4RQN0q3YRgP21bdexr61+XkY4E
         uoAUpS+AGRtL9ehbvcEETUpEzlZEThYE3OUvudElwp6/oIVAk17ynnfAAFOzjJsTeDOq
         RP+A==
X-Gm-Message-State: AAQBX9fINQa/feq2ol9S5nclare1pqeEeIKvb2Ngh/iltnYG2xclRa8Q
        /dyuXVD6kevxzO9kSXW1W8uBYsTTVuNUpOaKtg==
X-Google-Smtp-Source: AKy350aaoh93+L5dKhpMe4U4ScNijLPz6JrwK/hEXdXZjJxlABpl48nBgKWQn47XOQmKvIzz5qSq0w==
X-Received: by 2002:a05:6214:2348:b0:5cb:ab2e:b15c with SMTP id hu8-20020a056214234800b005cbab2eb15cmr466346qvb.30.1681343383077;
        Wed, 12 Apr 2023 16:49:43 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a27d300b007486cc8a3f8sm56231qkp.23.2023.04.12.16.49.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 16:49:42 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] selinux: ensure av_permissions.h is built when needed
Date:   Wed, 12 Apr 2023 19:49:42 -0400
Message-Id: <20230412234942.533478-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The Makefile rule responsible for building flask.h and
av_permissions.h only lists flask.h as a target which means that
av_permissions.h is only generated when flask.h needs to be
generated.  This patch fixes this by adding av_permissions.h as a
target to the rule.

Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build")
Signed-off-by: Paul Moore <paul@paul-moore.com>

--
v2:
- typo fix in the description
- use grouped target
v1:
- initial release
---
 security/selinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 103c2776478a..0aecf9334ec3 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -26,5 +26,5 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
       cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
+$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
-- 
2.40.0

