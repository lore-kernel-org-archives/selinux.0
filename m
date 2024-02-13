Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C24629EC
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861477; cv=none; b=dv70A1Nm6pC3QCUx/sbfg9ngbWuH9Lzg1iieUJO3FmDcprVDG/97O5RzpB4QPY3SvQyp5325APVvwGFYcC3OdXT1aCXR4VCIHGKnmIK39cXIe7nlkNwHIFqcmCzv0tACIcNn7NcyL6pmZNrkCd3d8WeNLBqhv3RIgKUo8iEw0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861477; c=relaxed/simple;
	bh=LC9aLap2APj/OH/lobM36oEQVV0oPuQPtnUuvAgE1is=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oMzPpm2tpK5PPHWtVrzQR1IYXkaXIzIff9dpKVhf61cOveyct1F1xMHocybMqoxxQq2s3bjNHjYZC4gAU0SA9qz7uuDZdZF7W2D5CZA/GJtguxVfS02Dr+sfHILsxlHBlwwUuteZAmgRfCSdFjkP3zFCgyCPESjilKdW5BNP7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2syN5LN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2syN5LN"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60781e8709eso2580387b3.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 13:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707861473; x=1708466273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ir4+0EAbk6DmHSJMCOQ+63RTEjcKM6OBoUCHYQ558Qo=;
        b=Z2syN5LNhc2RrVTe9Wh5aUgM42WA5VdKdJTmY84ptaaTakQ+cs4Ey/MNDxzMC7fBTV
         eKysJJJgcHq6/Vckrs/T0ms7yu08hgDyqoYkmLgh4IJUnI/+A+BDuuv4ZHPGiuyV6Wgz
         SCzYA9zLbFh2+TXaktRIfRDawTsN/RuDXR9uNHu7QcR/4rDvanhKpXIF2ortyeVMIrNE
         wgiCDxvS0VSLN+qPR2GqIw7KktiFpU/bAJqfHxUwrCiMR1XaSm5aj8zwz2WTBB2HD9WN
         fMxTMCu+j5SrkDqlbIzaYiGhZX9w4uOZhfleKzle0Oc5ZCPpGLiW+ObD6V47fFzzafq/
         0Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861473; x=1708466273;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ir4+0EAbk6DmHSJMCOQ+63RTEjcKM6OBoUCHYQ558Qo=;
        b=ry1pYDvCmHes85XwHl/3GTCJJAGbwYdWqV7rETzoiOFql1WAu8z4VUlSSi0wAvnV34
         HzZ8PEpkMkGEP0hF93Sfhabwf4aaTis+GeEWpnKl1VlMivBRbuk2p+jNwK7KSFdy1Iu7
         RSBHjyk7LBcxjB2xZ50xzhxK9hbemlm1Q8QqQbJGadd+qkinPmBWBKxXLHj5JPz3scP2
         JTCjQU1GQzzczUAGA/mmdz7OKL8Zh5oA0jQapbIwr6s623oZYeq/J+kn95Mg2PkmWFAG
         rvbgGD0Ukkz3cUFnDJ9+LjoDlKLuaNpocO8aKU0fyZXlfvwwaJsSmtzcwESLyyaZ9YEs
         M2/g==
X-Forwarded-Encrypted: i=1; AJvYcCUDSVYXVJd+TqfJ8VTOEspUo1mRrqcrWnbrOxTr7ZyPjYRQ/b/QTUksftQlFN3LrwdFn1vkBr5PqCd2cksNpa+O4EK1S2bM3g==
X-Gm-Message-State: AOJu0YyfNNtYT4TVCE5pofp7KLkrMYyRA0YDUk4EAPF71SkEljqS624r
	Xwapm86nXuPhky10GL3n5amqBgzW3TJx9F4cZ3bwIBgaNgFeM7RlKzM0mTIc0gNSe+Z4Cg9Api/
	CBVbxL546n5LORdDeIn/sfw==
X-Google-Smtp-Source: AGHT+IFDSd5xu2FB72V4FXpKTmeqW1QesEeAS6gwaRywm0PkcXIJA1oGvUM9nR5x/IAVPoUhZ5UVHHp7Mrodt7B/AA==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:ce6c:821f:a756:b4b8])
 (user=lokeshgidra job=sendgmr) by 2002:a81:5702:0:b0:5ff:6ec3:b8da with SMTP
 id l2-20020a815702000000b005ff6ec3b8damr12240ywb.1.1707861473107; Tue, 13 Feb
 2024 13:57:53 -0800 (PST)
Date: Tue, 13 Feb 2024 13:57:38 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213215741.3816570-1-lokeshgidra@google.com>
Subject: [PATCH v6 0/3] per-vma locks in userfaultfd
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

Changes since v5 [5]:
- Use abstract function names (like uffd_mfill_lock/uffd_mfill_unlock)
  to avoid using too many #ifdef's, per Suren Baghdasaryan and Liam
  Howlett
- Use 'unlikely' (as earlier) to anon_vma related checks, per Liam Howlett
- Eliminate redundant ptr->err->ptr conversion, per Liam Howlett
- Use 'int' instead of 'long' for error return type, per Liam Howlett

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
[5] https://lore.kernel.org/all/20240213001920.3551772-1-lokeshgidra@google.com/

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 ++-----
 include/linux/userfaultfd_k.h |  75 ++++--
 mm/userfaultfd.c              | 438 +++++++++++++++++++++++++---------
 3 files changed, 405 insertions(+), 194 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog

