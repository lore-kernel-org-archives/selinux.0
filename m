Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49613B787
	for <selinux@vger.kernel.org>; Thu, 15 Feb 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021693; cv=none; b=aTT+/DqSTAI9H+OyP7h6Yv6isNdB0kF98MiFlCvhujwaHGW8j1ii17m3LIHyowwAfkvCgk+2kpUdF1AFyB7ZN7cds7BcPIoG5OBE2Ig0OyVhBmv35hG6rXzvJMZmk83JFqe69qU6ausKD/RHct8wc7iiRoMd0rGY0qt24po2bW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021693; c=relaxed/simple;
	bh=APdeBRsHAtrJONBAc4fOC4nb+0sbyGbwGk53lr6VS2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YOvJ4D/dM9vTn1chJ2qPbGjCE26QoFhT/PtlmKjpHE+7FABpOxytxQ+OKMjUOAF0oi5NdNrYON802tindyokbQlZQ/MXjxXKFS8JYCpBKp86EGDJZMIuYaHJQ0CE0XBrYd5VfhSexNNr0CYpClaxNydntlU/eyuoeDvPpUf52G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdeZASRb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdeZASRb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e8e8c2f1so7898787b3.3
        for <selinux@vger.kernel.org>; Thu, 15 Feb 2024 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708021690; x=1708626490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jFzOipv9bDJZnpb7UwZ8Eham/ShclgiDNDH7Ow4z+0=;
        b=JdeZASRbYGYpemdfvKlLncp+bu5y5SrC9zBhw3hUislOcnKDtb8Maj+MENxMnDBGz8
         +3+LGzuHYoaPV80kNhyGPR6dW+5DIgB174pmMlT50p+5WRL2ss/TbnVO3KmYW4UGLC1C
         Pc3y7YAVoZuz8OXIY6UpTFVcJAtbc9PRkn7gWSmEUBpN6BZWyb0PEdX/dMmEFEZUJSlD
         WPnKXbD+FKcDG8HqwxgEm1RLg4m1NuD7NMH459wax33b81DplHbFcTxGtOdGCxRHeKky
         JR8swyaRs+ap5hHtKe+Js63RVYTgDPAxkQn0Bgt0gSmpb4GXwd3VnhB1WqxM2VvDwnO0
         QbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021690; x=1708626490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jFzOipv9bDJZnpb7UwZ8Eham/ShclgiDNDH7Ow4z+0=;
        b=XfMJK1jsA/0FZx3M7gQkD+EubqVGDES5nYmCB6UTPZVVBmpqlMNghvrX74Cg50lDpj
         5gmzhDgadL0qQOgC78bd7VJuxQpiDDMtyOIiw1kCNwErmlIJFQCYPGKq14mtu5NZqRcM
         lDSybnXiG4MGdAkICrhRgOubTkExspJcHps8JB410EVJF+NydkybMIHEAnPIyLcSTvXG
         GhJqqLyRViJsdjcYaJQH9qqWOHl4oPTA3GGLjXL4HOoWdX2PtQWiwWrL7pse4k5pjHk0
         kZI5cdhMOQ7Dz7aNopS8Os8Zx0gckWuNB50ywzbHaamvdY4GWGxZwMIi8aaflQbWLT5B
         zBsw==
X-Forwarded-Encrypted: i=1; AJvYcCWPGqWtzpoYbmqUflux8bLAlxcNICucpo/0x/vRoerApz4wVBANtn7VE3h5btDx8fMXnAYYrZJwRPHhMUKcsHs3fKq/l2f0QQ==
X-Gm-Message-State: AOJu0Yz3bOdKsmUKk5QPVR1zY97AG2K+Cd1jWEjKwe8Q3nhndBHTFjB7
	YKAchwBLngWxyENBVZBj8oOtuLFYcKtCWZHmPLtlnuftUXcuT7YpDC7Y1F+XzablcZP9QmVsmPe
	MTfBLhCkygLKj+r1MxP9+eg==
X-Google-Smtp-Source: AGHT+IHHi2mCkEldISrNhtoRZCLnocCFS9qBcw8e+39nrcye3IQvcjCcfdDQNRvMWp/R1wX/qkVergX2FymdVGvJXg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:6186:87a3:6b94:9b81])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:f11:b0:dc6:db9b:7a6d with
 SMTP id et17-20020a0569020f1100b00dc6db9b7a6dmr83663ybb.13.1708021690138;
 Thu, 15 Feb 2024 10:28:10 -0800 (PST)
Date: Thu, 15 Feb 2024 10:27:53 -0800
In-Reply-To: <20240215182756.3448972-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215182756.3448972-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215182756.3448972-2-lokeshgidra@google.com>
Subject: [PATCH v7 1/4] userfaultfd: move userfaultfd_ctx struct to header file
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

Moving the struct to userfaultfd_k.h to be accessible from
mm/userfaultfd.c. There are no other changes in the struct.

This is required to prepare for using per-vma locks in userfaultfd
operations.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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
2.43.0.687.g38aa6559b0-goog

