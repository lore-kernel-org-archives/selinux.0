Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494833F383
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138828; cv=none; b=BTsEKeKLYA01sKZXej9LtCRMy7pZQV5uy6GnLzjT12S0iiY6PWSxgp3dYx3tK/NQWKd7yWWTmrP9fzJvQdIFgKAboEaycvUgOuka4EdsM98liIOxkXjuaLlpajYgNrEe9wcxUlf/PNKr+typWxn0f2ucR/Hgx3obMjfHA/lXhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138828; c=relaxed/simple;
	bh=1iccaAk2DpMcFPOeIA50EvR9Vr76A2gD/VEB4kdHJM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WhwATwQtR98QBYS2TocAw5/YI1QlQNT0WJ4sNQ3Xm4AnrabPEaqhlPXerAcGbwk6WgoJTo6uPmNtKlZFXCVcC6incDIxtrwOFYijh4k465Qdc+dx+uYOx3B1B+8IZu7N/WBRLIrcXd+N7D6Ci93bdMESqT+vi69qY5/fORwX+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lut2e3CQ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lut2e3CQ"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb769ca17so11763591cf.2
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138826; x=1789743626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ezzsRFIPAETPhnq8POn3G2w8BscJ1bGp2nfA7Ef4a4=;
        b=lut2e3CQ4AqfJUCtAo0tv1Nx8CKEdf7p427Gj+pqOxG1QQapLKzU6qyV4VgkIUvPXj
         y457DB8WPzEKeW+8/YyCz5haWVsB498YEOG7ckC8rvugUEPeIPtedZzQY9f+WJ5n+Xck
         bdi6E3dHAs5HgnxHOqMG8nV9/B06gYF2GxLTRzs+Enu6ZAlIxhwMKgGD1u/CNjOsUw/M
         l271tE5qvo22aSU9uRPZMz/okMcjhdxbHMBffupXS1fn8IhhauXX0V3fuYU3k1Bk8/M+
         ii2BILE7KhiVIDxyNtDcSSO/G2jO5ZA+fbIsW0ICdTW1Yi+0ZPrALb8UcW4lNfOmOm2G
         RetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138826; x=1789743626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ezzsRFIPAETPhnq8POn3G2w8BscJ1bGp2nfA7Ef4a4=;
        b=eEvoaWMqwzwoe1mMLlU1N6gYFoRhmznU8K/bF25i+ApJPBT2+vRGRq1x2yJTfByjqG
         L2ozaQ8fzYZRtQb8/TYUcGgzj8jq6HnWXmcQ7lhBrUvUJfRzPAGD4Ms5wc5BcOIjhHeX
         92byOkcNCbsh4boXuG88gxlJrsUFQtcgxU3GVEIPVMK7uOWvuNDQn0az+ckB8OAukMAX
         UlEKS/IwLHpsvuZ72CAKXEYuwU0Hz+wsF/a91eEhJuKdHLx0iUT30KnjsWQ0xZuKU9lr
         zh8IYhoNSO7SEnAFLYgpCHPQpF0kM7OhJN5xWvhidmCKNsNRFR4cm7DTcb1jy65Bw8kj
         LT/g==
X-Gm-Message-State: AFuF++nux9iBbnCV5ZeuOoFq383IKgfMLI7jHds+AxdVUwcQjI9S4Wj2
	fQAcK+h5qyUVi5Ok8Eru+zWf8y4inQjm+DBaUrKbl3nXioNtcVhxMNDTmQRRENcA
X-Gm-Gg: AYBFou2e/yXN+k3S/BvwJqCWlfpX1BaP7y3WJ35om98e4JGexgi7nBtYNGpo5N3UgGJ
	QFo4g6VSkiUO5R0P+rCO+GAmTjR/tEfIb6Mn1ZUclti+q9mSI4vblIrXSalX6bd3Qav0W8r25UR
	MO8JgKef2Gr/7+XOB7snAkwQrVV/uyvVx16bCjHsiYYsNjeNqGVrr6mtim53s2n1BVwM28S3gqn
	9kW3qklDiT+nVWbbfJIFQT2ITZRO6WptLQWFjnjMNnskdDg6CVti+LLyFyLnTih+90+9CJ0leVN
	E8VHxwA8wXONOyndmC1bHpZ3hBNzV2Vt01IUBXMf7AjGgfJLfCjR4Vsosf/Bky4oVPZBwLCAg5v
	bKMawfXTBebFln+/PiP0zcjcaHmVVedOxIumwYzHodNXb52UB6ZhVo9j5dwfWISugcNy1IXT9xQ
	pkmOBsCvvmW1GO/V3/+xqZz+RLs+7lhbNNfXrUOlr9Rkenijy92GnBfuUvLKwgbxCIkH/pZD0Md
	KV+oN8vYzH/Rn34Scg+okRdyt6xODVm3mxIpjtIfQquk+cGpdDaYYIngr9+UpfQTXVnar8qo8Y=
X-Received: by 2002:ac8:59d6:0:b0:530:39f3:6c7f with SMTP id d75a77b69052e-530c86d506fmr81542311cf.29.1789138825218;
        Fri, 11 Sep 2026 08:00:25 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca47efa2sm21814061cf.11.2026.09.11.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:00:24 -0700 (PDT)
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
Subject: [PATCH v2] selinux: reject writable opens of status file, drop mmap write checks
Date: Fri, 11 Sep 2026 10:58:41 -0400
Message-ID: <20260911145840.19039-2-stephen.smalley.work@gmail.com>
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
VM_MAYWRITE and checking for VM_WRITE. This does NOT prevent
truncation via open(O_RDONLY|O_TRUNC) or truncate(), which is
left to another patch.

Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
cc: ljs@kernel.org
cc: jannh@google.com
cc: jack@suse.cz
cc: cgzones@googlemail.com
cc: brauner@kernel.org
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 corrects my previous incorrect claim re preventing truncation,
deferring that to a separate patch like the still-pending one
from cgzones, and also moves the FMODE_WRITE check before the
status page allocation.

 security/selinux/selinuxfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 292302eb60f3..835594d221fc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -214,8 +214,12 @@ static const struct file_operations sel_handle_unknown_ops = {
 
 static int sel_open_handle_status(struct inode *inode, struct file *filp)
 {
-	struct page    *status = selinux_kernel_status_page();
+	struct page    *status;
 
+	if (filp->f_mode & FMODE_WRITE)
+		return -EACCES;
+
+	status = selinux_kernel_status_page();
 	if (!status)
 		return -ENOMEM;
 
@@ -247,11 +251,6 @@ static int sel_mmap_handle_status(struct file *filp,
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

