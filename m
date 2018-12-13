Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA22C67872
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5552086D
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5552086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeLMOTV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:19:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46968 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeLMOTV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 09:19:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so2160281wrt.13
        for <selinux@vger.kernel.org>; Thu, 13 Dec 2018 06:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwWLrWLH338ATQ/oBWcdZ3VAWRguwjpBavS6DcJQQ7o=;
        b=TB6gxk4Ona+qE3d0vZAlwdCxW9aBivsX6zpgT1FHq632BwWI3qjK0v8DHi8exc2W+/
         7W9R9+BkiNzZRMk1hgIWkn2mpUeXHbyeETTLQIYjbuqurpwxtNQa9I/ULXBBPaBK3gmt
         KxTCJLlKTUsMI4AG6/+BVD0HJjDBBludIE1xuBeZpAhhDHiDgKc7an/VllThLU/8L2P5
         4Z1o2FCd/vEMTD2mGy0oh1tbDgOKikNuBk/BoBoYXnPB7Nj/pTsO4INebSL/JRFdVCLU
         zIpVYU6teqDWZzDNkX49jKJ+3BYt1cBxSf7C4e7XZTLjoBJOLAZAZHl+wvhXVZt7TPDM
         s+xQ==
X-Gm-Message-State: AA+aEWYXoSuep+u4erRfevc2+1ChsWWlQO8t0/FAkPkSZyd20yKeTeF+
        thLIJ1CcJOLrQyLuF6FpPdmn1cgVhTE=
X-Google-Smtp-Source: AFSGD/W5EnJtx0yUTWrWSaJFmNtJwdWIgAjiqkHA+4q2KRHoq8REMizlNNBlqOvVwcnkHWP4QLqRGQ==
X-Received: by 2002:adf:9521:: with SMTP id 30mr20091592wrs.192.1544710759472;
        Thu, 13 Dec 2018 06:19:19 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e16sm2544750wrn.72.2018.12.13.06.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:19:18 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH 1/3] cgroup: fix parsing empty mount option string
Date:   Thu, 13 Dec 2018 15:17:37 +0100
Message-Id: <20181213141739.8534-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213141739.8534-1-omosnace@redhat.com>
References: <20181213141739.8534-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This fixes the case where all mount options specified are consumed by an
LSM and all that's left is an empty string. In this case cgroupfs should
accept the string and not fail.

How to reproduce (with SELinux enabled):

    # umount /sys/fs/cgroup/unified
    # mount -o context=system_u:object_r:cgroup_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
    mount: /sys/fs/cgroup/unified: wrong fs type, bad option, bad superblock on cgroup2, missing codepage or helper program, or other error.
    # dmesg | tail -n 1
    [   31.575952] cgroup: cgroup2: unknown option ""

Fixes: 67e9c74b8a87 ("cgroup: replace __DEVEL__sane_behavior with cgroup2 fs type")
[NOTE: should apply on top of commit 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option"), older versions need manual rebase]
Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6aaf5dd5383b..8cb616232035 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1744,7 +1744,7 @@ static int parse_cgroup_root_flags(char *data, unsigned int *root_flags)
 
 	*root_flags = 0;
 
-	if (!data)
+	if (!data || *data == '\0')
 		return 0;
 
 	while ((token = strsep(&data, ",")) != NULL) {
-- 
2.19.2

