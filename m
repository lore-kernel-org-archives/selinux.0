Return-Path: <SRS0=8IdP=EM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54021C4741F
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38952067C
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUHYQlCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKFP4j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Nov 2020 10:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgKFP4h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Nov 2020 10:56:37 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BAC0613D4
        for <selinux@vger.kernel.org>; Fri,  6 Nov 2020 07:56:36 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i20so1196862qtr.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2020 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bu5Eked262Yqjy7vLc/7v5hG2v0AiZ5jBwjzS/hxCOs=;
        b=tUHYQlCoc1s5aYJya18uS22d3UTuNreyZaKH6b0+Ng+PkQNmxnwx/JRRmeKT/1/OcR
         frWxCzVol+m7glkfQxEe73L334XNz/jIEy+tEgEZUXRq3RkFUIyCQu3x7Rr4CyiJ/wXO
         9ySAck5isc2WeflM37CgZNunVBJ8j821EZYJ+kAgIeVVTRzZfU7+YbZjck9gyOOBW7nW
         WROEbsyT+zeadQHQRTJi7J66JE/EJCU32eUBVmtJ7PBQluRf9Y0/vshho6deYxMWhZko
         VN7pFN0kLzw9/HQKP08olKfvHXlzt5rZtGai+w7yJ2bKtseW3mYGE20jP55W/6ksA0VZ
         9lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bu5Eked262Yqjy7vLc/7v5hG2v0AiZ5jBwjzS/hxCOs=;
        b=QfNJeRxCQAj+U8Ooll16j2K31tGxnOAuK9iVIz8lsMFxhHNg7nJWaxHAKq2SKPp57M
         a+SOaZSrO6rsgDNS9Xwwb36Ei6sa5QS/3E6Z8XiazEDULCfqfgavnuEajXO47hymHxs4
         jmNzUcbrMRYKBQmtbGndpkqN0tmFdqC1/4BPVIQqJg19CxgzRF6Ve//uIZDlbZzGR4SB
         /lTto2TF23xduj5bQ9wdAHWrQ3CEi95+kIQ02hkYPqU6Evq/qRRqfC0G8xRBRd3JGyq4
         Nv+m+QRr/k4pd2SzAeMn3zmv9RURusM0vBYxgLopk873+suGsVxPo3xlw872wh6SVQpR
         xyXw==
X-Gm-Message-State: AOAM533jK3naqBsVn7rrm2LGlgAWLAQ0SuX3zQY5yKMYZGZITcC8FTln
        zH6/yLeKAmSD0omNiXCbW7c4b1Xx/4mC5aREeA==
X-Google-Smtp-Source: ABdhPJx+CvqAWS4teVk5tHn3xTDEntP/bcjs0s4pTYnq0DlDWFNArmUzSNYmwEA+ClpRT/MWBvBIXsXRX4Fbm0AB8w==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a0c:e40c:: with SMTP id
 o12mr2222905qvl.29.1604678195875; Fri, 06 Nov 2020 07:56:35 -0800 (PST)
Date:   Fri,  6 Nov 2020 07:56:23 -0800
In-Reply-To: <20201106155626.3395468-1-lokeshgidra@google.com>
Message-Id: <20201106155626.3395468-2-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 1/4] security: add inode_init_security_anon() LSM hook
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org
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
2.29.1.341.ge80a0c044ae-goog

