Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E115579C
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783586; cv=none; b=nHUrMFhB+o15zzkAKagR28kI43+r4EM9eadjn0DdksgRCpk4LajrNvq0ZMoYQdtPsyw9htHNnd8/8i+m+JFdpOI9nl04uwnf/D9HyoZ4jJC5HeQFneUW9Ke6xVbkc8Ak4awU3jdpciR5dyLEgmmyqjnf8kgDjhcIKBnYLJlqisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783586; c=relaxed/simple;
	bh=vIwOtGsDzqC6GvHsB1Ywa4a3VYOkSPAQAcBcMttGK5E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tNrlB7B0rP6O0RalUg1SQ+XAQr2qKkNDHjtsIK44V1ty38qPAw+eNmPOgJZOAktTFFaEuQS0NaM/wWANcUHDJuOQiTwZPqBMDHwwUYbKMOoM0C3jjr5QgbbJQnXg8Al3eOiXUq1pirl4Dua2h8jnxcXhMdBGHdvVT+/PKU6VLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQRjbjOy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQRjbjOy"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60784cf4109so2064547b3.2
        for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 16:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707783583; x=1708388383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYp0cW/LgWI9ONT8F6R5Ej86mgi7Qlg0RXGsGKtpVus=;
        b=wQRjbjOyJfTEUsqjAXLbp1F3qm8rGErGNXUpRjjc9JLWYgwjx7dfqxMIzEpzAXJera
         wKUV3jipe4utWjwAg3ZGXPkRCnKjne39/B89hOUzLZw5EZsiAMcZVLs5D/8jdN7TdngO
         rM7RLQJpXLtRO3EjEIZP/YKb3dFVEiohyXPqVdkOvFg0wpWxPnM+WH6vTmEPbYacS8CV
         wYPhBjTmIBhQxKOx5rX7NYzsnM4prxsL0R5i0GXO3hqQqePbO4xFtGPkNxjgA+Fg1+0l
         1vMJbnyU8KgqElowPmYrB/4XvA00ocTVw+bWXbNc1M7/HJykq64FEyp3zp+DhfpytXqh
         fvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783583; x=1708388383;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYp0cW/LgWI9ONT8F6R5Ej86mgi7Qlg0RXGsGKtpVus=;
        b=t6TrZq86lGkVNr5bx1BCTD2UgsBRblV1d/VU6XqHkmHnUCvgQ2Sxr1mFa0Lk+JTvIG
         +/1v+3Hq1My7hbgYpsVjmO0GgG8WG0c53QHLLlzKf61yHIbvvA5UzV8uFfTkx8pyPWX9
         n8RNx2CtxTanCcfoBya2Kc36EvOjaeBf79hxPKd2gSPBIvpN+dkVTQVXRYG9O3Ti8QjP
         B9N2z+ee7JgnoW9O4/O+ukBBdGo6KvEPwjv2vvma46d0uLvxestLJOX1PCC4xJejYCiN
         vtGv/QAIU73mjPjf0fUqxILW3UagRhnPKR0TuJYLUMV5QGMK1xSV1x3zf88scokEwCCj
         tZXg==
X-Forwarded-Encrypted: i=1; AJvYcCWmD0Ccx9QcnAMZOgnJ/u9Tcc5WZ/qe1MoneLHyGznGi2rGUFneYobfM0Jdt3gLdWrbNZYyRohVC8IwLdayDKA/cGFwIRtM+A==
X-Gm-Message-State: AOJu0Yyk91RkZ724uE+iRiBzDrtWXfdM9/L/s4ygDxeyX/CQOlEqTQtE
	gHBbcR/UFBVQExTjdJOfuH4ScSbE4vWnk4Oe8EZGN+CbtgcBsv70VB7tM+YODd90eGnx8jAkae8
	6LKNSkrN+YEEoyoGf4lbORQ==
X-Google-Smtp-Source: AGHT+IETpVKlK4W4ES+O6uH9bAYT9eFgcT5Mcr7AWYf1RXBnBN+OIklD/nT02bdob/BzELYAfud81u94YEZ4Zw50uQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:fd80:ef0f:6359:fc4c])
 (user=lokeshgidra job=sendgmr) by 2002:a81:a107:0:b0:604:228:7e with SMTP id
 y7-20020a81a107000000b006040228007emr2397004ywg.8.1707783583386; Mon, 12 Feb
 2024 16:19:43 -0800 (PST)
Date: Mon, 12 Feb 2024 16:19:17 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213001920.3551772-1-lokeshgidra@google.com>
Subject: [PATCH v5 0/3] per-vma locks in userfaultfd
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

Performing userfaultfd operations (like copy/move etc.) in critical
section of mmap_lock (read-mode) causes significant contention on the
lock when operations requiring the lock in write-mode are taking place
concurrently. We can use per-vma locks instead to significantly reduce
the contention issue.

Android runtime's Garbage Collector uses userfaultfd for concurrent
compaction. mmap-lock contention during compaction potentially causes
jittery experience for the user. During one such reproducible scenario,
we observed the following improvements with this patch-set:

- Wall clock time of compaction phase came down from ~3s to <500ms
- Uninterruptible sleep time (across all threads in the process) was
  ~10ms (none in mmap_lock) during compaction, instead of >20s

Changes since v4 [4]:
- Fix possible deadlock in find_and_lock_vmas() which may arise if
  lock_vma() is used for both src and dst vmas.
- Ensure we lock vma only once if src and dst vmas are same.
- Fix error handling in move_pages() after successfully locking vmas.
- Introduce helper function for finding dst vma and preparing its
  anon_vma when done in mmap_lock critical section, per Liam Howlett.
- Introduce helper function for finding dst and src vmas when done in
  mmap_lock critical section.

Changes since v3 [3]:
- Rename function names to clearly reflect which lock is being taken,
  per Liam Howlett.
- Have separate functions and abstractions in mm/userfaultfd.c to avoid
  confusion around which lock is being acquired/released, per Liam Howlett.
- Prepare anon_vma for all private vmas, anonymous or file-backed,
  per Jann Horn.

Changes since v2 [2]:
- Implement and use lock_vma() which uses mmap_lock critical section
  to lock the VMA using per-vma lock if lock_vma_under_rcu() fails,
  per Liam R. Howlett. This helps simplify the code and also avoids
  performing the entire userfaultfd operation under mmap_lock.

Changes since v1 [1]:
- rebase patches on 'mm-unstable' branch

[1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/
[2] https://lore.kernel.org/all/20240129193512.123145-1-lokeshgidra@google.com/
[3] https://lore.kernel.org/all/20240206010919.1109005-1-lokeshgidra@google.com/
[4] https://lore.kernel.org/all/20240208212204.2043140-1-lokeshgidra@google.com/

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 ++-----
 include/linux/userfaultfd_k.h |  75 ++++--
 mm/userfaultfd.c              | 450 ++++++++++++++++++++++++++--------
 3 files changed, 421 insertions(+), 190 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog

