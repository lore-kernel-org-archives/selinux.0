Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E86298CC9
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314638; cv=none; b=F4l1Ghk4VvzMzdAEnq0HhYi/uLbNsVIFLxdSOetIM3d7tHsovg3Ycaky48qsFzz2Dgwpo1C2nMRBQwJzYugCFI3Sj51ZusRPOdjusS3XXi4X1kTtPhuF6h+j5TXZUwwNQpArWw1DGAW/+iSczjCPeWasBeq3JigeDlH+eTyvrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314638; c=relaxed/simple;
	bh=gjIEsnfB2qc27MeHkPhEjazf5HQUiR2eiMsyC1h+Whw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/zSYq9jIMmtp1OQbWfQXRrzlvh+UoEnnKHa1fJSlb6/WCtn4pXxn+0cbznXpnndZrWKu3S8bvBoNKArKwQXzRiVQLNQ5CYswdx5xpLowx6O/FNMxlwxWSm1AGsR4a5MMC5J6CcsEJBW/NpfZcZHj7VMt/SLmZgVgiPd6QP7yJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhUJs0Fn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhUJs0Fn"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-477282401b3so10098441cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314635; x=1747919435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PcxwHr0xST6B1rBf+kdZEIPoZzApVPN64VgFYq4Yac=;
        b=mhUJs0FnsH32z0WdIUqB5NBnezD+1gLb6U+g5vGfm3HaKTyTY+tBeT2VJbEgP00tHE
         xGtbKd6yoi/NXZ5RQuHuaKGaZnfrep9Ms/5mEQKBV7IsylZoEgTibT9ZEBCCcbY6yW8F
         mwYuf0lAa5RRG+qD5jeuMgi/nK52ULrZdg+bAA/xuEgwae9Evb9SCCqvR2rmjSjtT3Eb
         Sfid7/6ZbtruL5X0EKNWD7VSv6PoBgNPmwEhhpNbC/uhDO0hOcHDZhcImY7wmemFEC99
         eQBITnTkNcRmUcaz7nhBYls8XYwijiTNQG3dBn5Di9HhXqhjgVAXeMyxB75q7h6EueFu
         0N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314635; x=1747919435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PcxwHr0xST6B1rBf+kdZEIPoZzApVPN64VgFYq4Yac=;
        b=pXDByag8C93JDeERnA462bs02BVd6bsSwv45ZE99invHxpTvHvBVFNv4+Lh+mBmtDE
         ubAjW38Zhd2AMDVsLUpp8rqi5kXq9iinERoLZDVn5FEhRCSLXR/jEk5ZyLa1J2ZkkWIx
         2Mm4kHTOEPpjjoFjozrsUChD2C8ANsSUnu0wAD2QKwmwqeUbDuV3Mpf5i862JYGRz+64
         Ab/j81BRAXde5jAsb8n4msV3/lGkYCgpySB6Yf0AMUccxlsvwdn4/8X7LEl3RZ1VT3aA
         9YKaypVpIqwi519vcW0JWC/UMA0w3ObsY73Mn8O74gsWAymjv1kPyhW1Knj8UfjPKg1j
         EEgA==
X-Gm-Message-State: AOJu0YxCiVTRvPVyI5Y8ValAwnI6+WHGQa329m92gcyN5rAFF/l42ML4
	SiB014ZurvIo4v1QauJvzEkzRAzk0CjpCgPAMt4nbPqzUPLlUPHUPGYZfg==
