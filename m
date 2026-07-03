Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198BB343D80
	for <selinux@vger.kernel.org>; Fri,  3 Jul 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079268; cv=none; b=cLKK7Y2NGCpoPogFb8jbXE1E5UkmZ1T66iREQy/dt4s+BoJIL9bvd+tR1+MnZuE8kQNRHqc9w0KtpYCVaUgVqQI/npYFIOfa53EyoB+VscObN3vqblZ/Jtj4jC4zXITE2xFRCdGhu8FzPTAJdApXck/UkhKiGKYxQw6tblBitWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079268; c=relaxed/simple;
	bh=Ie8t3AwSLjLZFiMJ5VEr9GRJShtXoYIu9jCMu1GW2Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4jj6D71jC76MjRRtrNGUog9zDiQXLtDKiL572nIsDjfMbDzBEYA/uGLifaEWtNd5yQSQNEtzU+Kwq+QFtmNXxqjpmk1dcYUMUhdoCAcuz/Nymow02NiGPT9PYMFG74djoxAStiNNaHGfiab8ViNCSAohFJK+wgaNVAuRNSZfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKbGOvFe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ues12Dre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKbGOvFe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ues12Dre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783079266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fAU3gNJjPq3P8YvIL49WN5Hu3q24A17MTS2QVGG3Wlg=;
	b=ZKbGOvFeKO5sCNveEN9eDqVD2nlAFccjRmojP/ClJBxYdjj4aUjLKcjJAnr3IsPcCzXXD8
	BdVL03gXJi9Us9UIKkZzyv8Cz+UuKuTd4X5VhEPt7OJnu5DadzTW2NsPuUi9J2UBMhkUfe
	LjiJeDrhZzEJiWKdorYvuKP67bkHdQ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-epl3LlBoO5eIOeb0buf3aQ-1; Fri, 03 Jul 2026 07:47:43 -0400
X-MC-Unique: epl3LlBoO5eIOeb0buf3aQ-1
X-Mimecast-MFC-AGG-ID: epl3LlBoO5eIOeb0buf3aQ_1783079262
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472c330e555so265565f8f.1
        for <selinux@vger.kernel.org>; Fri, 03 Jul 2026 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783079262; x=1783684062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fAU3gNJjPq3P8YvIL49WN5Hu3q24A17MTS2QVGG3Wlg=;
        b=Ues12DreyPe8MRhUhCtyQJy7NXbRtbLBWzJdy/hhdMb4oS+j3kVMyt3vOPaAXA2qe9
         GQxh6bUmbingsfwGM5+2tVlK/5PVJYBFU5PB7Sn+sLHmYFyLbkoE/BacR5BZv+NG0nOG
         1Cv4UOWZ2XD5ekJuZXQE+hMKNZ0TKNH3sUSTF9z7BpKFvMuMqOIsNQ+dv4Y6lVD7eLYH
         EvIkxywnJ8vbNkGg0n9ID3/hchNkmsJIRgYwHUlXbu5eCw1ueWSYhqYkRC7cuH0dYjpi
         71oswLw0aOswP/07Gd9nc4Bgm6tVQDNEFDJbprgPCLdiWtZfrM3dFtC384ZMy4GC7BwA
         oB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079262; x=1783684062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fAU3gNJjPq3P8YvIL49WN5Hu3q24A17MTS2QVGG3Wlg=;
        b=qJGnJghrPOH9W+XlRNDSarWZHIXPtLE1Y2PABhPdBhnMa169Y6FFDgMXJzgjK001X4
         gSl/W0zm/xEeFPYIPKWkYoOg7DMjouIYCIBtZGbib71A6x5G+b6dfJ7o3/TyclctFjFA
         s/QykVc6iwelkMNsDTNqXnmRdtONspmyD89v1qEZ6jyIDLPOMijNPkGhwAyjjbQfUJll
         6HG3eazJ0/QBDeGacae1HmWapL2y5DJoJ8/ixp+xHpB2Od56+F33YovTptwOefmy8j06
         KhJOcClJ7yJ0P2aSqLWUKUjVq8KJHcP4HbEJzQAfLSxqynehPjUOlmqEoyLyf/eC4NK8
         JmeA==
X-Forwarded-Encrypted: i=1; AFNElJ+AfTm7ctCBcGLmeor00YmO1VxZYNqy0gYb6OjK1M7gm4OTnxLQlcveT8z8BhgMRpsoZWSEGYCN@vger.kernel.org
X-Gm-Message-State: AOJu0YwL20ZtpwwR8mVqhiDkbjfrpOyJWWr1/9tPzlKCpzKnPiZZdVYq
	1GS2xp6SQnDKwqa+1WgUmfLqdtKwQPE532zG0hbGh9Wf++iTwFHk40SLrPJEBwghXEVd7mA+K53
	j7okNP0XA/81CMBTuhPoTPO3VoZwR7GvYII9VVXUHFEEq+ZEYxpxVyeCBoOE=
X-Gm-Gg: AfdE7cnz68HGbYAc94Gv/lEXERRzcKt7LLHKEmbg9hVMZvgS4/5ObwWrJAxolZiiz33
	1YTb41iwbX7s1o2oe9hLQsKbC0ZrxcumlyZFLM7B+vLmsNXA/HyVAy7Bg/g8/U8dUj79LnL466o
	AXZM1Twv0Pr2TOKt3kqnq+ZJ0CFzMePq2HzIvN65salF8hj5ZNqn5xlKjS2+8AlcXEWNJK80CdR
	qFs5M+ZrC4oO+hlhZTJGCLd7k93AyF5YNi11WMngpgQDdKGgiWh9zfVTMalU+q/sglo9GbXR6W8
	tTm+otz5dP+sbEv0NbaxYQ6p5bGL87VmRMliWNW2fs+8Wr53+3jSpIhDFtS2Av4K1Kqy
