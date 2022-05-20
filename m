Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62879C433FE
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 13:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349697AbiETNI4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349693AbiETNIz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 09:08:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0EA1632AC
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i40so10729263eda.7
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhF+tWQjOPpI2OiFwo2RDcVdwaDVEsXYnduE/AEjPbo=;
        b=mxPx1FZGIW6FyJZ5SKMKCI+aTb9SqaiPPehpBOAWbC01Pn/w+H/588tl0/9w4XCZa2
         /f8qDuJg9B0rjGXH2pPjfiTtt/kjiZ/cYbS7BZdmonbJOfkn/8h6omqABdRytb64JWMR
         5CuBxM5PCmcUfcC/0C+al9fUnRsclLcIlHmF7bUJGLDNXy963yptK8C9AbvRqNvcULQo
         GKYeXBE6ga7QKSRHRUC1Krb8QzVa7OI/Y+paeoVov+saoL3u0IrRNcA+0T7nHmLuuPC2
         dJHTvjMf4UYpTKzgYpmUdMtxZYKxRg5j4bKXDZXxwvuBsarEF4aJKif4hlSLzgmVYSJE
         HMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhF+tWQjOPpI2OiFwo2RDcVdwaDVEsXYnduE/AEjPbo=;
        b=N8o2IcNlGdKEMeWXLzAaIyVdhwDPNkDGazJW7nDuUdDhNKKMkqa1Z1sHcyvqjzRbSH
         ptcwFd8id068iyvWLdG/INGkLB77YAD/TH7X/bUJxFUeS4BT4XrUdBO7go+PDehDIWc2
         UqwRqeWCA2lM86yqjxJp3JetGw8mQ6LS0h2wxJIhmRIbZ7zWAqC1YwWmK54TnCEDCTZD
         Ny5Ib9AUEf/7Floq2QooQqjwob1Cxt2+UIKCCwQynAD2lViTllMFn2Tm5qJl8vWSLhgs
         A6YyBvYP+cpNU1kA9/M2n7F9wCx4XikbU5UDnxQsAn2hOMUeZY5EzgUCcLlXMc83b5gY
         Lgng==
X-Gm-Message-State: AOAM530AYA7T/0NSkjosPhpX6XVESM/RxS2ybL1eS6DvpNmJZwiYpg6x
        GtPYorGSjzkAPsv1mWGdRe/EFb+Vkv4=
X-Google-Smtp-Source: ABdhPJwMr0fm6YXv492CHSEP5Qcdv9Xj03aDVArRokx5ccrNqVyZTC0ahwPoNtByfdVw4uK4rBkVWw==
X-Received: by 2002:a05:6402:27cd:b0:427:bf42:44cb with SMTP id c13-20020a05640227cd00b00427bf4244cbmr10848943ede.276.1653052132295;
        Fri, 20 May 2022 06:08:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id hs33-20020a1709073ea100b006feb71acbb3sm160154ejc.105.2022.05.20.06.08.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:08:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] libselinux: add man page redirections
Date:   Fri, 20 May 2022 15:08:44 +0200
Message-Id: <20220520130847.10958-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following interfaces are documented but do not have a redirection:

  - context_str(3)
  - security_get_checkreqprot(3)
  - security_set_boolean_list(3)
  - selinux_sepgsql_context_path(3)
  - setexecfilecon(3)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/context_str.3                  | 1 +
 libselinux/man/man3/security_get_checkreqprot.3    | 1 +
 libselinux/man/man3/security_set_boolean_list.3    | 1 +
 libselinux/man/man3/selinux_sepgsql_context_path.3 | 1 +
 libselinux/man/man3/setexecfilecon.3               | 1 +
 5 files changed, 5 insertions(+)
 create mode 100644 libselinux/man/man3/context_str.3
 create mode 100644 libselinux/man/man3/security_get_checkreqprot.3
 create mode 100644 libselinux/man/man3/security_set_boolean_list.3
 create mode 100644 libselinux/man/man3/selinux_sepgsql_context_path.3
 create mode 100644 libselinux/man/man3/setexecfilecon.3

diff --git a/libselinux/man/man3/context_str.3 b/libselinux/man/man3/context_str.3
new file mode 100644
index 00000000..f4f03a6d
--- /dev/null
+++ b/libselinux/man/man3/context_str.3
@@ -0,0 +1 @@
+.so man3/context_new.3
diff --git a/libselinux/man/man3/security_get_checkreqprot.3 b/libselinux/man/man3/security_get_checkreqprot.3
new file mode 100644
index 00000000..d59e5c2c
--- /dev/null
+++ b/libselinux/man/man3/security_get_checkreqprot.3
@@ -0,0 +1 @@
+.so man3/security_getenforce.3
diff --git a/libselinux/man/man3/security_set_boolean_list.3 b/libselinux/man/man3/security_set_boolean_list.3
new file mode 100644
index 00000000..29731efa
--- /dev/null
+++ b/libselinux/man/man3/security_set_boolean_list.3
@@ -0,0 +1 @@
+.so man3/security_load_booleans.3
diff --git a/libselinux/man/man3/selinux_sepgsql_context_path.3 b/libselinux/man/man3/selinux_sepgsql_context_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_sepgsql_context_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/setexecfilecon.3 b/libselinux/man/man3/setexecfilecon.3
new file mode 100644
index 00000000..b2e6ab81
--- /dev/null
+++ b/libselinux/man/man3/setexecfilecon.3
@@ -0,0 +1 @@
+.so man3/getexeccon.3
-- 
2.36.1

