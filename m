Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C56C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 08:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A6C20767
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 08:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407041AbgDNIL6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:11:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407026AbgDNIL4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 14 Apr 2020 04:11:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2AD1250E5F5107F30E6;
        Tue, 14 Apr 2020 16:11:52 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 16:11:45 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <selinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] selinux: fix warning Comparison to bool
Date:   Tue, 14 Apr 2020 16:18:07 +0800
Message-ID: <1586852287-67588-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

fix below warnings reported by coccicheck

security/selinux/ss/mls.c:539:39-43: WARNING: Comparison to bool
security/selinux/ss/services.c:1815:46-50: WARNING: Comparison to bool
security/selinux/ss/services.c:1827:46-50: WARNING: Comparison to bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 security/selinux/ss/mls.c      | 2 +-
 security/selinux/ss/services.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index ec5e3d1..6a5d7d0 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -536,7 +536,7 @@ int mls_compute_sid(struct policydb *p,
 
 		/* Fallthrough */
 	case AVTAB_CHANGE:
-		if ((tclass == p->process_class) || (sock == true))
+		if ((tclass == p->process_class) || sock)
 			/* Use the process MLS attributes. */
 			return mls_context_cpy(newcontext, scontext);
 		else
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8ad34fd..3b592d1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1812,7 +1812,7 @@ static int security_compute_sid(struct selinux_state *state,
 	} else if (cladatum && cladatum->default_role == DEFAULT_TARGET) {
 		newcontext.role = tcontext->role;
 	} else {
-		if ((tclass == policydb->process_class) || (sock == true))
+		if ((tclass == policydb->process_class) || sock)
 			newcontext.role = scontext->role;
 		else
 			newcontext.role = OBJECT_R_VAL;
@@ -1824,7 +1824,7 @@ static int security_compute_sid(struct selinux_state *state,
 	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
 		newcontext.type = tcontext->type;
 	} else {
-		if ((tclass == policydb->process_class) || (sock == true)) {
+		if ((tclass == policydb->process_class) || sock) {
 			/* Use the type of process. */
 			newcontext.type = scontext->type;
 		} else {
-- 
2.6.2

