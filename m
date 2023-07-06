Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED326EB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjGFOSN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjGFOSL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:18:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC8A10EC
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:18:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992b27e1c55so96422366b.2
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688653088; x=1691245088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7q9pldomPNLoca5EXmRISWWc+6C34gTaWZYGim3y7s=;
        b=YUBafwcHX8aLYhFARSc8ehpnEP5Fc58BpPeFNhbTacFq+Pv1UA6lCXRRQ6glwh0p3X
         5yw2Sk77hEt2wM16UZ4lAcKo7nM3t03j5m3UC7SnvrBYGfl7xq8FvPIv8t2SrhDAThtI
         0n8sInxmEYquHVtr+eh4/Z/NtDF31val8xflP7Z/aSUMNx4umKANbu+GDW6qM1IbODPV
         yRZZ8V2r0sCFwfBerb8Czk65fS89XT+vAOsh0WCLfmMPAMaRj5Cvlys3bkMZZa7AoX67
         +gDyjxsX0SPojMzvZNSHsgmyBK6UemCO7DSX+eR1nYXqy/YJL6snNkMrNVdWBi3JHyOh
         48cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653088; x=1691245088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7q9pldomPNLoca5EXmRISWWc+6C34gTaWZYGim3y7s=;
        b=UtWDFQPUVuR97F+HY3Eoi6iSOsJvWf2QC/kDGjo1xmAovtk1b5dHqBBwy9fwLbYiP0
         dFp5/RHVXEuwFEbkItnOull72rdVmfaMTgGOW/LNeJZID1bxwSZ3Tl+0jA2UKL2gAnse
         0NCy53siFZmB6FrOeVd7XrgqIWeyjzyQzaMT4df5s9Gzh7AvD6CEmAhBooRw++fUcK+5
         lzlr0L5DMV8ax6NwcE+2/DLqY6APjP6dxYOJ3gDbtsW8/BBVZJWbyV16nVDamvcmKW/b
         8QII61YII3djEIxmm9tJOfjpbAIl15m/iixUtifQez9BpMStRqhXshea5zQaKq1kS9IA
         fCWg==
X-Gm-Message-State: ABy/qLbJinF1YIBeoSBw5yxgGAm7v15DV/umQyKqFBSHllrgLrSVzI5u
        /4IXvz00x4YBK7FlwVUD7GOD+xJRMPybefRg
X-Google-Smtp-Source: APBJJlGuc9P41cdpwNsW+CL2PrDY2PslvT3Mlo5gEq8e1lA7iDzqA5nQSwNRhZJiAgc7KsJESvOzlg==
X-Received: by 2002:a17:906:13:b0:988:a837:327a with SMTP id 19-20020a170906001300b00988a837327amr1491499eja.44.1688653087515;
        Thu, 06 Jul 2023 07:18:07 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709063e4d00b0096a6be0b66dsm857889eji.208.2023.07.06.07.18.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:18:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] setsebool: drop unnecessary linking against libsepol
Date:   Thu,  6 Jul 2023 16:18:01 +0200
Message-Id: <20230706141801.58737-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

setsebool does not directly use any symbols from libsepol.  Any
transitional ones, via libsemanage, are available by linking against
libsemanage.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/setsebool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 4b55046c..c1440c1c 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 
 CFLAGS ?= -Werror -Wall -W
-override LDLIBS += -lsepol -lselinux -lsemanage
+override LDLIBS += -lselinux -lsemanage
 SETSEBOOL_OBJS = setsebool.o
 
 BASHCOMPLETIONS=setsebool-bash-completion.sh 
-- 
2.40.1

