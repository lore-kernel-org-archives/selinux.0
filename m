Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF1C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC852086A
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBVO5x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:57:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34887 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBVO5w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 09:57:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so2710977wrx.2
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 06:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7n/70NaWl0BIWsrw4Nf9QtXYHdDHEAFx5YuB2+JlALg=;
        b=KjPSx+laEFgspb7pEC4/Ny0x5TZqVlaMy78+tC7Ws1rVeVqYyHc84CwWx51uWxXC95
         Ri6u43Gv0bjKbgfqK6mJI5HD52iS+fPuEM/AYaP7u5sC9U6TgStV1Mr7Yk2BgTjVcEqL
         XT7vhKQ86mbd0d8Z2Lq/76XwQ4E6wZ26/Xr50WlVYUyBD8resc9U5pSe7fhWCAR+wDDN
         Kk9fm5R+bEVw42r6JCXi2p5nn+JtXJeHL+/0x/NAy9Pe1pLpSrxwNc09NntzQ43knDoT
         eAgd756JuSvfMX/xnexGR9pFSct8a7x+F1q+OTa/tmBR91gotxUEWrdzNGAP+4GqI/+n
         X4Jg==
X-Gm-Message-State: AHQUAubZF+n4ziJEW3NrqT+Pbh7Eb9yUNoT+BXtnYQxb08x7HTR6mlfO
        gjTxsJgwK9gwxkip33vJRzH63GHrbLvvxg==
X-Google-Smtp-Source: AHgI3IbmtHK+lnP7Dljpl1l5VaePLL7sxhmizTelgs7gUNpQQvXAR4jRwoQad6d+gSsubj1f7mv2rA==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr3324885wrr.261.1550847470086;
        Fri, 22 Feb 2019 06:57:50 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 203sm1503912wme.30.2019.02.22.06.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:57:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v7 2/7] kernfs: do not alloc iattrs in kernfs_xattr_get
Date:   Fri, 22 Feb 2019 15:57:13 +0100
Message-Id: <20190222145718.5740-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222145718.5740-1-omosnace@redhat.com>
References: <20190222145718.5740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a read-only operation, so we can simply return -ENODATA if
kn->iattr is NULL.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/inode.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index ffd1ef962728..7a7985961bbf 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -31,14 +31,14 @@ static const struct inode_operations kernfs_iops = {
 	.listxattr	= kernfs_iop_listxattr,
 };
 
-static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
+static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 {
 	static DEFINE_MUTEX(iattr_mutex);
 	struct kernfs_iattrs *ret;
 
 	mutex_lock(&iattr_mutex);
 
-	if (kn->iattr)
+	if (kn->iattr || !alloc)
 		goto out_unlock;
 
 	kn->iattr = kzalloc(sizeof(struct kernfs_iattrs), GFP_KERNEL);
@@ -60,6 +60,16 @@ out_unlock:
 	return ret;
 }
 
+static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
+{
+	return __kernfs_iattrs(kn, 1);
+}
+
+static struct kernfs_iattrs *kernfs_iattrs_noalloc(struct kernfs_node *kn)
+{
+	return __kernfs_iattrs(kn, 0);
+}
+
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	struct kernfs_iattrs *attrs;
@@ -306,9 +316,9 @@ static int kernfs_xattr_get(const struct xattr_handler *handler,
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
 
-	attrs = kernfs_iattrs(kn);
+	attrs = kernfs_iattrs_noalloc(kn);
 	if (!attrs)
-		return -ENOMEM;
+		return -ENODATA;
 
 	return simple_xattr_get(&attrs->xattrs, name, value, size);
 }
-- 
2.20.1

