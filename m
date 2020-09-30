Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C5C4727C
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 01:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D7920B1F
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 01:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgI3BiY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 21:38:24 -0400
Received: from smtpbguseast1.qq.com ([54.204.34.129]:44765 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgI3BiX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 21:38:23 -0400
X-QQ-mid: bizesmtp2t1601429879teikl1dg2
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 30 Sep 2020 09:37:22 +0800 (CST)
X-QQ-SSF: 01400000002000F0D000B00A0000000
X-QQ-FEAT: WK7HT2c9PvWR0a7FdtqZp++22iZWCxON5yY9T0eBLNhNI901pR8uWn9iyeCEM
        kxd/1weKhTRzRvcsEYbGfY50YEGqwGqHzn0HCVHeHckzSsKkTH1d3RcBxb/tuBDV2QTVVww
        B/1o2SlhwveMqdFdgH5adUBChoW5sysZn2A8aQzEEIaq5cqkxqQrujxcC6xHiJjp8PfEU2B
        Kx52Nz+nv4IVTzH9bjH8fZiUsdXB9fWBMgd4cyGAjWuVaQhbHWHz0hiC+OjNogR7KvLk8S8
        bO2CbDXwbVrakIz3SQOt0yDcm94w3nWJo19Na/CxRhEwA2fQKYTsz574dSS7Hd+QeDhjuM/
        bRrOppIIzGWuw/5EJg=
X-QQ-GoodBg: 2
From:   rentianyue@tj.kylinos.cn
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     yangzhao@kylinos.cn, selinux@vger.kernel.org,
        Tianyue Ren <rentianyue@kylinos.cn>
Subject: [PATCH v2 0/1] selinux: fix error initialization in inode_doinit_with_dentry()
Date:   Wed, 30 Sep 2020 09:36:52 +0800
Message-Id: <20200930013653.48787-1-rentianyue@tj.kylinos.cn>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAEjxPJ7==mkXDKuDw2YueRP+ymoQjPDdCS8Wk7GJfth+CpLqkg@mail.gmail.com>
References: <CAEjxPJ7==mkXDKuDw2YueRP+ymoQjPDdCS8Wk7GJfth+CpLqkg@mail.gmail.com>
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

Tianyue Ren (1):
  selinux: fix error initialization in inode_doinit_with_dentry()

 security/selinux/hooks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.28.0



