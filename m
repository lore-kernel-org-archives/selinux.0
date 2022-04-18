Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAAFC433FE
	for <selinux@archiver.kernel.org>; Mon, 18 Apr 2022 09:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiDRJs6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiDRJs5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Apr 2022 05:48:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B51659D;
        Mon, 18 Apr 2022 02:46:18 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Khhm111NHzCr93;
        Mon, 18 Apr 2022 17:41:53 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:16 +0800
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:14 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <alexander.kozhevnikov@huawei.com>, <artem.kuzin@huawei.com>,
        <hw.likun@huawei.com>, <igor.baranov@huawei.com>,
        <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <yusongping@huawei.com>, <anton.sirazetdinov@huawei.com>
Subject: [RFC PATCH 0/7] SELinux-namespace
Date:   Mon, 18 Apr 2022 17:45:45 +0800
Message-ID: <20220418094552.128898-1-alexander.kozhevnikov@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAHC9VhTDu1GDxJwFg5gAMWhuMKUWEU5eXuTr_6eG=tGwiGsMTw@mail.gmail.com>
References: <CAHC9VhTDu1GDxJwFg5gAMWhuMKUWEU5eXuTr_6eG=tGwiGsMTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.219.174.70]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Igor Baranov <igor.baranov@huawei.com>

Continue with the previous discussion, we decided to do the following: publish all of our patches.
The aim of these series patches is to extend the functionality and
stability of selinux namespace base-on the existing work for a basic
PoC.

To try our patches you need to:
* Checkout https://github.com/stephensmalley/selinux-kernel/commit/3a3b3ad9bd266f0199a2db6c0aa15c343c2307f1
* Apply our patches.
* Compile the kernel and boot into it.
* Next, we recommend creating a privileged Docker container with a SELinux-based distribution (we used CentOS 7) with mapping /sys/fs/selinux:/sys/fs/selinux
* Then log into into the container and do the following:

# create new namespace with name "ns", unshare previous one
echo "ns" > /sys/fs/selinux/unshare; unshare --fork -m
# remount selinuxfs, load policy
umount /sys/fs/selinux; mount -t selinuxfs none /sys/fs/selinux/; load_policy
# relabel everything
restorecon / -Rv
# check xattr's
ls -Z
# now enter enforcing mode
setenforce 1
# check enforce
getenforce

First of all, there is a need to build the solid code base for the
workable PoC with the latest branch working-selinux, hence the related
commits picked from the sources comprise the first two patches.
And the rest five patches are the major work, detailed description
can be check in each commit message:

  (1) Infrastructure management of the superblock
  (2) support per-namespace superblock security structures
  (3) Fix initilization of the superblock security under spinlock
  (4) Namespacing for xattrs
  (5) Migrate all open files and all vma to new namespace
  (6) Fixing superblock security structure memory leakage
  (7) Fixing concurrency issues

Hope the initial efforts in this direction could re-initiate the discussion.
Thanks.

 README.SELINUX-NAMESPACES           |  22 +
 include/linux/lsm_hooks.h           |   1 +
 security/security.c                 |  46 +-
 security/selinux/hooks.c            | 682 +++++++++++++++++++++-------
 security/selinux/include/objsec.h   |  41 +-
 security/selinux/include/security.h |  23 +-
 security/selinux/selinuxfs.c        | 368 +++++++++++----
 security/selinux/ss/services.c      |  32 +-
 security/smack/smack.h              |   6 +
 security/smack/smack_lsm.c          |  35 +-
 10 files changed, 950 insertions(+), 306 deletions(-)
 create mode 100644 README.SELINUX-NAMESPACES

-- 
2.34.1

Alexander Kozhevnikov,
Igor Baranov,

Advanced Software Technology Lab

Huawei
