Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917462EFDA9;
	Fri, 20 Jun 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441547; cv=none; b=DtavBovx/yPksEo9O7JxXvnAXeEO4B/O2E1A2h0grC/8V5I9+jW1EJw5jjlJlSBxrw7yL2fL40CJ+klRl4kUO0FqyZCJlh2PtvfmLcmE6mQB6+BDKnbGa0/Cp8Pvh+UW4hIq9Mpz6HP+6vHAq+dBv3oOSiqu+5U7jVj9po+Xquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441547; c=relaxed/simple;
	bh=QWmWhco9jAAelM9yYbT3JLSCiU6nZ21pYxx6Ihh8k+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5bx/TYSr6WnhJqjmWUgqGq3VBooPw9i0Dc4w+LUW/RYr8cnZMB8EkaorYvCVAeWHUqJJc+EmoP1FmJ3ygnPACK1kLMcyWdpfHx7Q7QJFJgYF20SPZNdrbnh92tbubZjr4X34wKWTfZh49g27DyVh6eDgtNI0UcraCePl7SAqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbKIlmTX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbKIlmTX"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fb3bba0730so24101226d6.0;
        Fri, 20 Jun 2025 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441543; x=1751046343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQQKYEktuUdcWVnjQ6YNsRRItq+8Dzv+FLT5ZtZEGRs=;
        b=kbKIlmTX8idqRhD8HlrAqHnCmIOKuFSeMQlojR1dcjQnKc+7Ypn5Vso0PyZZglTcb4
         Gb6wglcuCCLoMFWUg+hAGHMuDH7qWpBvb2C+tOv8vjOxzqRZ2MxAoz4vPG2+/a54sfcz
         7jvrB43aGA+d2w/ASTJhdxnyjYFZJFJXgaeB/P819dK/jikfmM0voY8tNf8z2Ys1NV34
         jv9EuysDazhXlehMadfYA0rhlC8gdPFaRS4J+Ep4EN3ZoI6i9ZmiIGxL159ly2tTs/hA
         MHk/F/RK+33mzIPgqn5BKhAppsFHO8lEO2UaHotwUuHvtQ1cGrt1gN96eDDcUrxygJ96
         fPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441543; x=1751046343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQQKYEktuUdcWVnjQ6YNsRRItq+8Dzv+FLT5ZtZEGRs=;
        b=MU9QZ+rZ3LGo51e/EjNlz/sNjRscqmcnLg5jC/QNL4N+pe8X6tb2ZEYWCwJc3fJnTj
         yFl/Xnn3sdrZXcIhgAQEZYNamz9ufOw9A0Wfg+vruLOrrNukqkwSs3eBGO+oKrYxQeJ5
         0njKBBhB2R1pouI5DFNG6HzXRnQs3QkWXH4uL3jUck6vRM0bP7F9p51lWBjDDVfblYV/
         pjoq8EksXulQ70Mdpsr0k4CkOY3vX8h9PnWiZR7zBoboUr3O+zFLdCCWsf2L5SBZYqtE
         ayCt1HajG/jJHInecMUSosspIjw/yA/JXi03l64pBrkbADgGtJUU0JHGw5OKrAmld8Xc
         i8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOIRuQaXdgwD3nhQ4E8a0mQjr16avK8ctsText/VIU4uZy5RcpieQYSzFZOMLg4xzgTkNjQ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdH+b5iCPUSgGR1S3Ggkgi8SRZmnciQrRFK84w+zqrelqTSYC
	tQaeuGz5KyZikgEYlQWrQtahCXGxc9N94Hgp0O4xnpNJqWdmnUpyDYGnA1EfLQ==
X-Gm-Gg: ASbGnctv/geEi4IG4Ye3S3Jm5NnhFiuLb9BG39yqbbDkQ5ZumMf0031HqsjKNyRuMmW
	1EKwyuiHXI45SwoOV40uKH6Tv62KG3xSY5UobiOl+jxSKF4jFMtO5QKqNkSrlhfi4eOkiNnFO/d
	gkh5krdHEmOyo2xnagBT8XGkSeqgu4dMztde/zaHsjP6xFJwm1F5+blEFJgkrYuq+0sOmOUycWQ
	vWWbH653rm7MQ+XPHvS5tKLomDM6NKNG/VUqY9LtsC/SGlKOomrlJWJYFbDShNhIRXIGNvyZNoa
	IDihiRBrl1B5G7s74+sgkF7+wiTqEwzm4xZoCbfluBvn6KqmSuWvfSJXyBS5QAVEhXf0/JOVVDR
	/ikuvsofT2N+veaPGQMcGXbTKj3w6oS+7qwTuhaeD51SlYKNFovs2qA8C1ufD2vuiVw==
X-Google-Smtp-Source: AGHT+IF7btgLC3ethtKbK1ldeLvLOFL6oXuygaqnjQEP7U8dPcI4bmADIXE3fp0NrMd9tlybB/Ingg==
X-Received: by 2002:a05:6214:2483:b0:6fd:27:5a43 with SMTP id 6a1803df08f44-6fd0c87dac4mr50261356d6.4.1750441543241;
        Fri, 20 Jun 2025 10:45:43 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 30/42] selinux: convert selinux_file_send_sigiotask() to namespace-aware helper
Date: Fri, 20 Jun 2025 13:44:42 -0400
Message-ID: <20250620174502.1838-31-stephen.smalley.work@gmail.com>
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
index 52055b31e816..07ce934b75ee 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3837,8 +3837,7 @@ static int selinux_file_alloc_security(struct file *file)
 	u32 sid = current_sid();
 
 	fsec->sid = sid;
-	fsec->fown_sid = sid;
-	fsec->state = get_selinux_state(current_selinux_state);
+	fsec->cred = get_cred(current_cred());
 
 	return 0;
 }
@@ -3847,8 +3846,7 @@ static void selinux_file_free_security(struct file *file)
 {
 	struct file_security_struct *fsec = selinux_file(file);
 
-	put_selinux_state(fsec->state);
-	fsec->state = NULL;
+	put_cred(fsec->cred);
 }
 
 /*
@@ -4131,14 +4129,14 @@ static void selinux_file_set_fowner(struct file *file)
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
 
@@ -4152,9 +4150,8 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
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
2.49.0

