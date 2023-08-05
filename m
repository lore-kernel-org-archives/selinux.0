Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99F4EB64DD
	for <selinux@archiver.kernel.org>; Sat,  5 Aug 2023 07:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjHEHHG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Aug 2023 03:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHEHHF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Aug 2023 03:07:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EF74EC4
        for <selinux@vger.kernel.org>; Sat,  5 Aug 2023 00:07:03 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHtpZ2vmwzGptK
        for <selinux@vger.kernel.org>; Sat,  5 Aug 2023 15:03:34 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 15:07:01 +0800
From:   Huizhao Wang <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     <weiyuchen3@huawei.com>, <dongxinhua@huawei.com>,
        <wanghuizhao1@huawei.com>
Subject: [PATCH] restorecond: compatible with the use of EUID
Date:   Sat, 5 Aug 2023 15:06:50 +0800
Message-ID: <20230805070650.197744-1-wanghuizhao1@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.136.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The `EUID` does not exist in some shell environments. To ensure compatibility,
use `id -u` instead of `EUID` when `EUID` does not exist.

Signed-off-by: Huizhao Wang <wanghuizhao1@huawei.com>
---
 restorecond/restorecond.init | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/restorecond/restorecond.init b/restorecond/restorecond.init
index c1cbb247..4e71a2c6 100644
--- a/restorecond/restorecond.init
+++ b/restorecond/restorecond.init
@@ -29,7 +29,11 @@ PATH=/sbin:/bin:/usr/bin:/usr/sbin
 [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled || exit 7
 
 # Check that we are root ... so non-root users stop here
-test $EUID = 0  || exit 4
+if [ $EUID  ]; then
+	test $EUID = 0  || exit 4
+else
+	test `id -u` = 0  || exit 4
+fi
 
 test -x /usr/sbin/restorecond  || exit 5
 test -f /etc/selinux/restorecond.conf  || exit 6
-- 
2.12.3

