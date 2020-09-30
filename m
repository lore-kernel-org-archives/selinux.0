Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102F0C4727C
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 01:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C126420B1F
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 01:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgI3BiJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 21:38:09 -0400
Received: from smtpbg702.qq.com ([203.205.195.102]:47901 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729404AbgI3BiJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 21:38:09 -0400
X-QQ-mid: bizesmtp2t1601429884tfkczzv7u
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 30 Sep 2020 09:38:01 +0800 (CST)
X-QQ-SSF: 01400000002000F0D000B00A0000000
X-QQ-FEAT: Ry58bBY793vMGSxEvts4BX2LU96VFEbx9cSPcr5HTgw3iXgKu2kei0zARCt23
        2mLAfGgE0cIHKWRGXpXeUCRs55N8liPqRg/KG4Qcg138JL3vC3dzHGpinYh4RHCvRQpGrEa
        xvMjfDdvo6sJxjaZMCwc+8lElWcNbCGO88wNxSWOgsnOEYHTZiVUdcQZ8Ch4jkg73qmGFnT
        Aq3Aj/wTgZHamIcLrk3bDD8Zl4LFYG/jQCjZMs9V0AtiBrcV3M1wHGx1EnFjfNcz//ny2qh
        +FO3kDX9j3mEpxlxeNaG+7OCkjuBpj5qrR3KTRgFIJ/mbF7wIjQcs85YdaOOrxdY818PKNN
        NA4AsSevA1+lCKOsfE=
X-QQ-GoodBg: 2
From:   rentianyue@tj.kylinos.cn
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     yangzhao@kylinos.cn, selinux@vger.kernel.org,
        Tianyue Ren <rentianyue@kylinos.cn>
Subject: [PATCH v2 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
Date:   Wed, 30 Sep 2020 09:36:53 +0800
Message-Id: <20200930013653.48787-2-rentianyue@tj.kylinos.cn>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930013653.48787-1-rentianyue@tj.kylinos.cn>
References: <CAEjxPJ7==mkXDKuDw2YueRP+ymoQjPDdCS8Wk7GJfth+CpLqkg@mail.gmail.com>
 <20200930013653.48787-1-rentianyue@tj.kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tj.kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tianyue Ren <rentianyue@kylinos.cn>

Mark the inode security label as invalid if we cannot find
a dentry so that we will retry later rather than marking it
initialized with the unlabeled SID.

Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
---
 security/selinux/hooks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bf8328adad8f..da7295a546e0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1499,6 +1499,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 * inode_doinit with a dentry, before these inodes could
 			 * be used again by userspace.
 			 */
+			isec->initialized = LABEL_INVALID;
 			goto out;
 		}
 
@@ -1553,8 +1554,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			 * inode_doinit() with a dentry, before these inodes
 			 * could be used again by userspace.
 			 */
-			if (!dentry)
+			if (!dentry) {
+				isec->initialized = LABEL_INVALID;
 				goto out;
+			}
 			rc = selinux_genfs_get_sid(dentry, sclass,
 						   sbsec->flags, &sid);
 			if (rc) {
-- 
2.28.0



