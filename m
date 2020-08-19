Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE533C433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 10:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEF6207BB
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 10:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHSKnB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:43:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53838 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgHSKnA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 06:43:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k8LYX-0005jD-3p; Wed, 19 Aug 2020 10:42:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selinux: fix allocation failure check on newpolicy->sidtab
Date:   Wed, 19 Aug 2020 11:42:56 +0100
Message-Id: <20200819104256.51499-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The allocation check of newpolicy->sidtab is null checking if
newpolicy is null and not newpolicy->sidtab. Fix this.

Addresses-Coverity: ("Logically dead code")
Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f6f78c65f53f..d310910fb639 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2224,7 +2224,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		return -ENOMEM;
 
 	newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
-	if (!newpolicy)
+	if (!newpolicy->sidtab)
 		goto err;
 
 	rc = policydb_read(&newpolicy->policydb, fp);
-- 
2.27.0

