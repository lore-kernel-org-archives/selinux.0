Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD537C4332D
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D04B23AA3
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 22:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAHWXr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 17:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAHWXr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 17:23:47 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C7C0617A5
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 14:22:32 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d84so4663107pfd.21
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6MJ/Mtjmj+33/ewT428wH6PWq4EtZoCoS3wdjfPfGts=;
        b=YYA1E41BAWtjcDPOBAvpekyYblM+e/qSQgBAE3fG3J57Cpks8qgBce0gR9ieQoqLaZ
         4c3I+dF72GHTzEhbVVK7I6bjXiIwriJd3i7MLXn+NjxcgsLgTX8/qZQPsJ6u11Lho/Wr
         Sqd2uqG1w4mI0eEaSxpdjdJlE2/ts+VwwbLvpQAHiG0e06iABStKdD7WPk3USIzKVX1o
         /5eyvtApXAJHhxniqyekk3niTJ4gze+1XcBW+PHFQ6YCp5TJONDi/GQRE2UAE/j7Wvzw
         AIqaUj6vuiTPqrfldlPxVhBvnsJXWxjy25n6o7UMy7nXjdoR7WWgOB+zPTtvQk1htEdp
         ilJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6MJ/Mtjmj+33/ewT428wH6PWq4EtZoCoS3wdjfPfGts=;
        b=swF//MpKOTWzPJSpyS9/bpPSkkJovxe4iGEIYDF3FWnfehyFxXJnX2X2LDse3w/VS5
         HJYVFYpkRQqf4huJgpDFRn7EE1lDIwtgY7sNPO/9iNXHo9ZefrCiM6JHoRWP2FbqjDf0
         ISLHHiB3tOPaZE4aPG6xZ8ChIt5HZoYjTDRiFUQon0HKV/352RWUq4Ys5AulB2r00/Ip
         jQ1WJOCDOTHf0U08C0cMFLbUH7xPXyHMPrM8w1vAGB28lGGVYz3Qcj80Fqy/I2qxRAeC
         oACmhNxYwsyBdmJOHqAxs2c8ANvDIcmdEg9O166hO4QXSNKRhFLBIBEan70V6nrwSDMR
         eEqg==
X-Gm-Message-State: AOAM530oiKQlScLdEdyEl5RgzPvxo2LFHzP0UjdwsW3xxhCtMAtUVW07
        X6RBfxhhpSm7IzHi4QgYP1biSzFMPCh9E/qkAA==
X-Google-Smtp-Source: ABdhPJwY0lzUWT9L/TMGH6EZt5NcZ/C6wl43YButvA43Almybc2Om4XHqPpO7qc0fbJgM8W6mTJzZJLMBF1aThUl5w==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:902:9a4a:b029:dc:435c:70ad with
 SMTP id x10-20020a1709029a4ab02900dc435c70admr8978943plv.77.1610144551518;
 Fri, 08 Jan 2021 14:22:31 -0800 (PST)
Date:   Fri,  8 Jan 2021 14:22:22 -0800
In-Reply-To: <20210108222223.952458-1-lokeshgidra@google.com>
Message-Id: <20210108222223.952458-4-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20210108222223.952458-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v15 3/4] selinux: teach SELinux about anonymous inodes
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Daniel Colascione <dancol@google.com>

This change uses the anon_inodes and LSM infrastructure introduced in
the previous patches to give SELinux the ability to control
anonymous-inode files that are created using the new
anon_inode_getfd_secure() function.

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
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 security/selinux/hooks.c            | 57 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 2 files changed, 59 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 644b17ec9e63..a5e12b2fabde 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2934,6 +2934,62 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	return 0;
 }
 
+static int selinux_inode_init_security_anon(struct inode *inode,
+					    const struct qstr *name,
+					    const struct inode *context_inode)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct common_audit_data ad;
+	struct inode_security_struct *isec;
+	int rc;
+
+	if (unlikely(!selinux_initialized(&selinux_state)))
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
+		if (context_isec->initialized != LABEL_INITIALIZED) {
+			pr_err("SELinux:  context_inode is not initialized");
+			return -EACCES;
+		}
+
+		isec->sclass = context_isec->sclass;
+		isec->sid = context_isec->sid;
+	} else {
+		isec->sclass = SECCLASS_ANON_INODE;
+		rc = security_transition_sid(
+			&selinux_state, tsec->sid, tsec->sid,
+			isec->sclass, name, &isec->sid);
+		if (rc)
+			return rc;
+	}
+
+	isec->initialized = LABEL_INITIALIZED;
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
@@ -7000,6 +7056,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 40cebde62856..ba2e01a6955c 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -249,6 +249,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
+	{ "anon_inode",
+	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }
   };
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

