Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6522C433EF
	for <selinux@archiver.kernel.org>; Wed,  9 Feb 2022 12:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiBIMIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiBIMGb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Feb 2022 07:06:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAB6DD5BD15
        for <selinux@vger.kernel.org>; Wed,  9 Feb 2022 03:22:20 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JtyB53Gh4zccsG;
        Wed,  9 Feb 2022 19:21:17 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 19:22:18 +0800
Received: from huawei.com (10.67.174.191) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 19:22:17 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>
CC:     Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Cui Gaosheng <cuigaosheng1@huawei.com>,
        Lu Jialin <lujialin4@huawei.com>,
        Yi Yang <yiyang13@huawei.com>, Guo Zihua <guozihua@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>
Subject: [PATCH testsuite] tests/binder: Adjust kernel uapi headers check for building
Date:   Wed, 9 Feb 2022 11:42:42 +0000
Message-ID: <20220209114242.2229-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
`struct binder_fd_object` were both introduced into kernel 4.11 by the
same commit feba3900cabb ("binder: Split flat_binder_object"). Change
the check to <linux/android/binder.h> before building binder tests to
see if it contains the definition of `struct binder_fd_object`.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 tests/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 3f7cae3..273eed8 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -53,9 +53,11 @@ ifeq ($(shell grep -q getrlimit $(POLDEV)/include/support/all_perms.spt && echo
 SUBDIRS += prlimit
 endif
 
-ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && test -e $(INCLUDEDIR)/linux/android/binder.h && echo true),true)
+ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifeq ($(shell grep -q 'struct binder_fd_object' $(INCLUDEDIR)/linux/android/binder.h && echo true),true)
 SUBDIRS += binder
 endif
+endif
 
 ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
-- 
2.18.0.huawei.25

