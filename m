Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F606C3B18F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 03:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC1D2168B
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 03:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8Bsd5O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgBND1F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:27:05 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38406 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgBND1C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 22:27:02 -0500
Received: by mail-pl1-f201.google.com with SMTP id t17so4402383ply.5
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 19:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fKf7Qy7FXarC79v0tJzZ3+R2Ba3CQFsER7P1EGsqsHY=;
        b=m8Bsd5O0fYTKXemGllMkb7FkRhDEMVPj/GtwwVndphe2KtvZwDgPMvOndFJ1Me9mR6
         qchUsPUoP5EMZyWtPHuhw/3WRcCKJ9AJpFVvSqDmZYbjLUufy2ZPyY2E1CWK6dvjq+TW
         5/FD9kOtqSSGOtpUCyyqsW5UppSVE95es/30cP5meRBUMbYnjjkHCprogKIm8kn7EnNc
         DUPF38vxu4j3W4ZB28OXlCzWb7otenUgLwLYUb7x9KbAP937VsvwyYvAUPc+BmGY4m0W
         6c3h1C3PFYeapH9/kxLyE5PkmDq3X8R+UfxQj585upTsNCWPx7ZVgF57E1OsvjcEU5Sn
         xSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fKf7Qy7FXarC79v0tJzZ3+R2Ba3CQFsER7P1EGsqsHY=;
        b=bQDsO+jSlQPBuQG2PFfe+k4Q4MnjDtVeUWFxdxQom762aCJQzru7amrRBqlK4WdZXf
         uoQosr5gUyGs/oNFNb9p2ZGcGeSNCqpITwEpm9clAT1SjnUJnQS24HLZjMtxOUES1O22
         XnFzttpZtpe11BZKUBD3Kry6VIQJk4PzupIGua6idjFWKl37nrJEIz5X5RL1HoviVQEz
         Ks4MidBDU+WH/Le9eWukVoxDPbRmXRYFcsLdAx5mTR2iOSNqhnaFCBSO3L7Cz8pAtuBa
         ZVeAZV8ISrprrGeZRJgzVXhQrQQ0YtxUR+0M6R/BomqKcLi7PBpeDPybydQD8kWZjFKv
         yVtQ==
X-Gm-Message-State: APjAAAWdUf7aloo/X/Zb9vqNcgSSE9CLZ7vd3E8NZNTSEvWCWCZCApkR
        YabvPuGlQOtcvkC8DmwyVeWwKSzsJ2U=
X-Google-Smtp-Source: APXvYqz2fnuE3DjoH2Z9nK9q0f7PKQ3B4Sm4/6hfEOXXSIs9x+fZJnAlRyTJsD2KVimPXLIKVGevufbrNME=
X-Received: by 2002:a63:f0a:: with SMTP id e10mr1105943pgl.402.1581650821043;
 Thu, 13 Feb 2020 19:27:01 -0800 (PST)
Date:   Thu, 13 Feb 2020 19:26:34 -0800
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200214032635.75434-3-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 2/3] Teach SELinux about anonymous inodes
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
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
type_transition sysadm_t sysadm_t : file uffd_t "[userfaultfd]";
allow sysadm_t uffd_t:file { create };

(The next patch in this series is necessary for making userfaultfd
support this new interface.  The example above is just
for exposition.)

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 security/selinux/hooks.c | 57 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1659b59fb5d7..6de0892620b3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2915,6 +2915,62 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
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
+		if (IS_ERR(context_isec))
+			return PTR_ERR(context_isec);
+		isec->sid = context_isec->sid;
+	} else {
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
@@ -6923,6 +6979,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
-- 
2.25.0.265.gbab2e86ba0-goog

