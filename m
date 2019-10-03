Return-Path: <SRS0=hhxa=X4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69136C10F14
	for <selinux@archiver.kernel.org>; Thu,  3 Oct 2019 13:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E9920865
	for <selinux@archiver.kernel.org>; Thu,  3 Oct 2019 13:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJCN71 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:59:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJCN71 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 3 Oct 2019 09:59:27 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41B6D2A09D2
        for <selinux@vger.kernel.org>; Thu,  3 Oct 2019 13:59:27 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w10so1168048wrl.5
        for <selinux@vger.kernel.org>; Thu, 03 Oct 2019 06:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAonW3+MQnM9ZuTTSZ+/hFOui0wWJPUlTC95a7H8+BE=;
        b=Pe+K+2lux9Svy5+DNWzFJS1HLs1r6Z50m7L+9+SpJQX8jyyDttZpcjm/4GIXGbfNBT
         iLtiecgPqaBgFjYWjbUVNYJrlGBcbSn5luxCWAZfH7HGYCdAyEWsy0o9P1zOxirtHOFh
         807GKw3AXmpwde+EIgMYpwNNXqYkFnJ+6fYpms8gjFyVf/LrOijnrfgPaIm/nNdA3N9a
         cDDmXttWyEywHhcx7+poYVn2Z0TqBdr+0cCWg7I4EEVpptvI0870LnGK0Bw2zrFT0jUT
         3I3Tml7/yELuqDFKYf8GOVhuNlKS6tylMA8NEJUo4WtKWakRbvBXPaH5uV961w2B7oOY
         264Q==
X-Gm-Message-State: APjAAAWN6bPlKpJ187iNQM03ttLHMkan+VPB/hPOCZ0Zh4FTObeUr8Ad
        YgJNq6JAw2bldhw7asnMk5NrOt8QiqykHCPNDaLnJzJ6YAhozY+Y8LyjtzRUVsInyVpqAYFxxcH
        cO7vyXdZlzuD2vEoTQw==
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr6966608wmb.124.1570111165736;
        Thu, 03 Oct 2019 06:59:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybIurh1JhjuaY/n8wSNbBlTvSsM4tBwsu0f2bBDLzttaOH7iN5cozmm9qyKZgYI4nuI1ep7w==
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr6966596wmb.124.1570111165466;
        Thu, 03 Oct 2019 06:59:25 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w12sm4199559wrg.47.2019.10.03.06.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 06:59:24 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Milos Malik <mmalik@redhat.com>
Subject: [PATCH] selinux: fix context string corruption in convert_context()
Date:   Thu,  3 Oct 2019 15:59:22 +0200
Message-Id: <20191003135922.29498-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

string_to_context_struct() may garble the context string, so we need to
copy back the contents again from the old context struct to avoid
storing the corrupted context.

Since string_to_context_struct() tokenizes (and therefore truncates) the
context string and we are later potentially copying it with kstrdup(),
this may eventually cause pieces of uninitialized kernel memory to be
disclosed to userspace (when copying to userspace based on the stored
length and not the null character).

How to reproduce on Fedora and similar:
    # dnf install -y memcached
    # systemctl start memcached
    # semodule -d memcached
    # load_policy
    # load_policy
    # systemctl stop memcached
    # ausearch -m AVC
    type=AVC msg=audit(1570090572.648:313): avc:  denied  { signal } for  pid=1 comm="systemd" scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=process permissive=0 trawcon=73797374656D5F75007400000000000070BE6E847296FFFF726F6D000096FFFF76

Reported-by: Milos Malik <mmalik@redhat.com>
Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3a29e7c24ba9..a5813c7629c1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1946,7 +1946,14 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 		rc = string_to_context_struct(args->newp, NULL, s,
 					      newc, SECSID_NULL);
 		if (rc == -EINVAL) {
-			/* Retain string representation for later mapping. */
+			/*
+			 * Retain string representation for later mapping.
+			 *
+			 * IMPORTANT: We need to copy the contents of oldc->str
+			 * back into s again because string_to_context_struct()
+			 * may have garbled it.
+			 */
+			memcpy(s, oldc->str, oldc->len);
 			context_init(newc);
 			newc->str = s;
 			newc->len = oldc->len;
-- 
2.21.0

