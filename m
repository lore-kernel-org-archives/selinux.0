Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C66C10F19
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5320657
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfBVO56 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:57:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53942 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfBVO55 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 09:57:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id e74so2218491wmg.3
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 06:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2p+VI6j5gfZjTHNdZ8lX8IuXyHupxAeLlzJqdwI76k4=;
        b=he/s/eOyJt7uh9+/bRtOIJqt/X/idfMISWNfRWJf1JDYY7Xt5eqUHGw9nJ9PAG6Ja1
         hM/WEvM9rpkkEBsdX7fy7+RfquPWm0oepCgnhjXo4TaHszXMRUafQqTQ5Co7vbMT1Mab
         pJv/ZspgBOf7/L+kjOFAAzrSSbO1whtRyuy6hVGm+ibjuOD5b4y0iLuCEPmZ2HRu9hju
         u2Hpw9ZO4QC5+Zd2slYn3Zeepr/Lpq7cJXJLmBlrM6aWyTqjLXP8ufkGKuSMWPOMkEOv
         CYmoH3r2IbmsIsPbtHPFjh/5AGjTj00aysWaoAzfDVRax1nUceSMRYlclLUgDldHVQf6
         pWjw==
X-Gm-Message-State: AHQUAuZGN6oUu6vOw9urx250uc88jK9aIcs17KyC39YOuy25xrKQL/fa
        wZ8zVlEt4eJHmol8NdsR4lrmLTdLZ3WUnQ==
X-Google-Smtp-Source: AHgI3IbwD2JjYuG0PnozoXfx2vXHZ+WE8vRDavFvrpXjInl5zdRsW5+aheACzJ4V5RBxXYqHbxUOxQ==
X-Received: by 2002:a1c:80d6:: with SMTP id b205mr2857712wmd.109.1550847475877;
        Fri, 22 Feb 2019 06:57:55 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 203sm1503912wme.30.2019.02.22.06.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:57:55 -0800 (PST)
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
Subject: [PATCH v7 6/7] selinux: implement the kernfs_init_security hook
Date:   Fri, 22 Feb 2019 15:57:17 +0100
Message-Id: <20190222145718.5740-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222145718.5740-1-omosnace@redhat.com>
References: <20190222145718.5740-1-omosnace@redhat.com>
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
 security/selinux/hooks.c | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f62757b6634..42b576d82d7f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -88,6 +88,8 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
 #include <linux/bpf.h>
+#include <linux/kernfs.h>
+#include <linux/stringhash.h>	/* for hashlen_string() */
 #include <uapi/linux/mount.h>
 
 #include "avc.h"
@@ -3350,6 +3352,68 @@ static int selinux_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+/* kernfs node operations */
+
+int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
+				 struct kernfs_node *kn)
+{
+	const struct task_security_struct *tsec = current_security();
+	u32 parent_sid, newsid, clen;
+	int rc;
+	char *context;
+
+	rc = kernfs_security_xattr_get(kn_dir, XATTR_SELINUX_SUFFIX, NULL, 0);
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
+	rc = kernfs_security_xattr_get(kn_dir, XATTR_SELINUX_SUFFIX, context,
+				       clen);
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
+		u16 secclass = inode_mode_to_security_class(kn->mode);
+		struct qstr q;
+
+		q.name = kn->name;
+		q.hash_len = hashlen_string(kn_dir, kn->name);
+
+		rc = security_transition_sid(&selinux_state, tsec->sid,
+					     parent_sid, secclass, &q,
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
+	rc = kernfs_security_xattr_set(kn, XATTR_SELINUX_SUFFIX, context, clen,
+				       XATTR_CREATE);
+	kfree(context);
+	return rc;
+}
+
+
 /* file security operations */
 
 static int selinux_revalidate_file_permission(struct file *file, int mask)
@@ -6796,6 +6860,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 
+	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
+
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
-- 
2.20.1

