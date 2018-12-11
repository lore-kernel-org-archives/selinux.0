Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA54C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B3D20851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PGX9mJJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B3D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLKWp2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:28 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:41073
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbeLKWn5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568236; bh=mOH1jMGSjEQ/xFrT6GtLpC/r3huR+zGxEWp8FnuIDGw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PGX9mJJI4/vTHrdbngVq7VqBk35AWpggqE2Xj3jhfaoHm8Cn39zSn1u8mR00WZydmRW0JDsCxAtsap1Rn8JXUR/lnImxKUhJrWb0ioUx6EawKvUorVrPtBEKuuocOTHyKzXu8oVEo0T0t5rA4WTmYkf14/cJFJci5Pzzmet3bhjUlRNzdh2aN3EWE9ZKNEoLAiicvFF5Vl/g/TgVzZDfmrNMc4/HRu/+aob5caUSyQPBPRyvIwN4vwn+5wiSEyLp0Hh1GLWYOnsR20HFkuLO0ZF8RDvh9i6ivX7qVAoTcatvRF+mDJ0mivm76u9MQ22s4gcqlZLWfSmuTa+RBMvGpg==
X-YMail-OSG: Y08GeSMVM1lEc4O4lfpxZI.Exf0jvIhrm25hC4AmQIlReiW14TVtkmCRLBwk1nS
 kSCt7mAQtDCsLnqAk9hbbYyLDNo920fjTTajuJ8iUGeO.pv8tnn15wO.HjsRhB_B8Sxg6.QSd7yN
 oTPcHDDj0kFzvZ6pgDVJZRXrxiCJ3VTCHGgwQwbvsTm90lfsKJ3y.gTv.dWt74Vyyzv9VyXp8V5M
 lx9dE1d37UOTiU2qfGeTateL7SL5DPnVg1salqoK.OOMAjQwfYHG.PUORyGZS1we7IpjZ7n2j1u4
 PxYAaimmr_LR08vaCKzNFuj_6YEYJo.6EjDzDef2QNLbzOeiOhc.GdN93HUBv90v99Q1mXMs7FOU
 v.wN3EPZs5dOiCzpxFaq.tbS75HcswiaadXB8TH6vcEvSGQlefTpCZ3JNOAv2ejMOHuC3wpG7kZ_
 bJt4VJqS1IoI5lmc4xonHnK4miIJsctNqd3wgR2vg8NRk2tclfmeq7vQ4RhPLZkCreT1by97HhNg
 zVthn1d5KBFm2c.4j1BXuVzSooIgzksgN1z7GdUHB74gRoKobjaxUS75PEXE2xKYkt4ngDGrTYEQ
 rfJbY5FggyAgmaDWhDnUKHlxXez.ycbsEafbWSq3UKhFca94d.5fbkeaXeFwlJ3sp2Ixrfek48Tp
 HsD6iqbRHlAB2MrTcN7XrMsIoK0tm.pS_KmIASlyoeckqRzCvzFzWIn65fmqIGO0aRFeiZeGiheG
 RZ5kpgcEVyeCiMTIjNH73HHoyyrVdoii4CTVyqyfj0Hh0qcx4uJzL_3FHh1LYaVW5EnemWXBvP2m
 zaFX7xi6gR.Vk7CGQ38mvSn05UKTRX6d4fkFZ_YmnmnP09.h_5gwzz2gc13Zh4K5p2DLTBtUxzse
 p2YKCjtkdqKb2tkR0PignTneW3.fU.Y8vgMX_mqgiieISWj83OGhypRIS8VXMJIkZH4vP.zJN32u
 .h2x4l9G4k0Spg8U51hlU0X04dwp1SzejL5.yGcUinfb2VUsDOJ58_BpjL2dL.3CcXCmYPaKVSHR
 V_S_e8ZFT7MPs956TwfQfRB61Uuq03cxOiyGyj.aeSaNLv4CHsD3OO2Gkw9lfvSKfHYUHFI0VCeX
 F4lw1xRyWcv0G8JlA6RfL
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:56 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 24/38] SELinux: Remove unused selinux_is_enabled
Date:   Tue, 11 Dec 2018 14:43:00 -0800
Message-Id: <20181211224314.22412-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are no longer users of selinux_is_enabled().
Remove it. As selinux_is_enabled() is the only reason
for include/linux/selinux.h remove that as well.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/cred.h             |  1 -
 include/linux/selinux.h          | 35 -----------------------------------
 security/selinux/Makefile        |  2 +-
 security/selinux/exports.c       | 23 -----------------------
 security/selinux/hooks.c         |  1 -
 security/selinux/include/audit.h |  3 ---
 security/selinux/ss/services.c   |  1 -
 7 files changed, 1 insertion(+), 65 deletions(-)
 delete mode 100644 include/linux/selinux.h
 delete mode 100644 security/selinux/exports.c

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 7eed6101c791..2e715e202e6a 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -15,7 +15,6 @@
 #include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/key.h>
-#include <linux/selinux.h>
 #include <linux/atomic.h>
 #include <linux/uidgid.h>
 #include <linux/sched.h>
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
deleted file mode 100644
index 44f459612690..000000000000
--- a/include/linux/selinux.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * SELinux services exported to the rest of the kernel.
- *
- * Author: James Morris <jmorris@redhat.com>
- *
- * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
- * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2,
- * as published by the Free Software Foundation.
- */
-#ifndef _LINUX_SELINUX_H
-#define _LINUX_SELINUX_H
-
-struct selinux_audit_rule;
-struct audit_context;
-struct kern_ipc_perm;
-
-#ifdef CONFIG_SECURITY_SELINUX
-
-/**
- * selinux_is_enabled - is SELinux enabled?
- */
-bool selinux_is_enabled(void);
-#else
-
-static inline bool selinux_is_enabled(void)
-{
-	return false;
-}
-#endif	/* CONFIG_SECURITY_SELINUX */
-
-#endif /* _LINUX_SELINUX_H */
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c7161f8792b2..ccf950409384 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o ibpkey.o exports.o \
+	     netnode.o netport.o ibpkey.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
 
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
deleted file mode 100644
index e75dd94e2d2b..000000000000
--- a/security/selinux/exports.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * SELinux services exported to the rest of the kernel.
- *
- * Author: James Morris <jmorris@redhat.com>
- *
- * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
- * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2,
- * as published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/selinux.h>
-
-#include "security.h"
-
-bool selinux_is_enabled(void)
-{
-	return selinux_enabled;
-}
-EXPORT_SYMBOL_GPL(selinux_is_enabled);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 41b230d459a6..c82f11270de6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -79,7 +79,6 @@
 #include <linux/personality.h>
 #include <linux/audit.h>
 #include <linux/string.h>
-#include <linux/selinux.h>
 #include <linux/mutex.h>
 #include <linux/posix-timers.h>
 #include <linux/syslog.h>
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 1bdf973433cc..36e1d44c0209 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -1,9 +1,6 @@
 /*
  * SELinux support for the Audit LSM hooks
  *
- * Most of below header was moved from include/linux/selinux.h which
- * is released under below copyrights:
- *
  * Author: James Morris <jmorris@redhat.com>
  *
  * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 12e414394530..1a745e2f49a9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -49,7 +49,6 @@
 #include <linux/sched.h>
 #include <linux/audit.h>
 #include <linux/mutex.h>
-#include <linux/selinux.h>
 #include <linux/flex_array.h>
 #include <linux/vmalloc.h>
 #include <net/netlabel.h>
-- 
2.14.5

