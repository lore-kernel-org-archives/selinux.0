Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B173C77B7A
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 21:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjFAVrz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFAVrz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 17:47:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECD107
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 14:47:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f805551a19so10419671cf.3
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685656073; x=1688248073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gyEpU0GbmyaKgBzXJUuntBGux48RC0TnTpYaRLwHdGY=;
        b=HQFj6EevrXX64CtuXHGrAo2WJ1KWFrLZsQk/qQDrsTW4BbMOLdfFoEcslTaxgE5/Qj
         xgRE/JJ+1Iv/XkRuVSA83cbAb4OConyEINYKEACsFpae/CKXwgJ5LFtvJ4GJaTD1lrPB
         oxBcJxca7agAOnGf4Fh+aACHTXYcbVCfRY9JznPFW042pWGQLdodndOQEoyXkkSGVAsN
         TEmLQYqwbTxyznoc8Mi+Uvm2UUFCTRSvCla3QLNgiRGEP0mOrA9HJbepbhKDfEetceBh
         GOVJO93TgkpQkH6NpjlhHIM29Ow1vYpR2ZoC041BZPYqnOWN1brVt9lEmMPYS7ReMYeX
         OrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656073; x=1688248073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyEpU0GbmyaKgBzXJUuntBGux48RC0TnTpYaRLwHdGY=;
        b=jSabuD6LlldCkWs19kSFvH1U++WLqJ6tXdX+2ev7pgU/qkc5bosJn6quMpQ8R/0iD7
         v/ArV9f64/BBhjti+BVjYJeKuH1/HqtIYdBxDWQ0QmU7L96Brg2uuGn/7b+w/J9CMqB1
         uiVRcugIdvkRVm3+/Aa0jabhsf+v/kSbvyryDa0E/EOJZAMLR7MhSGNqc9wLPdMqhbkA
         +GVHN0+uje147znbtX+t2ilBBWwy2t5nrc/18gTVNDVmrBbndYc9RMRt+zuetSfltdMn
         y2o/2lxajOpc1G48BFaF3v9ph79h0EmbVzdtbMxxJYFLd/n9T59D71r+EuAo7c/aUeEi
         N/gg==
X-Gm-Message-State: AC+VfDxVFahiM3nGNxS3YEqMYW8KXha6OTRAKIM57hMSPlU3nq2uJLSa
        3hbs55zvjksjN+KFcVPuuKFkeELYztm9pIMIAw==
X-Google-Smtp-Source: ACHHUZ4rKFs+pnsm+6edXb7seht4MQltKRfAlxG28c1u12kmguxRXXmd8imSE3cFiDHZqV67rTba2A==
X-Received: by 2002:a05:622a:290:b0:3f5:3659:4901 with SMTP id z16-20020a05622a029000b003f536594901mr12302646qtw.20.1685656072865;
        Thu, 01 Jun 2023 14:47:52 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id g3-20020ac870c3000000b003ef33e02eb9sm8133752qtp.83.2023.06.01.14.47.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:47:52 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: fix Makefile for versions of make < v4.3
Date:   Thu,  1 Jun 2023 17:47:51 -0400
Message-Id: <20230601214751.406786-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236; i=paul@paul-moore.com; h=from:subject; bh=2ZjVpEShJFTkuhB46y7HfS4VkpgilmQDNuaXlTZiTqM=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBkeRIB5XKiIYW+s9fheRuU4Q0tACvcPL0LTUQAn nIwcJUGGnKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZHkSAQAKCRDqIPLalzeJ c9AgEACsLYMd0FWyhJ1mR+5o0mX7AFQTezZynvIiwIqEiIzSjFLyFecjB4ZkbIz+bPcQ8jqJ+zM it6Ham208crZaVd7EgacaXZCtQHPrUdlIADmn39c9j3luj3Cqr/BcQwRazTMLENLw6dxyUVGsO1 361gH+EYh/K25PIE4TyPs3umzd7i+caUzTqOkKpcAoxTpIR0UD4TxtdgGRU9+jzFKVcMYLm+Gbo FZ9A35a7LK+HJ5Opgl2dzukrBqHHB43fYdOyAJRWKn8PpDpGcKti2+2Ig7FpCVKsgL8/KYmcFql Y5L0sHcC/h+xgki/IrqvA5P1SboYNk3uBsrqtSJVJmnUtZxuqU2yC7dn9AzpOkyVi0wShXvaRq8 Hr28/ebXJFD7+XE/negXiSksoWvfNT6Sdt34lSN7+BV9W2CKtH3P9JtX76ZblyVW4tTia3C60OY EmseTEB3d/PILCgUPl8DOl0Tl9FkGq9l3wWAk/C4/muPicXM3icIY320tE7gDDjBjAdt43hUTlJ 06JOQ/rs1AMhkbF8F5QL5dOURCMg8hsMzu2tGl+sRRCCyKRINFM6CMS6vLy6xBW3DhtmjpU1Vb+ kmYCo7KjHnfGYQ6FxLUKyV1L11levKzn7xJS2iCnVzTIM0VeQ4RC2nHDVI3TsYFT55lvfl0OS6v w/KUliPAsUvPBBg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As noted in the comments of this commit, the current SELinux Makefile
requires features found in make v4.3 or later, which is problematic
as the Linux Kernel currently only requires make v3.82.  This patch
fixes the SELinux Makefile so that it works properly on these older
versions of make, and adds a couple of comments to the Makefile about
how it can be improved once make v4.3 is required by the kernel.

Fixes: 6f933aa7dfd0 ("selinux: more Makefile tweaks")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Makefile | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index ab8c3093d5fd..abf19fee09f8 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -3,6 +3,11 @@
 # Makefile for building the SELinux module as part of the kernel tree.
 #
 
+# NOTE: There are a number of improvements that can be made to this Makefile
+# once the kernel requires make v4.3 or greater; the most important feature
+# lacking in older versions of make is support for grouped targets.  These
+# improvements are noted inline in the Makefile below ...
+
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
 ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
@@ -19,11 +24,17 @@ selinux-$(CONFIG_IMA) += ima.o
 
 genhdrs := flask.h av_permissions.h
 
-$(addprefix $(obj)/,$(selinux-y)): $(addprefix $(obj)/,$(genhdrs))
+# see the note above, replace the dependency rule with the one below:
+#  $(addprefix $(obj)/,$(selinux-y)): $(addprefix $(obj)/,$(genhdrs))
+$(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
 
 quiet_cmd_genhdrs = GEN     $(addprefix $(obj)/,$(genhdrs))
       cmd_genhdrs = $< $(addprefix $(obj)/,$(genhdrs))
 
-targets += $(genhdrs)
-$(addprefix $(obj)/,$(genhdrs)) &: scripts/selinux/genheaders/genheaders FORCE
+# see the note above, replace the $targets and $genhdrs dependency rule with
+# the lines below:
+#  targets += $(genhdrs)
+#  $(addprefix $(obj)/,$(genhdrs)) &: scripts/selinux/...
+targets += flask.h
+$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,genhdrs)
-- 
2.40.1

