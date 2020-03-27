Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9BDC2D0ED
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277B120B80
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0RoG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:44:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36383 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0RoG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 13:44:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jHt1X-0001ZM-8m; Fri, 27 Mar 2020 17:44:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: clean up indentation issue with assignment statement
Date:   Fri, 27 Mar 2020 17:44:02 +0000
Message-Id: <20200327174402.351334-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of e->type_names is indented one level too deep,
clean this up by removing the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/selinux/ss/policydb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 932b2b9bcdb2..70ecdc78efbd 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1219,10 +1219,9 @@ static int read_cons_helper(struct policydb *p,
 				if (rc)
 					return rc;
 				if (p->policyvers >=
-					POLICYDB_VERSION_CONSTRAINT_NAMES) {
-						e->type_names = kzalloc(sizeof
-						(*e->type_names),
-						GFP_KERNEL);
+				    POLICYDB_VERSION_CONSTRAINT_NAMES) {
+					e->type_names = kzalloc(sizeof
+						(*e->type_names), GFP_KERNEL);
 					if (!e->type_names)
 						return -ENOMEM;
 					type_set_init(e->type_names);
-- 
2.25.1

