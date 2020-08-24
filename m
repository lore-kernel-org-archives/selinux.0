Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F5C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F9920838
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ivnm1/tT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHXNTB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXNS6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:18:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6097C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:18:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so11838662eje.10
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxvgtkKW4r0x00FcaoXHLfF4wc6Z9Lp/MFZ0+yWzC4M=;
        b=Ivnm1/tThjx+Hegi78vsdTLa4Wqygf70OW8eh5zhyZ8Ux7BI2hIAjYc/ycFRTkuN5v
         G41RtaVzCjtpGDGKlr1dClcjhxPqL52CIP7yET0+iitdDknUxrOYSKwpdcQ+Dd8gcwIv
         ghcnk5JcEaJGOQmX0RfRevVngzh0mExZqONQC2YGPoHqiJ7R6tBVr3D6ja97E+kvVfin
         H+xOIDSernqvIr6fdp+BfpcSSO/HPBqkMrCykdgtz541cB39nq4QD8BNOWncoVP9/QfG
         tTAjNFZaeBgxR3sVWjPaXaZVIyt8A1Uyq2pbnwIwc291YiHuYs/kngacsSPoLmnVVffK
         j2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxvgtkKW4r0x00FcaoXHLfF4wc6Z9Lp/MFZ0+yWzC4M=;
        b=ZjNBClD19ym6MRnLwIp1Y++/6FGbV62yVwlN074NRyIFaC+ihCOBahRrctKbnhUTD3
         5a1BglEkqs97/4L21pJGftAxchn3a8IQjyRXaQw9PON7mrTx9vOD0iB0gX4C+J+rMXEN
         o5AJlRY5jrzFwj6nef+z0SFcoR1Wn7HRtzsF29g4gQwRRdRmT7ziyuOK+Up1NWVAxY0f
         Q76KoqQ7Afy1ifGe3uz1FnTjtyhUvpEci7RjdIGB33+1TE4XAB+7QX8+HLK74NyscCrW
         i7ZM2ox4PxQ6GDBgubE3gD7HxKw98phXKOr/XRekdT2Bf8glhqds7wQ3VlUw3EufRiUM
         XM3A==
X-Gm-Message-State: AOAM531by7Of5T5ARgkZ91H0Gej36yuKyZOQZeQ3JoO2l5y9heqIQKcj
        DQkt9IIzAT3rpmipHIdMwJiIW1rM6EQ=
X-Google-Smtp-Source: ABdhPJyB6ncUHgMAQa++sy2Ak61H1TMlsMr6URneNzabB8vgrAnT20T+1bWAsqm8p89204E59ATYsg==
X-Received: by 2002:a17:907:41dc:: with SMTP id og20mr5723284ejb.183.1598275136436;
        Mon, 24 Aug 2020 06:18:56 -0700 (PDT)
Received: from debianHome.localdomain (x4d01ad51.dyn.telefonica.de. [77.1.173.81])
        by smtp.gmail.com with ESMTPSA id p3sm9369834edx.75.2020.08.24.06.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 06:18:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: [PATCH 1/3] libselinux: refactor wrapper in sestatus.c for safe shared memory access
Date:   Mon, 24 Aug 2020 15:18:39 +0200
Message-Id: <20200824131841.55687-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/sestatus.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 814e86ee..925e6079 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -80,6 +80,14 @@ static inline uint32_t read_sequence(struct selinux_status_t *status)
 	return seqno;
 }
 
+/* sequence must not be changed during references */
+#define sestatus_save_access(name, result)                          \
+	uint32_t _seqno;                                            \
+	do {                                                        \
+		_seqno = read_sequence(selinux_status);             \
+		(result) = selinux_status->name;                    \
+	} while (_seqno != read_sequence(selinux_status))           \
+
 /*
  * selinux_status_updated
  *
@@ -142,7 +150,6 @@ int selinux_status_updated(void)
  */
 int selinux_status_getenforce(void)
 {
-	uint32_t	seqno;
 	uint32_t	enforcing;
 
 	if (selinux_status == NULL) {
@@ -157,13 +164,7 @@ int selinux_status_getenforce(void)
 		return fallback_enforcing;
 	}
 
-	/* sequence must not be changed during references */
-	do {
-		seqno = read_sequence(selinux_status);
-
-		enforcing = selinux_status->enforcing;
-
-	} while (seqno != read_sequence(selinux_status));
+	sestatus_save_access(enforcing, enforcing);
 
 	return enforcing ? 1 : 0;
 }
@@ -179,7 +180,6 @@ int selinux_status_getenforce(void)
  */
 int selinux_status_policyload(void)
 {
-	uint32_t	seqno;
 	uint32_t	policyload;
 
 	if (selinux_status == NULL) {
@@ -194,13 +194,7 @@ int selinux_status_policyload(void)
 		return fallback_policyload;
 	}
 
-	/* sequence must not be changed during references */
-	do {
-		seqno = read_sequence(selinux_status);
-
-		policyload = selinux_status->policyload;
-
-	} while (seqno != read_sequence(selinux_status));
+	sestatus_save_access(policyload, policyload);
 
 	return policyload;
 }
@@ -214,7 +208,6 @@ int selinux_status_policyload(void)
  */
 int selinux_status_deny_unknown(void)
 {
-	uint32_t	seqno;
 	uint32_t	deny_unknown;
 
 	if (selinux_status == NULL) {
@@ -225,13 +218,7 @@ int selinux_status_deny_unknown(void)
 	if (selinux_status == MAP_FAILED)
 		return security_deny_unknown();
 
-	/* sequence must not be changed during references */
-	do {
-		seqno = read_sequence(selinux_status);
-
-		deny_unknown = selinux_status->deny_unknown;
-
-	} while (seqno != read_sequence(selinux_status));
+	sestatus_save_access(deny_unknown, deny_unknown);
 
 	return deny_unknown ? 1 : 0;
 }
-- 
2.28.0

