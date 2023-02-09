Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B94C61DA4
	for <selinux@archiver.kernel.org>; Thu,  9 Feb 2023 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBILy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBILy0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Feb 2023 06:54:26 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5B7C646
        for <selinux@vger.kernel.org>; Thu,  9 Feb 2023 03:43:01 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PCFLj0w2fzJsGg
        for <selinux@vger.kernel.org>; Thu,  9 Feb 2023 19:41:17 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 19:42:58 +0800
From:   wanghuizhao <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>, <nixiaoming@huawei.com>,
        <tengfei22@huawei.com>, <luohaizheng@huawei.com>,
        <leisure.wang@huawei.com>, <dongxinhua@huawei.com>
CC:     <wuquanming@huawei.com>, <chenjingwen6@huawei.com>,
        <douzhaolei@huawei.com>, <hushijie3@huawei.com>,
        <jiangyangyang@huawei.com>, <laiyuanyuan.lai@huawei.com>,
        <luozhoujian1@huawei.com>, <wangxu72@huawei.com>,
        <wanqian10@huawei.com>, <weiyuchen3@huawei.com>,
        <wangfangpeng1@huawei.com>, <young.liuyang@huawei.com>,
        <zengweilin@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH 0/2] Improve efficiency of detecting duplicate in libselinux
Date:   Thu, 9 Feb 2023 19:42:51 +0800
Message-ID: <20230209114253.120485-1-wanghuizhao1@huawei.com>
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

In my process of using selinux, I found that when semodule -i some.pp loads
a large number of modules with rules, the loading time increases rapidly.

(none) /tmp # time semodule -i 1.pp
real    0m 1.085s
user    0m 0.871s
sys     0m 0.063s
(none) /tmp # time semodule -i 2.pp
real    0m 3.178s
user    0m 2.890s
sys     0m 0.170s
(none) /tmp # time semodule -i 3.pp
real    0m 13.365s
user    0m 12.927s
sys     0m 0.340s

Then, I analyzed and found a function nodups_specs in label_file.c. The
algorithm complexity of implementing this function is O(N^2). In my use
scenario, the N number would be over 20,000, so it would be performed
hundreds of millions of times. It takes 13s to install the policy.

Therefore, I propose an optimization solution to this problem. The purpose
of this function is to check for duplicates. I'd like to propose a new
implementation that uses hash tables to check for duplicates.

This patch set consists of two parts to implement this solution.

- Migrate the existing hashtab templates in policycoreutils/newrole to
  libselinux.

- Implement the hash function and key comparison function required by the
  hashtab template. Improve algorithm for checking duplicate items of
  nodups_specs function.

Test again with the new implementation.

(none) /tmp # time semodule -i 1.pp
real    0m 0.725s
user    0m 0.483s
sys     0m 0.100s
(none) /tmp # time semodule -i 2.pp
real    0m 0.939s
user    0m 0.597s
sys     0m 0.228s
(none) /tmp # time semodule -i 3.pp
real    0m 1.885s
user    0m 1.473s
sys     0m 0.300s

wanghuizhao (2):
  libselinux: migrating hashtab from policycoreutils
  libselinux: performance optimization for duplicate detection

 libselinux/src/hashtab.c    | 208 ++++++++++++++++++++++++++++++++++++++++++++
 libselinux/src/hashtab.h    | 115 ++++++++++++++++++++++++
 libselinux/src/label_file.c | 112 +++++++++++++++++++-----
 libselinux/src/label_file.h |   5 ++
 4 files changed, 416 insertions(+), 24 deletions(-)
 create mode 100644 libselinux/src/hashtab.c
 create mode 100644 libselinux/src/hashtab.h

-- 
2.12.3

