Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E75C65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AA920879
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AA920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeLMOTU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:19:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35850 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeLMOTU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 09:19:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so2583536wmj.1
        for <selinux@vger.kernel.org>; Thu, 13 Dec 2018 06:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZdnQOtY2wTAGFXdGaMR5ArMi5mB6CbdMI14JswuOR14=;
        b=rRRkL2e4mx+ogtrYwDSfdwvTfUiDJvych253D9Q/BekUFFZcT65mHqvXzZeMs4tGMz
         86BU1pvC0QYrZvQq/FO7HRTQc6ak7l2yr+OiruNmmezFVV6FF+2umKVKs3JiKLZlmOyE
         ssjwnPWam4OmWxZqJbZcQ9oCy1NTw0hRHLmultSnhd3cENp/6VvIEdJoGL4AJ8awV1Ma
         ETCLNr66khL2TYxhmiKNfXA7OtvKnsK590MxUyDkj2Ke/piCEnMUGLEH+seQlOlAEIqh
         dimLO1T9sytkaNFJJZNJvZVM0VTjTvpbVXbQcRtDndUXvtIzBSKwIDJzNSD/DZ3mqmjA
         ExPA==
X-Gm-Message-State: AA+aEWbRCGe/LM00YRkAPnTVa3lPR5Bi7zv+wGGCioWg1GVRVfFqppv3
        Lb1sBJ3lh3X5J8mc4Zah7jTeOstBQUI=
X-Google-Smtp-Source: AFSGD/XFItuZBF3HI+jzk17FOR6A5oyW30XB01YCtKnTl92JsD4acvGUPDJ3T56CPxP62dCXR1/cPA==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr10116304wmg.55.1544710758203;
        Thu, 13 Dec 2018 06:19:18 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e16sm2544750wrn.72.2018.12.13.06.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:19:17 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH 0/3] Fix SELinux context mount with the cgroup filesystem
Date:   Thu, 13 Dec 2018 15:17:36 +0100
Message-Id: <20181213141739.8534-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains three independent bugfixes that together make it possible
to mount the cgroup filesystem with the 'context=' option under SELinux.

The first patch is trivial and fixes cgroupfs to correctly handle the case when
the mount options are just an empty string.

The second patch fixes SELinux to always disallow relabeling inodes that
belong to a 'context=' mount.

The third patch fixes SELinux to ignore security_inode_notifysecctx() calls
on inodes that belong to a 'context=' mount.

Paul, Stephen, please have a quick look at the last two patches, I'm not 100%
sure that I understand the expected behavior of the context mounts correctly.
(My assumption is that in a context mount we want the whole subtree to be
labeled with the given label, no matter what.)

Also, I'm not entirely satisfied with the code style in the second patch (and
it produces an annoying false positive with checkpatch.pl), but I didn't see
a better way to write it...

I haven't had time to do much testing on the patches (other than the
reproducers mentioned in the commit messages). I'd like to make sure that
I'm going in the right direction first.

Thanks,

O.M.

--
Ondrej Mosnacek (3):
  cgroup: fix parsing empty mount option string
  selinux: never allow relabeling on context mounts
  selinux: do not override context on context mounts

 kernel/cgroup/cgroup.c   |  2 +-
 security/selinux/hooks.c | 48 ++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.19.2

