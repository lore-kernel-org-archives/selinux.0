Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D6C10F04
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC51222A4
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438061AbfBNJue (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:50:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34506 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406226AbfBNJuc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 04:50:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so5755500wrg.1
        for <selinux@vger.kernel.org>; Thu, 14 Feb 2019 01:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfDKifGipwVLvnoTRSRsrIQ0C5r1C/KhRwkZEcbpnOY=;
        b=Nu8oz1Q8YSIiSYvaUnUhBbq46s5SZamb6OYSy5WwFI0kq3wXZ2DLYn+WiX2HEcYQiV
         nD3OMIhCA5gnYFLYO29BtoMq/mDjlDI82hB9sUjDugk2ZbVuXTOYTzG9I/lbq+J3n8ap
         sO45BVXZJOEFVXP99Tv0IX4VoDEyx5m028t9m70fzKS0pndLptkcur1XmEXjPiyKeaFM
         nY6hv4DKkK22hqyDoHAHmIFLb0RZ/fDfrM6BuQxivLyKGmUZ+E60TFphaGT58N5ZvGCk
         Aqgl5Lm5x/RcR79RThKeLxRA9gnslZeicnwAy8aGDzO+pACQrhiPGOdmUCZ+Nic3WhWQ
         fJaQ==
X-Gm-Message-State: AHQUAuaoRuBFoRXE/LULusJX/v+ybShugoeTF8fBVkFB9ebLK+B7XeID
        iOoPGDnN7eFD+YegHGCEhW6GIF6OQRw=
X-Google-Smtp-Source: AHgI3IYvCc23OZb39tXAuHgt3WZgILGQQQya80F9ofW+dOFpaiyXrr35QJu7D+bC15riWM21EUjt+w==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr2206453wrp.164.1550137830914;
        Thu, 14 Feb 2019 01:50:30 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g11sm969439wmk.26.2019.02.14.01.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:50:30 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v6 4/5] selinux: implement the kernfs_init_security hook
Date:   Thu, 14 Feb 2019 10:50:14 +0100
Message-Id: <20190214095015.16032-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214095015.16032-1-omosnace@redhat.com>
References: <20190214095015.16032-1-omosnace@redhat.com>
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
index 7dea5b1a89a3..2b72aa50392d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3353,6 +3353,66 @@ static int selinux_inode_copy_up_xattr(const char *name)
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
@@ -6799,6 +6859,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 
+	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
+
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
-- 
2.20.1

