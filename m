Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8443F44C5
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814830; cv=none; b=NEs6/rCzEakpXpoV116RSey56hxEzviwPt5tdXMC8wA3DyX0HTnwe9jbkD9EXIXS6qZ//G0NesAcs+IHHWZvuy5YEt0IiLlvJvBnTVlKo5xPNAYTunVy13jI77Z7SBxIPEJdCmujVDZygDis3WuATM40jtZmMdmkdLc/JlULtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814830; c=relaxed/simple;
	bh=nXhPP7b+pyPXaxP9+90HyfAUpFQfbnZ7QKkr8iKuqZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWdHFWVc4yfe1Da1XPClaU29V0zDFAfAH0FijErxBZVeETcsxJdV1gluAcVrjFbACjBEndqbNiS7uqIGKlJ0KrfYCS8evDKzBWzlOAdJJNTlZIxqX95B2u6HgMsxGPP0rwq166k+GzUAcIkQcIMsnio8FMlhPS+JVbZ0rsyqmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UExz0H7L; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UExz0H7L"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cff3b3b92so58685e9.1
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2026 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814827; x=1789419627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQCLFONZFsqSS9MwFNZTsRaivhIEdBav9Smp5SCcRdQ=;
        b=UExz0H7Liw3n0dAgTccqu7Au/eOEQ1aYy6b9xat9MWebk6RLBZUn08n3uyRXdsJ8pW
         OWmBmPM9/Mk1QmRWay0aLS7RSD4TOrWCCnYxyIySNTEB6NgMeOz9cvl1dpTDDbwrW0rc
         3Vv4pkoCVXykDBftnTNbPEKAfUrseLawqnjcTXxZSmXImP+qn+CswhyAJVwbaHnQtoxB
         Era/GuJRdOhtPg7y7/9nVf903xWGTs9ojmAVVP/SQXRcbbH6o8Ad+n9QAtY6qYp8Von8
         cwesLHG+ALjBPx75cxBGswcy3gKKKBY3NiYDz6p/EB0O1YmLwQ1LbolIimy9mXW3QRx2
         /NQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814827; x=1789419627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQCLFONZFsqSS9MwFNZTsRaivhIEdBav9Smp5SCcRdQ=;
        b=EcPFFv1aQuW3elfuMAQy6AwmqEoV7bFF9yEYOY7g7yzdgzgZF3vP3LtQBgYtlorLSE
         ttPR7EjsiMaxRYNTHAc3gn9yZ9zz6KNCxNbifQ2ueuq3Covncvp/b4znclU/UOFodBSD
         +ajzesbBYynQr+iSjW1tFYuSWVPFH/HtpDfwUKLvF4N9Rsj9ep7kiB0E9WcOu8RPf1sR
         FIl+BqeR2hDMyidjoE3Fe1LYub2E1wb94lab6FiHv6HuMn9U0+n8+JZGoklfSD/+VtvL
         sEghpiUGl/eOyjIzbzrWBzQ3Xt6BkJW2VfSK8Qk7tb6rph/YL+3A+S6T0djOjxpuvyRB
         dxBw==
X-Forwarded-Encrypted: i=1; AKwUvBw+i6wNTiQfOA3NGZzXDrbeQFyvTQDUE9PrO6vbD9NqWmQRG+TvIhUHuPdrOWKr77sQds0r6gky@vger.kernel.org
X-Gm-Message-State: AFuF++mWdsZWH2gflqZ0u9YKluWyA1QCZsgAovB8kJ1R7SyNy6S7ltbd
	woz/hXYqAP7N+4ia7lQTEFu9EL/uW5+TkL2L6+6g+tTPArhH2Y39oB0v7ZO5BXanZw==
X-Gm-Gg: AYBFou12ouc1VwKXPf4jjNppQxYcRkoXeS7I9j7Hy3ml4t5CMUtjxl9zs0A2R2XoiVU
	yj0F8/3m/aR1yAdM4zTOqmiXmQV1S1jzPC9etUHyxzOl2AQ7QJSkwGTx1Mg5xj0tlLJZvf23QKf
	7e8v6nbZdUdWIROMHGDChfyqcpqqvPeLXbh+K9Dk/Jh30/He2YUy0KAdeRxLlO+bsuE9d9+auee
	OYUKIJXfgtC/IRx+cBg9ybzwwnJInLNtdxsyxG6cq7GtyiETKtKYxlgZgKSfKmQWzbqaXf/h0IT
	5HEGL3Z2iUWpmXS7epwQGokZnR7OT6wozzxZPL37KmMcCgQkNtJavlFynVCu+t7ZBdPw71mBvYp
	qlY8tvmZMAbvvLSP5YjEfJOaeoUm/PuN+OGKMFb2zYuApKQ2r1iWy9cUcERX6LIHr2rkZlBPTgR
	GFIzRBuq+ze/tJMBhKw2v0GWqXfTWxF7FGOo3jjP+Ef9b6b2Vu1D3CRqArmUhj6T6q3YVumMOaM
	eQMlWPGHLS2Zgv8xkPC6wztiaaXOM8Rnq3b3fBVQmkVBj6H
X-Received: by 2002:a05:600c:6a97:b0:49c:e41a:4c70 with SMTP id 5b1f17b1804b1-49d0918770cmr1429165e9.6.1788814826565;
        Mon, 07 Sep 2026 14:00:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm284349545e9.14.2026.09.07.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:25 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 07 Sep 2026 23:00:16 +0200
Subject: [PATCH v3 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-selinux-pokemem-v3-1-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
In-Reply-To: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=2509;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=nXhPP7b+pyPXaxP9+90HyfAUpFQfbnZ7QKkr8iKuqZM=;
 b=TjH93s5viiCaqbVla2fILw+6iavAeMoHXtJBogMiukSdNz0HlukgBb+TDYrU3XHWPX6nl+Ot9
 pD4MowbEkJcBFfFenw8ptozqsSCQUPqx8gGuKY+Ky6uiXYzKNt3+1wC
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Refactor the handlers for proc_mem_operations to use the new struct
mem_private as ->private_data, rather than directly storing an mm_struct*
in ->private_data.

This is in preparation for adding more state in mem_private in the next
commit.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 780f81259052..bec6197329dc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -848,11 +848,24 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 	return 0;
 }
 
+/* private_data for proc_mem_operations */
+struct mem_private {
+	struct mm_struct *mm;
+};
+
 static int mem_open(struct inode *inode, struct file *file)
 {
+	struct mem_private *priv __free(kfree) = kmalloc_obj(struct mem_private);
+
+	if (!priv)
+		return -ENOMEM;
 	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
 		return -EINVAL;
-	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
+	if (IS_ERR_OR_NULL(priv->mm))
+		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	file->private_data = no_free_ptr(priv);
+	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
@@ -880,7 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
-	struct mm_struct *mm = file->private_data;
+	struct mem_private *priv = file->private_data;
+	struct mm_struct *mm = priv->mm;
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
@@ -970,12 +984,21 @@ static int mem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int mem_release_with_private(struct inode *inode, struct file *file)
+{
+	struct mem_private *priv = file->private_data;
+
+	mmdrop(priv->mm);
+	kfree(priv);
+	return 0;
+}
+
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
 	.write		= mem_write,
 	.open		= mem_open,
-	.release	= mem_release,
+	.release	= mem_release_with_private,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 

-- 
2.55.0.1003.g10538fe699-goog

