Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C09C2D0CF
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 12:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D552053B
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 12:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLXMqK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:46:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfLXMqK (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 24 Dec 2019 07:46:10 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41B1F529B409AD86BBDC;
        Tue, 24 Dec 2019 20:46:08 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 20:45:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <paul@paul-moore.com>, <sds@tycho.nsa.gov>,
        <eparis@parisplace.org>, <omosnace@redhat.com>, <rgb@redhat.com>,
        <keescook@chromium.org>, <casey@schaufler-ca.com>,
        <yuehaibing@huawei.com>, <jeffv@google.com>,
        <kent.overstreet@gmail.com>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] selinux: remove set but not used variable 'sidtab'
Date:   Tue, 24 Dec 2019 20:45:52 +0800
Message-ID: <20191224124552.10452-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

security/selinux/ss/services.c: In function security_port_sid:
security/selinux/ss/services.c:2346:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]
security/selinux/ss/services.c: In function security_ib_endport_sid:
security/selinux/ss/services.c:2435:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]
security/selinux/ss/services.c: In function security_netif_sid:
security/selinux/ss/services.c:2480:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]
security/selinux/ss/services.c: In function security_fs_use:
security/selinux/ss/services.c:2831:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]

Since commit 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
'sidtab' is not used any more, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/selinux/ss/services.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 743b85e..b1c8ae1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2343,14 +2343,12 @@ int security_port_sid(struct selinux_state *state,
 		      u8 protocol, u16 port, u32 *out_sid)
 {
 	struct policydb *policydb;
-	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_PORT];
 	while (c) {
@@ -2432,14 +2430,12 @@ int security_ib_endport_sid(struct selinux_state *state,
 			    const char *dev_name, u8 port_num, u32 *out_sid)
 {
 	struct policydb *policydb;
-	struct sidtab *sidtab;
 	struct ocontext *c;
 	int rc = 0;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_IBENDPORT];
 	while (c) {
@@ -2477,14 +2473,12 @@ int security_netif_sid(struct selinux_state *state,
 		       char *name, u32 *if_sid)
 {
 	struct policydb *policydb;
-	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
 
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
@@ -2828,7 +2822,6 @@ int security_genfs_sid(struct selinux_state *state,
 int security_fs_use(struct selinux_state *state, struct super_block *sb)
 {
 	struct policydb *policydb;
-	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
 	struct superblock_security_struct *sbsec = sb->s_security;
@@ -2837,7 +2830,6 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
-	sidtab = state->ss->sidtab;
 
 	c = policydb->ocontexts[OCON_FSUSE];
 	while (c) {
-- 
2.7.4


