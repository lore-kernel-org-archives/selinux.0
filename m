Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2BCC433F5
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 14:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E41613A7
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 14:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbhI2O0V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbhI2O0U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Sep 2021 10:26:20 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9FC06161C
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 07:24:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d8so2435756qtd.5
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pqP12otaejcAOMxYhj6m/yEhZN0YUIMMEnuXr5nAH/Y=;
        b=ymXReKG0d1RUjjE2hyi/cX9PkUlQsoFAFh1JQzVhWqHfh6f5l8X2aoM+zqUngIEhy5
         OOWcwtisSmcKRFLXQSrGHxLztZcgMRQYdzfqLk5k+2+yS2SDaa4LcnFfIO7AUbyjwdIP
         HuFMmzRVtrGOHqahf8st31vQZ8xElt0wMUtK518kr1eykBx2pL+spiiw+i0GwRNz2AJ8
         e60SATfOQejuwksia8PvfhAEeoxS08u0ggywWb5dlEpFdpM9OzflkfkyiUhAap0qOJ7D
         4+ZOJv1FS9ozqNXmMqHLfnmKeHa4k1hOsTtsJICYg5N+HnxvNDPLlknE5gU0DAu7u1Vc
         NTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=pqP12otaejcAOMxYhj6m/yEhZN0YUIMMEnuXr5nAH/Y=;
        b=QjzabBXfr8YTyDc/+K7BoW7KD/VcnpsN+bMSEiDfRxNxuaApH+hV/rTZz2LcXw8i/X
         yfSf+jySrBCpCF7w6ZFtzUJFjgNhI4aDf40GhJ7ddSYWOKQqX5YXQOn+myJYf2eEEn7l
         pDcG019UEs9nhWnv6OJQJgWLYtl3tqduzLrHP8Lw+GsxBzOLs5dg23/bqamaeNMjrmqb
         bUvfVtQFc/OXU9pUTSzDBYCeWxRR9zQj/Ig3OloqhK2RJhGxZO8ttUlYDNl/T2wZzJ6H
         qCfHN1d2cd08djldOkZKzrnEErMuypQE/c9yQUSXiXlsp6VLiqSjhd7AG2LqLyZ/E90+
         0JZQ==
X-Gm-Message-State: AOAM531TmGYE93uN/Ql0QTu0UPArpNitL/IMy7OCnd4ZBHv4b4U5T/z0
        OZgNmiJFg1Xa0kJZqi9vLZjDGURMqF5G
X-Google-Smtp-Source: ABdhPJzXfn78++bKqzxlRjIvhCKopOxJEvIaQvM5HH5LpbB/SVgQD0v3DeWwHOmOvbOoEsNDd+Nz2g==
X-Received: by 2002:ac8:1404:: with SMTP id k4mr134281qtj.278.1632925477926;
        Wed, 29 Sep 2021 07:24:37 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id c4sm1532965qkf.122.2021.09.29.07.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:24:37 -0700 (PDT)
Subject: [PATCH] selinux: remove the SELinux lockdown implementation
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Wed, 29 Sep 2021 10:24:36 -0400
Message-ID: <163292547664.17566.8479687865641275719.stgit@olly>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

NOTE: This patch intentionally omits any "Fixes:" metadata or stable
tagging since it removes a SELinux access control check; while
removing the control point is the right thing to do moving forward,
removing it in stable kernels could be seen as a regression.

The original SELinux lockdown implementation in 59438b46471a
("security,lockdown,selinux: implement SELinux lockdown") used the
current task's credentials as both the subject and object in the
SELinux lockdown hook, selinux_lockdown().  Unfortunately that
proved to be incorrect in a number of cases as the core kernel was
calling the LSM lockdown hook in places where the credentials from
the "current" task_struct were not the correct credentials to use
in the SELinux access check.

Attempts were made to resolve this by adding a credential pointer
to the LSM lockdown hook as well as suggesting that the single hook
be split into two: one for user tasks, one for kernel tasks; however
neither approach was deemed acceptable by Linus.  Faced with the
prospect of either changing the subj/obj in the access check to a
constant context (likely the kernel's label) or removing the SELinux
lockdown check entirely, the SELinux community decided that removing
the lockdown check was preferable.

The supporting changes to the general LSM layer are left intact, this
patch only removes the SELinux implementation.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c            |   30 ------------------------------
 security/selinux/include/classmap.h |    2 --
 2 files changed, 32 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6517f221d52c..11ebbbd65823 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7013,34 +7013,6 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
-static int selinux_lockdown(enum lockdown_reason what)
-{
-	struct common_audit_data ad;
-	u32 sid = current_sid();
-	int invalid_reason = (what <= LOCKDOWN_NONE) ||
-			     (what == LOCKDOWN_INTEGRITY_MAX) ||
-			     (what >= LOCKDOWN_CONFIDENTIALITY_MAX);
-
-	if (WARN(invalid_reason, "Invalid lockdown reason")) {
-		audit_log(audit_context(),
-			  GFP_ATOMIC, AUDIT_SELINUX_ERR,
-			  "lockdown_reason=invalid");
-		return -EINVAL;
-	}
-
-	ad.type = LSM_AUDIT_DATA_LOCKDOWN;
-	ad.u.reason = what;
-
-	if (what <= LOCKDOWN_INTEGRITY_MAX)
-		return avc_has_perm(&selinux_state,
-				    sid, sid, SECCLASS_LOCKDOWN,
-				    LOCKDOWN__INTEGRITY, &ad);
-	else
-		return avc_has_perm(&selinux_state,
-				    sid, sid, SECCLASS_LOCKDOWN,
-				    LOCKDOWN__CONFIDENTIALITY, &ad);
-}
-
 struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
@@ -7349,8 +7321,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
 #endif
 
-	LSM_HOOK_INIT(locked_down, selinux_lockdown),
-
 	/*
 	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
 	 */
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 084757ff4390..9859787e8e61 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -250,8 +250,6 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "perf_event",
 	  { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL } },
-	{ "lockdown",
-	  { "integrity", "confidentiality", NULL } },
 	{ "anon_inode",
 	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }

