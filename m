Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8674A05
	for <selinux@vger.kernel.org>; Tue,  6 Feb 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181789; cv=none; b=OvomBf5RPhZXTXBQ4nl9Pk9d1jd/trOGajc3JRyLJpigAQ1dTbOs7pK0rg8nBDWsGvqyFh/x+4j6TqDDg/8Qpz9r4g5cupj0n7CRqIHcGUyPF8LpAlefa+S39qoYra7C5r3at+/YNUfYzT+X+7+YQsN9RODFBBOcAAx2uALe8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181789; c=relaxed/simple;
	bh=bW5FqUi/xixapZsn2hg3bnkQMMB9OGn3jW6cVE5NBpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P3/MDbtah/n/WAhXoZMV4VsIR6wdcGwXHcvXq64tsYqq3wWjVdtlGNBR4WYJSWcsjUo6uWY5ZWW/wOzsh1nhUgJMdSTxVXf8SDmiG+dnS6kRMWGwnMP05tkXv27yaCvuRm/lcQf23fD3grOh6jiMhPDRgfy9qgg+mXwNzxnaqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkJeKvR6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkJeKvR6"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so8503026276.2
        for <selinux@vger.kernel.org>; Mon, 05 Feb 2024 17:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707181787; x=1707786587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Wsa/otXfcNbNeX5OxfMRaNnAPGn+xliclZzLODRNs=;
        b=IkJeKvR6Iclv0F+scZfsBuvRqyDqE7LSd1FwFesYxaZLtceS+MwKQTBgbVler14khK
         xvdjNJ7wWY0wa8umpb2erSiE4BB3hH+VPMuqbP1pW/0GPTRUWCp27R0iFio4HlZT+x98
         YIQetP6lbogEreqEZSGdSulXWUiK7xU6F38xQGn87dds+edeeRisB2QK8XSUBmp8isDD
         Wf5bZytpzM4e80MQnk55AQRRRwApV2ZtsTpOKxjfhJwruatI6//zN4v0tkVGaDzfD8wG
         DI2ZvYXKbDENTQa0bN2fQ+BY1dcNMECQd85AYTikexsFS0vJvhblABu+aPAuqu4UpGWs
         M0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181787; x=1707786587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Wsa/otXfcNbNeX5OxfMRaNnAPGn+xliclZzLODRNs=;
        b=HgdOaT0ys1C5/sxyt/+IPZUdKf+1S7dWAgc8+slKmxTUR9EGeRmMhMsY0KtCD1nIQ7
         QzjH2HVxXH+n3HTKlzjd6rwHeCLntouYUuFn2uo8W0r5x0N/2OpjQWH5g1DTs03cJZ9u
         KtgtZuhsfk5TuNN6yP4xSzr0gderULJxZmaNP1QkzM72aFwyg28CAzmf4sesP6/0GLgB
         gGO9H5+8a1iHv51RB7MPEuW59yz1xSr0+j2GHYpNlelkyaJhH+8BcqW6UkB9VUfMQQFW
         cNZFAVqbXYL992f2or3Iwuq4KLSs2epbxJXGQwR/QD/gd65Ck4z3lHprTYvTs4+QwhVw
         U/Pg==
X-Gm-Message-State: AOJu0YwPZPO1ApwFTKxu0XI49oUg5imBrODarTqWPGN+wQEAXgZgw3J0
	dTksYDAUFElHCqJ2O+SF0Dyz0whoj0slPDkepYefd9h7oXX1KfabWJV2fJB6oYjGixHNQqAPusX
	bkrSbzZgHrNnYjd+jshhZKQ==
X-Google-Smtp-Source: AGHT+IENlNSDcojoxWkSl049zlYz4bm/u4F+E9+JQ3HrIX9YrhW8LmpdpxXCyJfTB1mNb9KyDkiJPwezJtg2W5ykyQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:713:bb2c:e0e8:becb])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:13ce:b0:dc6:e90a:7f2a with
 SMTP id y14-20020a05690213ce00b00dc6e90a7f2amr53474ybu.5.1707181786937; Mon,
 05 Feb 2024 17:09:46 -0800 (PST)
