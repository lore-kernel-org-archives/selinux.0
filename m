Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D31EC433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 18:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbiA0SWB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiA0SWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 13:22:00 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA85C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 10:22:00 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h25so2309990qtm.1
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 10:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GMYBa2wkZNw/5k0W3SdjmrDFNFgiOqDuw0OR0LSMqNs=;
        b=6m5CDggXByagfCoD/CVqx+3OLYH6IjNB9qBTwgSwE/raR7oBen/SI+21dpmmAyY++u
         BnFts6NF821w3styqQ++0TcKX55HOzsqnFGNXSNV6DKwCpFQW5ooaWRNeS4SPlhzR7Ik
         mjYDey82qcIpAlsB+WUvaNya07g+yqKKuPNIg3wPozIwQOGimHjK5vDa5B0vUxy+rx4r
         g/Ldmv72KnVrtEiOTbqDZo1AivLHzVzX15KO9f27Gwhh+JMsorNSB9rSkEy6Kw7xSvrI
         /FG+x0lDf4JHmrGyoLlly/OyqaZyhy37rt8kobc2BouHRSw1oMsV6dSB2YlX8OgiW8Y4
         sLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=GMYBa2wkZNw/5k0W3SdjmrDFNFgiOqDuw0OR0LSMqNs=;
        b=vwCj4kfB4tYeCCO3M+Zn+SoVPNWylQvWyoOgqXdVPg00XMKIW2yQxJsg89mquBUrb7
         MKmp1eLhB8et/n38IoGUaqm4c6xeiVGtn6FVXjPCRhK4XlGuPOwPeF9lf7M7iINotK4z
         vqetVcVvaZhcjT2wyeFJEvpuVVaTaJd4GDVwqmy4TnpaUElNfm6c7F4HXLGiKN9q9tB7
         VxzeQZ3hz9cSoi2yRMzIZvHPQXotvRU7gSlTP4sZsfoZy4B10V1hp2UsVCt0XTLLcWs0
         UdRhvOmAxDQWCszDnv6C8Ac0dL3nkISfKr8oZi3xEXicTcrzuN9LypwLLA6R1ZgJMbGm
         fn0Q==
X-Gm-Message-State: AOAM531G6jiApChuVoTACZr7uMSEON6ZKHmODXYA6Zhb+f4t6msO10ju
        R5/sQUzrAu9vdAeKZMrUmLLMHOlS2rLF
X-Google-Smtp-Source: ABdhPJwi9i5EkZb+FlMl0he0rPu1qctxsqa5V4YucsRr329EQwKI+GGShTpIftb1GWM83+v8rVJdKg==
X-Received: by 2002:ac8:7619:: with SMTP id t25mr3807383qtq.456.1643307719288;
        Thu, 27 Jan 2022 10:21:59 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id o10sm1825390qtx.33.2022.01.27.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 10:21:58 -0800 (PST)
Subject: [PATCH v2] selinux: various sparse fixes
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 27 Jan 2022 13:21:58 -0500
Message-ID: <164330771809.139041.6643670399086580972.stgit@olly>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running the SELinux code through sparse, there are a handful of
warnings.  This patch resolves some of these warnings caused by
"__rcu" mismatches.

 % make W=1 C=1 security/selinux/

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c   |    6 +++---
 security/selinux/ibpkey.c  |    2 +-
 security/selinux/netnode.c |    5 +++--
 security/selinux/netport.c |    2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 221e642025f5..0e857f86f5a7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 	if (rc) {
 		clear_itimer();
 
-		spin_lock_irq(&current->sighand->siglock);
+		spin_lock_irq(unrcu_pointer(&current->sighand->siglock));
 		if (!fatal_signal_pending(current)) {
 			flush_sigqueue(&current->pending);
 			flush_sigqueue(&current->signal->shared_pending);
@@ -2542,13 +2542,13 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 			sigemptyset(&current->blocked);
 			recalc_sigpending();
 		}
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_unlock_irq(unrcu_pointer(&current->sighand->siglock));
 	}
 
 	/* Wake up the parent if it is waiting so that it can recheck
 	 * wait permission to the new task SID. */
 	read_lock(&tasklist_lock);
-	__wake_up_parent(current, current->real_parent);
+	__wake_up_parent(current, unrcu_pointer(current->real_parent));
 	read_unlock(&tasklist_lock);
 }
 
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 20b3b2243820..5839ca7bb9c7 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -104,7 +104,7 @@ static void sel_ib_pkey_insert(struct sel_ib_pkey *pkey)
 
 		tail = list_entry(
 			rcu_dereference_protected(
-				sel_ib_pkey_hash[idx].list.prev,
+				list_tail_rcu(&sel_ib_pkey_hash[idx].list),
 				lockdep_is_held(&sel_ib_pkey_lock)),
 			struct sel_ib_pkey, list);
 		list_del_rcu(&tail->list);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 889552db0d31..0ac7df9a9367 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -164,8 +164,9 @@ static void sel_netnode_insert(struct sel_netnode *node)
 	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
 		struct sel_netnode *tail;
 		tail = list_entry(
-			rcu_dereference_protected(sel_netnode_hash[idx].list.prev,
-						  lockdep_is_held(&sel_netnode_lock)),
+			rcu_dereference_protected(
+				list_tail_rcu(&sel_netnode_hash[idx].list),
+				lockdep_is_held(&sel_netnode_lock)),
 			struct sel_netnode, list);
 		list_del_rcu(&tail->list);
 		kfree_rcu(tail, rcu);
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 9ba09d11c0f5..8eec6347cf01 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -113,7 +113,7 @@ static void sel_netport_insert(struct sel_netport *port)
 		struct sel_netport *tail;
 		tail = list_entry(
 			rcu_dereference_protected(
-				sel_netport_hash[idx].list.prev,
+				list_tail_rcu(&sel_netport_hash[idx].list),
 				lockdep_is_held(&sel_netport_lock)),
 			struct sel_netport, list);
 		list_del_rcu(&tail->list);

