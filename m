Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9A46A608
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134726; cv=none; b=Z8esUsaamDzPqmfzAimDGkMIevAgB56MeJUKgS8V7QmTgwXibmurQixvYelh0aHxSowG4LFU3Ptdl2aa3I6h964+NWvPj/H95MK8rfxVs9omYnOTgpVxO8VM768xaGEu7TYt10MuU9ypIxq/0EOxhA2Zu8jbuFlkRctTUbwsoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134726; c=relaxed/simple;
	bh=C7i7DkhgUWtIVDPCdGl/PZGRmdglROd2FY+t1LQlSpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ko+l4q73HSV71xuXBZyLmbNlooJRjpkqCqeoBt/xr4cBcNouLxj3n5jQzvyG7MiP9Q77W6a5rs+7canhVRb5HB6033al3EyUK4DidMRS1RmdY8MKzz6BswEjNCE4g92c/UJHtTSN9EwpvOoawrdgD6IClGGbVJmuNUex4qK3SQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npVBS2OF; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npVBS2OF"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939695b5741so96458885a.1
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789134723; x=1789739523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mNcqn50VnErH2t2c6SQSD7y0Ze92yI9r0uKX8OUwQ8s=;
        b=npVBS2OFVhthU5fNc0hXeoMgSbMVC+6mni130kiqe5aKcM3EUOi1nyij/BoLkzQZLq
         b5ngwrf4hE7iJ1JYdyABRzykos2fiJc4+47143XItawg4Gwhm884rlB3qXcK04zu942W
         SC0j16JTkbkKQq973GKmexJPH8t0jxqImbBoW55PFDc3zZ/u1Xp/W6aSlkO/oi2s14RP
         +VeRbc0trdyvRX3avGPRo7I6qg8T5Vrds0AgLmQJYgNyFwlHYqHZs2vMPD6OkC+1rRnE
         fr+pR7rwF+Zo3rp1szDXDYV3Azhvvmcerf+UDcLxeF43eJOSugzn1bnQS16JrLUs5uga
         B1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134723; x=1789739523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNcqn50VnErH2t2c6SQSD7y0Ze92yI9r0uKX8OUwQ8s=;
        b=HpYE/HXtQOi/sQ8vuPWJOAmavscg17sQnzYDDKmSUI59vGAHn7lG3m+GG5aVQ/8iAq
         hXalW1B0nnT58gnayAgcvKTihpJKS0Kq5pkDyrCDhJlKce5l3WNTZwu/N7UxhpyvuykD
         CsdvEo2XJUQNYmaywHZVcs9CwtPuZhxOhLYokF9WOvk7ZZ1IzX6iBeFqfZlUSan13FGr
         PaE4zKayCS8UPp9H1llZygi5vEcZy0M7yw5yjHLgmTH8WgtgwOaKKV2sGIWgRIgAq0Op
         nztmhBRta/L6EaMUyJzT2HLjaMJzGteDy53Joko3/h3VjrEcrYv+3g0VLwnVyZkNgZnR
         gBzQ==
X-Gm-Message-State: AFuF++m3pjTfst9TGFqNoK9YInAzDVu4/Om1UpEOvRuKjM61SEIZ6DPf
	T7UMnyJIc0cAa79fmMJXwJfudcKLtLD5NW3m2JqgWnSX4LnGlzD2l7OcCsV7NJSN
X-Gm-Gg: AYBFou2VdUkhs5UsG93LzzRPFKU/C/nnwVr29B7pNxXvOR5BaRuEIdpo95AK5jAHBSQ
	WEbaKhP04pGCQQsmTVD5eJwOacqaH6upOMCJ3Cb4VzGRscV91IEF/SPBCZqETm1gX3I7cW5d8na
	oiHVeTfZ1LarLMewoKS4FAMghaAkB21C8QmWG8GnEL//31YxUg9SJl4coIkVtcQaO45EqdytCgS
	+bc9EC70sWCQYu8QGO/78DnXHQhXvhVtSfrdErTlQN/LBRJbcLBueJ7eUIrBq571An4VUO2euVm
	TjffFtt1YXJuwRJl4lv/lAHtthOIrFwEZoiBaN3QKvSp2TBOzMn0fltjAx1Ph7n8BvOdLF7nSe0
	Mh2o7XNeWmp7BRU4upws/TbJCMX28SkM28WjwbbuanTLyv16wZ1XPf7JqaVMKKVln4mgfnaRF08
	CSNk/3oegfr362f5yoh0nM5ImVTxe4wIVdbxv8E0vmpgcaGLdw45eVkP0Uv2eaHZ8AKcY4s3Wzd
	lRSgT9z0ApYZTaDjmIR05gpPkM1y0AsGFHh81/KBfunuFuPn5FNdknuJ7mnaDkXJh3PD56r14k=
X-Received: by 2002:a05:620a:2b43:b0:939:6dfc:8abd with SMTP id af79cd13be357-939ea21022dmr518641785a.52.1789134722850;
        Fri, 11 Sep 2026 06:52:02 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8047a4dsm251932085a.23.2026.09.11.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:52:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	ljs@kernel.org,
	jannh@google.com,
	jack@suse.cz,
	cgzones@googlemail.com,
	brauner@kernel.org
Subject: [PATCH] selinux: reject writable opens of status file, drop mmap write checks
Date: Fri, 11 Sep 2026 09:51:47 -0400
Message-ID: <20260911135147.15355-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to what
https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/ does for the
policy file, update the .open handler for the status file to reject
writable opens, and update the .mmap handler to stop clearing
VM_MAYWRITE and checking for VM_WRITE. As a side effect, I believe
this will also prevent the issue previously reported with libselinux
users like systemd seg-faulting on the mmap'd status file if it is
truncated.

Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
Link: https://lore.kernel.org/selinux/CAJ2a_Df6GOirF8TnNWTqNMpdWLHgjT9_v7G-PiL4e7LU2nr1PA@mail.gmail.com/
cc: ljs@kernel.org
cc: jannh@google.com
cc: jack@suse.cz
cc: cgzones@googlemail.com
cc: brauner@kernel.org
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 292302eb60f3..3657778de82d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -219,6 +219,9 @@ static int sel_open_handle_status(struct inode *inode, struct file *filp)
 	if (!status)
 		return -ENOMEM;
 
+	if (filp->f_mode & FMODE_WRITE)
+		return -EACCES;
+
 	filp->private_data = status;
 
 	return 0;
@@ -247,11 +250,6 @@ static int sel_mmap_handle_status(struct file *filp,
 	/* only allows one page from the head */
 	if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
 		return -EIO;
-	/* disallow writable mapping */
-	if (vma->vm_flags & VM_WRITE)
-		return -EPERM;
-	/* disallow mprotect() turns it into writable */
-	vm_flags_clear(vma, VM_MAYWRITE);
 
 	return remap_pfn_range(vma, vma->vm_start,
 			       page_to_pfn(status),
-- 
2.55.0

