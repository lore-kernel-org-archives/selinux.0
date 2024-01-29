Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB01153BC1
	for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565496; cv=none; b=oDAcCuE5kbZvPZZaww2nIFio6L2WmJ/UQDSaFd3VV7KtadHXkHPcI6Z+kFdMyQUu2iQSWGdGIy88LExnBbBc/u2ywSm5+SlCFCAmgiFw3EenuKv0gB45xTdVGJs2DUdqs81hUdb+yfgyQJBhLuzk5CQAV3CxCCbhcWE4s2DZj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565496; c=relaxed/simple;
	bh=yZyZ29p6yMC6LhYj5NL5f97FYixcVCB1YcfCBS49aMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nFb3KFousqIUWLjMPuY7t82VP2AH7SKfHP8Vfama5a3xu+/lv3QApUIGNFS71dVywOULVgyqzS2eFysERswHvubGhaEfIyAHoNanEThkg0F3jmX4/jGFzKeK64jmQdDs3vWJHefgr+NbK1/YKtYmAUe86G6yRZnY1Xnsafcjmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExZh8qvA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExZh8qvA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso12483905e9.1
        for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706565493; x=1707170293; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUG0VAx6fB3sqRZQjRRGH6lMhLjFI7rY91Z4hSbS8UE=;
        b=ExZh8qvAvRoPwP8AmR83NNRM72HpbFMUYcCHAaqEl9UsRSWGu79vyXO6XtWV7iv96n
         y3GQeXo4qhwt/HwslQbPkbUw12VaMJ+nu7iKb34JyZgHlE78LLN8i7gRg8Ik65x3CHYt
         t42mcbXvSUyUA8JaNNXVH9fhK4yjrL0H6zsvNdKZHdxRjvAkJM/e9gv6dUV3accM3Slc
         HHnBQaOpY7mxmu5z3UVSpek3ep63KHjnjICmekrW7ghycb6su1FnkRIP5bKmm9s+jadH
         ZNBOVgWhhoGv7VW2AWcnJc5V7xZKUkCCaI+RWzUu/YIcr6+LuCv7I2ig/fd1BS7uEcUS
         T8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706565493; x=1707170293;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUG0VAx6fB3sqRZQjRRGH6lMhLjFI7rY91Z4hSbS8UE=;
        b=v9Fn9D9ohVZ15AnYdPHcDpwr3pUhoUEBjy0U2XrXiQfOZY4pHpzV5wI5WaDlrrxr1S
         CCL4xJ6dTFtizuq3l7ZKF0tGiduy5tiN2WurXJSIatPNhMxi05WJbseFWuouZdblgghV
         yNgJ8C9T00a+lLLJHMnl1IwtC7Bp5imuQP98ZqMdo98HsklEptrTraNcd8xw752GhRLO
         fG/wVYMJDvUOr/6DtWnnr9MmfHlAqh2oS9iMNInXFf5RYGUiSG64emee6yz1gNG7q9bm
         bO3QtglB59eVmbp1qhds2l+tOHAjLmWkbEQxA6wG7UQZknJc+Vy4h598Agf3P/oudgdW
         y9nA==
X-Gm-Message-State: AOJu0Yz8mmfXXp9dJSN8ZznnZ3gIqIkQnGLqI+/wwvLkgPdAaSiq4CGU
	w9UmgNrYn4prS9y391u9rSPurDk+sua/upgS6li8KCg5uBv+9Bhuvz6/ZwaZUGJNAk3SfLXTeHh
	tPN4jOrlGiVD2fPxBhtVvZ7IR0T8eZkVRE7HP
X-Google-Smtp-Source: AGHT+IEEO9aGC7CpGPiSuiXN+SuE0N37YyaPf1+lp1ZQZTirO7MY/Cp5QyQH6Dgc3eP4RAbyZkoXfbiAF1yqBSVoK0s=
X-Received: by 2002:adf:e44a:0:b0:33a:e5a8:eaed with SMTP id
 t10-20020adfe44a000000b0033ae5a8eaedmr4230312wrm.14.1706565493189; Mon, 29
 Jan 2024 13:58:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com> <20240129203904.7dcugltsjajldlea@revolver>
In-Reply-To: <20240129203904.7dcugltsjajldlea@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 29 Jan 2024 13:58:00 -0800
Message-ID: <CA+EESO5dNSg1d4L37hMbhuT-poD4R3ttBoEQdPvWEy7xHjD1oQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] per-vma locks in userfaultfd
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:39=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> > Performing userfaultfd operations (like copy/move etc.) in critical
> > section of mmap_lock (read-mode) causes significant contention on the
> > lock when operations requiring the lock in write-mode are taking place
> > concurrently. We can use per-vma locks instead to significantly reduce
> > the contention issue.
>
> Is this really an issue?  I'm surprised so much userfaultfd work is
> happening to create contention.  Can you share some numbers and how your
> patch set changes the performance?
>

In Android we are using userfaultfd for Android Runtime's GC
compaction. mmap-lock (write-mode) operations like mmap/munmap/mlock
happening simultaneously elsewhere in the process caused significant
contention. Of course, this doesn't happen during every compaction,
but whenever it does it leads to a jittery experience for the user.
During one such reproducible scenario, we observed the following
improvements with this patch-set:

- Wall clock time of compaction phase came down from ~3s to less than 500ms
- Uninterruptible sleep time (across all threads in the process) was
~10ms (none was in mmap_lock) during compaction, instead of >20s

I will add these numbers in the cover letter in the next version of
this patchset.

> >
> > Changes since v1 [1]:
> > - rebase patches on 'mm-unstable' branch
> >
> > [1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@go=
ogle.com/
> >
> > Lokesh Gidra (3):
> >   userfaultfd: move userfaultfd_ctx struct to header file
> >   userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
> >   userfaultfd: use per-vma locks in userfaultfd operations
> >
> >  fs/userfaultfd.c              |  86 ++++---------
> >  include/linux/userfaultfd_k.h |  75 ++++++++---
> >  mm/userfaultfd.c              | 229 ++++++++++++++++++++++------------
> >  3 files changed, 229 insertions(+), 161 deletions(-)
> >
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >
> >
