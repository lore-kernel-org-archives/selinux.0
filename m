Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC36C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4E320830
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 08:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfCYILT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:11:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39569 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfCYILT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 04:11:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so8921693wrn.6
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 01:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fa4our0YlcrZvFO7MO5kkGlsUjFYadC11RfQjikggsc=;
        b=IdilX9nI/RxKAIwE8NtMAy0zt31jVL65iAFO8m8K5CUr0ZmfdLiF6BFsbT+K4+NTdG
         6BH79vwTliK+JQQJdE8OCuLtq1IWdcxblYCXEdlWBqK0lC/tZ3Gd4m54g9l92rLSYCDy
         OkTzR2bGgOX1uWZI5JGlEfXgah0MOovmojRKHRtPHg/AyqilfcFd6/E8kJo1yfS012fZ
         4Wk69lXCH+koqOWZB5DC2haeH8Jtr44B/NqrC/D4Xx6N9lAWiqytk6R8GcaM5+UmzpB5
         Q+5po7ym/TKzblLwCbY+WDDKXTL5sr3Y5dizbd1LhX2MLn1fFsN4IanK2JgHv8wDzfzu
         Gqkg==
X-Gm-Message-State: APjAAAWXkwVe9Bj2SPHNvGxnXn310Iy0JvKEwq+KIu4qGgvSqD+zbMNt
        c+VRP81b1U2Soq0pCfLP/PtGpZ5yJafiCw==
X-Google-Smtp-Source: APXvYqxknji71n63jyhOBiQr5i5CnghinobkP4OtV2j7KBZrUYyWRTQTWCbxNl95yXgApu8Qb1Mpeg==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr4057018wrs.250.1553501477575;
        Mon, 25 Mar 2019 01:11:17 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q17sm12317119wrw.70.2019.03.25.01.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:11:16 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] selinux: remove useless assignments
Date:   Mon, 25 Mar 2019 09:11:15 +0100
Message-Id: <20190325081115.19874-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code incorrectly assigned directly to the variables instead of the
values they point to. Since the values are already set to NULL/0 at the
beginning of the function, we can simply remove these useless
assignments.

Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Fixes: fede148324c3 ("selinux: log invalid contexts in AVCs")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ec62918521b1..b18a8d7c1b5e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1318,14 +1318,11 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		rc = -EINVAL;
 		goto out_unlock;
 	}
-	if (only_invalid && !context->len) {
-		scontext = NULL;
-		scontext_len = 0;
-		rc = 0;
-	} else {
+	if (only_invalid && !context->len)
+		rc = 0; /* *scontext/*scontext_len are already set to NULL/0 */
+	else
 		rc = context_struct_to_string(policydb, context, scontext,
 					      scontext_len);
-	}
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 out:
-- 
2.20.1

