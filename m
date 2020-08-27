Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23695C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0CA22B4D
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7+8qDfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0Q2D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:28:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727814AbgH0Q2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 12:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598545680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/hKuk8MSM0/9AtqYnSBv5byOTkW4De2zWpePM6acCuQ=;
        b=h7+8qDfJQ3lukeMpUEMa7f+hkSgOBZWk9KFI4p2D5z0AVRbsQVkB8YqZekrmjdSQ7qLX0v
        icn8F4TAMNkN9mNR43zerwqt3bfXlK9d1Lglat5Ms0vjzrWvAT3ficRhECyrk1OxtN5G8E
        3QA41bGjH9LHWkkuq08xGPXS6ToPyrw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-9Moh5Ck5MfCgNPaFHhPn_w-1; Thu, 27 Aug 2020 12:27:57 -0400
X-MC-Unique: 9Moh5Ck5MfCgNPaFHhPn_w-1
Received: by mail-wr1-f72.google.com with SMTP id 3so1711023wrm.4
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 09:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hKuk8MSM0/9AtqYnSBv5byOTkW4De2zWpePM6acCuQ=;
        b=PCuj3iis3FpuJCCi6AMuGY3GkLu852BVChRdwL7F7S9YGuODJuPk7jkkDOlpoGC/fu
         quNWvtHhnYjsAF57qt1q66BlGRO39260adAXyrj4uJ4N4FNhZ12OwhpiboLiynhE3G1h
         SVwQ/4xk6qoLRu7wYX3ZWuyTYatPHiFIrShZIWBfYvKfgqNy9CjBa2QhfnokbDWQH1V5
         CLCnVgoYLM/ykIJDrEoWtJXJc/5JDZOjSrOl2P7oZ0zs3734MaDh2S8T6x6MSV8s3olU
         NVY0cN8HCkmlikaYGU4k2JrgdHw2UjCSnPtM5TtPMKqJlgpQfWdum4TbfX87kAM5bj0O
         xbKQ==
X-Gm-Message-State: AOAM530MgSQeujS+YJPYFO32gIcsDe4G36u/Pej8sQcNeMx/cgT/teur
        pPNpiNhZkbzI7prZ2eHe9nu8EpBPw4pRdSt4Eng8Ark+lYO+LpIsGsd1VeSJZj/oHuEHnzQ4QLt
        SpTAD4y6TYaBTySbpLg==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr20137810wrn.231.1598545675702;
        Thu, 27 Aug 2020 09:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Yd3cI1K686DFzKTEJAp+wa8GWEfFSL3yz0zrjBYKXp69oENlhsGcAcRKCkHCj+eAuOZLSA==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr20137788wrn.231.1598545675373;
        Thu, 27 Aug 2020 09:27:55 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id q8sm6757456wrx.79.2020.08.27.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 09:27:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] selinux: simplify away security_policydb_len()
Date:   Thu, 27 Aug 2020 18:27:53 +0200
Message-Id: <20200827162753.2089782-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove the security_policydb_len() calls from sel_open_policy() and
instead update the inode size from the size returned from
security_read_policy().

Since after this change security_policydb_len() is only called from
security_load_policy(), remove it entirely and just open-code it there.

Also, since security_load_policy() is always called with policy_mutex
held, make it dereference the policy pointer directly and drop the
unnecessary RCU locking.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v3: rebase on top of latest selinux/next

 security/selinux/include/security.h |  1 -
 security/selinux/selinuxfs.c        | 12 ++++++------
 security/selinux/ss/services.c      | 27 ++++-----------------------
 3 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index bbbf7141ccdbc..cbdd3c7aff8b2 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -219,7 +219,6 @@ void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
-size_t security_policydb_len(struct selinux_state *state);
 
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 29567acdda214..45e9efa9bf5bf 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -415,16 +415,16 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 	if (!plm)
 		goto err;
 
-	if (i_size_read(inode) != security_policydb_len(state)) {
-		inode_lock(inode);
-		i_size_write(inode, security_policydb_len(state));
-		inode_unlock(inode);
-	}
-
 	rc = security_read_policy(state, &plm->data, &plm->len);
 	if (rc)
 		goto err;
 
+	if ((size_t)i_size_read(inode) != plm->len) {
+		inode_lock(inode);
+		i_size_write(inode, plm->len);
+		inode_unlock(inode);
+	}
+
 	fsi->policy_opened = 1;
 
 	filp->private_data = plm;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 85cfd46836c7e..8dc111fbe23ab 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2328,22 +2328,6 @@ err_policy:
 	return rc;
 }
 
-size_t security_policydb_len(struct selinux_state *state)
-{
-	struct selinux_policy *policy;
-	size_t len;
-
-	if (!selinux_initialized(state))
-		return 0;
-
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
-	len = policy->policydb.len;
-	rcu_read_unlock();
-
-	return len;
-}
-
 /**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number
@@ -3903,11 +3887,12 @@ int security_read_policy(struct selinux_state *state,
 	int rc;
 	struct policy_file fp;
 
-	if (!selinux_initialized(state))
+	policy = rcu_dereference_protected(
+			state->policy, lockdep_is_held(&state->policy_mutex));
+	if (!policy)
 		return -EINVAL;
 
-	*len = security_policydb_len(state);
-
+	*len = policy->policydb.len;
 	*data = vmalloc_user(*len);
 	if (!*data)
 		return -ENOMEM;
@@ -3915,11 +3900,7 @@ int security_read_policy(struct selinux_state *state,
 	fp.data = *data;
 	fp.len = *len;
 
-	rcu_read_lock();
-	policy = rcu_dereference(state->policy);
 	rc = policydb_write(&policy->policydb, &fp);
-	rcu_read_unlock();
-
 	if (rc)
 		return rc;
 
-- 
2.26.2

