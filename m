Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32825C05027
	for <selinux@archiver.kernel.org>; Fri, 17 Feb 2023 08:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBQIpH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQIpG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Feb 2023 03:45:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEEB5F279
        for <selinux@vger.kernel.org>; Fri, 17 Feb 2023 00:45:04 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PJ50t5LwFznWGM;
        Fri, 17 Feb 2023 16:42:38 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 16:45:02 +0800
From:   wanghuizhao <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>, <nixiaoming@huawei.com>,
        <chenjingwen6@huawei.com>, <dongxinhua@huawei.com>
CC:     <lautrbach@redhat.com>, <jwcart2@gmail.com>, <jason@perfinion.com>,
        <cgzones@googlemail.com>, <wangfangpeng1@huawei.com>,
        <weiyuchen3@huawei.com>, <wanghuizhao1@huawei.com>
Subject: [PATCH v2 0/3] Improve efficiency of detecting duplicate in libselinux
Date:   Fri, 17 Feb 2023 16:44:55 +0800
Message-ID: <20230217084458.40597-1-wanghuizhao1@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20230209114253.120485-1-wanghuizhao1@huawei.com>
References: <20230209114253.120485-1-wanghuizhao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.136.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

changes in v2:
  1. add hashtab_destroy_key function in the hashtab.c and declaration in
     hashtab.h. Replace the original resource release statement with
     hashtab_destroy_key function.
  2. change macro definition to _SELINUX_HASHTAB_H_ in the hashtab.h
  3. fix build error:
     label_file.c:74:77: error: suggest parentheses around arithmetic in
     operand of ‘|’ [-Werror=parentheses]
     74 | (val << 4 | (val >> (8 * sizeof(unsigned int) - 4)) +
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
     75 |                         k->mode) ^ (*p);
        |                         ~~~~~~~
  4. fix memory leak and add oom check in label_file.c
  5. fix length parameter of hashtab_create function to hashtab_len
  6. move struct chkdups_key to label_file.c

v1: https://lore.kernel.org/selinux/20230209114253.120485-1-wanghuizhao1@huawei.com/

wanghuizhao (3):
  libselinux: migrating hashtab from policycoreutils
  libselinux: adapting hashtab to libselinux
  libselinux: performance optimization for duplicate detection

 libselinux/src/hashtab.c    | 234 ++++++++++++++++++++++++++++++++++++++++++++
 libselinux/src/hashtab.h    | 117 ++++++++++++++++++++++
 libselinux/src/label_file.c | 118 +++++++++++++++++-----
 3 files changed, 445 insertions(+), 24 deletions(-)
 create mode 100644 libselinux/src/hashtab.c
 create mode 100644 libselinux/src/hashtab.h

-- 
2.12.3

