Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB3C433FE
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5108A61107
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 15:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbhIWPvJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242239AbhIWPuY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 11:50:24 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E66C0613F0
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 08:47:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r16so6555063qtw.11
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eanBuwDkgOLZs3AUy1n+xC0OqqvkchufmO8SEsSq0R4=;
        b=U6kusfQhFDPVN3HHPOiJ9H7kNIlTpfE+ijkhxf7HBluJA3lGuHlBqbrpQqTS6BVz03
         oFegILOVRjlVHnsGd+RXoC5XrBXiZIugjqW/mF6CnkYyaJoH0foFW/5Ua+83PAg6Wbg/
         umOCEddZW9F4M29qD2v8niTnvCnWCqyVXnTGYqsVLfBx97QYieKu8pvSkK/Qju8AVkh5
         vO/xU+BURJfW+FqVtKULILjXBFzxSgV7LjKAFfCvilL+uy4sVwfVKwhWu9zLP2gWnHjl
         FYhGk3UMKkmxCV5siHGsqdWdnaEl1cS2FvbhHKzbhKF3uAwhrDFrkvfFMDRST7k4m7kT
         9QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=eanBuwDkgOLZs3AUy1n+xC0OqqvkchufmO8SEsSq0R4=;
        b=pF/KHv7CS0JND9Vt9fSIUn6VEhD4wo4y2mYGDGUJ1oknbYi2cCPkOBxncI1VX+sZWY
         jSrVFsThq/prTtlKXyXxrBiLCWfNZmoqvQHgc6lmRuVmRKRMF0jKDYHwRBn1OstNXscR
         mBDgfYreFC/zKkWfg39QsoJeGkqK3GSN9Y9tC+Uag4XZmodC6qPRsBkhjd0urXLx5+NC
         OlBsSkuCGRrbarvOQ9bCUHlbSLyDtj0QeWtGMj64mDkoxP/NoJ9oGkul4ghiEsR1utVN
         HkSFpWQdb/2YtY9kXr0sW/dx0hWDHpJBcZ2TAv7NIrDEoAG4u4pqQC0Yn8ZMj4lE9SuF
         /IpQ==
X-Gm-Message-State: AOAM530/ZEGyj72c/WHSgstvEw3zpYtVKhG+JGXPFOr2FSgT0F18SA/N
        yav5z6HhEr1JAo5j2jpRkCmQ3msz4O7V
X-Google-Smtp-Source: ABdhPJyFKJzNhWMOvwK0AtGx03qKP4YsFJJ9MfZISiOWIWfu7AIY4PV1fipuIltFZ1S77yWb+c30aA==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr5558066qtd.345.1632412067337;
        Thu, 23 Sep 2021 08:47:47 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id m139sm4801445qke.18.2021.09.23.08.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:47:46 -0700 (PDT)
Subject: [PATCH] selinux,smack: fix subjective/objective credential use mixups
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jannh@google.com
Date:   Thu, 23 Sep 2021 11:47:45 -0400
Message-ID: <163241206546.71956.16494958077958683533.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jann Horn reported a problem with commit eb1231f73c4d ("selinux:
clarify task subjective and objective credentials") where some LSM
hooks were attempting to access the subjective credentials of a task
other than the current task.  Generally speaking, it is not safe to
access another task's subjective credentials and doing so can cause
a number of problems.

Further, while looking into the problem, I realized that Smack was
suffering from a similar problem brought about by a similar commit
1fb057dcde11 ("smack: differentiate between subjective and objective
task credentials").

This patch addresses this problem by restoring the use of the task's
objective credentials in those cases where the task is other than the
current executing task.  Not only does this resolve the problem
reported by Jann, it is arguably the correct thing to do in these
cases.

Cc: stable@vger.kernel.org
Fixes: eb1231f73c4d ("selinux: clarify task subjective and objective credentials")
Fixes: 1fb057dcde11 ("smack: differentiate between subjective and objective task credentials")
Reported-by: Jann Horn <jannh@google.com>
Acked-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c   |    4 ++--
 security/smack/smack_lsm.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6517f221d52c..e7ebd45ca345 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,7 +2157,7 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
 	return avc_has_perm(&selinux_state,
-			    task_sid_subj(parent), task_sid_obj(current),
+			    task_sid_obj(parent), task_sid_obj(current),
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
@@ -6222,7 +6222,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
-	u32 sid = task_sid_subj(target);
+	u32 sid = task_sid_obj(target);
 	int rc;
 
 	isec = selinux_ipc(msq);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index cacbe7518519..21a0e7c3b8de 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2016,7 +2016,7 @@ static int smk_curacc_on_task(struct task_struct *p, int access,
 				const char *caller)
 {
 	struct smk_audit_info ad;
-	struct smack_known *skp = smk_of_task_struct_subj(p);
+	struct smack_known *skp = smk_of_task_struct_obj(p);
 	int rc;
 
 	smk_ad_init(&ad, caller, LSM_AUDIT_DATA_TASK);
@@ -3480,7 +3480,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  */
 static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 {
-	struct smack_known *skp = smk_of_task_struct_subj(p);
+	struct smack_known *skp = smk_of_task_struct_obj(p);
 	char *cp;
 	int slen;
 

