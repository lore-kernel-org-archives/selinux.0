Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F6C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5685D2224D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRsJPlra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHXLaj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:30:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgHXLae (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 07:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598268622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YE/jK4eKX/v8UKDjgiKwa3k55ce8EcYH7DtpXZaxArA=;
        b=LRsJPlraSZuZGxRe87QOPCCktZoRJMRF3OMJ8/49x0pD/FuBg4YC9tsL0FdLyVmia27bNS
        V/+gpyWRaJSTr1ogpl0/0iyFJSoBJUJnORYUukrco3FKJQYrIgVi+rJb7Mu8pk5h2UsGD0
        mfytJ+ANkrjsAeENi4KMvrxqLwR3O9k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-GwF-bCrbNh-7NV0-Btcjuw-1; Mon, 24 Aug 2020 07:30:21 -0400
X-MC-Unique: GwF-bCrbNh-7NV0-Btcjuw-1
Received: by mail-wr1-f72.google.com with SMTP id b8so3873470wrr.2
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YE/jK4eKX/v8UKDjgiKwa3k55ce8EcYH7DtpXZaxArA=;
        b=LH9+3x6CpUbJmSPxN6laenKq04eq4wFFxgX247O2DRm/3oMJYRhXsBBRl2i3IjIpZR
         98x8GviE9bxhGRWZSP7P1GSZ+k0wCOLRq9E44nj8xfsODl6A4RvfdBsxhj2WVLeP21eb
         /0ciyBRmM9dDpS+XHLxJlbkzzztYjZSNuz8mVOf7G3SQd5SnsX287wj1GTscGdw6oJp1
         vm3NW5y6BLJthlVwhS9FGEgGO/MIm0iADicq0NLWORVxzsMIG7Tj4Xfd1wUelkWwxX0v
         lds2BoVqhq2Mx3b0U4An5qtYCHXn2TMxK/GI1zeisJOmio4XXNuIfW9tYI+Ciy1kcL98
         Lq1g==
X-Gm-Message-State: AOAM5316gvChwrmewFs1tBKX2VAV51Bdx52qi2lNpYYVTMzN/Aio00qn
        pLu3uv8f7HdtK374EfvsoL2bPwSSTcVTMSJKtOWPzVs7p6wUQr5BUDAFN3514oA3I1H1r43GobH
        feqUOO8UQjFX6R0rFOw==
X-Received: by 2002:a7b:cb19:: with SMTP id u25mr5005349wmj.113.1598268619659;
        Mon, 24 Aug 2020 04:30:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/Nu8mrM9RbArzyDbTY6Musx3YwYplNfadPgaAy2aJOgH/Nhc23+ISg9RRdPLGzsZS9ItQTA==
X-Received: by 2002:a7b:cb19:: with SMTP id u25mr5005325wmj.113.1598268619453;
        Mon, 24 Aug 2020 04:30:19 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id l1sm25092434wrb.12.2020.08.24.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 04:30:18 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] selinux: fix a race condition in sel_open_policy()
Date:   Mon, 24 Aug 2020 13:30:15 +0200
Message-Id: <20200824113015.1375857-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824113015.1375857-1-omosnace@redhat.com>
References: <20200824113015.1375857-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code to update the policy inode size is racy and inefficient. Move
it below the security_read_policy() call where we already know the
length of the policy we are returning.

Since after this, security_policydb_len() is only called from
security_load_policy(), remove it and just open-code it there.

Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h |  1 -
 security/selinux/selinuxfs.c        | 12 ++++++------
 security/selinux/ss/services.c      | 18 +++---------------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index c68ed2beadff4..2c14d4165d688 100644
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
index 131816878e503..098d012cf40d8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -403,16 +403,16 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
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
index 2c9072f095985..0745d4f3a5765 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2289,20 +2289,6 @@ err:
 	return rc;
 }
 
-size_t security_policydb_len(struct selinux_state *state)
-{
-	size_t len;
-
-	if (!selinux_initialized(state))
-		return 0;
-
-	read_lock(&state->ss->policy_rwlock);
-	len = state->ss->policy->policydb.len;
-	read_unlock(&state->ss->policy_rwlock);
-
-	return len;
-}
-
 /**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number
@@ -3847,7 +3833,9 @@ int security_read_policy(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return -EINVAL;
 
-	*len = security_policydb_len(state);
+	read_lock(&state->ss->policy_rwlock);
+	*len = state->ss->policy->policydb.len;
+	read_unlock(&state->ss->policy_rwlock);
 
 again:
 	*data = vmalloc_user(*len);
-- 
2.26.2

