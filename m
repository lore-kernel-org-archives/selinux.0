Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C6C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 22:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687352224D
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZFP3fsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgHGWu0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgHGWuY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 18:50:24 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C8AC061757
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 15:50:23 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b18so2746738qte.18
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5LUPe8BT+jHh/tZlanYghI1SrJggIU5nJyl+FoUY+zw=;
        b=SZFP3fsZ2jQjHSSnMI+Z8i/5NI90k34O3AvqbW76psCndf30+itZlYlkH6wYGU2eQ+
         UZgQhQmVZQ5Dw01H1xwXtPGwvxMhqcENTM3IFDc+4tgm2eln9Oa0+F2DQLUFVoZAmkFL
         4yAqkSB8i45M+hEZ4VheqrsQf6zjEib8GMM2TIQpo+a6Oxlmled6yX5X0jDpQ1sqz2bd
         w+5f0XoFNB/0/IKFQM/69VGaaI/Aji0zwITUHJdzeKzsvSVe6CUM3bFZL+9PtZP5tmcl
         x+4dJpKNpBZQdmC8lh1JTHPEbzbwyoGFOlz+cpmLUekQsWUSEnlMmcre9w4x+5gq05NA
         Eluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5LUPe8BT+jHh/tZlanYghI1SrJggIU5nJyl+FoUY+zw=;
        b=Q7KC25SxZlRhm4E9LTUAAg3xjwVENj0aZLKT1zimUqaee7r5eDegx5efy+LX9D5Ogt
         lDsv6e6g/1Uu0TOzUNaXknolCkb/LV8ZMVdfqQv1zDuRZAyqzbrouIML0LfDS7DwRqLu
         COj2Ys6JGI4mpOsxQlZLeX3Spz7Hk3i9QDSj7yxNiL6LfKRDWWt/PWU8BVQkIGt8aaQS
         JSe9DImB0UvAZGKthHvZVVH0+ZUPFKLiv/Bvh2xIVpF2NgqP/9W328J3etBsQ4BW7JKw
         gNb4jlpuryFNW2VpFF2foGHkHGTTgRD+IuA8tlRWM6nW759yHJI/MhAGCL9CiH0XjgaQ
         nuqA==
X-Gm-Message-State: AOAM533MflFO0jJTtoivTRk5J0ruW9AbkQL+Bc17VIl00MB8TGknyJC0
        yQ7rvHXXlXKKKbLQhE0BCgcAoblG8EbHcmSyhw==
X-Google-Smtp-Source: ABdhPJytkJJ1Im9EoucEn8GQ70mfklaLWFe9apw9X6eW8WrUOXqtG852zHNYsyhsZg0X1RHy8lmIHoP6OW3uJ5F2tw==
X-Received: by 2002:a0c:fdeb:: with SMTP id m11mr17231144qvu.103.1596840623013;
 Fri, 07 Aug 2020 15:50:23 -0700 (PDT)
Date:   Fri,  7 Aug 2020 15:49:40 -0700
In-Reply-To: <20200807224941.3440722-1-lokeshgidra@google.com>
Message-Id: <20200807224941.3440722-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200807224941.3440722-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v6 2/3] Teach SELinux about anonymous inodes
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
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ca901025802a..5b403ad44aad 100644
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
@@ -6993,6 +7045,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
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
2.28.0.236.gb10cc79966-goog

