Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEFC282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A96218A2
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfAYKHw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:07:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36225 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfAYKHw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 05:07:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so6036003wmc.1
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 02:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyODzxGht9RaSmgg9jGFKOJL+ty1bMeltBCvPetHwxM=;
        b=mGM/8n8gLWD9DaGnPZ3bVmmjHxzLKS9SnkRRPgPlPedwQ5egBaQo/tl4fwnxIkKXWt
         z2n39QghpS36dapJLjTJOUGD9AkZVPTNKKyxX7i/wfJqhrANNNm61qxHTjfG9RhxmvD0
         Gus6oDDKnYcYnINPy0lsCNOTU856GWKYviORs4kZFaK5P95sMSK3L3zLq4bO9JHPnYtj
         kXsrRqyZFBlrAPqjdpc7vGWwhIufSjAeKay/7151TSWGzNM9+u8pCdryJyjj8vzKo31Y
         X0I8GMnpiJF/MiJeW6E0q118u0AV0nFEA5gX69wKVMLlRe9k7KVz5NoaRvfKPDK5w9yg
         Ld5w==
X-Gm-Message-State: AJcUukcvPJqOXXv24LLuJlWnoZQSqsg0dd2JVgLkqwdgIm1TU+88DiAE
        QV51WiDau2yHoYWWdpi7C3LTzkROrzc=
X-Google-Smtp-Source: ALg8bN5huMWiGitkhfIB3L+8bi/04AUwaeb5qpByVpA/DANj5rIolcL+1Ggz6Lq8O/aM3uRVj9AATg==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr6467137wmf.115.1548410870299;
        Fri, 25 Jan 2019 02:07:50 -0800 (PST)
Received: from p600.fit.wifi.vutbr.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id v6sm89155089wro.57.2019.01.25.02.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:07:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 3/4] selinux: remove some useless BUG_ONs
Date:   Fri, 25 Jan 2019 11:06:50 +0100
Message-Id: <20190125100651.21753-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125100651.21753-1-omosnace@redhat.com>
References: <20190125100651.21753-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These BUG_ONs do not really protect from any catastrophic situation so
there is no need to have them there.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 5ebad47391c9..478fa4213c25 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1044,7 +1044,6 @@ int avc_has_extended_perms(struct selinux_state *state,
 	int rc = 0, rc2;
 
 	xp_node = &local_xp_node;
-	BUG_ON(!requested);
 
 	rcu_read_lock();
 
@@ -1134,8 +1133,6 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 	int rc = 0;
 	u32 denied;
 
-	BUG_ON(!requested);
-
 	rcu_read_lock();
 
 	node = avc_lookup(state->avc, ssid, tsid, tclass);
-- 
2.20.1

