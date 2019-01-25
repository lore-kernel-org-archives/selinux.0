Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F44C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FF0218A2
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfAYKHu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:07:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37223 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfAYKHu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 05:07:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so9632403wrt.4
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 02:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLvIX/eHSfIOuaUDcW5+tFt8JBlGohA0LcGVV1V+IIs=;
        b=OONPHPPBapw1Jp+WCSegbkIhKRC8xSejPvRn67s5VcGcDkaQRmrcCbVczaV9ofjk9N
         SKgbpH4tjs/x+OWaEkUDJcgLOyHDJpovDkrRTEk7/HrI9M0lTxg9t4HBM/7MLqOilHr7
         zUFOwPcyyjGGiD2F6ieeywyFcOnFSrQaVAo2IKAilxd1Dc0H0m8u2LsAZITNAdBZiVv3
         xYTh6xXI3h7WKdKNuG2aecNKEfg7jEuoh2pRUg174/DB3Z5u1bz6XT36inZcWE8JvdCG
         xZeCwOBTh2UvuOVFQ+EVqHY2yGDknp5ut5aC1Pc+8VKIB9dyOyBGgMf1XDNNHGqDUKv6
         rC2Q==
X-Gm-Message-State: AHQUAub5l0WhgM2VbZkSQwjvhdaYPP1iTUIuHDrlblGOFDi8t1kbUAX+
        YQH85EQ1xirozrjsJ34nc8MfdQu7JOU=
X-Google-Smtp-Source: AHgI3IbLt60IATQHVJtEChA+cQ/8NLkLVsBFHR3DoFrhQFseLG9Kl2A/unO2R1WfZGWgkg/k9W9dzw==
X-Received: by 2002:adf:ef88:: with SMTP id d8mr1770057wro.163.1548410868234;
        Fri, 25 Jan 2019 02:07:48 -0800 (PST)
Received: from p600.fit.wifi.vutbr.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id v6sm89155089wro.57.2019.01.25.02.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:07:46 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 2/4] selinux: replace some BUG_ON()s with a WARN_ON()
Date:   Fri, 25 Jan 2019 11:06:49 +0100
Message-Id: <20190125100651.21753-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125100651.21753-1-omosnace@redhat.com>
References: <20190125100651.21753-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We don't need to crash the machine in these cases. Let's just detect the
buggy state early and error out with a warning.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 502162eeb3a0..5ebad47391c9 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -678,7 +678,6 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
 		return;
 	}
 
-	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
 	perms = secclass_map[sad->tclass-1].perms;
 
 	audit_log_string(ab, " {");
@@ -731,7 +730,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 		kfree(scontext);
 	}
 
-	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
 	audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
 
 	if (sad->denied)
@@ -748,6 +746,9 @@ noinline int slow_avc_audit(struct selinux_state *state,
 	struct common_audit_data stack_data;
 	struct selinux_audit_data sad;
 
+	if (WARN_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map)))
+		return -EINVAL;
+
 	if (!a) {
 		a = &stack_data;
 		a->type = LSM_AUDIT_DATA_NONE;
-- 
2.20.1

