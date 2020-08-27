Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521ACC433E4
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 06:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5AE22B4D
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 06:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wHwCCfOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgH0Gfn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgH0Gfd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 02:35:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC1C061233
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 23:35:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so6093525yba.12
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 23:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pLxaBib0LMkN4D4wR9hiVJIAOm60ZZrqLyNtSVQ6McE=;
        b=wHwCCfOVlKR+vTkeXOUL2ZliPAhdFBIlxDc+gQIk+nJ0ruhpVVIEiioyadTtOxwW/B
         NyuwpzBLYY3JGG7d+DpNz3uLscGKU6ea+m6fDZpubsy5qULyWo6c2LELhhZ8Z0TNUBOG
         PfNN8Ei1PEtGLZkBRw/S+v+P5zmDovIfN/LOcml/Fi4tlH1a3zFKu2wNbqxNg6hNQSvt
         ZSP9dzkUWMUOeMjxtihy6F0HFKpCTn+5DjFovfX1C6lXdKyS5hlMvI1r7fcOXVYJVFSt
         0W23vbW7N7snvf4TnYXDLNbzRwzfitJxfDqKLLWpquCKn7MdxeL/31xHWswe6qLOwOv/
         Cs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pLxaBib0LMkN4D4wR9hiVJIAOm60ZZrqLyNtSVQ6McE=;
        b=Rjzb85y7dR267aEZOeV0vWZJ3AW9ZtsR/NVoikfrXwDMJLb3YY4rPFOXdX3CWa9T/q
         qz5+UyrDZENqVBI7EqEnsAp60L/Fl9J9Eu2Fzip90+mu4uNdO+mF6eQCTCAA4x7o2W1t
         viohppKeZdVij3lmdzx/tMHL7NGvj26LhPUz5P80ExC+quhDpsxvwAYoaCyTVG/G/rhm
         vun1MMLi05ipbLVGYTAxZMRsgD3Da30w+BikSshgUrn1bARjz/guOvNqbwTozwKX4iKx
         pdwEq88d5wePUA2iJtnIDAnflolk6sWl1zAC+Oh0tBR/AlnkIK5iryCR2cPcGSrsvPBr
         VHBQ==
X-Gm-Message-State: AOAM531ig8H5qMFEeA2biiymVtUo8s6ncMIyaI83W0Esu1lA9WNuJ1xR
        6qV6JLYH9NOl7AVnzamWSpEmoFclJzf2/S0Oug==
X-Google-Smtp-Source: ABdhPJz66lEBcU2uHus1V086mNXk3LCt5yHkf8vbymGDl41kU7EQRALFBPJs7iT+92xVfsT0baMMKGLnl7YUkNR0tQ==
X-Received: from lg.mtv.corp.google.com ([100.89.4.209]) (user=lokeshgidra
 job=sendgmr) by 2002:a25:ab0d:: with SMTP id u13mr28407715ybi.248.1598510132559;
 Wed, 26 Aug 2020 23:35:32 -0700 (PDT)
Date:   Wed, 26 Aug 2020 23:35:21 -0700
In-Reply-To: <20200827063522.2563293-1-lokeshgidra@google.com>
Message-Id: <20200827063522.2563293-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200827063522.2563293-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v8 2/3] Teach SELinux about anonymous inodes
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Daniel Colascione <dancol@google.com>

This change uses the anon_inodes and LSM infrastructure introduced in
the previous patch to give SELinux the ability to control
anonymous-inode files that are created using the new anon_inode_getfd_secure()
function.

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
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a340986aa92e..b83f56e5ef40 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2926,6 +2926,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
+			isec->sclass, name, &isec->sid);
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
@@ -6987,6 +7039,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
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
2.28.0.297.g1956fa8f8d-goog

