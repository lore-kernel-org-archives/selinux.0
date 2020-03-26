Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4AC2D0EC
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0832073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 18:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXA5gS6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCZSPY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:15:24 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:37513 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgCZSPW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 14:15:22 -0400
Received: by mail-pj1-f74.google.com with SMTP id d9so4911988pjs.2
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9GDXsfdPczBi7v6sQvXYnauY2/NgUYZJiwGuOoj9VaM=;
        b=AXA5gS6SkSmd0/XuDxbbqNVaCihLDe9+DmMAZcsBrzmrtTpSW7/rl+hyD7F6T2jA+l
         cdMN7WpPpdDFzVeeBCYY1AUl7GpaZ1Db3vhI9cCX2HylCgJ7lHkWPWwtcNmxbW14CnCR
         S3emEKPzIKKv4RNY5kk1UyJvwjD+mi6SHYyj9LaBEqy1l5ATak4ev+4W0J+YD7Zrx/sG
         nuWlJwd2ON0rWDSA1Hzt0tZYt8Veq7dH8iq/R5jTwf2VSvd38+yGKT9gMvXq20hHcAQC
         EdilpRDOkpjD4DXinfQNe4rWYvb9abbqcotitsgNMPkhg9FvMoWzfmlfPUM0AqRvSiPx
         ALyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9GDXsfdPczBi7v6sQvXYnauY2/NgUYZJiwGuOoj9VaM=;
        b=RCB6d8/wPGE/18Tfz0E0klf6dq461t+8BauD0PNlx7Cc/vE4oquBrQT1ekMsxPANCf
         ageu7FZ7WH4zjWGDPben212GynKzKFzS84zyqACd4GzXZb+zzBqcDZVSPQ/pxLpIgnvP
         NRNoBamx1OgqyvUZgaPqHc8oJfZI9FQdHbgyyn1NYFn3hOt2m4IKz9M0AQ5OmTOwvU1E
         AlFsE4jj7KXJmVUdUnZRqmo7Nn5x/T4G/sxs5eB45fqLoDk82rQ+h3Saj9+ydM8plcqj
         fkxfHLncuQv/GWnSaSQO6lV84pW997Z4GMIP0UEdZJw+su3E8cQjGGEJTu8EKgx2KlYw
         /CEA==
X-Gm-Message-State: ANhLgQ1vMo8WUZxLMfsVebOqKjOfHi4BsiZAmowRopgT5XN92Rmr4Mxj
        3xRf4QRbQ1+JgxkpKjLSpu+a6F4ED4Y=
X-Google-Smtp-Source: ADFU+vuSN0yISqvXhTDaFBgwUzE9zYiTA6xLb5Jqy1lqmi6Or7i+l9KljGPyXE07LbTrKwVVneYQ+TQnMzc=
X-Received: by 2002:a17:90a:be0b:: with SMTP id a11mr1407192pjs.56.1585246521251;
 Thu, 26 Mar 2020 11:15:21 -0700 (PDT)
Date:   Thu, 26 Mar 2020 11:14:55 -0700
In-Reply-To: <20200326181456.132742-1-dancol@google.com>
Message-Id: <20200326181456.132742-3-dancol@google.com>
Mime-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com> <20200326181456.132742-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3 2/3] Teach SELinux about anonymous inodes
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This change uses the anon_inodes and LSM infrastructure introduced in
the previous patch to give SELinux the ability to control
anonymous-inode files that are created using the new _secure()
anon_inodes functions.

A SELinux policy author detects and controls these anonymous inodes by
adding a name-based type_transition rule that assigns a new security
type to anonymous-inode files created in some domain. The name used
for the name-based transition is the name associated with the
anonymous inode for file listings --- e.g., "[userfaultfd]" or
"[perf_event]".

Example:

type uffd_t;
type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
allow sysadm_t uffd_t:anon_inode { create };

(The next patch in this series is necessary for making userfaultfd
support this new interface.  The example above is just
for exposition.)

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 security/selinux/hooks.c            | 54 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1659b59fb5d7..b9eb45c2e4e5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2915,6 +2915,59 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	return 0;
 }
 
+static int selinux_inode_init_security_anon(struct inode *inode,
+					    const struct qstr *name,
+					    const struct file_operations *fops,
+					    const struct inode *context_inode)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct common_audit_data ad;
+	struct inode_security_struct *isec;
+	int rc;
+
+	if (unlikely(!selinux_state.initialized))
+		return 0;
+
+	isec = selinux_inode(inode);
+
+	/*
+	 * We only get here once per ephemeral inode.  The inode has
+	 * been initialized via inode_alloc_security but is otherwise
+	 * untouched.
+	 */
+
+	if (context_inode) {
+		struct inode_security_struct *context_isec =
+			selinux_inode(context_inode);
+		isec->sclass = context_isec->sclass;
+		isec->sid = context_isec->sid;
+	} else {
+		isec->sclass = SECCLASS_ANON_INODE;
+		rc = security_transition_sid(
+			&selinux_state, tsec->sid, tsec->sid,
+			SECCLASS_FILE, name, &isec->sid);
+		if (rc)
+			return rc;
+	}
+
+	isec->initialized = LABEL_INITIALIZED;
+
+	/*
+	 * Now that we've initialized security, check whether we're
+	 * allowed to actually create this type of anonymous inode.
+	 */
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	return avc_has_perm(&selinux_state,
+			    tsec->sid,
+			    isec->sid,
+			    isec->sclass,
+			    FILE__CREATE,
+			    &ad);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -6923,6 +6976,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..263750b6aaac 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -248,6 +248,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
+	{ "anon_inode",
+	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }
   };
 
-- 
2.25.1.696.g5e7596f4ac-goog

