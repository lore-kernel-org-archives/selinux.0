Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B70C7619A
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDLUyd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDLUyc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 16:54:32 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B111C4
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 13:54:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o7so9712390qvs.0
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 13:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681332871; x=1683924871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DH1vlduoVVUeOOw8+PW2xwWVJ+mUmqNUt4J3l2tex8=;
        b=eRkF77WRB+I4sE1eiAriLCivrSL4pL9MvqrmlDUX0AzN1kQZjO9O3HPkhs9AzKxZUf
         2zw0OeQMOw1UEcdvFX/j7FjDut8fr3q0Ag3A6teNwAcA02w2UDdqQ8xUgcTiPF+G3cur
         DfIHoqy9qA9D+cqZvQbE1lR2ObdsZEmIPdiAa2pNthOBFRJyAhPKdmGfMfvcgcOvbOIO
         QgGEoCWXTeEmXS5tJgJceOXM2N8JB47qBuxLF7qp3x59yQIMFljuA+zRLqMuOxL59Qgp
         zIiuarv1yiu73C/JnrpKUs1c3i4SSDKjEoDalKCzCB2HYeA+E7eYwJ6MN2wNSP/YKgkS
         IjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332871; x=1683924871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DH1vlduoVVUeOOw8+PW2xwWVJ+mUmqNUt4J3l2tex8=;
        b=GOeeF1BPzt7xmrgWxujxzYMnVszZIYAsxzXL5TOIgKP0PqD6aI9PVZPf6VnJl4k3Vj
         v4t5KcRFncH+nw7H0EgFOaDIWThotTY3J7pHNJxI6AW16U4qaGA9rfudwyn4V8Gn9Enn
         6hB7uPMavXewBYNtXa19SsgU2ezLGhSLI40baC7gO0b9xuyMzRKPzDAZN6GkkXv/CBkp
         6TKwTDpj2pXV7S6Z7OKfuQwREOpe8B79p6mTi/3u558ZXjoUj5jSQoMocN41guluny3n
         HXukQG5K8hUboYILDODYpr2S2Yd5nnGHbV4wexGXlqIGfCcQ/aIJGJ6u7VHdVHehLsJ4
         beNA==
X-Gm-Message-State: AAQBX9f9OOOuvYeesbZGf4UWOy8tl8Do/kFT1FtuUQ3evwjOJsZUyfpE
        ytUpngSNxYZ7LrL2BahJh55ZKJbzGthn2fLKyg==
X-Google-Smtp-Source: AKy350Y8sKvG4gbMtSb1ixTz8VOBVkiM4D3N1PUjtTaKNM4JY2MkDpSWgQo/3dpbHfJ9iOPfXXL16g==
X-Received: by 2002:a05:6214:20c1:b0:5aa:ad07:ea58 with SMTP id 1-20020a05621420c100b005aaad07ea58mr6227823qve.3.1681332870931;
        Wed, 12 Apr 2023 13:54:30 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id n2-20020ad444a2000000b005eec576e4d2sm1849010qvt.87.2023.04.12.13.54.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:54:30 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: ensure av_permissions.h is built when needed
Date:   Wed, 12 Apr 2023 16:54:29 -0400
Message-Id: <20230412205429.389382-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The Makefile rule responsible for building flask.h and
av_permissions.h only lists flask.h as a target which means that
av_permissions.h is only generated when flash.h needs to be
generated.  This patch fixes this by adding av_permissions.h as a
target to the rule.

Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 103c2776478a..df35d4ec46f0 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -26,5 +26,5 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
       cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
+$(obj)/flask.h $(obj)/av_permissions.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
-- 
2.40.0

