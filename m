Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C2307AF4;
	Thu, 14 Aug 2025 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178056; cv=none; b=HNqWI1uFp7lGZ9+8193ZeKToAR9wntW+b2ALXL+SEclz+L2HICQJYVJAG2UqlyOVdlWLeXiI/bXx+bNxIpj/4fLKXy0eYypuBDD/9aePnMg5Bt5SGEb0WqpIhdBbOOqS/0ufKURqDEvJ8YxAkWxFHyZPFX0Be2A0WVT8CIXBx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178056; c=relaxed/simple;
	bh=aZfkQZelFfWXEcJeSq2KKwGhMEPmDeMDvhFrS2CLduc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOetN+DwN4eoOcbonpz1iIsBvFGOG5QtZszS+1GusVxTHfNePpZhZzfIqh1fRczj5KXzEQdZVA3vI6n6Toxo0hDMNPNmT/wfr1lT8BsRLBwLiiMRe82aYozoRRkho1xTyHCA6AVsa4J3SHk6cO4qex0rKQ1gLPQlczk4OOtS9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdqbJ0+F; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdqbJ0+F"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109a95f09so6547431cf.1;
        Thu, 14 Aug 2025 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178053; x=1755782853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmWXK6xiL7dO0GSO4urHCElVPEi9OSvkEukCRxJp8w8=;
        b=OdqbJ0+FI4hg2tKIvt9tjnVag48md8o//ojLPTQ0b+w6RgaydpIitcloyRzDiVVxbH
         h2LFZBeiI+xKbKDtypjSImzU4FCSXa2t4wUESbrLApl+636oPq/Vg9mgtJGvJ0Sa4C7a
         WddaqeHwReEmdn5plOaDFBbucIkULopbNFm9tMrJMo/nWSpMOAeQxXOZILkaMIQWm0Lq
         PxBjbWegRfvPwUwD0xT4DuKw4ejyeHaODrwuR4+36DknnDyzzKEbqXIcz2EVXbxiXcde
         kgSFN/dAXaBVm66BOmIvmdoTApG5vfhqyQTOGDw/a7flwJsKSvCGzbecHqsfKmcMAzC7
         zB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178053; x=1755782853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmWXK6xiL7dO0GSO4urHCElVPEi9OSvkEukCRxJp8w8=;
        b=eFshJH4FdzHxUtfVKUzPcwdwsbdQOfpf46lTE3QgX00EsFAaZwelG/Y25ove1/ZnoD
         7XZuYQ1LTvnUmciCNjeLzRmOFsM7FY0viiERGA+2oR2GaOJl0T90LKL7zclJ5eF5/Htk
         LG3IoHgRmjJ9tydbr90dVx11iGKiPpb8qCEf/Q8NfknQKRtri8W/Q5Z4jbg3kb9OtfgB
         5NdxIUtRq0zy7axTqzMeuBvWbWfQ0UfeR1o/+kCBlIkg4cAYpcacJXtU/5ETnvE31qzl
         ZzpuCf+pZ1S7wpjUV3fOFBMkRtjTDcd04xEnQpT40UMsGWp/byl1DR5Y+hRIxA7TBQBL
         cEUg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7LxanTWCwsfvPf6BTA6EeMdyBzF4q7E5vKyXsUVcfyITXixsIjvBe5h2bXVuhNHUFP/csQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBAjyHzOsO77SKE6UfS7eAe/DMRT3mP4+n697TAJ5BcZULaYq
	JAzjzGjk0SGFEs/R6o/521vRlBqAuF4NB3WZwwbcicSEdONkMPAG9NOXir8IXA==
X-Gm-Gg: ASbGncsSnYGxQ9g6t2FU3RmY4RJbZpJ+WsCVtPc29gd/4EauwLu+tUXub2j38CThCEB
	4ttMeT1aedh8vASZjGDGtWlnNHSBrHFlZZbXhKDO937Y+7YIFkEHab0xi4BUd3bMq6T1L0bK16R
	hwQgaMtLqXhvbboQqWyqRlfmrb/f48+d5kFDJm/sShPht2YY+HJgA+WxmOOvRPfEMQ1XZ9hRbZT
	3yXRntRg7LE2t0EOqwa0eZocrPoCDEImnBbPAeDLgt648z8tcTPr8xgkT5RZrxqZjR6yKvvYCFJ
	NRjhzi6pv1zGVPQXdvTktQb8Cbquz5yK5CiZ43PIxlOVS8OMyppwCJE2zx1QLzk7/6ZOcrn0GH2
	BYFfFYhv/1zqlsUTTUfIXElG/ibZa0DBlTIn8x7Fsr8AJxvtNZf/26LoMENCbJJQQ6wvLpZKeHB
	KLP5wiQRC7UwXpJ1Zuh2kyfNVJQg==
X-Google-Smtp-Source: AGHT+IH4hIxuSR0GpKsOb/wwozG8WWlxeprp6iBnImNjxOCbABYN/eNkW4tTScfzGPhAvyEmfhQmrQ==
X-Received: by 2002:ac8:7d0a:0:b0:4b0:8633:f979 with SMTP id d75a77b69052e-4b10aaae56fmr42016431cf.42.1755178052747;
        Thu, 14 Aug 2025 06:27:32 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 30/42] selinux: convert selinux_file_send_sigiotask() to namespace-aware helper
Date: Thu, 14 Aug 2025 09:26:21 -0400
Message-ID: <20250814132637.1659-31-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 07bf35c14ae2..3c487b48e510 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3849,8 +3849,7 @@ static int selinux_file_alloc_security(struct file *file)
 	u32 sid = current_sid();
 
 	fsec->sid = sid;
-	fsec->fown_sid = sid;
-	fsec->state = get_selinux_state(current_selinux_state);
+	fsec->cred = get_cred(current_cred());
 
 	return 0;
 }
@@ -3859,8 +3858,7 @@ static void selinux_file_free_security(struct file *file)
 {
 	struct file_security_struct *fsec = selinux_file(file);
 
-	put_selinux_state(fsec->state);
-	fsec->state = NULL;
+	put_cred(fsec->cred);
 }
 
 /*
@@ -4143,14 +4141,14 @@ static void selinux_file_set_fowner(struct file *file)
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
 
@@ -4164,9 +4162,8 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
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
index 662329923214..9975a13700c5 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -55,10 +55,9 @@ struct inode_security_struct {
 
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
2.50.1

