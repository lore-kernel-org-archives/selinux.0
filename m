Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAFFC433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6640F60ED3
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 18:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhJSSSW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhJSSSW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 14:18:22 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD4DC06161C
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 11:16:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o13so525563qvm.4
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dXghIocfAF3wOhpknZLUZlQYNFlP3or4qdCZ7nfofW8=;
        b=C7on2hZmOo0cDAClw3++FkmzPvIPHzS9xX6fM7jboKq10e58p1eIIeIBfBkW4tHqi9
         byGMmBOTDb4X/mplOzNYYnci3LmhkI9pZ76kFhTCS67j9/TwcoN6zC6ZmxNFxomCi64G
         KslmEveIV9zQ17wUNW3c3zdGmDKnKutJp+6dewVdt2ZNX5Om8L7GsPBoRN2WWQPX0aZ3
         tJtwQ3An/bEOzUPAisA4chfgXQKiMhZlCwnRKhYKRp70jWXeaa6+tTvZcTmXUMK4XPsu
         /Ei5GWewUbOd6hyV1wk4k9Llgr4eDH0IU3w+3r96E1AoauaJXxnFFtVatybM7Puj1XeN
         Icog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=dXghIocfAF3wOhpknZLUZlQYNFlP3or4qdCZ7nfofW8=;
        b=jYG02MgldfEqRioU8xkuIFy0TnsbMHfKDsfE0IgAX/xMXryKlwv+WCJsykmkJYF5cR
         WoTQD33V9JuYTCz8VtT4ulyKWq+bxPNXLAXVyZVtlCqe3ukqqp3TQK58BFbW5VBuOE8Y
         Rd+hSuLAtQG2S8uLZBCpdkWRVXKu3q4MN/9gjkShaCUSZEraHqmRwg+lLYgrptjy1Oev
         Ry4TxnB92AR6KoV1F5PX5MlMs11fo3pe1uqGMEPSIJtA/TCxcnXuIYbm6/fQcw1xqzWk
         ZwsQebmghLu1nM3lV+C5fdXnlbLKx/Qhx7JAX66qfu/0sq51VE/M6il+gC3f4Y1qqZtV
         iV3A==
X-Gm-Message-State: AOAM531GcIcyWxZSTyLxyiFdZSmTxlqMMVZQBjzulzy5bqaPZh9xFgQ7
        BdRC8XJaUJYfTVVwNLonEC9i3gBAd/1P
X-Google-Smtp-Source: ABdhPJzA9U4Ua0F1exBDBHHX91aVD1WsoZLi4m9ttXEwNHdWso+3pICyasX0HTdRsaaEIZywobUP2A==
X-Received: by 2002:a05:6214:154d:: with SMTP id t13mr1594305qvw.40.1634667368045;
        Tue, 19 Oct 2021 11:16:08 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id bk7sm6687444qkb.72.2021.10.19.11.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:16:07 -0700 (PDT)
Subject: [PATCH] selinux: fix a sock regression in
 selinux_ip_postroute_compat()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Date:   Tue, 19 Oct 2021 14:16:06 -0400
Message-ID: <163466736648.20044.16531188246866586566.stgit@olly>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unfortunately we can't rely on nf_hook_state->sk being the proper
originating socket so revert to using skb_to_full_sk(skb).

Fixes: 1d1e1ded1356 ("1d1e1ded13568be81a0e19d228e310a48997bec8")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b4a1bde20261..6f08cd2fc6a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5778,9 +5778,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct lsm_network_audit net = {0,};
 	u8 proto;
 
-	if (state->sk == NULL)
-		return NF_ACCEPT;
 	sk = skb_to_full_sk(skb);
+	if (sk == NULL)
+		return NF_ACCEPT;
 	sksec = sk->sk_security;
 
 	ad.type = LSM_AUDIT_DATA_NET;