X-Gm-Gg: ASbGnctYVmYLHjJqAGbGcm6vgYzLsZ+kzVcJ0G3MInXtunSSUMMdwa2rU/3G+ND51WB
	BOJIsi+n/YpyJ3Hi3ceAL+sSrYLJRY0DqTTkFB0O+rR81j0yh0Mum/cz0cl/ngoRZQX4ttBlHoT
	s4/kpOkAIE7+dWDx/Mr/fgLm8jmGjjWDJP74mB3OXIL9qoJwbEhT4HrS9CMiN6966rEmVVYBaEJ
	7UhxENMGDutwdDL2c2J2yWpjJ0oZlhCE0o3hrHBvlUvMlX3VtRRo8jrV9fSxHmmsjRmOaadBgBS
	nxLs/qwZFrCBZkft+6M/FGVQr8AShvxOFnPpNh7vG4jHo860Lcx6yOEp+hzMQD6OLhkCMISOApA
	oXVz/LRlzdSwdTWBfEeJBCydS+dVCjSjSMG3W7L2/qv6j1JN40z/EBw==
X-Google-Smtp-Source: AGHT+IHr+BWhlqCNhsf2+Mm6wJ5kfqcEuxJvAFVzBzHWb2xF9jwvRqbmo6wumAJ0x6n0utmUq1hcfw==
X-Received: by 2002:a05:622a:229b:b0:490:9528:c48d with SMTP id d75a77b69052e-49495d2c9d6mr116880791cf.46.1747314635366;
        Thu, 15 May 2025 06:10:35 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 22/49] selinux: convert selinux_file_send_sigiotask() to namespace-aware helper
Date: Thu, 15 May 2025 09:09:20 -0400
Message-ID: <20250515130947.52806-23-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert selinux_file_send_sigiotask() to use the cred_task_has_perm()
namespace-aware permission checking helper. This required saving the
file owner cred in the file security blob for later use in this hook
function. Since the cred already includes the cred/task security blob
which has the task SID and the SELinux state/namespace, we can drop
those separate fields from the file_security_struct at the same time.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c          | 15 ++++++---------
 security/selinux/include/objsec.h |  3 +--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 94777b89a3b6..f29e1adde57a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3832,8 +3832,7 @@ static int selinux_file_alloc_security(struct file *file)
 	u32 sid = current_sid();
 
 	fsec->sid = sid;
-	fsec->fown_sid = sid;
-	fsec->state = get_selinux_state(current_selinux_state);
+	fsec->cred = get_cred(current_cred());
 
 	return 0;
 }
@@ -3842,8 +3841,7 @@ static void selinux_file_free_security(struct file *file)
 {
 	struct file_security_struct *fsec = selinux_file(file);
 
-	put_selinux_state(fsec->state);
-	fsec->state = NULL;
+	put_cred(fsec->cred);
 }
 
 /*
@@ -4126,14 +4124,14 @@ static void selinux_file_set_fowner(struct file *file)
 	struct file_security_struct *fsec;
 
 	fsec = selinux_file(file);
-	fsec->fown_sid = current_sid();
+	put_cred(fsec->cred);
+	fsec->cred = get_cred(current_cred());
 }
 
 static int selinux_file_send_sigiotask(struct task_struct *tsk,
 				       struct fown_struct *fown, int signum)
 {
 	struct file *file;
-	u32 sid = task_sid_obj(tsk);
 	u32 perm;
 	struct file_security_struct *fsec;
 
@@ -4147,9 +4145,8 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	else
 		perm = signal_to_av(signum);
 
-	return avc_has_perm(fsec->state,
-			    fsec->fown_sid, sid,
-			    SECCLASS_PROCESS, perm, NULL);
+	return cred_task_has_perm(fsec->cred, tsk, SECCLASS_PROCESS, perm,
+				  NULL);
 }
 
 static int selinux_file_receive(struct file *file)
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 18736dd23441..65c529ae7f75 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -48,10 +48,9 @@ struct inode_security_struct {
 
 struct file_security_struct {
 	u32 sid; /* SID of open file description */
-	u32 fown_sid; /* SID of file owner (for SIGIO) */
 	u32 isid; /* SID of inode at the time of file open */
 	u32 pseqno; /* Policy seqno at the time of file open */
-	struct selinux_state *state; /* SELinux state */
+	const struct cred *cred; /* cred for file owner (for SIGIO) */
 };
 
 struct superblock_security_struct {
-- 
2.49.0

