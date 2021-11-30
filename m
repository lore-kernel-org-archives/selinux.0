Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE1C433EF
	for <selinux@archiver.kernel.org>; Tue, 30 Nov 2021 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhK3LEI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbhK3LEH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Nov 2021 06:04:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62304C061746
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 03:00:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l25so84772053eda.11
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 03:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7IOqjmAU12ht+0Jf9A6Yl19HIuCPJ0kOBFBCNewniWY=;
        b=MjSclXZhEvTuR1iMrOa1f1SrBT0QFTNYygco68mTe8PjOQicWkPIf6tnjhGhErUVJl
         lM9zsVzDKtkFay5y0IpKAUKrm91DA4LEMGIQbE+4vUVEUlGlB4Ir7eAMWZJBXTDYeyBB
         OGMUbg0ekbZkoSwRkMjmmy83ezT6m+LxG8fvuK4BezBvoqsbhMvAJ1kfI42V5VJYHxfe
         Fr5XNffWBj2K9k/GsHivEnNj9zduRmrL1It9miDjJoDV8Z8lk2rEcarmvk86CfnuFEti
         YKMFikQhw9Ha7WcXB/mHmjltJJldYml0OURyh0cr59WfGSQl5gfk8plvO7PMWwv60g1k
         Q2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IOqjmAU12ht+0Jf9A6Yl19HIuCPJ0kOBFBCNewniWY=;
        b=aAkMpQl1jDsRTCg/sYfswz7K3Z29xcdhKlDv2Wa42Bg00mDVZcpFW5fGkxL2woBFqp
         lMYMloGfxVrtgzjjzgqBiJpXkeTWvCs82sQF1Mnl06WD992Pee7HQVf35AY4ZliOiVzK
         vsDH4qroChjAIHmM97srSgVtonCQh7Jk6y30xVF9UFwTZjDOexvKfSPWPkvKPsJCc/zj
         cp/aiJ4cL4ZUm61xb7IuH/vUmN8yjpnX9VUAWxMwkX9qar4rgyps/bb28KlwXtfxVzLi
         MKCRJZ0lUJu7qmNwl0GbJNJuO7h7DWa5IEVGsIQ017hbgqXXdlPUgJSrIe+6TD5cXR60
         1GMA==
X-Gm-Message-State: AOAM533FD9ZDvo+3cqWfexpB2nCxfVcwCubUFE4tqdj6b4RqJYb0BvmU
        PlDEjHUf4TQtAD8Z5ekhvD//Q/l9SmU=
X-Google-Smtp-Source: ABdhPJyovR56ucDeySN4uHKfFpsRl4EmZxk36OaADj+mA0/ntfrTQX9k+eQIq2imqga+tbZBxkJJFQ==
X-Received: by 2002:a17:907:8a1b:: with SMTP id sc27mr68131340ejc.572.1638270046979;
        Tue, 30 Nov 2021 03:00:46 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-061-070.77.3.pool.telefonica.de. [77.3.61.70])
        by smtp.gmail.com with ESMTPSA id q7sm10847880edr.9.2021.11.30.03.00.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:00:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] checkpolicy: warn on bogus IP address or netmask in nodecon statement
Date:   Tue, 30 Nov 2021 12:00:34 +0100
Message-Id: <20211130110034.12920-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211130110034.12920-1-cgzones@googlemail.com>
References: <20211130110034.12920-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Warn if the netmask is not contiguous or the address has host bits set,
e.g.:

    127.0.0.0 255.255.245.0
    127.0.0.1 255.255.255.0

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d3eb6111..b2ae3263 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5290,6 +5290,14 @@ int define_ipv4_node_context()
 		goto out;
 	}
 
+	if (mask.s_addr != 0 && ((~mask.s_addr + 1) & ~mask.s_addr) != 0) {
+		yywarn("ipv4 mask is not contiguous");
+	}
+
+	if ((~mask.s_addr & addr.s_addr) != 0) {
+		yywarn("host bits in ipv4 address set");
+	}
+
 	newc = malloc(sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
@@ -5325,6 +5333,40 @@ out:
 	return rc;
 }
 
+static int ipv6_is_mask_contiguous(const struct in6_addr *mask)
+{
+	int filled = 1;
+	unsigned i;
+
+	for (i = 0; i < 16; i++) {
+		if ((((~mask->s6_addr[i] & 0xFF) + 1) & (~mask->s6_addr[i] & 0xFF)) != 0) {
+			return 0;
+		}
+		if (!filled && mask->s6_addr[i] != 0) {
+			return 0;
+		}
+
+		if (filled && mask->s6_addr[i] != 0xFF) {
+			filled = 0;
+		}
+	}
+
+	return 1;
+}
+
+static int ipv6_has_host_bits_set(const struct in6_addr *addr, const struct in6_addr *mask)
+{
+	unsigned i;
+
+	for (i = 0; i < 16; i++) {
+		if ((addr->s6_addr[i] & ~mask->s6_addr[i]) != 0) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 int define_ipv6_node_context(void)
 {
 	char *id;
@@ -5376,6 +5418,14 @@ int define_ipv6_node_context(void)
 		goto out;
 	}
 
+	if (!ipv6_is_mask_contiguous(&mask)) {
+		yywarn("ipv6 mask is not contiguous");
+	}
+
+	if (ipv6_has_host_bits_set(&addr, &mask)) {
+		yywarn("host bits in ipv6 address set");
+	}
+
 	newc = malloc(sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
-- 
2.34.1

