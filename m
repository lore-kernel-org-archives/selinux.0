Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DA2E337C;
	Tue, 17 Jun 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169206; cv=none; b=dMuOPKcxrIN6sHJU8odZLRlOUDFsMRa4FvhN317YBj0wjJ1PKDsn12mWfBIgCHPa+CklJvjxkIgg15pjev0GyElKLhQb2pqECXyPnzIHA1DC6krPD8dhqM8j3PGzkRY22Zrv2lbUvUKo4qLuNEadTwnr1Fgr7Gt9SAjWiipMGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169206; c=relaxed/simple;
	bh=tqLd+WYK3qM37/Se0ByAxzD1+d8BrvuWE398r7+Im8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifTToksPqj4bBmAjWCVYEsKoxmSfJR/56iOjsdrvdFOH4cVX+lxm8JZWB9jOrVj2RjcJ8vAyAooNYKqv/2tDA801BCyHxr1z3o+idMH9RBCunBm+dPqL0WVdqsIMVwt7IiDbJ3vkOtEGW18yxN870lK/oV88CQ0pqGH40L7jjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNQL/CJH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNQL/CJH"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cad6a4fae4so1130503385a.2;
        Tue, 17 Jun 2025 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169204; x=1750774004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GAhAL4IJ8j/IuKF6nJRUk/g/y2P+1MJJDNCendXAOc=;
        b=WNQL/CJHmJVPKDf9NLB0MXTHzljWpFxqe687L08+LUn9AZQKClbxJM0BdC79lScT5A
         u6TzEAaAb0kE9v6hc+ZBD0i2+pPXEJui4nxq647Dnx6kJU5dabAMWIku2DUtgNcVgPq3
         XzBLPmjuNbIwzEM5Pl6s2smZ2tQMXC1aNAJl1Glv4DVureHCDVnqGjdUmR0w1rh2QqUd
         YonsdeR5V6nlLBj3t6xQfOY7WHUvtev3TiUoglIB6Pya0zkZO/ynmMWWN37z0bICSlHs
         NBZf8Ip1RzYTaHDihFu8hvdD3bpK73bQNFlXzWmS8T4b9EmWbhJ2FZUzIAx/AfPKHH+E
         XkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169204; x=1750774004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GAhAL4IJ8j/IuKF6nJRUk/g/y2P+1MJJDNCendXAOc=;
        b=vLDX8hqKm7fz2QO2x/KgKdXtXiDMVP//ajVHU75DsKsYofo/JDURAaE/11vASfZa7p
         zV0sPY4Qmq5xcQlBm7dFWsppRrVOs3Zl0nc+eCDb7xpb/wE0+4yAzjbewX8EokJ2lucJ
         os2O1WRuzkgo5CmO+u79tSylY4FX0sbYmj1VNyBIKLWfZr3h+3E2VAvokzgi+HS2S7V8
         ig936+n2Inp2zJxmr8i5MeM1vZRQClW23GNlDoH5pSMeewjdCZM1iw/H5WQAaqGqMteo
         1PAMIjMmitf3ddy434j6yp8QTrFN0NSq0jYgTsRaD2EwwueIblwQoER7znF1YnrfQsdu
         a35g==
X-Forwarded-Encrypted: i=1; AJvYcCUaXJKMiBG1sIyBlARMzMoY5DozVYe+fKi/r/k8qaeV9VWB4TxAIASy3rKChXKWdHXRtuakAuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphlfpsdB9UmpvZyLIwYVN4xgeq1oXPMtTTTV47u4BN5qniUJb
	twm2mt6EpYm5GwmtdU1+K0/2i+H2R/I9+BFhM281iLySx+C6eWGAZUR0IAa4zQ==
X-Gm-Gg: ASbGncsXDp6mwX7ir2nQuFZ0hxqEqvklLzyOVp64Qq+CT0KMWg139SqVe7uKxPL8gJ5
	uVMED06/Tr0XuVK1Ot1ljX0MQ7qKm/gtcI3DXqKLNqxPJz13eW4HLSZqo7yXESGrfGTngUPaxMa
	saPR4nhhWWt+SCSwq/57ktBKUtmJ8noXRXOkhsd6Y4nOc9vYiCPGQHZgFJKbcPBWUj5Px0kDUe4
	FdmQlvg5TuJRjn/Iq+Xq+OdkMvX1BOiamQtbx4oOOQzwkT5NDJrgAeLlVeFOGUycABUSlNOBRac
	yhDH4nLOb/SpbWeVzrS1YRcTpEgyqgYhroKmfDaSqe8UBCfYtaO9eAFJ1Psnp6iYrhVabDC26nG
	a8B7POHKrT3QscKRdKH2NSHXL1EP0wZDr7b072B7It/FPY3a52L3UmJ1iL7P8Aujg6w==
X-Google-Smtp-Source: AGHT+IEFj7xeBmXruGMnN0xghLD8NDZ7rMqAq05oEF4a996BxJuewT12AGZVjvMvFZO+Guw1F7NXmQ==
X-Received: by 2002:a05:620a:17a6:b0:7c5:5e05:df33 with SMTP id af79cd13be357-7d3c6cf8f82mr2234756285a.51.1750169203620;
        Tue, 17 Jun 2025 07:06:43 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 30/42] selinux: convert selinux_file_send_sigiotask() to namespace-aware helper
Date: Tue, 17 Jun 2025 10:05:17 -0400
Message-ID: <20250617140531.2036-31-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index d088cba8d6aa..2a2b094e8b7c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3825,8 +3825,7 @@ static int selinux_file_alloc_security(struct file *file)
 	u32 sid = current_sid();
 
 	fsec->sid = sid;
-	fsec->fown_sid = sid;
-	fsec->state = get_selinux_state(current_selinux_state);
+	fsec->cred = get_cred(current_cred());
 
 	return 0;
 }
@@ -3835,8 +3834,7 @@ static void selinux_file_free_security(struct file *file)
 {
 	struct file_security_struct *fsec = selinux_file(file);
 
-	put_selinux_state(fsec->state);
-	fsec->state = NULL;
+	put_cred(fsec->cred);
 }
 
 /*
@@ -4119,14 +4117,14 @@ static void selinux_file_set_fowner(struct file *file)
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
 
@@ -4140,9 +4138,8 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
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

