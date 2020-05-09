Return-Path: <SRS0=vu0J=6X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81847C28CBC
	for <selinux@archiver.kernel.org>; Sat,  9 May 2020 11:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679A02184D
	for <selinux@archiver.kernel.org>; Sat,  9 May 2020 11:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgEILTd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 9 May 2020 07:19:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbgEILTc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 9 May 2020 07:19:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A2E2C7F2C6B95D3F1E8;
        Sat,  9 May 2020 19:19:23 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 19:19:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <tglx@linutronix.de>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] selinux: netlabel: Remove unused inline function selinux_netlbl_conn_setsid
Date:   Sat, 9 May 2020 19:18:52 +0800
Message-ID: <20200509111852.29812-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There's no callers in-tree.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/selinux/include/netlabel.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index d30d8d7cdc9c..0c58f62dc6ab 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -98,12 +98,6 @@ static inline int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	return 0;
 }
 
-static inline int selinux_netlbl_conn_setsid(struct sock *sk,
-					     struct sockaddr *addr)
-{
-	return 0;
-}
-
 static inline int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 						    struct sk_buff *skb)
 {
-- 
2.17.1


