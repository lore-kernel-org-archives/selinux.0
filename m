Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA95C6FD1F
	for <selinux@archiver.kernel.org>; Wed,  8 Mar 2023 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCHJxg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCHJxT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Mar 2023 04:53:19 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E1509A6
        for <selinux@vger.kernel.org>; Wed,  8 Mar 2023 01:53:16 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PWngR6jGjzKmb9;
        Wed,  8 Mar 2023 17:53:07 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:53:14 +0800
From:   wanghuizhao <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     <cgzones@googlemail.com>, <lautrbach@redhat.com>,
        <jwcart2@gmail.com>, <jason@perfinion.com>,
        <weiyuchen3@huawei.com>, <wanghuizhao1@huawei.com>
Subject: [PATCH v3 0/3] Improve efficiency of detecting duplicate in libselinux
Date:   Wed, 8 Mar 2023 17:53:05 +0800
Message-ID: <20230308095308.60661-1-wanghuizhao1@huawei.com>
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

changes in v3:
  1. fix bug to detect duplicate items when mode is set to 0. Therefore,
     `k->mode` is deleted from the hash calculation. More information on the
     https://lore.kernel.org/selinux/a236c473-4f18-c882-2197-f49195d84051@huawei.com/
  2. add new macro definition SHRINK_MULTIS. This macro is used to control
     the `hashtab_len`.
  3. modify the algorithm complexity in the commit message.
  4. fix `hash_table` leak in failed malloc.

v2: https://lore.kernel.org/selinux/20230217084458.40597-1-wanghuizhao1@huawei.com/

v1: https://lore.kernel.org/selinux/20230209114253.120485-1-wanghuizhao1@huawei.com/


wanghuizhao (3):
  libselinux: migrating hashtab from policycoreutils
  libselinux: adapting hashtab to libselinux
  libselinux: performance optimization for duplicate detection

 libselinux/src/hashtab.c    | 234 ++++++++++++++++++++++++++++++++++++++++++++
 libselinux/src/hashtab.h    | 117 ++++++++++++++++++++++
 libselinux/src/label_file.c | 120 ++++++++++++++++++-----
 3 files changed, 447 insertions(+), 24 deletions(-)
 create mode 100644 libselinux/src/hashtab.c
 create mode 100644 libselinux/src/hashtab.h

-- 
2.12.3

