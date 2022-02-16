Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778F0C433FE
	for <selinux@archiver.kernel.org>; Wed, 16 Feb 2022 12:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiBPMxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:53:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiBPMx1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Feb 2022 07:53:27 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066B2221A3;
        Wed, 16 Feb 2022 04:52:29 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzHsZ05Ybz682G3;
        Wed, 16 Feb 2022 20:52:02 +0800 (CST)
Received: from lhreml725-chm.china.huawei.com (10.201.108.76) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 13:52:26 +0100
Received: from centos7.huawei.com (10.122.133.3) by
 lhreml725-chm.china.huawei.com (10.201.108.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 12:52:25 +0000
From:   Igor Baranov <igor.baranov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <hw.likun@huawei.com>, <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <alexander.kozhevnikov@huawei.com>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>, Igor Baranov <igor.baranov@huawei.com>
Subject: [RFC PATCH 0/1] SELinux-namespaces
Date:   Wed, 16 Feb 2022 15:52:05 +0300
Message-ID: <20220216125206.20975-1-igor.baranov@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
References: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.133.3]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhreml725-chm.china.huawei.com (10.201.108.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all!
Our team at Huawei decided to revive the work on SELinux namespaces.
We took https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
as a basis with some patches from selinuxns-xattr.
We reworked them significantly, fixing and adding functionality.
As a result we managed to run a CentOS Docker container with SELinux in enforcing mode!

We would like to start our discussion with the smallest, but most basic
change: we gave each namespace a unique identifier.
It is assigned to a namespace from the global counter
that is incremented each time you create it.

All the objects which in the original patchset kept a pointer to their
namespace now store its identifier. It's needed only to determine whether
an object belongs to our (in the current context) namespace or not.
The aim of this change is to reduce the height of the Babel tower of pointers,
because in the original patch there was such a mess and such bugs,
that we decided to cut this Gordian knot, removing some pointers altogether.

This is a very small part of our changes, but we see the point of discussing
more when we come to this.

Particularly because there are alternative approaches,
such as Casey Schaufler's suggestion, which is mentioned
in http://namei.org/presentations/selinux_namespacing_lca2018.pdf
"How to deal with secids (32-bit IDs) which are passed to core kernel and
cached there - Make them global" which seems quite promising for us too.
In the case of this approach, it is not necessary to store the namespace ID
in objects, because it can be deduced from sid. But a detailed study of
this area reveals some painful challenges. For example: fragmentation of
the global sid space when loading/unloading different policies. And the
depth of the rabbit hole is not obvious from current positions. This is a
separate big topic.

Igor Baranov (1):
  Replace state pointer with namespace id

 security/selinux/hooks.c            | 29 ++++++++++++++++++++++++-----
 security/selinux/include/objsec.h   |  4 +++-
 security/selinux/include/security.h |  2 ++
 3 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.34.1

