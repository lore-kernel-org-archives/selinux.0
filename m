Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B02CC3F68F
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B482073A
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lj9h5vUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgAPMEp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:04:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50662 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgAPMEp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 07:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579176284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+R/b/UKnif2jsCIpi0kOkImmskTCvOskBW5Z7TgPuQ=;
        b=Lj9h5vUc5n9be5iSG+unnR/harxQ+L1083qUInQ2tJaYszAip88PSx4bjZ6DNoKXJAk2Dn
        ZinZVpKSMmwumCr4TYta0RQ4qqdsEgMY8yvV2GkQ7JZDVMcz/zIL2YdYv9sVKbPyPOJ007
        JD6C0BGMyihCcJj+PecGeLvXmWaFM0k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-uzSQGkkWMdOFjxCVpkDqbw-1; Thu, 16 Jan 2020 07:04:43 -0500
X-MC-Unique: uzSQGkkWMdOFjxCVpkDqbw-1
Received: by mail-wm1-f70.google.com with SMTP id n17so528666wmk.1
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 04:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+R/b/UKnif2jsCIpi0kOkImmskTCvOskBW5Z7TgPuQ=;
        b=terGIQH5p7o4iYKFCZdOdxFQCT6YzJ3ana+yAimzzemkEaCmLmLRKXLGz1xrlWjfHU
         0dg+BQ5vBt5+u9pOKevGv9WD8+zVI2tExapD+9dT/xJIMvVxAQPukBR6VSfgvhfMytAH
         YFvF4YknDwesuS6CU5xwZK4rcahMpO3dFDq92u23HfAXbVHK/tmSVkzYSNNXeoy1Nx5h
         2VuvKWSd0nck+IiWBzIC+pR7EnWjfq5TBwEoM6bxnQf20DB0TvdMf3k5UXKQ5LIWoc/Z
         ZespM9m6H+mlX1QfA5lHc5KBJPkR6TppWDig4qySuuCHldJTKbrTWRbOGzq3OvzBn/wV
         h5vQ==
X-Gm-Message-State: APjAAAU8iEBlozmmjhnkU75qqNVOIZs7rGRR/e/uoxgVE9HwjMHsZOpG
        upb6ApGQqpmEj3XjpTiadPhj0csrrjMysxHHd6gpGaHQj8EhyO0QuFgjbCtPVhX78qcIswROjrx
        SiBfpVy4M3sd805Dkkw==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr5971724wma.103.1579176282491;
        Thu, 16 Jan 2020 04:04:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjwWIDf7AVQ1Qo+7VsEQSXtbJx+t+qH+AYFXtH0clZLgcdD1A3IfBZ1UPHJDcrP9hxwvQDpw==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr5971711wma.103.1579176282296;
        Thu, 16 Jan 2020 04:04:42 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b67sm278117wmc.38.2020.01.16.04.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:04:41 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/6] selinux: do not allocate ancillary buffer on first load
Date:   Thu, 16 Jan 2020 13:04:34 +0100
Message-Id: <20200116120439.303034-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116120439.303034-1-omosnace@redhat.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In security_load_policy(), we can defer allocating the newpolicydb
ancillary array to after checking state->initialized, thereby avoiding
the pointless allocation when loading policy the first time.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 55cf42945cba..42ca9f6dbbf4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2183,26 +2183,17 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	int rc = 0;
 	struct policy_file file = { data, len }, *fp = &file;
 
-	oldpolicydb = kcalloc(2, sizeof(*oldpolicydb), GFP_KERNEL);
-	if (!oldpolicydb) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	newpolicydb = oldpolicydb + 1;
-
 	policydb = &state->ss->policydb;
 
 	newsidtab = kmalloc(sizeof(*newsidtab), GFP_KERNEL);
-	if (!newsidtab) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!newsidtab)
+		return -ENOMEM;
 
 	if (!state->initialized) {
 		rc = policydb_read(policydb, fp);
 		if (rc) {
 			kfree(newsidtab);
-			goto out;
+			return rc;
 		}
 
 		policydb->len = len;
@@ -2211,14 +2202,14 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		if (rc) {
 			kfree(newsidtab);
 			policydb_destroy(policydb);
-			goto out;
+			return rc;
 		}
 
 		rc = policydb_load_isids(policydb, newsidtab);
 		if (rc) {
 			kfree(newsidtab);
 			policydb_destroy(policydb);
-			goto out;
+			return rc;
 		}
 
 		state->ss->sidtab = newsidtab;
@@ -2231,9 +2222,16 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		selinux_status_update_policyload(state, seqno);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
-		goto out;
+		return 0;
 	}
 
+	oldpolicydb = kcalloc(2, sizeof(*oldpolicydb), GFP_KERNEL);
+	if (!oldpolicydb) {
+		kfree(newsidtab);
+		return -ENOMEM;
+	}
+	newpolicydb = oldpolicydb + 1;
+
 	rc = policydb_read(newpolicydb, fp);
 	if (rc) {
 		kfree(newsidtab);
-- 
2.24.1

