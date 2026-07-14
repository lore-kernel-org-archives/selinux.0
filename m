Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676144D014
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034007; cv=none; b=aP0HEDJpDIDUotypH9mJVJWiH/9w+beNssw/Yi7HIdw5/1SEbZSVyUhIIbnnXh/zNlmgAw5C8hF2U81/Xw320ILzeIL/kayIse9XnlfzvTu0I62IcSQHVzrH9ZmPtK6s+hxGix0n8jhp92ZbY2toP+aA2el1uzsuvRBHnij37f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034007; c=relaxed/simple;
	bh=MVRWGeT+I6qUEITiwRiAUfb6a+9x+2f/S8DhU2+Smg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNLK9zWrkhayyZ1N83LFyivQWwnZq7UrOW1bbTvfuObgLWg/9UN4o+/qHmaDqCHcKAi1vObRa9bgxtY2gtoPaG5F6D+SA/FUt6s/tFulmyRWzdb5PO3c2d9SQ7k8DC6mtfBLFd5PvTMrEKtEgiEv3XxoBifCS3e+RLbfYXlFdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ip5QcXJZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p6F+IWJu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip5QcXJZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p6F+IWJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784034005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iLK94Vb92T2UiOotEB+hJAEFkjx3qFo9um8JczdnHmw=;
	b=ip5QcXJZnPM4d+Mw1YJ0nSlyozlK4ElsJTSyZ850bDKWo6RnbhKUvR5KF1kwX1I3qKrkHH
	ffbmrQjkt/Jz7RoEiTU4mz7/mLm3dCl+ey75Fp0CjwMSPyPglJEYrDSd8vs4hVwtS2XmNI
	Z6hEXzfkwMZbGbeoFCmgI7YzFbSB5Ls=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-xED4-PBDOx-lgHiPDJ-a3w-1; Tue, 14 Jul 2026 09:00:03 -0400
X-MC-Unique: xED4-PBDOx-lgHiPDJ-a3w-1
X-Mimecast-MFC-AGG-ID: xED4-PBDOx-lgHiPDJ-a3w_1784034003
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69c6057f3a3so3150007a12.3
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784034002; x=1784638802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLK94Vb92T2UiOotEB+hJAEFkjx3qFo9um8JczdnHmw=;
        b=p6F+IWJuT0RD7REwS3r080z3qnv+qk6AY1RsWFTdYuZwhE+e6b1Cp92nNbaKX5lEJK
         sRwB7WjGL9mH7Ua/IFqBLICLInvIG6owAPkr7EAegpw04zejC5uXeHYentK3DJCg2kws
         aUB/qUIujwET3iU62luvjq1NDA4+xfTueiDyFwxWCWnEuQB/l8Lv6RSX26zPe23RHyr5
         XnTvVgYF0PWo0a/BZTSzxZbyqoQEZ6zp7dl3z7mPs8U/ugdoYvSv6ZA1JlcOBckDtFz0
         +9SRSEnEKAu9MbNS96ZwSSya2uVk1BwpIC4QkmvxMBlRtxDMTGz0kDrq7ZzoVMCQHNqN
         Vvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034002; x=1784638802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLK94Vb92T2UiOotEB+hJAEFkjx3qFo9um8JczdnHmw=;
        b=IqpbSBefrc14R0trJNCuO4D2CxstBSXC2T1hmbKm85UM/IEVaDUEvGe/6/wpjF/Xyp
         WuzhWThOOBZ3ugCO1W5zw47aB6RmluHzqO1G1SO6/S7xowNubgHQU4t0gGV+YM7hoztK
         gMaeW1QEtcI1rlxuR1k9cO9RotRpo6ulaVjRlfXqizl6xi3GHXRfcHjokxkDREX6wyQ5
         t7sYNEiJ2EqN063OkeQIehwSIhlgZ0B+HiygJ7ztsLpn6ZRZ+FuaA1HaI1u/LWkmzhdZ
         aIfnjViYfx72QchvHWGdD75keGokY3l12yNAplSnsWK5tXSIjPznFSjzk/ZSDLBTi0m/
         epIA==
X-Forwarded-Encrypted: i=1; AHgh+RpvLRibgRbsUzRa3S6jfeC0Ba5F1GprHYuxRpH7SwDNMWhTwP+SOFV+wAk4+vgAA0ny/lV8W9U7@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxRvix5SKZbYnKDcfM6Li60caZrrLO8U9Pm/D7HHjC0PN74eu
	GxQcsWi04ajaIDzJhTLHAxFYcSzzgqtG/+dsc3K9r/nBgBq8kzVMFZn5munKdaHjZITGtlPHLFV
	bQ8+fjQ4MwEG02Uqif+8izIAizs+UMy40aXMFWCRopcbk4F6Tuop99wYps7/g08NjYAw=
