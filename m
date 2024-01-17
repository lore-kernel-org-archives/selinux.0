Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CC2E854
	for <selinux@vger.kernel.org>; Wed, 17 Jan 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531175; cv=none; b=cuOxHQxhCPoaXKA3n5cptfpObI9U07WLfLftmiurxnnBypEcX9/GJpi1nvN0WuO4dH0Y5pOGerk40vUnpm2b4kZFnzTO2jorq5/6MvpB6CpIifALxRbB48X6M/n7VS6XmVZjm0xK81wHuZPdCe2rqJZ6alidfepVR7kTU6bkMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531175; c=relaxed/simple;
	bh=oRoNsUf+N/66WV9Y3eaIeFuphFtcmnjjyoS3YAhmUgk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=fQYceCCLVM2KHOQbLyOkJPLb4KPiqUwcYa30Uw2N7KMFBgIZZBMVp3gt5vJBPrHVT86zqS/8N/4UUuG80GVCz6XffjfqkFyqIRyZmMrPYTK+mMUIr9ZHA5IDBvS7TQiIkcBDQJ51q9b7B1EL0FlKJ49GRrs8oq4QnMacSg9q+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWqYOPrJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWqYOPrJ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcd9f4396eso16773567276.0
        for <selinux@vger.kernel.org>; Wed, 17 Jan 2024 14:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705531173; x=1706135973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLaX/VsA0yABQN8R4nb/2mlejC59XdV0vgZ4D9pH8tM=;
        b=fWqYOPrJCsvZVR9nuCQLf0mAJYaQjM/FKrge94dd/SjNIz4qBuSWF4HhLGThHeKynW
         i8spFJehhXYxItmx6unFG+0ow8iPRThYgrE4LTpNWCK38CAW6izIAJE/7SKvhr77oNUl
         tMdIH16Mq1cJ8fpptNKfhNJqbrXmm157sscNG/wAe+k1YDDRkPdZ0sXwp83Wvu4/69eP
         LzkerM/tjrf50ys3z5rmKBiFDuzBvfO7vg1i6NceAQ1KvleaMLZKX8BzYTdiDeQ/AiBm
         XOxHJ70A7Rw0vxx2byYxnnmw2U2cN923EjHbMn0ZsX5UjzRHRVNrOjRhgjUH/F8ROzAI
         ynwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531173; x=1706135973;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLaX/VsA0yABQN8R4nb/2mlejC59XdV0vgZ4D9pH8tM=;
        b=KE2d7A2v6Y/2WXKRMZX2Q0OG9fLWeXZt+qbzneYtpZX1alJRJg0eQE1uM2kXX8KMJt
         tT7Ac9LkGJAWqyPaum46UexzN9rVqUFNv2wgu5GDR33liDk2WKnJSRpWX5V3I+5AHLDN
         DdbmRMiAMs+XU6TxpuXRxOGUC+jUW2agv2udRB+M7aFy29fOB0ygh8uqN8qTx2iogYXn
         hRfT7z0A2Pj5TRK3LxcIVQOLW4bXrgDkTgjFvCBkAx6S45Ekmk62SDIwa6IsELtBqbX2
         s9SW5jBlSHTqSkhxA4rub7MgPwp7cpOGTVXYd5aya63EovXMnsHzth9bwhkuo4ASYvkI
         N2dg==
X-Gm-Message-State: AOJu0YyPhkXRRWnv0BdDFd+L0zNKPoi+pTnI59Dm+C51yl6iTSKiYwbK
	XZMYJN9I2E9wkg2j+mwSN6Y3nmX+8Ey8UZ+Jf6abGJpx
X-Google-Smtp-Source: AGHT+IHsZ/7oxdx8GaRkhurYhhtKgQfgyIX8pfvjQeNWc76oHlC+X+I8+rm1se2KT8OndYlqqJlgd/y/2fXPbmiP4g==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9c18:2400:c024:5c4e])
 (user=lokeshgidra job=sendgmr) by 2002:a25:5f4c:0:b0:dc2:5237:81c5 with SMTP
 id h12-20020a255f4c000000b00dc2523781c5mr231325ybm.10.1705531173178; Wed, 17
 Jan 2024 14:39:33 -0800 (PST)
Date: Wed, 17 Jan 2024 14:39:21 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240117223922.1445327-1-lokeshgidra@google.com>
Subject: [PATCH] userfaultfd: fix return error if mmap_changing is non-zero in
 MOVE ioctl
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"

To be consistent with other uffd ioctl's returning EAGAIN when
mmap_changing is detected, we should change UFFDIO_MOVE to do the same.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 959551ff9a95..05c8e8a05427 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2047,7 +2047,7 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
 					 uffdio_move.len, uffdio_move.mode);
 		else
-			ret = -EINVAL;
+			ret = -EAGAIN;
 
 		mmap_read_unlock(mm);
 		mmput(mm);
-- 
2.43.0.429.g432eaa2c6b-goog

