Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC421C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 13:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbhLFN1j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Dec 2021 08:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242009AbhLFN1i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Dec 2021 08:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638797049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GE8rS8B7TgD3oAAB+bsdlmZuYbB0s8Cq6GpzoDwBv7g=;
        b=X+e+KzkTmhz9p9q1R8JrHXeSBupG52rCQY+re89lICwVD+9JQRcUkbASTHWEnapE4ESF8A
        nCPcnxBeP2w/3UN3UJOB7i4fnEpR7VPfRrW6uqoqvJda/0HMA5yKfShbkgTHPAu05vuWlL
        FG84m/zQ0mKfDHvoaMMQhMAWERCDN2c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-LCSitU4eMoGcJAqBjMnzzA-1; Mon, 06 Dec 2021 08:24:08 -0500
X-MC-Unique: LCSitU4eMoGcJAqBjMnzzA-1
Received: by mail-ed1-f69.google.com with SMTP id v1-20020aa7cd41000000b003e80973378aso8301391edw.14
        for <selinux@vger.kernel.org>; Mon, 06 Dec 2021 05:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GE8rS8B7TgD3oAAB+bsdlmZuYbB0s8Cq6GpzoDwBv7g=;
        b=5wcHRwjOHpluKHyJkSyxbPnpuSfsTRVgQsgu0dkR6CAMcjwI9R7KUpFA4KyJxZhJhl
         s38e1MyEVGzVdYu87JRfv7igYfETmRbJba9bdpUWGXFjk0iaKSGnhYtRvTkLbL52kQPF
         x//H6NFYqByv/3Dk8ov/3/rAxMMcyBl1MN9o3xepR5SjElEISotCKlVFZUP57AFek9SM
         Y9LQkzXSUGKx7N4MBgmdTOJjj3Hfmz5+9jFy4xDAz+onx4DLCdVj4AScawHXB0I2K473
         9+dlDTfLIFhmxEV1dcq1q5Rl7wEjzL8JGp4lG1759C9T+Htr/18xJwhINC7r015Sf4do
         7T7g==
X-Gm-Message-State: AOAM532Z7eMzbK/6zdzZCIJ57+iEzqp3oTqUCoyOnCmDR073ZlxukEzY
        aTwpLsVe0faH0vV76HSSvwEtqKRMrKqYC78HYpBkSnOTGb06QFeJUPOyuGpmu9GlmFEnTd/hCde
        kzTjcf6Ya4jC1NPwxqg==
X-Received: by 2002:a17:906:4dd0:: with SMTP id f16mr44063502ejw.454.1638797047662;
        Mon, 06 Dec 2021 05:24:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJya0mVj56ngOA1ahoNflPjokyKEwdsaRAqOEsv4zX6Y9gdF0qFE2FqW+wSCQhYK1T99c5Jjsw==
X-Received: by 2002:a17:906:4dd0:: with SMTP id f16mr44063489ejw.454.1638797047471;
        Mon, 06 Dec 2021 05:24:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id nd36sm7003806ejc.17.2021.12.06.05.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 05:24:06 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH] security,selinux: remove security_add_mnt_opt()
Date:   Mon,  6 Dec 2021 14:24:06 +0100
Message-Id: <20211206132406.235872-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Its last user has been removed in commit f2aedb713c28 ("NFS: Add
fs_context support.").

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h |  2 --
 include/linux/lsm_hooks.h     |  2 --
 include/linux/security.h      |  8 -------
 security/security.c           |  8 -------
 security/selinux/hooks.c      | 39 -----------------------------------
 5 files changed, 59 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index df8de62f4710..7f5c35d72082 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -78,8 +78,6 @@ LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
 LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
 	 struct super_block *newsb, unsigned long kern_flags,
 	 unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, sb_add_mnt_opt, const char *option, const char *val,
-	 int len, void **mnt_opts)
 LSM_HOOK(int, 0, move_mount, const struct path *from_path,
 	 const struct path *to_path)
 LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d45b6f6e27fd..73cb0ab2bc03 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -180,8 +180,6 @@
  *	Copy all security options from a given superblock to another
  *	@oldsb old superblock which contain information to clone
  *	@newsb new superblock which needs filled in
- * @sb_add_mnt_opt:
- * 	Add one mount @option to @mnt_opts.
  * @sb_parse_opts_str:
  *	Parse a string of security data filling in the opts structure
  *	@options string containing all mount options known by the LSM
diff --git a/include/linux/security.h b/include/linux/security.h
index bbf44a466832..a4f0c421dd0c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -313,8 +313,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags);
-int security_add_mnt_opt(const char *option, const char *val,
-				int len, void **mnt_opts);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
@@ -711,12 +709,6 @@ static inline int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 	return 0;
 }
 
-static inline int security_add_mnt_opt(const char *option, const char *val,
-					int len, void **mnt_opts)
-{
-	return 0;
-}
-
 static inline int security_move_mount(const struct path *from_path,
 				      const struct path *to_path)
 {
diff --git a/security/security.c b/security/security.c
index c88167a414b4..0c49a1f05ac4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -994,14 +994,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
-int security_add_mnt_opt(const char *option, const char *val, int len,
-			 void **mnt_opts)
-{
-	return call_int_hook(sb_add_mnt_opt, -EINVAL,
-					option, val, len, mnt_opts);
-}
-EXPORT_SYMBOL(security_add_mnt_opt);
-
 int security_move_mount(const struct path *from_path, const struct path *to_path)
 {
 	return call_int_hook(move_mount, 0, from_path, to_path);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..8ea92f08e6bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1023,44 +1023,6 @@ Einval:
 	return -EINVAL;
 }
 
-static int selinux_add_mnt_opt(const char *option, const char *val, int len,
-			       void **mnt_opts)
-{
-	int token = Opt_error;
-	int rc, i;
-
-	for (i = 0; i < ARRAY_SIZE(tokens); i++) {
-		if (strcmp(option, tokens[i].name) == 0) {
-			token = tokens[i].opt;
-			break;
-		}
-	}
-
-	if (token == Opt_error)
-		return -EINVAL;
-
-	if (token != Opt_seclabel) {
-		val = kmemdup_nul(val, len, GFP_KERNEL);
-		if (!val) {
-			rc = -ENOMEM;
-			goto free_opt;
-		}
-	}
-	rc = selinux_add_opt(token, val, mnt_opts);
-	if (unlikely(rc)) {
-		kfree(val);
-		goto free_opt;
-	}
-	return rc;
-
-free_opt:
-	if (*mnt_opts) {
-		selinux_free_mnt_opts(*mnt_opts);
-		*mnt_opts = NULL;
-	}
-	return rc;
-}
-
 static int show_sid(struct seq_file *m, u32 sid)
 {
 	char *context = NULL;
@@ -7298,7 +7260,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
-	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
 #endif
-- 
2.33.1

