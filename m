Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C957C67872
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D18B2087F
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D18B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeLMOTX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:19:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeLMOTW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 09:19:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so2160349wrt.13
        for <selinux@vger.kernel.org>; Thu, 13 Dec 2018 06:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1ygaanma6hkjUu5scxzI8hxTVXGMIJQ0/s38b0k2JA=;
        b=pGLG9OjfU8JtNyyfjPboymYUF5eNPVzxSAvYIhX9NQQnFjcDjsbaEIXEo1AGfTvKvh
         PrzjXIB1J+d89/51MVNMwICTsVOIyxGRGZaoohoguKEdqrODwSDeWRYce6L3p0SGXGqT
         /5HMh+h4xwWpaNdObQmLZ/4EPN4gBIcQaX79eK+zfYxOydIYU4FHcJtXHrMm5fD+p1un
         btTJWNdmV+j7UdlftLJB5utkwW6dTR008ZtxCCPR9sbc9g3nf70wfgvenz1ozdgZZzHC
         IQM7OKk/kppNopikMD3xsOukWGvi+Lr9bbVUECxAnPAKXEzghr3NLojuw+5YbXKVYWUB
         MspQ==
X-Gm-Message-State: AA+aEWZTqoHtWm/bRDKEAymmYpVDf/OV2dv4353HPYMJzKsHuB2JILAs
        dCkki+5hqL3WMOgTGZJBdMivtLCM+IM=
X-Google-Smtp-Source: AFSGD/WKoF6gtYkcvTsV0XwlPjYht+Lv4cUMwtvahB7qAFicK9eWhxOmhuO5NISS2GK5mo5iIviffg==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr20102634wrn.102.1544710760882;
        Thu, 13 Dec 2018 06:19:20 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e16sm2544750wrn.72.2018.12.13.06.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:19:19 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH 2/3] selinux: never allow relabeling on context mounts
Date:   Thu, 13 Dec 2018 15:17:38 +0100
Message-Id: <20181213141739.8534-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213141739.8534-1-omosnace@redhat.com>
References: <20181213141739.8534-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the SECURITY_FS_USE_MNTPOINT case we never want to allow relabeling
files/directories, so we should never set the SBLABEL_MNT flag in this
case. The 'special handling' in selinux_is_sblabel_mnt() is only
intended for SECURITY_FS_USE_GENFS.

While there, make the logic in selinux_is_sblabel_mnt() more explicit
and add a BUILD_BUG_ON() to make sure that introducing a new
SECURITY_FS_USE_* forces a review of the logic.

Note that checkpatch.pl produces some false positives here, likely
having problems recognizing the monstrous return statement...

Fixes: d5f3a5f6e7e7 ("selinux: add security in-core xattr support for pstore and debugfs")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce012d9ec51..d6d29ec54eab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -501,19 +501,36 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
 
-	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
-		sbsec->behavior == SECURITY_FS_USE_TRANS ||
-		sbsec->behavior == SECURITY_FS_USE_TASK ||
-		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
+	/*
+	 * IMPORTANT: Double-check logic in this function when adding a new
+	 * SECURITY_FS_USE_* definition!
+	 */
+	BUILD_BUG_ON(SECURITY_FS_USE_MAX != 7);
+
+	switch (sbsec->behavior) {
+	case SECURITY_FS_USE_XATTR:
+	case SECURITY_FS_USE_TRANS:
+	case SECURITY_FS_USE_TASK:
+	case SECURITY_FS_USE_NATIVE:
+		return 1;
+
+	case SECURITY_FS_USE_GENFS:
 		/* Special handling. Genfs but also in-core setxattr handler */
-		!strcmp(sb->s_type->name, "sysfs") ||
-		!strcmp(sb->s_type->name, "pstore") ||
-		!strcmp(sb->s_type->name, "debugfs") ||
-		!strcmp(sb->s_type->name, "tracefs") ||
-		!strcmp(sb->s_type->name, "rootfs") ||
-		(selinux_policycap_cgroupseclabel() &&
-		 (!strcmp(sb->s_type->name, "cgroup") ||
-		  !strcmp(sb->s_type->name, "cgroup2")));
+		return	!strcmp(sb->s_type->name, "sysfs") ||
+			!strcmp(sb->s_type->name, "pstore") ||
+			!strcmp(sb->s_type->name, "debugfs") ||
+			!strcmp(sb->s_type->name, "tracefs") ||
+			!strcmp(sb->s_type->name, "rootfs") ||
+			(selinux_policycap_cgroupseclabel() &&
+			 (!strcmp(sb->s_type->name, "cgroup") ||
+			  !strcmp(sb->s_type->name, "cgroup2")));
+
+	/* Never allow relabeling on context mounts */
+	case SECURITY_FS_USE_MNTPOINT:
+	case SECURITY_FS_USE_NONE:
+	default:
+		return 0;
+	}
 }
 
 static int sb_finish_set_opts(struct super_block *sb)
-- 
2.19.2

