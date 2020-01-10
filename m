Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E00C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FF920673
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ry66mJ96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgAJOUt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:20:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36081 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbgAJOUt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:20:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2171893wma.1
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 06:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EQIZb4sxNJObtm8wFwZgGVkS0cbUj8pEml274MjbIVQ=;
        b=Ry66mJ962MZ1gt/egxaEQ9kqU39XJy+JvLGHRpc3JKogOSQGuTHkb4DMqVMQY4DLjL
         c20iy5nGrHa68tDjO9JaBh30VKX4UC11puEY4oaKgLgIW/N3grhCtdjA4063SYjpLCaJ
         iK7TvIwyLDyz1yUCZp9tRCCwtcHo46u0aEDUrKQz58WQNHM6CQ6gRB/vKPDLjzg7BFxn
         OwR+maWiYuWmWU7a3INrYEy7Qt4w1FEwkii7rfEQYKyz0Hvha51W5ZjmxlqJeFu4ibdn
         bel5NgP/DTcT68+Jo1G4LhqOGge3KBz20ObAfN+xgDCcpfggZKNmVaWZdChCiW43mEKA
         lKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EQIZb4sxNJObtm8wFwZgGVkS0cbUj8pEml274MjbIVQ=;
        b=BajsQ+9XcfUXaOcQzDG/F5ChyOrqNBQOEHOfqan/iw5Q4trLkCwU/LA6GAYxAuVfFF
         42dxc731nCN2HRwNAZ/NCrynTVggeObhuwjfwUUwcVIGn7BOoUDSzRF1RRvepi3IG8hH
         vqNV/7q4m5082M33llTX3LxsPZeisQzgtqIyVe7j19mkr3cRDPU/8k3REICIHsbUz/wn
         DurMrTNhR6dpY5hlD/Dctnw6wCmsvY1N//tUJKMSWRJ7oHi2Fxkju//CqFdSduZmmNox
         b53Xo07COzWpKDUxIkpsu9K1YFT9gQhdtoSP1JePA2Jq9FG5ytLLtmEBN36wDNWSPtOe
         U9Og==
X-Gm-Message-State: APjAAAWJz9SjPCd3wdsh6y1JIa8qOWZa9eAicJ/SI/o5DLf2bu2Nr0a5
        G6vtKFmde8cQm32Oe+BlzsHEu0qD
X-Google-Smtp-Source: APXvYqxVlNPHqKuwkci49HUryDkwkm9rSgM8N+NJvvcJtKqGPaO/13MtNN4gbR0CS5qxUPaFAMflYQ==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr4567389wml.138.1578666047551;
        Fri, 10 Jan 2020 06:20:47 -0800 (PST)
Received: from desktopdebian.localdomain (x4d03413a.dyn.telefonica.de. [77.3.65.58])
        by smtp.gmail.com with ESMTPSA id i5sm2371577wml.31.2020.01.10.06.20.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:20:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] selinux: add policy capability for systemd overhaul
Date:   Fri, 10 Jan 2020 15:20:38 +0100
Message-Id: <20200110142038.21602-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support a SELinux overhaul of systemd by adding a policy capability.

The systemd patch can be found at
https://github.com/systemd/systemd/pull/10023
and has NOT yet been accepted.

This is just a rfc to test the water.
---
 security/selinux/include/security.h | 1 +
 security/selinux/ss/services.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ecdd610e6449..2853e462977f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -79,6 +79,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 55cf42945cba..cb50e187b181 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"extended_socket_class",
 	"always_check_network",
 	"cgroup_seclabel",
-	"nnp_nosuid_transition"
+	"nnp_nosuid_transition",
+	"systemd_overhaul"
 };
 
 static struct selinux_ss selinux_ss;
-- 
2.24.1

