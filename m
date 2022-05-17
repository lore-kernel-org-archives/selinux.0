Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A2EC433EF
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 12:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiEQMIW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbiEQMIW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 08:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4193E44775
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652789300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=73wkVNvsDU2qu0dh8f4cvnYbPAao2aaVNoEq0/PBaQU=;
        b=bHG2HRpR0kctY+eyNKybo/XDLEWSbjnTT6O8RdCe1QrCwHjvZOCSH5jAq1FiP5kq0mxBk1
        e5uPuzr1ZIWQC8qYxcGOZOC5Ma0ju5PYhXc52WFO6Z5IyjyABUXEon4XYJukH2dDfUEW6t
        UaS0YA34SapDVmJR/c6KCOMY8nGc3ZM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-93AZ93F0MNOoZYnt7JQfVw-1; Tue, 17 May 2022 08:08:19 -0400
X-MC-Unique: 93AZ93F0MNOoZYnt7JQfVw-1
Received: by mail-ed1-f72.google.com with SMTP id w5-20020a056402128500b0042aa2647eb6so5277403edv.12
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 05:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73wkVNvsDU2qu0dh8f4cvnYbPAao2aaVNoEq0/PBaQU=;
        b=a/Fx/fc8cNk7XkhL8W7ZEvmXfWFBZE8BH8dYEZMf5omipppaxdmkBACma9t7cf9Pv2
         XwsDPCGpMGt9mMijMhLSRJtgRbqfjC0aSAzgpErtoTWNTvEa2+uXBhwcDiRupEGsbdj6
         364NSwk8LKeAwoB5kFK2Xee9KDi89KwCgpOpUwCW/FV/Us6oz3FOKpZ8xwGSppyfUWA4
         WfEsi5GMQQ4X0hMApj0jlc8/zHswX6qqpNdNRAWnLy4Y6rJrNZZ/bKAeKOk3ZLQ7GQZ3
         9XA/tDgZRsgjLQWCPZS4Apah933i+qLXnVHTmFXaY3H9QDtroY3z2W26DZqwSichMIQj
         sFTg==
X-Gm-Message-State: AOAM532uET230vKMrB1pXok50/W3afZKsXGMtXoAIA7YVqRm3gA2CpyP
        JLKdeNNyFoWb3uvfL6QgEqOoloo7xMo2lqTGCiidlqK3r3n22lofhFEUhiG5rrCORzppiEkGWEJ
        LzXDxt3t9F45jY9/DiA==
X-Received: by 2002:a17:907:6d9e:b0:6f9:b861:828e with SMTP id sb30-20020a1709076d9e00b006f9b861828emr19764740ejc.427.1652789297949;
        Tue, 17 May 2022 05:08:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztryjzKYvU5MligvrvihReumD2LXI4LlkEnu7piSHj3qRZLmiTbusQvjrEe/dSqL+uSL+itQ==
X-Received: by 2002:a17:907:6d9e:b0:6f9:b861:828e with SMTP id sb30-20020a1709076d9e00b006f9b861828emr19764717ejc.427.1652789297719;
        Tue, 17 May 2022 05:08:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id fd21-20020a056402389500b0042aae3f282esm3450835edb.65.2022.05.17.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:08:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] selinux: fix bad cleanup on error in hashtab_duplicate()
Date:   Tue, 17 May 2022 14:08:16 +0200
Message-Id: <20220517120816.769108-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code attempts to free the 'new' pointer using kmem_cache_free(),
which is wrong because this function isn't responsible of freeing it.
Instead, the function should free new->htable and clear the contents of
*new (to prevent double-free).

Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
Reported-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/hashtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 0ae4e4e57a401..3fb8f9026e9be 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -179,7 +179,8 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 			kmem_cache_free(hashtab_node_cachep, cur);
 		}
 	}
-	kmem_cache_free(hashtab_node_cachep, new);
+	kfree(new->htable);
+	memset(new, 0, sizeof(*new));
 	return -ENOMEM;
 }
 
-- 
2.36.1

