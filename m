Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762BBC282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536AF2083B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 08:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfBEI7i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:59:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36369 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfBEI7g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 03:59:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so2716021wrv.3
        for <selinux@vger.kernel.org>; Tue, 05 Feb 2019 00:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/UgfA2b1LMjP8l3IHGLgf3GGlVLs/lH9BS+aBvDM2I=;
        b=twvfGghjwJytLK3GQqmsyd6fJUERikcDPvk1zgkT8gP+5fJ9e7R28DD6GbassJ820a
         u78pNv1NPIIW/ONLrVum+Zx5sOs383r515gkdVGodahyqTNK+JFtEyxb0eeTgzj5E9VW
         NgRtdJ3ddCgYafL6jPeOuH1QmcmFPrUBnNtd+fUXzMTNMj8YO4X25AJge5b0Z2ymutK8
         FIO1NkyCcg+4vukXjGkQI/PakDEwtiAxi30NzZjJrtch8BSqcAXUEpZnrDtIZd7H98Gj
         xJwfpDc7Xe6YlbHGjh7ccYTmRogZpIH3SG6t50kMgSL01ZEzxj4DVQzKEF9Ysf9RjwtG
         hkzA==
X-Gm-Message-State: AHQUAuZWuOUSCmP1R9WWaSpfYc/6pc84o5vpQ/pwdq13SWHrbFhOWRkb
        uIZL/T8X3KuFzf0FHPi/S80zicUAsyk=
X-Google-Smtp-Source: AHgI3IZl9A0gP5If4OdooT8IzDoGj3MoCs9lb1qA5iNvrkFls0IE2Ln+p34y4+WANoodZUlRpc9DPQ==
X-Received: by 2002:adf:e846:: with SMTP id d6mr2827755wrn.72.1549357174614;
        Tue, 05 Feb 2019 00:59:34 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n82sm12973613wma.42.2019.02.05.00.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 00:59:33 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v4 4/5] selinux: implement the kernfs_init_security hook
Date:   Tue,  5 Feb 2019 09:59:14 +0100
Message-Id: <20190205085915.5183-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205085915.5183-1-omosnace@redhat.com>
References: <20190205085915.5183-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The hook applies the same logic as selinux_determine_inode_label(), with
the exception of the super_block handling, which will be enforced on the
actual inodes later by other hooks.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 758a99d1086e..e013cc02de50 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3354,6 +3354,66 @@ static int selinux_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+/* kernfs node operations */
+
+int selinux_kernfs_init_security(const struct qstr *qstr,
+				 const struct iattr *dir_iattr,
+				 struct simple_xattrs *dir_secattr,
+				 const struct iattr *iattr,
+				 struct simple_xattrs *secattr)
+{
+	const struct task_security_struct *tsec = current_security();
+	u32 parent_sid, newsid, clen;
+	int rc;
+	char *context;
+
+	rc = simple_xattr_get(dir_secattr, XATTR_SELINUX_SUFFIX, NULL, 0);
+	if (rc == -ENODATA)
+		return 0;
+	else if (rc < 0)
+		return rc;
+
+	clen = (u32)rc;
+	context = kmalloc(clen, GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+
+	rc = simple_xattr_get(dir_secattr, XATTR_SELINUX_SUFFIX, context, clen);
+	if (rc < 0) {
+		kfree(context);
+		return rc;
+	}
+
+	rc = security_context_to_sid(&selinux_state, context, clen, &parent_sid,
+				     GFP_KERNEL);
+	kfree(context);
+	if (rc)
+		return rc;
+
+	if (tsec->create_sid) {
+		newsid = tsec->create_sid;
+	} else {
+		u16 secclass = inode_mode_to_security_class(iattr->ia_mode);
+
+		rc = security_transition_sid(&selinux_state, tsec->sid,
+					     parent_sid, secclass, qstr,
+					     &newsid);
+		if (rc)
+			return rc;
+	}
+
+	rc = security_sid_to_context_force(&selinux_state, newsid,
+					   &context, &clen);
+	if (rc)
+		return rc;
+
+	rc = simple_xattr_set(secattr, XATTR_SELINUX_SUFFIX, context, clen,
+			      XATTR_CREATE);
+	kfree(context);
+	return rc;
+}
+
+
 /* file security operations */
 
 static int selinux_revalidate_file_permission(struct file *file, int mask)
@@ -6800,6 +6860,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 
+	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
+
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
-- 
2.20.1

