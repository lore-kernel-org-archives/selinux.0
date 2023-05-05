Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E20BC77B75
	for <selinux@archiver.kernel.org>; Fri,  5 May 2023 22:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEEWs6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 May 2023 18:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjEEWsi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 May 2023 18:48:38 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AF5262
        for <selinux@vger.kernel.org>; Fri,  5 May 2023 15:48:37 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7515631b965so1209112885a.0
        for <selinux@vger.kernel.org>; Fri, 05 May 2023 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683326917; x=1685918917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODHCrY40kgxP/HaeirIbzlu6Q9y/CnxeC9GjAbPHNqk=;
        b=bsZFsYbK06gwTFCkNisPK90A7kc9Ks7zrel/1JaAtJ3tLDinpdCceYZNIwzuxYjuyL
         w7Lk29G86GDxcgAR0iflt8tyF3PSUSppZAhIJ2BYpMD3UqdusgKZvuJY7XeU4GjGgZ1r
         SPPxkmz98fib1lQguX9Qb2P2hBQCSTgP3s7E9wc5PUTMgZgBFRpDrHeBWIkwFLCtgqsp
         273MP8hsdhxxymzNEQZtDY7lXjm/F1KQqiHGntyLj8tt3WGQkAkZnjjTBeGfJZTLEhOs
         Bx593b0w2j6VQL1HyWYBWA7BTddXs5Bh7rAiVKXL3fMjUayh/YB34rfNEzPkIAuBoEgJ
         L8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326917; x=1685918917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODHCrY40kgxP/HaeirIbzlu6Q9y/CnxeC9GjAbPHNqk=;
        b=WD6RUcclbJtHxWQOBrTdYSIdwvxAN62TO5vCZHnlMaSjVyk3J9nTuLDEykvbnuLwRu
         bi4PfkUBtqPhw+4uBRbGrKDPiUXkeZuoRL88XNAFgftOwD7xA4HrXHpaWsOMEF3rSKst
         jE0siWTzE5fGkVUNFbCZbmnPZebPiLZk2L2Wo85CWZbZVS54/L/aQ4AvU1hI5hFpUv35
         DRyYRl096uP0rM7H81FUZoNg4lBNYa1J+IdA26qEEjNt7OIbDiZXsDvu8soWTEDxFWq2
         pMehb+N78s6nURxX5B66pGxSmXDCBCSNiWijW8igxqPdoaNiLAscx93Kzgg18iwGfkqR
         wJVw==
X-Gm-Message-State: AC+VfDw7YdkMoAw+S3zIFGTX6mzq4DyFDNDxbgwqDyBv6Bfwa6OLOnrz
        toVrYrpa04bI6zluYJN3fGCj44dqA8/45RiCQQ==
X-Google-Smtp-Source: ACHHUZ6CIq6K1DzatgPooA2PErvVuVNwmEsO9B691/ZVANTvpUW0mLXaPcbKErti06kBgi9xncB7Cg==
X-Received: by 2002:a05:6214:242c:b0:572:636d:626a with SMTP id gy12-20020a056214242c00b00572636d626amr5091635qvb.25.1683326916762;
        Fri, 05 May 2023 15:48:36 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id z9-20020ad44149000000b005f4964785b1sm944308qvp.0.2023.05.05.15.48.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:48:36 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: more Makefile tweaks
Date:   Fri,  5 May 2023 18:48:35 -0400
Message-Id: <20230505224835.644278-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A few small tweaks to improve the SELinux Makefile:

- Define a new variable, 'genhdrs', to represent both flask.h and
  av_permissions.h; this should help ensure consistent processing for
  both generated headers.

- Move the 'ccflags-y' variable closer to the top, just after the
  main 'obj-$(CONFIG_SECURITY_SELINUX)' definition to make it more
  visible and improve the grouping in the Makefile.

- Rework some of the vertical whitespace to improve some of the
  grouping in the Makefile.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Makefile | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 0aecf9334ec3..ab8c3093d5fd 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -5,26 +5,25 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
+ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
+
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
 	     netnode.o netport.o status.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
-
 selinux-$(CONFIG_NETLABEL) += netlabel.o
-
 selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
-
 selinux-$(CONFIG_IMA) += ima.o
 
-ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
+genhdrs := flask.h av_permissions.h
 
-$(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
+$(addprefix $(obj)/,$(selinux-y)): $(addprefix $(obj)/,$(genhdrs))
 
-quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
-      cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
+quiet_cmd_genhdrs = GEN     $(addprefix $(obj)/,$(genhdrs))
+      cmd_genhdrs = $< $(addprefix $(obj)/,$(genhdrs))
 
-targets += flask.h av_permissions.h
-$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
-	$(call if_changed,flask)
+targets += $(genhdrs)
+$(addprefix $(obj)/,$(genhdrs)) &: scripts/selinux/genheaders/genheaders FORCE
+	$(call if_changed,genhdrs)
-- 
2.40.1

