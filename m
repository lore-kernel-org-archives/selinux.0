Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D524EA90;
	Tue, 10 Jun 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576208; cv=none; b=NtRuyPiUhd3oSWweqjIAF7DqLEtl8NKtMoWzjlrYx+qngUD9S5XAdzRj3dU42l6YPGYXB1nhejl/4xBToOJzp04WF6vDPav2GxLuEBGIFH/8wMlHMOCEQ1itEQfGu6VoAS2JVDlj78uZjRO6VwOTg9W6tIkvlWWE4Y/WrQqSLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576208; c=relaxed/simple;
	bh=uox2P2Hl96WYhrLMSzZDCSsJx2tfsaUYkp50lXrN5KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idd2zHY47rbIDdTHc7HY4KtYkVLgfiSgXwLS0ooAXNJDy9KTereZagdDntb06wWMMtcq9nd+IF4Up6r2O5dnfsF/1WVtNqD+6rb24N9uFEwktdEz5GES4UxAdZA4ZFcphgiTA753MYJcSnBsQhZJZIoh+M5s8egyJZq0qTAQj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqaVSie/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqaVSie/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4772f48f516so700201cf.1;
        Tue, 10 Jun 2025 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576205; x=1750181005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkqGtM3F0SZsf67PmjPNDYUpiKec4HiM/s9NZaoYi/I=;
        b=KqaVSie/DZjfQeS/lq85JSlHgjVafNDGZ87izsgYiDmcaguBmL1xhkhPpdOhanOF/z
         OpHbuan5fdDIjBagmup1Z9HTPxlMvNNhdlJHKF3fqXQNmvSJHeB1SY9QVaFK379Rvzwz
         VWmfteyEm01yZr4whXHLJXUvVg3I+Puuee1iulHHwO57h/6GF1iNkjXpbNvjNf9Q8we4
         dj57+LZXAVWC5s1lUku/vUUi/VvY9Iincm0jVZAOmR7l2Vn6Qbtn/zPyHDBeZog3MMoA
         DoteEv9/waDrFg3P2RTXY4SrgPT2F4ySSpK/7h0d2Ha1UhlGI3+Ez6NJTrVrxrdMq90V
         dVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576205; x=1750181005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkqGtM3F0SZsf67PmjPNDYUpiKec4HiM/s9NZaoYi/I=;
        b=wu1gvXpIMoVKFpsvPuKfOH8U0rssXuYfqPO/OyzkYMJCr01D3b0fCWtxBS5E0ZVTQB
         lKJV+yy/KW0W5VHF+1uPmDJgv4lLaY/6lBpTOkljWhJKq6iGd1KUXQcieVdUxCu0SPn1
         RwxRTk8bo1K9Kt6AJVPlSz/3X5vcd5BL/QSMgCRnlyHW0doC/bipbINMn8djj4iUyOdX
         OaZiA/gaJvxdeHrcbAcgUmeozxha4OaKg+iQ7/lGkZT9puim25nRHQ5uDAmdT/Zzdbuc
         /yWoekSdczYSJEczg96wrL358QZ17Htxfs2xxFMUF4ejENmoMz6yd0u6hYMjw9tFbZNH
         VUIg==
X-Forwarded-Encrypted: i=1; AJvYcCUCel2Z7a3fkMPeoYkXv2oLtjbVBosCxXNNFHNmVAQoIoKhd1WJF5r5PLGGLS901g/t792uawQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwxph2HAfIT3BQk8pRcRwYhDaw06ePHuWFnzhcb74VnmJF6r2k
	pb+HhneiYuFxV4jgnTAgS2ey1ltInr96LcfLBLcjuG7SDgrGLl7tFGnjh8zT8Q==
X-Gm-Gg: ASbGncugMKuzzvfVdurXqwDaB/lIONZPB/iWwiL0agaLLTCF1j96zTS11gS93OFa9eF
	OK7Wcwp2SmP8eZJ1IdVIVrONFxpIxhCumbiZWtxuoPK7aYWjtlJ9iEvjppfbsKmdaO0daueKsmO
	0yezxsV+JCe9Nb+Yd5s838LKcWuVJNMU0X9RRKtdtXF+Mi06rOqZHt2YeA7Th/lyb31Gm1G0lC7
	ayoN4thmPIoibjnh5Q6B7ksDXxgyKaRRVPfOVqrWNvpImNUqAJGQU3rLzYHpV5TrAbuP2FmZNVM
	By/Ewshdvuzoj96ZUAdCLiDHAcBel8/tBC92gpp7HyGZQbPgIB8aoqJhL0vXx0j5KVBF7hb9DzX
	ZaIrcZKj8LNvk/T33QbfWvMpvxa3C8DW+qodWdJl5j8ONAkQU7cabPPxkYkPeFgYqXzPEm0f1Yg
	x5
X-Google-Smtp-Source: AGHT+IF1cNOnHCH1zhUqRWaEE0Ao2/TY7ZeEpkALfa2x2yfYX5QLF1JaKtr2kKEkOcODgnQKJzYCnw==
X-Received: by 2002:a05:622a:4a89:b0:4a7:896:743c with SMTP id d75a77b69052e-4a713af085fmr5608781cf.0.1749576205162;
        Tue, 10 Jun 2025 10:23:25 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 30/42] selinux: convert selinux_file_send_sigiotask() to namespace-aware helper
Date: Tue, 10 Jun 2025 13:22:01 -0400
Message-ID: <20250610172226.1470741-31-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index 2e2aa80b76af..25f7b9dd77d4 100644
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

