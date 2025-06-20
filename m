Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0742EF9A7;
	Fri, 20 Jun 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441545; cv=none; b=MTvmK8z3CCZZCUiAI7JoDZ4qTYh2YOqiBEWfOI7azU+4oOT2U4/UW9Nzba6njJV3S8H4ItZzmq/vojWUB8dNitfsIbHdwuk0ZUXuK9oxNGjaZILNALLl5ArWHgAVliznaTn4GjOoeYj2dcFoe8AKzVm28R8YEfXabcyHGp0izt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441545; c=relaxed/simple;
	bh=6pavZuV02hH+xy+s9Rfnki7oWK7ep0GwpAtSiUllv14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cATRSxvgEWz6S+KjSwTctfoDabrkPhNAjyymjffZf1wY8kRQWD3LdP6YLjNlBfxIEBnhU1321K93Gaox5czTDdZrbUz+5F8Z2up/iRDZKGkNh6Ebtw/h9ET/AEnb2Z2RMw4p3HrAIepb2nVQhF5Zf56+b2DtPgM2mofpkAHl82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXFjaxX+; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXFjaxX+"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fada2dd785so25751826d6.2;
        Fri, 20 Jun 2025 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441542; x=1751046342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJDa+WsNUsC0XoIDFZA8sSn3NcQVfwI+FO5FMwoCKhw=;
        b=QXFjaxX+HGcwXkGRDPlx64Fcr7Wx9KI3kZmgpyC4KLzuNpwXy9kxdkq1Ob6tcCTqcE
         D4YwNTit7U+NnrpQYhwk2Ypyo0sLpWC0UyMRTozkdRTrryj/NZhJt86tGOuAPvpBsxiN
         xRD06YK/+WLCd2+8CxbStTjoH2d++zLEUP2By0hUlFkGgUmT5ewPrEbo1rvMvwS9pkOu
         /STme1P5zMsOjgWNGQR8ENgF4LpDb/rQKRV2D+AQsQOODzSjoZE0pEMW/+HzZ0Tt+XJZ
         aMetOY+ImF0o+11vEd9v8T1BhULKWKCGL+cNU0ljjpnRQ4hOd53TouGBC1u4MWavW0E6
         wvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441542; x=1751046342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJDa+WsNUsC0XoIDFZA8sSn3NcQVfwI+FO5FMwoCKhw=;
        b=NIcyQGcnUywRRz6F/JdvEpbUcwLG3j9640E7FORL8F3aZ+yOF7f9EDWopY2+5szBEe
         XzAvBIDt9jltGksLYSz5qMZrbGEcmKjoigsDnjnxM1R0NuXu4BJYVhR8TDjUGMRNltPZ
         NlmhE0pGdPbwlfNqsT6uyvfVnAnHOI7UElDcDVNEcvmkUomEoBq65b+HZHCV2louS+x2
         3C38gQ7xFcqM8xNt75ika7dD6jY11LR8yxi6k//FzwC8zaz0mmhtsWBJRr55FPIQ3V/w
         FKUwItw+BpPbskGcxuPjWkLUWbbGo9D5l1Jf+B2vkcNp/n4QUWzSX7HCD+YLSwAC90Vk
         zHyA==
X-Forwarded-Encrypted: i=1; AJvYcCW35NS//lLps4Z+PasXGcPv9vR8lIm3IcnD7CEcSBJL7GgZ1LJeTG2r5sI8LSgcY+6x0xSLpHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxliqyli0fG7qnecIhmuYXAfoQhse2pat9Xr3Pz70YUuwM7ZCn4
	bdh74h3mFVMAGMOC0MgRJi5FUYRrelqP6y0q39d0VJxv0PhnmykU3WaD+mvXiw==
