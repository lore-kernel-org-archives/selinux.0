Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8601419A9
	for <selinux@vger.kernel.org>; Thu, 15 Feb 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035596; cv=none; b=XFNRf3tUcfkKjBb5DQCzj7Me+MW9cAyZsRlKUptwEDgzMy5Ccv5slIeYm4Cwe9l7N3rS+0wydohHm+DqlJx0inEux6x89MwMrLAWSQ+2fAvqkUpqXhrXvYGLuEAbSVRIclUHHjGR1/QCi9rWRq7b7JVGt/lOHj0wM+k8BWrGjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035596; c=relaxed/simple;
	bh=aF59DJKg+GxnyqLQw5fUxg2rlzvMMS+kzrvQ8I5o6Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYaQ8wU0S44eMrjyCVLvx+ZQegFI9kQkqFbL4DRJvfw/E3qDZ9Z1RKDJytNOTqWNheXbyU9Q3MdLjBq+VPRJROdW0gdVHUPlAVopJGN+palSrnQRRxSYTpRV5RxP1wKqh93u1s1zCwElqYoeqRgX8d+sHqgzXBW48gqEpRp6o9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLeRCuRX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLeRCuRX"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607d9c4fa90so10704747b3.2
        for <selinux@vger.kernel.org>; Thu, 15 Feb 2024 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708035593; x=1708640393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIA+RVykCQtMd4uKP0jMkGSiYfomHvLOKfcmRsJzzt8=;
        b=rLeRCuRXKcK1Rj3wRjnFm7dlMhDJOfW4VOdLOttjB9eTtl9P4zZFgDbbDYRjNCMpOQ
         2sAvga2xfZEakbYsnnd7bjfe9Bu9Z4/Enjznm/2ivr4Asehln6I+DGgoq3R+ALnTMnez
         xI4kazCh33YX+RP0EJcOqDrckkL7AMdhOA0HWNS1Z8UsHHrHsTX8kJLoy7MgJG685wnc
         YZ56JWLJXtrdTR8Z5QKFbvi/DXOArSV3axdAOeyF5PZkdrwhG/jFeimrKsuKkBeJ2FSc
         8r48k9iRVzJQ6kn9Nmer+ObPtgTMJ0U1ixcTrY9q23ZdYrPZ8MU8pmEpEqdoHlyx+zmG
         7G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035593; x=1708640393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIA+RVykCQtMd4uKP0jMkGSiYfomHvLOKfcmRsJzzt8=;
        b=EuUX4uiI9bKEw9S2htBB4C/HKjxRVtjbEqxWnSMgwvnKEB3vVtzgjFnNnzovilKON+
         Ijyk+JcAwi5n3x0KaxN7l2nwGO4VvlRvf6dM6l/n6vAKxqBNlLiOUKWynHxRWz0Y6WEe
         yMXxqqPX5/cnkifEt1EM4TKLGU+gz/3SFmMs77hrjIQtMiuOe7byAZvszNuF2r7uUOFA
         HrH9ic2XhGZV0YdmYGELrhABU/97WtKCr+CsPXuASbkRdWHF/ojFyI8QT0WuAxF5Y+42
         cm4n8DFb62U/nm4GMs2NztePX5reHcKAMNwe9ZTAdUAJN0OX7nxQMl8YkIA1IIv3dWvG
         ueiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/GjNgNYqfyooU5OtMg5IRuJcX6uXA0hTCdBLX2mos0eLggDTmXLE+7c2Yg/bdRG86IiT6c2CnrRRdnv4pzZDY4B7yFskvQQ==
X-Gm-Message-State: AOJu0YxkG8qSRQq8X0x5MCXSlY7IiBU7y9kWzij+eaedPE5cBiU0PUPG
	S4SjcXRD/s2m/7WTIGSd3ZYYemQeE+HVqTCDpm8ivEVU+j0VVHDHAmnpLLAs+OwerQtus7OAAt5
	CUDmKL4GldJuXHwBRafGImqvPiumMy/JnHC7E
X-Google-Smtp-Source: AGHT+IH5Y8G4M+psLtl5ozUOu2RjeWfSvT5C53fM4Wva+peYjIwy6mOS42gzLlAZlpmBSbzeIubfKTtWZadUROXeA8I=
X-Received: by 2002:a81:a103:0:b0:607:c8fe:c4c3 with SMTP id
 y3-20020a81a103000000b00607c8fec4c3mr3441262ywg.30.1708035592344; Thu, 15 Feb
 2024 14:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215182756.3448972-1-lokeshgidra@google.com> <20240215182756.3448972-4-lokeshgidra@google.com>
In-Reply-To: <20240215182756.3448972-4-lokeshgidra@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 14:19:41 -0800
Message-ID: <CAJuCfpFe2spt082fdB99ow+pqGj+DKnep6cHxoVYRVYgyO9uhg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] mm: add vma_assert_locked() for !CONFIG_PER_VMA_LOCK
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:28=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> vma_assert_locked() is needed to replace mmap_assert_locked() once we
> start using per-vma locks in userfaultfd operations.
>
> In !CONFIG_PER_VMA_LOCK case when mm is locked, it implies that the
> given VMA is locked.

Yes, makes sense. With per-vma locks used in more places, this makes
replacing mmap_assert_locked() with vma_assert_locked() very
straight-forward.

>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3c85634b186c..5ece3ad34ef8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -781,6 +781,11 @@ static inline struct vm_area_struct *lock_vma_under_=
rcu(struct mm_struct *mm,
>         return NULL;
>  }
>
> +static inline void vma_assert_locked(struct vm_area_struct *vma)
> +{
> +       mmap_assert_locked(vma->vm_mm);
> +}
> +
>  static inline void release_fault_lock(struct vm_fault *vmf)
>  {
>         mmap_read_unlock(vmf->vma->vm_mm);
> --
> 2.43.0.687.g38aa6559b0-goog
>
