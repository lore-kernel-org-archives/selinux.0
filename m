Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E04F1E9
	for <selinux@vger.kernel.org>; Thu,  8 Feb 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427336; cv=none; b=kORt3jyk4d7dLLWCd7xOJgEbOyOyxJaDpOF2OOK7LNQwaCLAPakjO4OuJqNcj6RKqkE6puIuz9/zkKeFp/AY/Gps7Zl8p6Z0T5ojaluj4if5tmsX/UN0FANC2ouJKczfqZYzGxp56RnqV+1WuLIUam9UztLaaqUM0mp92qYboqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427336; c=relaxed/simple;
	bh=TiCakHQHCzJxo6b5m4FPJwUjBHqVmMfkH6CiRMH6kVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lgE+8jrbLEyKhMZGPxFWVIGgrKLsaw9YHaAakIWR8YH8n7Sh0IIunckDXeVPCa7HEt2wGqCLf21no0LKm6YLogLH026zUVQ+A+pU7mj4L5YVUGYLPxrM5+NEYxldxhjVVTGGqpiDdeU9cBTR0fLHtWxQ/4Hbw8b0nXITGi8cS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2mOA92k7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2mOA92k7"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso458643276.1
        for <selinux@vger.kernel.org>; Thu, 08 Feb 2024 13:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707427333; x=1708032133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zI3aS3+a8yyiJmzrNkMYQ1tuNXiDnBYRofv+RFC6d4M=;
        b=2mOA92k7gnAf+gNwwXtbXgNmEb/8ZdYVQTToktJJTcJAZJKB+j0TX9QaMjl08YPiLS
         M+DRi7Mmrc0aniMYXAfvugBjd6WZelRJQaw156NA8IcGuVKpmz5tU4Qi6AkoM7TpPAId
         dC54Qh1sAHjZE05L178xqQGDxDNwC27V96GYWNB3JWM1NHNjTZvB30rsGYYTRxFppTO/
         gvkQ6FzZz3m0OEO6/Kz/SxnWJ/i8gwp5H3UtaYg6KLaSpigpfPEXW0ES8R+NeMXCaZF7
         smtlvpnW5vX0XMLaXSJu0NhP8T5hs6DwzVa2HsVuMtRtf+FnOY8vdv2yoW5NBBdgJPBb
         Rkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427333; x=1708032133;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zI3aS3+a8yyiJmzrNkMYQ1tuNXiDnBYRofv+RFC6d4M=;
        b=l+A0GPoKt5Vlqih4v92G/wgy2lTdjC9b6qOduaKDWlCSK59tB2GuRhoVsGO+V0sMvW
         e//1WjtnKk96HQ4kfDYOmcSXgbHkH/lWGqZYVrMBWqfgwCg9wcKlcL8rDwBtfvRT7C//
         +TX059lPy4I6fw1P1sdZioqT7Kn8sKsM91gTd+jTuCLYe1eX0hH8sZbNOW5oYQI3EenK
         uM0mT36F4SGLATIssfdyTN1SZqGAF6CDGtAari9Dq3U71BjNDGsLyHRkFhW3LkqXvXK6
         ++P5j/I5V0u8H8+xX5KNw0g/oJ7Eqike/o7MG489oo0kN2zDsYpnOWFio7rX7J6qYAcx
         BwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrT9NZpVXclV5OrYyrgcPbpKC23psC2RFwYw7v4HZ3zhMpzYIncbn/8bHU85Nz1i7vNWYiZM91nMzpNIJkh9ZoFwUZafkrmA==
X-Gm-Message-State: AOJu0YyrU29NyHksCSd28LEUW3331OumzvJ3FQ5YYj/cKj3wuCnLlezX
	zDsiDSthdvmFEDvla5tI1EcG9d28URGOsc/N0UUtCZ9Tk720y6/3uWN2mswB4sD+1jUC54vChYu
	NxuYvw/22PibHb0R62AdigA==
X-Google-Smtp-Source: AGHT+IHmzoTFZnOiD3iDxXCtJzuelRnEq6YZDdMuEI4bfjEAVm3HliYbUIhglRdmNUXogLEp1m8pKD87RvpGH3QiEQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:e9ba:42a8:6aba:f5d5])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:1207:b0:dc6:e647:3fae with
 SMTP id s7-20020a056902120700b00dc6e6473faemr39614ybu.2.1707427333639; Thu,
 08 Feb 2024 13:22:13 -0800 (PST)
Date: Thu,  8 Feb 2024 13:22:01 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208212204.2043140-1-lokeshgidra@google.com>
Subject: [PATCH v4 0/3] per-vma locks in userfaultfd
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

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 ++-----
 include/linux/userfaultfd_k.h |  75 ++++--
 mm/userfaultfd.c              | 414 +++++++++++++++++++++++++---------
 3 files changed, 384 insertions(+), 191 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog

