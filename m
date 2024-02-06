Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3B4A05
	for <selinux@vger.kernel.org>; Tue,  6 Feb 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181775; cv=none; b=IZ6by1f6tAkI+1OSBGDVBW4UeC6PnwXIL0YdjBwk5plSVva1RcdNHIfND58Jfg+b/gRDcNYrPfS2mix/mFi+tjPMCHHnra1TSk46WMgrgbNkLaHAxvvzDd6bq0D8LbDLpdQ9B7P96gyOCPkuy8C8memsCw9dS7rNSmTkEdzwHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181775; c=relaxed/simple;
	bh=GdHdniQnbMOXtlmLfBAIzFnjtasDR34ui/wEy9tYr8s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kltW7Tb0iVHguqM29dOQQ0KW1BLtzjgMM+q1IHBAJN9z4AyIFqsN4o//2xgpaCvSaiMyN+fxK2t5HYopks8Az5cY/19XQnJgEvk98af84weBYJWV4kcRI65Sg3vIVT4RsWdSLpNnjbNXEFzMohmrI5xWXj+XO2pq4wDFm95WyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vuBnNS2D; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuBnNS2D"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso8490243276.3
        for <selinux@vger.kernel.org>; Mon, 05 Feb 2024 17:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707181772; x=1707786572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFHBvxcNZW2HfjsGIsVhZk87PaG1v642sbVGsClWfxY=;
        b=vuBnNS2DuUXlqVJ15g75711OjVR9EqNrUnrFoy4+vDmz1KxfJipACqokd3EEMtYFOB
         M5L949iLtPgfaTpdv/s6ybOCrPn63NCdgkj+WRLJwKB1WYaDFtJVdmnuW8WH/t7BMv5v
         wDARcLSIRKiiZCCUo0BDJP0mRe44kv9PWKi4BGvd6K4KqOQhZ82UYdHzRG0iuabDfHsN
         qDbk7B4YVgqfffm2iYoqbngLvu94GKcw5lBcHffBzaeJlO4ciKgs9QkrsC5nuWPnBIif
         j1JrnSnQXzTU1ugBJx5Qr5QQdONZPI7M0+q5M47CrT8bVd3raBNa6NGigsEyaXNmo5B9
         SyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181772; x=1707786572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFHBvxcNZW2HfjsGIsVhZk87PaG1v642sbVGsClWfxY=;
        b=cZNDbi3qowxr9dniNld5ku2BP//id8gFTujMLDkOQsP0KPac8mUP4YJKVwmKKdYXZj
         L0CbHS3XCgpoBsvqbcsefHssjTRdcbkkassnq4poT1lTY+SG4RUI4o8ZNk0BEzui5RFG
         8tysXYZaZmYjf5KScLOItST8F4Y/jgjyoe0hyEKbnfrq/LsgXpGBIKVanTOAttR/c1wJ
         9IB9SECPsl1e8WbFXwSfu98sncbrppCY2Ka1rIIJMkj6F7MFQ1GdtH9/9nAHwbcRO7+D
         a5w1Uf5onX+t1yYvLFCfx8Mew/cScy1YcEdC/mNvNp/1reMjRxs+NPy9e/qSyJk79+Iy
         F3jA==
X-Gm-Message-State: AOJu0YzS0L5le2Xi21rhyFWZUv+VBw54uxI3A5PSf26WPWJFcKx+X+IM
	r3u9QECxeaXbeXXSkVyVURWEW81HWeZGPbrJxziv5+iS0u9mLH2RqoCxK0UjgPSfz3wgU7jYEsY
	6k9CovQAHZM5o8BLw5z7d1g==
X-Google-Smtp-Source: AGHT+IH1RhvmxdMgiLN/uYEOr6sr5Ko2uXZynT5hRnaY5hwDi5R6HBD+SHyb78d2LA94Xo7Ale0nQeBJWCfcO1Y4yQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:713:bb2c:e0e8:becb])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:2842:b0:dc6:519b:5425 with
 SMTP id ee2-20020a056902284200b00dc6519b5425mr38783ybb.11.1707181772174; Mon,
 05 Feb 2024 17:09:32 -0800 (PST)
Date: Mon,  5 Feb 2024 17:09:16 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206010919.1109005-1-lokeshgidra@google.com>
Subject: [PATCH v3 0/3] per-vma locks in userfaultfd
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


Changes since v2 [2]:
- Implement and use lock_vma() which uses mmap_lock critical section
  to lock the VMA using per-vma lock if lock_vma_under_rcu() fails,
  per Liam R. Howlett. This helps simplify the code and also avoids
  performing the entire userfaultfd operation under mmap_lock.

Changes since v1 [1]:
- rebase patches on 'mm-unstable' branch

[1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/
[2] https://lore.kernel.org/all/20240129193512.123145-1-lokeshgidra@google.com/

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 +++-------
 include/linux/mm.h            |  16 ++
 include/linux/userfaultfd_k.h |  75 +++++++--
 mm/memory.c                   |  48 ++++++
 mm/userfaultfd.c              | 300 +++++++++++++++++++++-------------
 5 files changed, 331 insertions(+), 194 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog

