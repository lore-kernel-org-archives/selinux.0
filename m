Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA174E73CC
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617629; cv=none; b=FrcrJbk/YB/+xQiMYD0WBAVuA7gaBzgR7i1jl+23fPC2KAU9CnmN8QlBKB6ac15xYauc0l5zCRmD/S3bjezNgtr2HAbGKjVAPCPfOaEVz2bjvIqW7ZBwN2kEYFQLp4U0mmoBnRQ6w06JSBwPOpXniwwEnaf71a8/lnaAsK6uFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617629; c=relaxed/simple;
	bh=XfNIuOMLJccYJOQtIz27ZuSNDN69p4N1QCMMSsAD9OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtbynxnnNPB3Cb4MmlyiTOYSnIn8FmMPyhEzJxckDz0xiGfqXNvH60bEBe+d+ORVtt2IGE0aOM6j0k+i97CreCIBefyjZhWZ+JtmpHllo63qjG299E0Ek3GmKkg0MSlErJRcce3TK3ajIiwuoRPGlGgN/BAMkZvG4sQITTYr4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=C3uW31k4; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="C3uW31k4"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617624;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nx1c3EG0doGrMq3apldODQVog/ZqmdoSGt9i1hya/i8=;
	b=C3uW31k4mSWtBTdx2y8iGzT5sHnUr6wNP1MCEI1OykbeXf2fC/MFCOvN7dzQKRKfoytBXn
	z4Y67qaVPE6J/dbu4QtZbXCjwaUpNKPcBVhv0zT30pJvWQGfp4XPNBpBGPoVU6TAFyQGB1
	N6GkxF1BSWqUtD+NTNk7wAJXhzCSiarv+fMhAPynY8nV6fDyT1TuCR8FWaSkftR8rWoRVi
	aIadWN2OjimHwI3E2YGQIxGdIZqgzePJ1Rq/SnIUalufNNHRlthqnIS9olBKjLaYYNFYd8
	Rq1+68J9LmFjPg9gZ0qLn52/+WevF9X0Tc+MAxDCFicWHI9Pr1ryWKMDH9ht9Q==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 26/32] selinux: drop page_mkwrite handler for the policy mapping
Date: Mon, 28 Sep 2026 19:46:36 +0200
Message-ID: <20260928174643.2458710-25-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

->page_mkwrite() is only invoked for write faults on VM_SHARED
mappings. A shared mapping of the policy file can never become
writable: the inode is S_IMMUTABLE, so the file cannot be opened for
writing and do_mmap() clears VM_SHARED and VM_MAYWRITE for MAP_SHARED
mappings of it, and in addition sel_mmap_policy() clears VM_MAYWRITE
and rejects VM_WRITE for any VM_SHARED mapping.

Drop the unreachable handler and with it the FAULT_FLAG_MKWRITE test,
which is only set on the page_mkwrite path. Write faults on private
mappings still reach ->fault() with FAULT_FLAG_WRITE and keep failing
with SIGBUS.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 595f9fabbc0b..9c626ef26a78 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -391,7 +391,7 @@ static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
 	unsigned long offset;
 	struct page *page;
 
-	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
+	if (vmf->flags & FAULT_FLAG_WRITE)
 		return VM_FAULT_SIGBUS;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
@@ -408,7 +408,6 @@ static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
 
 static const struct vm_operations_struct sel_mmap_policy_ops = {
 	.fault = sel_mmap_policy_fault,
-	.page_mkwrite = sel_mmap_policy_fault,
 };
 
 static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
-- 
2.55.0

