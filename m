Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365EEC433F5
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 01:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiAMBsh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jan 2022 20:48:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34904 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiAMBsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jan 2022 20:48:36 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZ6kz1fJWzccYT
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 09:47:55 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 09:48:34 +0800
Received: from huawei.com (10.67.174.191) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 13 Jan
 2022 09:48:34 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Cui Gaosheng <cuigaosheng1@huawei.com>,
        Lu Jialin <lujialin4@huawei.com>,
        Yi Yang <yiyang13@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>
Subject: [PATCH testsuite] tests/binder: Build only for 4.11 and later kernels
Date:   Thu, 13 Jan 2022 02:09:15 +0000
Message-ID: <20220113020915.13560-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Following compilation errors occur when building the tests with
userspace headers exported from kernel 4.4:

binder_common.c:111:14: error: ‘const struct flat_binder_object’ has no
member named ‘hdr’
   switch (obj->hdr.type) {
              ^
client.c:58:9: error: dereferencing pointer to incomplete type
  if (obj->hdr.type != BINDER_TYPE_FD) {
         ^

It's been checked that member `hdr` of `struct flat_binder_object` and
`struct binder_fd_object` were both introduced by commit feba3900cabb
("binder: Split flat_binder_object") in kernel v4.11-rc1. Fix this
by adding kernel version check at compile time.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 tests/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index 3f7cae3..22458a7 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -54,8 +54,10 @@ SUBDIRS += prlimit
 endif
 
 ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && test -e $(INCLUDEDIR)/linux/android/binder.h && echo true),true)
+ifneq ($(shell ./kvercmp $$(uname -r) 4.11),-1)
 SUBDIRS += binder
 endif
+endif
 
 ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
-- 
2.17.1

