Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0216DC2D0A3
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 05:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F0920825
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 05:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQyRpCsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgKLFiP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 00:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgKLByN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 20:54:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD8C061A56
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 17:54:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e142so1079570ybf.16
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 17:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=c9Og5DC1k1cUQRw8CGbu3hvhZccACMgaVukw9TXsnBk=;
        b=SQyRpCskDDQyjOj6Y7KQvyf3aH7p5CeESVkOzrwBVOw1wcZF5i6plpZZMnli4dRCk7
         KoIwO3P2UyZnp6UypXtHWy5M2Dap/44fsRQwyPpwXGdkVenFWanSIFIsv8SGfQcvEbdD
         o3eZGOw8xs9KPTNqy27mnkEv64rarQjcTaWJnxSDIWKqLGZwr5qem3oI89F0v3cxeyAU
         j/PhrDuI/dRIqJ5zGSIoLc1kEtTjSQdSW91Q0HjlOPZvrgj3pxvwZiNTwhAZwfq7bafH
         2sxTzHwcbexnyW7lTYQKJQZnTscocjiFdeH1tr0iAXvu/jrYNsRGNcaV10CkQ6IUrf/I
         8iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9Og5DC1k1cUQRw8CGbu3hvhZccACMgaVukw9TXsnBk=;
        b=hC+/sxbbdrqziRZc8c4xqf+FdG7qfZVWbJtN0kOb2AOvdQHyt7RNl03ZkBDZEDef5H
         OLZyYZK43zmp32CpZEKe93bzXtYMgYFdg4vc44WMxGZqqP1ecmPwbQ/sym43lDjAZ8E0
         rhtfg+JzxsXrlRceYlUuyjpPg7mMORsirqoXMX3VophvQCeWZf7thXS9QUs2fTnvmz+r
         04uDCnAuREh/0CtLkygILK0Ko2AlMgocH6EJ0RoaeSSDrkSuZUFrjEOwN120WekIHOrm
         apKUZ9bE2cWXRj1U9YUlD/vfZf07YI+H23C4ktnog/VLTdNVdTmf1HICzyBPiYRCeaER
         VUQw==
X-Gm-Message-State: AOAM532aLeMHA86MK2rn2NbNFtxJsksnh3tiMIhYRvvXe9AiKFETnk1P
        rGi1xi0GIAcBnzu0wy7VpuJTxTjzJNo6o6mhiw==
X-Google-Smtp-Source: ABdhPJwbEExJZLbWaATpLGAop1r2dI05u8VEsbPmkQZCo1UtYBTDWpESrtyVB/fsRM0ZspxgBdPVqcsf9LpufrRfvw==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:5702:: with SMTP id
 l2mr38652087ybb.184.1605146048341; Wed, 11 Nov 2020 17:54:08 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:53:56 -0800
In-Reply-To: <20201112015359.1103333-1-lokeshgidra@google.com>
Message-Id: <20201112015359.1103333-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v13 1/4] security: add inode_init_security_anon() LSM hook
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
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Eric Biggers <ebiggers@google.com>
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
index 32a940117e7a..435a2e22ff95 100644
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
index c503f7ab8afb..3af055b7ee1f 100644
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
index bc2725491560..7494a93b9ed9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -323,6 +323,9 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_inode_init_security_anon(struct inode *inode,
+				      const struct qstr *name,
+				      const struct inode *context_inode);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len);
@@ -737,6 +740,13 @@ static inline int security_inode_init_security(struct inode *inode,
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
index a28045dc9e7f..8989ba6af4f6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1058,6 +1058,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
2.29.2.299.gdc1121823c-goog

