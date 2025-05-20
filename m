Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6E286D4E;
	Tue, 20 May 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742498; cv=none; b=QjyoiVw2pbEGo8/RjVOPTEWwzlcf4bTOu9t1yAnh0mZ2bStZkXfcgzlQ091OF1oxOme01S78caf6Gv1z2BIQrPQF4QZ9Egq4jDbsWTn4VtygtejM4zOSaMZc9DNdtGPqEWyl4q60YZ8GCfNyuv4Ygqf7An23JCuQadOd+660Ufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742498; c=relaxed/simple;
	bh=IjYKvAPTN/DcCh8wFAUIMJ+oG2fP9k7ZSQrdJA69vQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd4CEOtvA3Gmx0r5WEUVQdcmEI4o/GwEwvtWhltaI++41SVFi2VglFHbjCpPH+4goZ2gBtPFQitaDRkb32ek5F5t6QgxbeB5bMenNFZ5u7kBUHREVyCF1ljc3hQUNqjEJ2ctpafxdMUTKE5iSlhVUK9gRvDZA+e+/GNNe2lFDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3zWqKHq; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3zWqKHq"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c58974ed57so586504185a.2;
        Tue, 20 May 2025 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742496; x=1748347296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFOXGSjuTfDLDAKtpdK72NVFIJb+MTZ6ECSxV3w3WUU=;
        b=d3zWqKHqS4xKf2jQ1EJ+w13Aup9P+FNG2KRxz2e+f+SdFCjbmA5bNJMUzS1kH3Q3Hp
         rHKUVOcSDYoX3vyKQoKPB242AUW4GXcKWLwrg2A4yfCFaJUie3aEg6MCIipTYQYgcRwz
         OIEKCtM5DJX74qbeBF52UaZoTBwdCYmUyi+CVN7eXnWDQUdf9wDhPPzJLk1CXPFwQae1
         haEGrZ4Ab8Fa/r7oFrqnxX+0ZJt15T2tOCwCUcsjQxuWL11kctAOy5c/Rb39nI57JgZ3
         jiZjvL8GftKyR9cZu1vTLMA1POyk0sxcyhMFyWYoKt0uyfxzdC88QlR/6ceWKWia6QBU
         XKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742496; x=1748347296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFOXGSjuTfDLDAKtpdK72NVFIJb+MTZ6ECSxV3w3WUU=;
        b=RdN8+Wu+CRob9rY4bGLdK9giYumonLn8cS3mjN2FV6Aw3BVWPkmdpRThHOh5n+CgIA
         76keaOyVMIgA3oS2AUqnBSxnOk2eot4X7Jc8Ea2WA/qiQg9DgAQ/+WKblMbsKoy0PDCR
         4etfDVSeIc7tSimUADXdv5rGZ9k0VTc1q2laofliwt96ItKXSydfA4WghLWW5FFTaHRv
         E91HUgvLXG5NN+8EGScjLs1LtgPHI7Uxy2JBA+aXuaCB7NY6lSwwDRxaSMyf5VPWhMFm
         eqko45RLxEC3FDy9XmCNTuX0+qoP3IG+XNR5qQkE0kKMYCxqn3V/PgH3CcUe/2h3GmTR
         XUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVufe5BQBc3UfPtveA72qTJrUC+S7nksLoVpJdZy2wf5dN/4rdyn3lx17tZyahrNeTmO8QvkFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7BQA6sL97r4qa49/Om5ugwZ9aCWRkA9REAm+ghqrLrTjW1vx
	muJHBD5FU/D8CbL1SbbafEaWSNghj7pMQhRl2VR8HU8ntIhAI417gsMTRkv0FA==
X-Gm-Gg: ASbGncvtPpHOuTvqZNuZpj/Kk6NyIedjM+0hnK4dS71nskAtpuLlbKDwdz7sDYM+nL2
	sYHJ26NeVbBc3VuaQU0bDXDLVa/j0cxRLNfO/xvOaHZoB8ffDKeSn2rVNBkB4rsevSvEQhTzHH+
	28Fs3CMI8R6Y2P3Tv6cdliQuIGaJCYcIPHqHDkDxSZBj8Uho7vX3MaR2/Da1dtDNINY1Kq7P2aB
	ctrX82QLy1xT8TCIENXaoExrlbmuX47jkkjqJTuPa+xJeDo0hFLVugI59So6B20qsx0Mpki7ry1
	SkYtDSY7vWco6JfvYmL3IfM5aHtMDcX6OXTDT5Kz8Szj77fDriuvjH3CfghaRaezGMWJfsu2CAj
	g/OMoLyJZAcML/ymj5+Yvg+wnsQp2eZxGdg/t4rWVV8iZvhzackTUZQ==
X-Google-Smtp-Source: AGHT+IFu6TJ1pyu4rX6APRXJLBNw3ynFNkitZLEOutPIfQIk2gDwAl0wgtSwUqYq3fYKOdKiZaB7EQ==
X-Received: by 2002:a05:620a:2585:b0:7c5:3d60:7f8d with SMTP id af79cd13be357-7cd4671fae6mr2334263485a.19.1747742495828;
        Tue, 20 May 2025 05:01:35 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 29/42] selinux: convert selinux_file_send_sigiotask() to namespace-aware helper
Date: Tue, 20 May 2025 07:59:27 -0400
Message-ID: <20250520120000.25501-31-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 1c7def807fb2..95829ffa7751 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3819,8 +3819,7 @@ static int selinux_file_alloc_security(struct file *file)
 	u32 sid = current_sid();
 
 	fsec->sid = sid;
-	fsec->fown_sid = sid;
-	fsec->state = get_selinux_state(current_selinux_state);
+	fsec->cred = get_cred(current_cred());
 
 	return 0;
 }
@@ -3829,8 +3828,7 @@ static void selinux_file_free_security(struct file *file)
 {
 	struct file_security_struct *fsec = selinux_file(file);
 
-	put_selinux_state(fsec->state);
-	fsec->state = NULL;
+	put_cred(fsec->cred);
 }
 
 /*
@@ -4113,14 +4111,14 @@ static void selinux_file_set_fowner(struct file *file)
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
 
@@ -4134,9 +4132,8 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
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