X-Gm-Gg: ASbGnctf4WyPC4oNob2Jg3XnpTFsb1aJgDGIepQlRn5JnzzQtnpM85Og3h68U+OP8C0
	auXcRaVJteoYHfWPZSmTmSycUj/VEryrhuukls/9vRKDImzwsx9jaPBTGBp9Acpos3Q8CiRgnDk
	q4I5kZvbUxIRKeR6QiZvXAT2yTTq/o4lykeGhRO+dBxjv3PxgQlU1lxdDgnqLEM23P6tpCUUNsW
	37Vj5cY4uNViURpVWTR6c9Ymr8InPFRgEwfmVwXlCl8Rm5R80afhjl/739Ltp6WU2zGy7SooaS1
	Mq4jsNIjJtpPfk13j+47wwHMwyyv/Dp+aPyAUde6cu1Ss8Dpr8pz1545yHRglzGMlFJJpAXeeWM
	Gn8zhV/5gGir9Pg/BKY1Dzhm3tJSI3NMm6BQEf/1rgsHmBeBflU8e46zphjUv3YOVjA==
X-Google-Smtp-Source: AGHT+IExtCGmLFsqkyM80uRKGx7XfTZPJHnvBcWy+PjArClUhhUXznTvoYgpLoafrtsvvR5aETnbgg==
X-Received: by 2002:a05:6214:23c9:b0:6fa:c81a:6234 with SMTP id 6a1803df08f44-6fd0a498371mr64219206d6.10.1750441542073;
        Fri, 20 Jun 2025 10:45:42 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 28/42] selinux: update bprm hooks for selinux namespaces
Date: Fri, 20 Jun 2025 13:44:40 -0400
Message-ID: <20250620174502.1838-29-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the bprm hook functions for SELinux namespaces.
Unlike most of the hook functions, this does not require
converting all of the permission checks to use the new
helpers that check permissions against the current and
all ancestor namespaces. Instead, we only need to check
the transition-related permissions against the current
namespace since only the SID in that current namespace
is changed by a transition. However, we do want to
check execute_no_trans against the ancestor namespaces
since they are not transitioning; hence, a check
is added to the end of selinux_bprm_creds_for_exec()
for that purpose. Otherwise, we just document the
fact that we are intentionally only checking against
the current SELinux namespace for the other checks.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bb8767762b7d..52055b31e816 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2283,6 +2283,11 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 			av |= PROCESS2__NNP_TRANSITION;
 		if (nosuid)
 			av |= PROCESS2__NOSUID_TRANSITION;
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS2, av, NULL);
@@ -2312,6 +2317,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 
 static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
+	const struct cred *cred = current_cred();
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
 	struct inode_security_struct *isec;
@@ -2322,7 +2328,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
 
-	old_tsec = selinux_cred(current_cred());
+	old_tsec = selinux_cred(cred);
 	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
@@ -2378,12 +2384,23 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	ad.u.file = bprm->file;
 
 	if (new_tsec->sid == old_tsec->sid) {
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
+		/*
+		 * Only check against the current SELinux namespace
+		 * because only the SID in the current namespace
+		 * is changed by a transition.
+		 */
+
 		/* Check permissions for the transition. */
 		rc = avc_has_perm(current_selinux_state,
 				  old_tsec->sid, new_tsec->sid,
@@ -2434,6 +2451,19 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 		bprm->secureexec |= !!rc;
 	}
 
+	/*
+	 * If in a non-init namespace, also check the ability of the
+	 * ancestors to execute without transitioning since the SID
+	 * in ancestor namespaces is NOT modified.
+	 */
+	cred = old_tsec->parent_cred;
+	if (cred) {
+		rc = cred_has_perm(cred, isec->sid,
+				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
@@ -2520,6 +2550,9 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
+	/* Only check against the current namespace because the SID
+	 * does not change in the parent.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
@@ -2560,6 +2593,9 @@ static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 	 * This must occur _after_ the task SID has been updated so that any
 	 * kill done after the flush will be checked against the new SID.
 	 */
+	/* Only check against the current namespace because the SID
+	 * does not change in the parent.
+	 */
 	rc = avc_has_perm(current_selinux_state,
 			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
 	if (rc) {
-- 
2.49.0

