Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA68C4167D
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjKINyI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINyI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:54:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC10272C
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:54:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so1388534a12.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699538044; x=1700142844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWVt1Q/KrxH4iyFm8wmAmgIwf3Ei7c4vUCToQbFYYPE=;
        b=bSZP9zSSoyq84SlzH6psv8npcmwuXlWMCIW/0ZAWFg3Aohijarfxv5LRx/KLIuAvt0
         IttOXGhNJi043TDPurXwYlEyfSsBnTqvIbHg+K8vtlgEwrLT38HTpEQuSyJovvIjRcJx
         mDr108SxueO8aBvGNlN8sJLVzsOgqUsBMooKRHif8B8stpaOmg0MxNVPFEj8nZ3KM5AS
         A5LoYrfV+/ERhaSA+2yeeJauENmN2to6Pl2JTHA7JdbQQWgpOhqzmN/RomuiNdIZxL+j
         okjYksns7cNtiG140ByJDL8RwARDLDmmJ7XI4OoPOCYHmLktg5L07sNG/OH90QPv2XEu
         bQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538044; x=1700142844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWVt1Q/KrxH4iyFm8wmAmgIwf3Ei7c4vUCToQbFYYPE=;
        b=m0LDLmSvSs3F1Cl4K6WVWDEgaRgQ5WbOZODfPNjtUd23QctfaM80I3lJgEDp5g9Sb3
         j47g4ZxFZOKMxEEimI3DiV9efDqJpdgWpcsxr5ETMSblzauvQiqJjKXS8WhYhCP/62Vo
         KRwhXIHppWukpJ4XN1Xx9et27q+HCdDv2jBS+JrZYorzdNexVHSPZUZMp3LeVEn+gmxZ
         zQeA4574j7PZ33Yay5nesCvrNp3b7+WpAeMro6iReRo/KTjvQLVH6vNCiwQZZCCOufmq
         hbvpNih5PjjbmnvEVqHXM83VcdfMSTESaCYeGgnDqIhII5xpy5qE+PWJGgRpS+cYLMJ0
         R57w==
X-Gm-Message-State: AOJu0YxKQ2vasmwrIjIL320ut9xjrHXHOPaGbwl+PshDt11NnQJ5O3G+
        MfgIIT0NcMkf/DHvYUPG9QhXh6S14p8=
X-Google-Smtp-Source: AGHT+IGta6232s+gN9jPgiRE8aM21uEyp60XbbG2qZTZ3RZS0od3DrIkYJw9kUTR58A41qre0rvm/Q==
X-Received: by 2002:a50:8acf:0:b0:543:52be:e6ad with SMTP id k15-20020a508acf000000b0054352bee6admr4439978edk.5.1699538044422;
        Thu, 09 Nov 2023 05:54:04 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id i21-20020a50d755000000b0054366251e04sm8374874edj.94.2023.11.09.05.54.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:54:04 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: update policy capabilities array
Date:   Thu,  9 Nov 2023 14:54:00 +0100
Message-ID: <20231109135400.44658-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use their enum values as indices to clarify their relationships.
Specify array size to verify it at compile time.
Remove unnecessary trailing entry, since all access is controlled by a
check against POLICYDB_CAP_MAX.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/polcaps.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index be12580a..8289443a 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -5,17 +5,16 @@
 #include <string.h>
 #include <sepol/policydb/polcaps.h>
 
-static const char * const polcap_names[] = {
-	"network_peer_controls",	/* POLICYDB_CAP_NETPEER */
-	"open_perms",			/* POLICYDB_CAP_OPENPERM */
-	"extended_socket_class",	/* POLICYDB_CAP_EXTSOCKCLASS */
-	"always_check_network",		/* POLICYDB_CAP_ALWAYSNETWORK */
-	"cgroup_seclabel",		/* POLICYDB_CAP_SECLABEL */
-	"nnp_nosuid_transition",	/* POLICYDB_CAP_NNP_NOSUID_TRANSITION */
-	"genfs_seclabel_symlinks",	/* POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS */
-	"ioctl_skip_cloexec",		/* POLICYDB_CAP_IOCTL_SKIP_CLOEXEC */
-	"userspace_initial_context",	/* POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT */
-	NULL
+static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
+	[POLICYDB_CAP_NETPEER]				= "network_peer_controls",
+	[POLICYDB_CAP_OPENPERM]				= "open_perms",
+	[POLICYDB_CAP_EXTSOCKCLASS]			= "extended_socket_class",
+	[POLICYDB_CAP_ALWAYSNETWORK]			= "always_check_network",
+	[POLICYDB_CAP_CGROUPSECLABEL]			= "cgroup_seclabel",
+	[POLICYDB_CAP_NNP_NOSUID_TRANSITION]		= "nnp_nosuid_transition",
+	[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]		= "genfs_seclabel_symlinks",
+	[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]		= "ioctl_skip_cloexec",
+	[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]	= "userspace_initial_context",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.42.0