X-Received: by 2002:a05:600c:6a98:b0:493:b307:6777 with SMTP id 5b1f17b1804b1-493c2b85665mr104374405e9.22.1783079261740;
        Fri, 03 Jul 2026 04:47:41 -0700 (PDT)
X-Received: by 2002:a05:600c:6a98:b0:493:b307:6777 with SMTP id 5b1f17b1804b1-493c2b85665mr104373345e9.22.1783079259836;
        Fri, 03 Jul 2026 04:47:39 -0700 (PDT)
Received: from fedora ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm145512755e9.15.2026.07.03.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:47:39 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org
Subject: [PATCH] selinux: fix incorrect execmem checks on overlayfs
Date: Fri,  3 Jul 2026 13:47:33 +0200
Message-ID: <20260703114733.1243995-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit fixing the overlayfs mmap() and mprotect() access checks
failed to skip the execmem check in __file_map_prot_check() for the case
where the "mounter check" is being performed. This check should be
performed only against the credentials of the task that is calling
mmap()/mprotect(), since it doesn't pertain to the file itself, but
rather just gates the ability of the calling task to get an executable
memory mapping in general.

The purpose of the "mounter check" is to guard against using an
overlayfs mount to gain file access that would otherwise be denied to
the mounter. For execmem this is not relevant, as there is no further
file access granted based on it (notice that the file's context is not
used as the target in the check), so checking it also against the
mounter credentials would be incorrect.

Fix this by passing a boolean to [__]file_map_prot_check() and
selinux_mmap_file_common() that indicates if we are doing the "mounter
check" and skiping the execmem check in that case. Since this boolean
also indicates if we use current_cred() or the mounter cred as the
subject, also remove the "cred" argument from these functions and
determine it based on the boolean and the file struct.

Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f5..87790f6f0d4de 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3969,13 +3969,14 @@ static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
 
 static int default_noexec __ro_after_init;
 
-static int __file_map_prot_check(const struct cred *cred,
-				 const struct file *file, unsigned long prot,
-				 bool shared, bool bf_user_file)
+static int __file_map_prot_check(const struct file *file, unsigned long prot,
+				 bool shared, bool mounter_check,
+				 bool bf_user_file)
 {
 	struct inode *inode = NULL;
 	bool prot_exec = prot & PROT_EXEC;
 	bool prot_write = prot & PROT_WRITE;
+	const struct cred *cred = mounter_check ? file->f_cred : current_cred();
 
 	if (file) {
 		if (bf_user_file)
@@ -3984,7 +3985,7 @@ static int __file_map_prot_check(const struct cred *cred,
 			inode = file_inode(file);
 	}
 
-	if (default_noexec && prot_exec &&
+	if (!mounter_check && default_noexec && prot_exec &&
 	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
 		int rc;
 		u32 sid = cred_sid(cred);
@@ -4013,11 +4014,11 @@ static int __file_map_prot_check(const struct cred *cred,
 	return 0;
 }
 
-static inline int file_map_prot_check(const struct cred *cred,
-				      const struct file *file,
-				      unsigned long prot, bool shared)
+static inline int file_map_prot_check(const struct file *file,
+				      unsigned long prot, bool shared,
+				      bool mounter_check)
 {
-	return __file_map_prot_check(cred, file, prot, shared, false);
+	return __file_map_prot_check(file, prot, shared, mounter_check, false);
 }
 
 static int selinux_mmap_addr(unsigned long addr)
@@ -4033,9 +4034,11 @@ static int selinux_mmap_addr(unsigned long addr)
 	return rc;
 }
 
-static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
-				    unsigned long prot, bool shared)
+static int selinux_mmap_file_common(struct file *file, unsigned long prot,
+				    bool shared, bool mounter_check)
 {
+	const struct cred *cred = mounter_check ? file->f_cred : current_cred();
+
 	if (file) {
 		int rc;
 		struct common_audit_data ad;
@@ -4047,15 +4050,16 @@ static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
 			return rc;
 	}
 
-	return file_map_prot_check(cred, file, prot, shared);
+	return file_map_prot_check(file, prot, shared, mounter_check);
 }
 
 static int selinux_mmap_file(struct file *file,
 			     unsigned long reqprot __always_unused,
 			     unsigned long prot, unsigned long flags)
 {
-	return selinux_mmap_file_common(current_cred(), file, prot,
-					(flags & MAP_TYPE) == MAP_SHARED);
+	return selinux_mmap_file_common(file, prot,
+					(flags & MAP_TYPE) == MAP_SHARED,
+					false);
 }
 
 /**
@@ -4087,8 +4091,9 @@ static int selinux_mmap_backing_file(struct vm_area_struct *vma,
 	if (vma->vm_flags & VM_EXEC)
 		prot |= PROT_EXEC;
 
-	return selinux_mmap_file_common(backing_file->f_cred, backing_file,
-					prot, vma->vm_flags & VM_SHARED);
+	return selinux_mmap_file_common(backing_file, prot,
+					vma->vm_flags & VM_SHARED,
+					true);
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
@@ -4149,11 +4154,11 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		}
 	}
 
-	rc = __file_map_prot_check(cred, file, prot, shared, backing_file);
+	rc = __file_map_prot_check(file, prot, shared, false, backing_file);
 	if (rc)
 		return rc;
 	if (backing_file) {
-		rc = file_map_prot_check(file->f_cred, file, prot, shared);
+		rc = file_map_prot_check(file, prot, shared, true);
 		if (rc)
 			return rc;
 	}
-- 
2.55.0

