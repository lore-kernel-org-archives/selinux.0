Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697415575C
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836354; cv=none; b=hcEiKTrnAFGGO35SAjBdEaT0beHzgT4Q+j7PSQ0pi3t2l8lPD3BaLp62XwxDWjK+KKImwzDjEFoQkPYIllEniDQOoLR/zoot01xdvUKEN3/+zXv6RXyXiBqvw0FeQbOLtWofIlO0fhWzgJSZEntMe98QbDp8KJDvtfllRtqK5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836354; c=relaxed/simple;
	bh=9aEI82yj5MBuwzxIhcriT0S0m7aRBS/Vtz4jCdIc5CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8TSTaVGVNwnJSdJgV+xMJx+fPHLAxc7D01zTyYtiTyi+58hlYzQB7LDvQFQVWekKxbmAUJ9qlobmfAUEpB06kAqKzuqUNadWVDvbBjwy0YgGf7+q0LFPv8/ZyIzJIs9NA3TWpaVoqIkRSIBOIz0uUDri3sNZ2z7Vb0xdppgGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR7F1Dly; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR7F1Dly"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6eb531e13so587369585a.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836350; x=1736441150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpHt0QuX96SLxrx0ZqRsq4Zuvzso+9JWoIe7UP1DSD8=;
        b=hR7F1DlyebHMRo+emOcH3TpGqvE9jcaOJkUjeVh4gXu68p/fMTjVNjsnTlElYsz1+T
         Ml5Zija1Yjh+UM9CA6nJ6C1uQTGFZue5S9pHa7du8GZEdVR5SWH9HeG7tCVj5W1Wom9e
         ql8OqFrwjLUZIAWJMq43dObBtg6AQuVEkrShGsV+K6bv3Y136f9jdFYmMQDfCSx8hVkj
         2+41RfFBhg1mMu5B901/FHz6lTEb9JGHYVa7mzH1cOq/aKn+F2/B0Zeulen4c9b24d0w
         198CylsMHj8pcdW1YiNFoZHKYyzO9juli7c9l1u1lIvrd3jA7r0MNHakqhQu3Dw2p8FN
         iXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836350; x=1736441150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpHt0QuX96SLxrx0ZqRsq4Zuvzso+9JWoIe7UP1DSD8=;
        b=bshJw0jge7//wV8q4TeRQ8qRTu34KIJfGvCQeqQcsx0dz662Y8KtHVlAgTqqsx6j57
         4jraBQ5qQQSuc5jTyvd4jt38tecJgvcKNjh7ETj5bdeIqYGycsUz2/yrFrra4D3tHyw2
         qsTTDsaJTqTIa8ZYyVtB4P6Qo6KaojXBfC+UPgNg2QK1zc5NvLpt3C1JWltcmHEkLW5A
         izj48tWpTVKR+6jm6cPTIcMB68tQ5v0H5nOFmD1CFwz+NnfGjHVFkbsRjpn5SMePnsxV
         IhWsuqU54hSlHigx0rabXjZ3mN3lTZfd7BqOKj28T1zIfZ+6W2SLHcHyNgZzRrp77CH1
         IHFg==
X-Gm-Message-State: AOJu0Yzhb1VvvZewTOZAHtwewGtpXACKNbr6sPp60+uJ5wru+ZNmth3N
	AYA7PanliypDwW+2xYr1urmcVRQKNjFAig4bvhB/CTcJQp5dKs2IXmsjDQ==
X-Gm-Gg: ASbGncsMRryNazOvDTAxDa27pgBu0c3qxfeYCWrOFUxEbydQcpi7nFXMBZf59kVT7wP
	+05If/Lswi6mneTdJVg/1wwj4t1C6EXcdjqZExdNz/Za7K1tOGpAbG04sD0QowcHaK4RsGdN0CU
	+d4cVIOHk4RzdSFrObhoupmtX69OtwKomFBR47AiP05m56mL/QGrCWoh6H7dNUbisbgi1SO3Y2R
	Jm7RA3WJ4NZe97a/iN67Nj7K6KzrcfJff3o+Ah4R0iMXasNp7LH0/zUsrleeubnwqQ4fsmrZaKt
	12dTjemxIxKGUjKiQkem2toK98DLnj1isuYuje+1hg50Kx/YJOxgq/EaNkHGe11x5Va7Ig==
X-Google-Smtp-Source: AGHT+IFm3N13jcjAcyOmURRhyonD875zrp0E4BrWWeIxxpteA/3aWfnzjss2Qqktl3toYjci5u72bg==
X-Received: by 2002:a05:620a:2b8d:b0:7b6:cc37:cbe9 with SMTP id af79cd13be357-7b9ba738a3cmr7116050785a.19.1735836350296;
        Thu, 02 Jan 2025 08:45:50 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:50 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 22/44] selinux: convert selinux_file_send_sigiotask() to namespace-aware helper
Date: Thu,  2 Jan 2025 11:44:47 -0500
Message-Id: <20250102164509.25606-23-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
index e34ba9a9f2a0..5a0355229ad3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3703,8 +3703,7 @@ static int selinux_file_alloc_security(struct file *file)
 	u32 sid = current_sid();
 
 	fsec->sid = sid;
-	fsec->fown_sid = sid;
-	fsec->state = get_selinux_state(current_selinux_state);
+	fsec->cred = get_cred(current_cred());
 
 	return 0;
 }
@@ -3713,8 +3712,7 @@ static void selinux_file_free_security(struct file *file)
 {
 	struct file_security_struct *fsec = selinux_file(file);
 
-	put_selinux_state(fsec->state);
-	fsec->state = NULL;
+	put_cred(fsec->cred);
 }
 
 /*
@@ -3996,14 +3994,14 @@ static void selinux_file_set_fowner(struct file *file)
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
 
@@ -4017,9 +4015,8 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
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
index 6560cb13fc34..7c452047664c 100644
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
2.47.1

