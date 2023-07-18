Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4063EEB64DD
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 17:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGRROY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGRROW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 13:14:22 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC62199
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 10:14:21 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5657d8ecdd3so3855133eaf.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689700460; x=1692292460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mw2sDHVFDNpe+4vRJTcmp2y/x9GGPO1Meq2LVLFYL5s=;
        b=rvxnwDZm//tRl8Apr4iGzQDkw23XWXxmP7KfXOTBEOLMrTofZABngYh9eezdxR/ymj
         +ynDTQOww+F74+jEZBwZpdipDWJXs4hgNyhSlNVS2SZ8A6r00PElzsNJgmbY24EEVIqq
         hIKDkwExCrJKGdbUOi1QXwZBJGM7fn/A9Jw8szJy9Qq5NoYtEOZj7+DzUm7ygZHt3em9
         hL70Ui1N7eVEDNZY+KIwXJX68l81DG8BcmM6HqxXC/RZIlElNhc1N6Ienuuzfl43rJjU
         QF/MeWLngdTUSV8kfo+4ajgkMIbU0eHSWne2/Msj9VM89Q4M2ieq3FmYcLJ7Pg3EJdVt
         EJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700460; x=1692292460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw2sDHVFDNpe+4vRJTcmp2y/x9GGPO1Meq2LVLFYL5s=;
        b=cgjM1H2Sf9VoTefBIBtH2d/M6qcKf2WLMvaIcXX3pNkc9KyN3yv1bQj7zXtlgsSR72
         g4uoqfHoTF5BQcwMZztfAqQ+aoOX7GJpBJsiue3OJXCVZloaeo+8XqHOUv2e90daYc/0
         OTxZhcoXNaRYpv4cFc7soWFsbe/PvRveX8WTXfa0hnPystRlXDN9wJuhhJCxJPfEtDCo
         VapPlN45gkSmFlUfsMAepmCQOXzooiJxp5GQIC+U4d/t6aA62FBoZaSOj5iVc8hkM78J
         9v1/OGp+WGr1Mmxw9BT98aT6jEOLuLaMEkkX4bl81My7PFeQYo4qx6Vpcv6+oz9LFxBa
         35+g==
X-Gm-Message-State: ABy/qLZWFodIhRKgDuOlhkzmGyn6PqkmW8ESJ7/23rM+udMJxx5fAW4B
        lrTu5/IAyUwmWX9rfywUJHhO+91S8Tg=
X-Google-Smtp-Source: APBJJlFOUU6XhcTLxaL1ITe9U6W7xz2TBpOmkmW9QpW3aLeHfgDsuDh7zUlmA0SN6bkoZ++5VW9FNQ==
X-Received: by 2002:a05:6808:13cd:b0:3a1:d3f0:32ed with SMTP id d13-20020a05680813cd00b003a1d3f032edmr18882217oiw.23.1689700460395;
        Tue, 18 Jul 2023 10:14:20 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id h7-20020ac85147000000b00403b3156f18sm788510qtn.8.2023.07.18.10.14.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2023 10:14:20 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: de-brand SELinux
Date:   Tue, 18 Jul 2023 13:13:35 -0400
Message-Id: <20230718171335.21591-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change "NSA SELinux" to just "SELinux" in Kconfig help text and
comments. While NSA was the original primary developer and continues to
help maintain SELinux, SELinux has long since transitioned to a wide
community of developers and maintainers. SELinux has been part of the
mainline Linux kernel for nearly 20 years now [1] and has received
contributions from many individuals and organizations.

[1] https://lore.kernel.org/lkml/Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/Kconfig          | 16 ++++++++--------
 security/selinux/hooks.c          |  2 +-
 security/selinux/include/objsec.h |  2 +-
 security/selinux/xfrm.c           |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 95a186ec0fcb..c275115b5088 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -1,16 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SECURITY_SELINUX
-	bool "NSA SELinux Support"
+	bool "SELinux Support"
 	depends on SECURITY_NETWORK && AUDIT && NET && INET
 	select NETWORK_SECMARK
 	default n
 	help
-	  This selects NSA Security-Enhanced Linux (SELinux).
+	  This selects Security-Enhanced Linux (SELinux).
 	  You will also need a policy configuration and a labeled filesystem.
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_SELINUX_BOOTPARAM
-	bool "NSA SELinux boot parameter"
+	bool "SELinux boot parameter"
 	depends on SECURITY_SELINUX
 	default n
 	help
@@ -24,11 +24,11 @@ config SECURITY_SELINUX_BOOTPARAM
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_SELINUX_DEVELOP
-	bool "NSA SELinux Development Support"
+	bool "SELinux Development Support"
 	depends on SECURITY_SELINUX
 	default y
 	help
-	  This enables the development support option of NSA SELinux,
+	  This enables the development support option of SELinux,
 	  which is useful for experimenting with SELinux and developing
 	  policies.  If unsure, say Y.  With this option enabled, the
 	  kernel will start in permissive mode (log everything, deny nothing)
@@ -38,7 +38,7 @@ config SECURITY_SELINUX_DEVELOP
 	  /sys/fs/selinux/enforce.
 
 config SECURITY_SELINUX_AVC_STATS
-	bool "NSA SELinux AVC Statistics"
+	bool "SELinux AVC Statistics"
 	depends on SECURITY_SELINUX
 	default y
 	help
@@ -47,7 +47,7 @@ config SECURITY_SELINUX_AVC_STATS
 	  tools such as avcstat.
 
 config SECURITY_SELINUX_SIDTAB_HASH_BITS
-	int "NSA SELinux sidtab hashtable size"
+	int "SELinux sidtab hashtable size"
 	depends on SECURITY_SELINUX
 	range 8 13
 	default 9
@@ -59,7 +59,7 @@ config SECURITY_SELINUX_SIDTAB_HASH_BITS
 	  will ensure that lookups times are short and stable.
 
 config SECURITY_SELINUX_SID2STR_CACHE_SIZE
-	int "NSA SELinux SID to context string translation cache size"
+	int "SELinux SID to context string translation cache size"
 	depends on SECURITY_SELINUX
 	default 256
 	help
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8a8a4f0f2ad..f0580e467dc5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  NSA Security-Enhanced Linux (SELinux) security module
+ *  Security-Enhanced Linux (SELinux) security module
  *
  *  This file contains the SELinux hook function implementations.
  *
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2953132408bf..8f50e8fe0488 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  NSA Security-Enhanced Linux (SELinux) security module
+ *  Security-Enhanced Linux (SELinux) security module
  *
  *  This file contains the SELinux security data structures for kernel objects.
  *
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 1fca42c4d0ae..95fcd2d3433e 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  NSA Security-Enhanced Linux (SELinux) security module
+ *  Security-Enhanced Linux (SELinux) security module
  *
  *  This file contains the SELinux XFRM hook function implementations.
  *
-- 
2.40.1

