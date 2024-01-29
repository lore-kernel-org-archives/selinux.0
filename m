Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9AE76051
	for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556927; cv=none; b=SI2GsniIcl5dcFancYpOpp5eBAgW3Dl/KEMcuQKXTjAdEGqgev5Uj5pZVEtdIwSAZD0LAvmKtaoDBCO83Ss/ezO17ZF/xVuTTsXFOb5mbjS5fLRlq6DiwZrSVxMYOG6HRmQxtKkm5GUJNb+WBk4g1uapDGoE5Pl9MGqOwXlGEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556927; c=relaxed/simple;
	bh=OJgQ1qhLDabP6L30mWXu4b8oGn7mXavl1NGjOvY9bUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=isVRrbtPGLNVbHHWbbVdj4i0F1aUZ44hdORqzXFR0YG7e13Kt+FG7rAhZpCFthd/3Vat7QfE3yG21ODfKK5gmDPSqUqVDdkCefyWVYetKrNANIQk1raZDnjzKWEIhpbCwdTUoLjzR9fc4HUQ6a+fe0J9JowEVTqtae2ciEDI0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DL1DtO5C; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DL1DtO5C"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4965294276.1
        for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706556925; x=1707161725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxV5wBXLAd7sIIElP90tsYG05NDDw/o/tErBcn9qBHI=;
        b=DL1DtO5C+sqoconRImf9YTESx0JrJIX1W8P3iTJ9x0GUqaWsn4E/JoNceR7l4Mrhs6
         UK2z2JPaW6mFs9PZcZ2IFNgwAFWLKBJMUIEvhS70yHiFabWLRB99YQqLo5HrLTUHL5l9
         6Unwt8BmjSIfvL/iRqUo35AH2I+SH6ER+MIH8wPJH1gtJGWNe7isKWvMQy+0cPostTpb
         LVsHrqXboFKhaQ/7K9H2S4NDTOa67uDZt40l/Pjp/c47FPTALOICEMM72F01fagGGuOi
         hEtKMYD29gOActz05USiM3f63Cawi9tL/XmSx77AuXhASLhbnjH7gchFkejL6A1d5VlX
         7g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556925; x=1707161725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxV5wBXLAd7sIIElP90tsYG05NDDw/o/tErBcn9qBHI=;
        b=FJGsGyEfrujvCoDg89GLe6arkXIPY17amDVzvmw47B8eeh3XO3jT82ax1a4hjtdxMn
         1Tcf0JW7lUQ3UHuYMST9lQU0WB0hBC+ujWijHF+5vUuOf4T+0PLxOQXkj7oKYeWNX4kl
         gNUGn6NOYxxHC5TMIyFYe8ZDTUdoZvv2r7LLnNyKHEjMKmkIRE/56SsJ0Ep55aFX1sFL
         SPOYFD7eQln/L8vcSX9xoXvVTaIdNCT4pBuYl9k4NEVGOsBCk9BuNqFlAg6XBYrC3YD2
         4mxMm/sYuVwSC+NgC8PpVjbr9kxcDwPE3lnMF+GAr01ajuppP4hJrPYz0qEUkhT8r9/V
         v0tg==
X-Gm-Message-State: AOJu0YzHiO7o/ibA9h7ottc91p83bRhn/AZMbZ4RVQV4dAIfnFLUxmEi
	/vpjPp1DAVOCuiJZ7wkiVDd+zlsCvHv7tpZGt8NqpFWs8Z0sucN4zcs7apK7O/VvlquuoNEA425
	QFq2p+1jyoDH27wXk4g7PqA==
X-Google-Smtp-Source: AGHT+IF32DkXw2QhhBn3l4mRA2HIAIDhN6YElkLAMaf3KndoLGpHhaAw9uQKXHl2RVkOyBG8Y0880v//3lgc+vKdmg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9b1d:f1ee:f750:93f1])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:2611:b0:dc2:4ab7:3d89 with
 SMTP id dw17-20020a056902261100b00dc24ab73d89mr2460415ybb.1.1706556925300;
 Mon, 29 Jan 2024 11:35:25 -0800 (PST)
Date: Mon, 29 Jan 2024 11:35:10 -0800
In-Reply-To: <20240129193512.123145-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129193512.123145-2-lokeshgidra@google.com>
Subject: [PATCH v2 1/3] userfaultfd: move userfaultfd_ctx struct to header file
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Moving the struct to userfaultfd_k.h to be accessible from
mm/userfaultfd.c. There are no other changes in the struct.

This is required to prepare for using per-vma locks in userfaultfd
operations.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
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
2.43.0.429.g432eaa2c6b-goog

