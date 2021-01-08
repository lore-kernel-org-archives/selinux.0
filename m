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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF47C433E9
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 05:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCA82368A
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 05:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbhAHFeJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 00:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbhAHFeF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 00:34:05 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC86C0612FE
        for <selinux@vger.kernel.org>; Thu,  7 Jan 2021 21:33:04 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id b8so7435387qtr.18
        for <selinux@vger.kernel.org>; Thu, 07 Jan 2021 21:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4KH1yzDb8snTvZnWPZ6fdUzRnCevlmVN32CkdvE/ol0=;
        b=OooG9vnAq2ysyycbcX08KiXI5S0HJbbgcA9Z9Oe2Ez2suyGyVQeZttS0HO9/+UCX/V
         PjCh7xJBw+TdGVoIZS/5qgRIm1qmo97LfRBqabAIBI1eElk2H8vl7Iq2/mJF/OvpbxZv
         S2DHBKn5hwyOvzL+cFt33QWpegpu0/4RIQXbtBugszlnBsVDw6iZPwE3EwdLtZnuE4jb
         iXk8Ya9/XnKUJPuZ9NKZuMg0V/wwMZIaYhIfU5f7QeWo9mpEC+S7/MxUfwosRALlsS7z
         VyixOvAGTgm5BqbxTBEz6lPVVpEjwtub+alQLQhkEdpqshrKURlxVPoAjGWDT9RlyPXj
         UuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4KH1yzDb8snTvZnWPZ6fdUzRnCevlmVN32CkdvE/ol0=;
        b=JBbShHKowKLIgK3fLgrIFozdJ2fU922BkHLeF9jlB5hp3+dzRCivNGaQEdmEKF4uqe
         2CMg+Zikd0DnZPOly4cgaUOpcyLOXs/x52uhIKWWuTHkBQM3SybD0myqZFjH81elLbZH
         T3E25KZrVp9rvFtmI05ywq40JdYsB6Btp0ILmQkGoxoyMIi73a2w6+XF0EdHxY6SeOAa
         KsgLm5xVd3SwtQjKcrVDpbac/xctlE8YF3o8O192+/skh4Ki4SHyg4S8MEJQEoPzPQC0
         Un9bVodKc3Xuczltv4mweyx8eOTqZK2u/BbDPxV7/6XfolC6vCalVwubP33BxemXiSg7
         njxA==
X-Gm-Message-State: AOAM530S6zxIpN3DFPm2ZApR5px5cTQwUf7sVVZBvixKZPPDuEXqzzlL
        lShZzmaj/Ah6SUYmuVhuxYJkMcVyfPeKcKE8JQ==
X-Google-Smtp-Source: ABdhPJxe5Xp0qHN/Ia6xoJMR+ESmUkHT1cbbplCD/GFyfD/HcPhZbdQJMkeXAwcx0bM8pckO4liRgJmF06RFMLCLzQ==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a0c:bd2b:: with SMTP id
 m43mr2274696qvg.32.1610083983055; Thu, 07 Jan 2021 21:33:03 -0800 (PST)
Date:   Thu,  7 Jan 2021 21:32:56 -0800
In-Reply-To: <20210108053259.726613-1-lokeshgidra@google.com>
Message-Id: <20210108053259.726613-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20210108053259.726613-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v14 1/4] security: add inode_init_security_anon() LSM hook
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

This change adds a new LSM hook, inode_init_security_anon(), that will
be used while creating secure anonymous inodes. The hook allows/denies
its creation and assigns a security context to the inode.

The new hook accepts an optional context_inode parameter that callers
can use to provide additional contextual information to security modules
for granting/denying permission to create an anon-inode of the same type.
This context_inode's security_context can also be used to initialize the
newly created anon-inode's security_context.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           |  8 ++++++++
 4 files changed, 29 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7aaa753b8608..dfd261dcbcb0 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -113,6 +113,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, const char **name,
 	 void **value, size_t *len)
+LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
+	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
 LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a19adef1f088..bdfc8a76a4f7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -233,6 +233,15 @@
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
+ * @inode_init_security_anon:
+ *      Set up the incore security field for the new anonymous inode
+ *      and return whether the inode creation is permitted by the security
+ *      module or not.
+ *      @inode contains the inode structure
+ *      @name name of the anonymous inode class
+ *      @context_inode optional related inode
+ *	Returns 0 on success, -EACCES if the security module denies the
+ *	creation of this inode, or another -errno upon other errors.
  * @inode_create:
  *	Check permission to create a regular file.
  *	@dir contains inode structure of the parent of the new file.
diff --git a/include/linux/security.h b/include/linux/security.h
index c35ea0ffccd9..b0d14f04b16d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -324,6 +324,9 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_inode_init_security_anon(struct inode *inode,
+				      const struct qstr *name,
+				      const struct inode *context_inode);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len);
@@ -738,6 +741,13 @@ static inline int security_inode_init_security(struct inode *inode,
 	return 0;
 }
 
+static inline int security_inode_init_security_anon(struct inode *inode,
+						    const struct qstr *name,
+						    const struct inode *context_inode)
+{
+	return 0;
+}
+
 static inline int security_old_inode_init_security(struct inode *inode,
 						   struct inode *dir,
 						   const struct qstr *qstr,
diff --git a/security/security.c b/security/security.c
index 7b09cfbae94f..401663b5b70e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1059,6 +1059,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+int security_inode_init_security_anon(struct inode *inode,
+				      const struct qstr *name,
+				      const struct inode *context_inode)
+{
+	return call_int_hook(inode_init_security_anon, 0, inode, name,
+			     context_inode);
+}
+
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

