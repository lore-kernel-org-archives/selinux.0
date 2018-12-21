Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA28C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE7E21927
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbeLUUTa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:19:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37187 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390140AbeLUUTa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:19:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so6488351wrt.4
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 12:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWSx7QbwxhuVfxTnkD2Ja7rEW9P1RZkF1IYCXQ+aVDk=;
        b=ZgIqRa7RJyFjaNtGlMx3KSYr2JfgutcTUFxwfyCig2hDNKoi/MnpPR91H8nZUJFEDI
         ouztmarZTkahntRXt9lhoujfQtCE2DDgWifKFp2kAcpgS+kSeH5NXyH9OGCbbrT8KCyG
         zKFCX+opmdP5lC7182APGY+bjmselQuGMKO2Jrxcvfq4bmKN6gw5zcbELFG4WRwe8kPm
         Zqg0xvGLgjQKyXkGSZHJZJy4nxRy3wDZ5a93GP4NlN63TEm4I39F2XErcWpF/jEOW+K7
         L1EZCUFwJGAtJNHIb64OLf9DyXeo159cfJ45r2ztYWPOZ7HYBWXDV0ZvPwKeHqWxCPwW
         lI3g==
X-Gm-Message-State: AJcUukd96yVdRmOYAkLwNzCNy/UHcbi/pqUwXpYDexvMFn5Hrzg6AnFq
        6AdGJdh0nB40oVZu+OMQ1/VNmLA94lQ=
X-Google-Smtp-Source: ALg8bN7GXrNBwrd3AHe4jZo7dEuiKOrRq96X1v42dcDw+hwysHcOIV+YvYU/5M/OOSPWDtLiL3MXjQ==
X-Received: by 2002:adf:c042:: with SMTP id c2mr4140856wrf.158.1545423568366;
        Fri, 21 Dec 2018 12:19:28 -0800 (PST)
Received: from localhost.localdomain.com (adsl-dyn216.78-99-85.t-com.sk. [78.99.85.216])
        by smtp.gmail.com with ESMTPSA id r12sm17378087wrq.3.2018.12.21.12.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 12:19:27 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 2/2] selinux: do not override context on context mounts
Date:   Fri, 21 Dec 2018 21:18:53 +0100
Message-Id: <20181221201853.24015-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221201853.24015-1-omosnace@redhat.com>
References: <20181221201853.24015-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ignore all selinux_inode_notifysecctx() calls on mounts with SBLABEL_MNT
flag unset. This is achived by returning -EOPNOTSUPP for this case in
selinux_inode_setsecurtity() (because that function should not be called
in such case anyway) and translating this error to 0 in
selinux_inode_notifysecctx().

This fixes behavior of kernfs-based filesystems when mounted with the
'context=' option. Before this patch, if a node's context had been
explicitly set to a non-default value and later the filesystem has been
remounted with the 'context=' option, then this node would show up as
having the manually-set context and not the mount-specified one.

Steps to reproduce:
    # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
    # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
    # umount /sys/fs/cgroup/unified
    # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified

Result before:
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads

Result after:
    # ls -lZ /sys/fs/cgroup/unified
    total 0
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
    -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
    -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b4759bebeddc..fcf4af1e5157 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3477,12 +3477,16 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 				     const void *value, size_t size, int flags)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
+	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 	u32 newsid;
 	int rc;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
+	if (!(sbsec->flags & SBLABEL_MNT))
+		return -EOPNOTSUPP;
+
 	if (!value || !size)
 		return -EACCES;
 
@@ -6625,7 +6629,10 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
  */
 static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
+					   ctx, ctxlen, 0);
+	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
+	return rc == -EOPNOTSUPP ? 0 : rc;
 }
 
 /*
-- 
2.19.2