Date: Mon,  5 Feb 2024 17:09:17 -0800
In-Reply-To: <20240206010919.1109005-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206010919.1109005-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206010919.1109005-2-lokeshgidra@google.com>
Subject: [PATCH v3 1/3] userfaultfd: move userfaultfd_ctx struct to header file
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"

Moving the struct to userfaultfd_k.h to be accessible from
mm/userfaultfd.c. There are no other changes in the struct.

This is required to prepare for using per-vma locks in userfaultfd
operations.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 fs/userfaultfd.c              | 39 -----------------------------------
 include/linux/userfaultfd_k.h | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 05c8e8a05427..58331b83d648 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -50,45 +50,6 @@ static struct ctl_table vm_userfaultfd_table[] = {
 
 static struct kmem_cache *userfaultfd_ctx_cachep __ro_after_init;
 
-/*
- * Start with fault_pending_wqh and fault_wqh so they're more likely
- * to be in the same cacheline.
- *
- * Locking order:
- *	fd_wqh.lock
- *		fault_pending_wqh.lock
- *			fault_wqh.lock
- *		event_wqh.lock
- *
- * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
- * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
- * also taken in IRQ context.
- */
-struct userfaultfd_ctx {
-	/* waitqueue head for the pending (i.e. not read) userfaults */
-	wait_queue_head_t fault_pending_wqh;
-	/* waitqueue head for the userfaults */
-	wait_queue_head_t fault_wqh;
-	/* waitqueue head for the pseudo fd to wakeup poll/read */
-	wait_queue_head_t fd_wqh;
-	/* waitqueue head for events */
-	wait_queue_head_t event_wqh;
-	/* a refile sequence protected by fault_pending_wqh lock */
-	seqcount_spinlock_t refile_seq;
-	/* pseudo fd refcounting */
-	refcount_t refcount;
-	/* userfaultfd syscall flags */
-	unsigned int flags;
-	/* features requested from the userspace */
-	unsigned int features;
-	/* released */
-	bool released;
-	/* memory mappings are changing because of non-cooperative event */
-	atomic_t mmap_changing;
-	/* mm with one ore more vmas attached to this userfaultfd_ctx */
-	struct mm_struct *mm;
-};
-
 struct userfaultfd_fork_ctx {
 	struct userfaultfd_ctx *orig;
 	struct userfaultfd_ctx *new;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e4056547fbe6..691d928ee864 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -36,6 +36,45 @@
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
+/*
+ * Start with fault_pending_wqh and fault_wqh so they're more likely
+ * to be in the same cacheline.
+ *
+ * Locking order:
+ *	fd_wqh.lock
+ *		fault_pending_wqh.lock
+ *			fault_wqh.lock
+ *		event_wqh.lock
+ *
+ * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
+ * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
+ * also taken in IRQ context.
+ */
+struct userfaultfd_ctx {
+	/* waitqueue head for the pending (i.e. not read) userfaults */
+	wait_queue_head_t fault_pending_wqh;
+	/* waitqueue head for the userfaults */
+	wait_queue_head_t fault_wqh;
+	/* waitqueue head for the pseudo fd to wakeup poll/read */
+	wait_queue_head_t fd_wqh;
+	/* waitqueue head for events */
+	wait_queue_head_t event_wqh;
+	/* a refile sequence protected by fault_pending_wqh lock */
+	seqcount_spinlock_t refile_seq;
+	/* pseudo fd refcounting */
+	refcount_t refcount;
+	/* userfaultfd syscall flags */
+	unsigned int flags;
+	/* features requested from the userspace */
+	unsigned int features;
+	/* released */
+	bool released;
+	/* memory mappings are changing because of non-cooperative event */
+	atomic_t mmap_changing;
+	/* mm with one ore more vmas attached to this userfaultfd_ctx */
+	struct mm_struct *mm;
+};
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /* A combined operation mode + behavior flags. */
-- 
2.43.0.594.gd9cf4e227d-goog

