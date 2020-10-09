Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79749C433E7
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 01:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CDF221FC
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 01:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgJIBim (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 21:38:42 -0400
Received: from smtpbg701.qq.com ([203.205.195.86]:44395 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727313AbgJIBim (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 21:38:42 -0400
X-QQ-mid: bizesmtp5t1602207440t942295fv
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 09 Oct 2020 09:37:12 +0800 (CST)
X-QQ-SSF: 01400000002000F0D000B00A0000000
X-QQ-FEAT: Dql/Ow0GiGxiv6VuIpOcnVX3HwSA2COF/K3nFCTQCOZm3iWaRydB703ruxJBe
        TT/vBLa8PoeTo4eKBlI53FgS93xck/sbXsIGD3zBJGxfZXw9V0VSFaYMjBjOat5WxMVF/Nl
        HQd5Dq+0al1faQv2cVyyo806pL8gv4aGrz/V/gjeFmiAHBrCqg+/Z7GERHTkzr9XJKFZE+d
        wQoLenLYPIxeykpupfs/1qzezQAcxwv71VPuEpRgpcHGM0RRVH/54k1evK5Nmmb5qZnhlwe
        xwBWTcUge9kIqNmdW9on0ncqAcv3VVYQBb8c4Rm4VlG6xps0eez09vE9KgaNbUg5cwyA==
X-QQ-GoodBg: 2
From:   rentianyue@tj.kylinos.cn
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     yangzhao@kylinos.cn, selinux@vger.kernel.org,
        Tianyue Ren <rentianyue@kylinos.cn>
Subject: [PATCH v3 0/1] fix error initialization in inode_doinit_with_dentry()
Date:   Fri,  9 Oct 2020 09:36:29 +0800
Message-Id: <20201009013630.6777-1-rentianyue@tj.kylinos.cn>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tj.kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tianyue Ren <rentianyue@kylinos.cn>

I think there is a error initialization for isec->sid when the dentry is NULL,
when we do "remount -o rw,remount ${rootmnt}" action before selinux policy loading.It's
leading kernel getting wrong security label "unlabeled_t" when the userspace access
files such as /etc/fstab.

This patch lets the label be invalid before it's initializated correctly.

v2: Modify the patch description
v3: Remove unnecessary "out cycle" that do a needless
    spin lock/unlock cycle when dentry is NULL.

Tianyue Ren (1):
  selinux: fix error initialization in inode_doinit_with_dentry()

 security/selinux/hooks.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.28.0