X-Gm-Gg: AfdE7ckIr9OJxX9fujfHf49LWc6NC6KlbgwnBUDobZTvd3jSocFeZLSlRhamNzqy0od
	SiceJ9DSdnq7iHayTzGKVpgvQmr3LerPox7/2xKW7h2D49Yd6Qa3Jez0Bah5Vulgn4Ks53bWuZK
	iuRV7F7OFoPu3ZmzRfQIJhbJZlngb5iO+tOJ+ZlmBbBuhl3U7nTi4pwT123Z/c+FR5QgNZgGt+5
	m8ZOvZcggYV70O/OQtxX8MZAkR7JgbrXn5+zL4/wNYOneRaafApuISoDLcjYSfDwpbLtBZ0fW87
	vFPpvNgB+GQfI4xJXd3NoMonr9kEurySY168H6I1kNx5saPOLVudiDlXpuVqaevMWF2gobRe0UH
	PjxZAAN4BUVzoIgk46rNXHKCa60Z6C5/LFrRID3Kt
X-Received: by 2002:a05:6402:51cb:b0:698:3e99:815b with SMTP id 4fb4d7f45d1cf-69c5f234970mr5863218a12.37.1784034002575;
        Tue, 14 Jul 2026 06:00:02 -0700 (PDT)
X-Received: by 2002:a05:6402:51cb:b0:698:3e99:815b with SMTP id 4fb4d7f45d1cf-69c5f234970mr5863198a12.37.1784034002165;
        Tue, 14 Jul 2026 06:00:02 -0700 (PDT)
Received: from fedora.redhat.com (109-81-89-200.rct.o2.cz. [109.81.89.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd29213d7sm1495130a12.16.2026.07.14.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:00:01 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org
Subject: [PATCH v2] selinux: fix incorrect execmem checks on overlayfs
Date: Tue, 14 Jul 2026 14:57:59 +0200
Message-ID: <20260714125759.1042127-1-omosnace@redhat.com>
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

v2: only access file->f_cred after checking file is not NULL

 security/selinux/hooks.c | 42 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f5..65d6a2d6061e9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3969,9 +3969,9 @@ static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
 
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
@@ -3984,10 +3984,10 @@ static int __file_map_prot_check(const struct cred *cred,
 			inode = file_inode(file);
 	}
 
-	if (default_noexec && prot_exec &&
+	if (!mounter_check && default_noexec && prot_exec &&
 	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
 		int rc;
-		u32 sid = cred_sid(cred);
+		u32 sid = current_sid();
 
 		/*
 		 * We are making executable an anonymous mapping or a private
@@ -4000,6 +4000,8 @@ static int __file_map_prot_check(const struct cred *cred,
 	}
 
 	if (file) {
+		const struct cred *cred = mounter_check ?
+				file->f_cred : current_cred();
 		/* "read" always possible, "write" only if shared */
 		u32 av = FILE__READ;
 		if (shared && prot_write)
@@ -4013,11 +4015,11 @@ static int __file_map_prot_check(const struct cred *cred,
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
@@ -4033,12 +4035,14 @@ static int selinux_mmap_addr(unsigned long addr)
 	return rc;
 }
 
-static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
-				    unsigned long prot, bool shared)
+static int selinux_mmap_file_common(struct file *file, unsigned long prot,
+				    bool shared, bool mounter_check)
 {
 	if (file) {
 		int rc;
 		struct common_audit_data ad;
+		const struct cred *cred = mounter_check ?
+				file->f_cred : current_cred();
 
 		ad.type = LSM_AUDIT_DATA_FILE;
 		ad.u.file = file;
@@ -4047,15 +4051,16 @@ static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
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
@@ -4087,8 +4092,9 @@ static int selinux_mmap_backing_file(struct vm_area_struct *vma,
 	if (vma->vm_flags & VM_EXEC)
 		prot |= PROT_EXEC;
 
-	return selinux_mmap_file_common(backing_file->f_cred, backing_file,
-					prot, vma->vm_flags & VM_SHARED);
+	return selinux_mmap_file_common(backing_file, prot,
+					vma->vm_flags & VM_SHARED,
+					true);
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
@@ -4149,11 +4155,11 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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

