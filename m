Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67678C433E3
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A442075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQYh64yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHZOF0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:05:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726763AbgHZOFW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598450720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+s6uiJQMkK1JRqK55TUXmwD7WclQNed8wLU6Nw1EONE=;
        b=ZQYh64ybcFz0ggizVzBVAw19/9KgU3JHrOnCNUfBidezxE2uubt/ECvuFYf2Td0+YwxDVI
        NLK9HPgo6Uvr2l95AmyWjTeYFrccLFIguIbQbSff7Hx3oyEKWVvkd55SCMejb9+UvzhgqQ
        /JTfit+ZOAmWlbW4D4xSUKX+NoQHQsA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-O-J3oDCnNt-u7avASEmstw-1; Wed, 26 Aug 2020 09:59:10 -0400
X-MC-Unique: O-J3oDCnNt-u7avASEmstw-1
Received: by mail-wm1-f70.google.com with SMTP id p184so804078wmp.7
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+s6uiJQMkK1JRqK55TUXmwD7WclQNed8wLU6Nw1EONE=;
        b=X/E+eecoIsQHBqhhYbMiMQynXtNNrATNEFzfE0UwXdNbdiZ7gdMfJVQpph0KeCwKaR
         hC00uXQfqd/YkFrX1ed1s0wMGREbuSMzLgQmsKvhVZdodiTTig2hAaahg2lYGghEVnJO
         KX6EcEXv1Zn/Z8s4oE6fdQOQNtR0wyB9kaTDa+NfP4FdIyqJOiC8+ofgrQcmUEQ69HEO
         JGBYSKYq/oQdKlE8WrvFiOv/KCPZxLHzEvO/TIPYgpVNAs5dZ3tyoRYChJwNEj49HB++
         MJb9UXjki3YalRXFDupz6cqvxMyrEOm/kjpuFyqitXy91wsK7YEf5nXf2yGa8f6FZpMM
         Mv/w==
X-Gm-Message-State: AOAM533exvLjhMdbnf5FBxSUU2sjX3diWIYOS4wvRkecxcByRdeZJgn+
        uk+mjmNfxdWdB0XxaLchcHutuazdpbzHT5UixAaenH72UxSBEF36jWjDKIiUMjlesaSQdFVYwWW
        5d7ryXNv0Kvi+FNZCIw==
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr7792036wmi.177.1598450349097;
        Wed, 26 Aug 2020 06:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzhF6VROxhTtu0r31ScTKYKjrgU0fAFvKV5NmrA7+7y+QAW+LYviqM38kdzpbde6it3TzJcA==
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr7792014wmi.177.1598450348874;
        Wed, 26 Aug 2020 06:59:08 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id y24sm5622325wmi.17.2020.08.26.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:59:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/3] selinux: simplify away security_policydb_len()
Date:   Wed, 26 Aug 2020 15:59:04 +0200
Message-Id: <20200826135906.1912186-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826135906.1912186-1-omosnace@redhat.com>
References: <20200826135906.1912186-1-omosnace@redhat.com>
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

Also, since security_load_policy() is always called with fsi->mutex
held, make it dereference the policy pointer directly and drop the
unnecessary RCU locking.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h |  1 -
 security/selinux/selinuxfs.c        | 12 +++++------
 security/selinux/ss/services.c      | 32 ++++++++---------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 505e51264d51c..839774929a10d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -218,7 +218,6 @@ void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
-size_t security_policydb_len(struct selinux_state *state);
 
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d1872adf0c474..fc44c4b8c0692 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -417,16 +417,16 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
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
index 8381614627569..7cc2f7486c18f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2331,22 +2331,6 @@ err:
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
@@ -3912,11 +3896,17 @@ int security_read_policy(struct selinux_state *state,
 	int rc;
 	struct policy_file fp;
 
-	if (!selinux_initialized(state))
+	/*
+	 * NOTE: We do not need to take the rcu read lock
+	 * around the code below because other policy-modifying
+	 * operations are already excluded by selinuxfs via
+	 * fsi->mutex.
+	 */
+	policy = rcu_dereference_check(state->policy, 1);
+	if (!policy)
 		return -EINVAL;
 
-	*len = security_policydb_len(state);
-
+	*len = policy->policydb.len;
 	*data = vmalloc_user(*len);
 	if (!*data)
 		return -ENOMEM;
@@ -3924,11 +3914,7 @@ int security_read_policy(struct selinux_state *state,
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

