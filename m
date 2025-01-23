Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B27149C57
	for <selinux@vger.kernel.org>; Thu, 23 Jan 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654404; cv=none; b=qvEyvEZs1aanKP/4YyHjbKtinUVnDQcq6+N0BUSMDrBycoFc9+Fju86wo5QjUaOX4luUFihBzwSdvbF+pMwu7Wu1oD71D27fFqmnKB6OxVWrLJSbty0hBIlPPaeETfkV6aQQAZ/kqqI/mDLDJD4u21mOfWHgxbnDNkV51Jk6q3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654404; c=relaxed/simple;
	bh=BuShac5PMRQuRzTxvxR5pt7P+mhVL7M2844BdeFajHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF9fwS3wtRrL9c3ReSaKbqmYf+7b/0NYZjRolaeR1++BLwGIBr1wS7ZmLJgff0G1Ssvpg7OGtRx9cbJJB1zye36NvE7UuWZ4LdkzBya3K2zXGHUgp+OYx/HvUo6PB6u04hzsShLXO/O7k9lvWwZpU7AqXkDl/DwEYBHSGp9D5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JU1MoDTa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JU1MoDTa"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467896541e1so5581cf.0
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2025 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737654401; x=1738259201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrlv9bvuLVdAcLvAk4Tcl1flaXn6F0NFVsxyfsj51MI=;
        b=JU1MoDTaKu0ape9QGj87TD/HGQJL7KceOpbMiuQJ4Ku47p72Ji8234ySMcA7mETyED
         t1jKeSzCyY6kI6JUUVFQWiZNUdaf5PrvAGJrtKe5Fo2vRQOyeWWg/jC/QUZKyWQIfXt6
         f+Wz/9hy9Itp09ZCa9SZzKELCUeFGllGNnZIiviFKjhkuGAyxcIPOfkoCFIgJ6f+Ii3X
         Q9WLpYhRaZCK1IDdqGKlvB72gETsT/2xfL1L1RYkcdPGnoIQHFa42tkSniOx6S/3cF3c
         nVi2NANZoVECZ3fun/upbYM3m5iJpCjWuE4ufk9P9JuCU6nULquV2WFpWdbx6c7Rlg3Z
         /Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654401; x=1738259201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrlv9bvuLVdAcLvAk4Tcl1flaXn6F0NFVsxyfsj51MI=;
        b=PtS2OrhtMrWbrS+5MqA2mTMFMmTwHeo9RdOib3YRCMieeLv7brDEYM0uEEICyT0zcb
         NnCHFIDofq9pLSRTbT35i44LLISK2acP38NydSntBUbMWtq5LGZDpo8F/J4f7D6pqxUC
         xqibvgydIpP+iPnGwQ37xfKnuElqA7ILX5+DRMLMfMaRIIoJ1m7If9mwnxbGCk73NBrE
         S8YCNzg4JcT78huamtQAk7UmoHWCRYY7nMytZP5lQG8754ImY41vI0WG/XuB/dqnFY4j
         MT1Ojgj4Ya9p1sIu6PjIpjpR6EeTVMSYZTwe6jXFODc559dUzYl8gmsIj+r+eeL6uJeg
         HKsg==
X-Forwarded-Encrypted: i=1; AJvYcCWFcWofYBvhabR1sC0k52RiC8rQkFBQ1Ko7Cf57JSnkjXbBw/v4YIlmgyUDducDoTpdEcoVgvMu@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiOoCwBVTt3Lu8pIOF8S+3leEQ4spcm7bVtUsBe7Sxd63FMFH
	KiwtYHkFkMPg4O9RK4bhXgCIBI5az3fRH4Cv5T0hjyX9QG7NMBPn6mlyvyLj+Z8MN4+iR7rrlXn
	x12J0hbkMQRb1FTNgSYsWOxu8CDTt3lyGMgrj
X-Gm-Gg: ASbGncsgFMlP8s4lnuD4szIVOotMA/SPtj7+hGGjDniHH6PiaoJ8vKOSI3h6+ngG5CF
	HNM6rum2L7Cob7vTL+P5BJbaznrP5Y6qsCaxMSRJmiQKnCpj0lTYbz0jKbReZUYuj7BsnNe+f7T
	yDb/nXUtSsYc7TQY5M
X-Google-Smtp-Source: AGHT+IEn4udzSqij9W5TtY168fZ3ISFGTuwhi8IFIrEr1ddSwx4c84+jssbVKhdPt2W/Kzz4tpbpwatrQE4H4KrUWCg=
X-Received: by 2002:a05:622a:6090:b0:467:82de:d949 with SMTP id
 d75a77b69052e-46e5c0f91a5mr4787321cf.12.1737654401102; Thu, 23 Jan 2025
 09:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com> <6aee73c6-09aa-4c2a-a28e-af9532f3f66c@lucifer.local>
 <7a4f8c38-13a1-4a28-b7ce-ad3bb983dd69@redhat.com>
In-Reply-To: <7a4f8c38-13a1-4a28-b7ce-ad3bb983dd69@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 23 Jan 2025 09:46:30 -0800
X-Gm-Features: AbW1kva8LK6Oxl7iQk-wTWwjvZt1uKYq-oQd8CI-0vr3J2eS5f5rcXJCLlw0J98
Message-ID: <CAJuCfpF2iCo+ZKrqYam6wjqn7LYu4cnDeqDKrd-LpHerc5WHVw@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd operations
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Barry Song <21cnbao@gmail.com>, 
	lokeshgidra@google.com, Liam.Howlett@oracle.com, aarcange@redhat.com, 
	akpm@linux-foundation.org, axelrasmussen@google.com, bgeffon@google.com, 
	jannh@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com, rppt@kernel.org, 
	ryan.roberts@arm.com, selinux@vger.kernel.org, timmurray@google.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:15=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>
> >>           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90TASK_SIZE
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82mmap VOLATILE
> >>           =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82default mmap
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >>
> >> VMAs in the volatile region are assigned their own volatile_mmap_lock,
> >> which is independent of the mmap_lock for the non-volatile region.
> >> Additionally, we ensure that no single VMA spans the boundary between
> >> the volatile and non-volatile regions. This separation prevents the
> >> frequent modifications of a small number of volatile VMAs from blockin=
g
> >> other operations on a large number of non-volatile VMAs.
> >
> > I think really overall this will be solving one can of worms by introdu=
cing
> > another can of very large worms in space :P but perhaps I am missing
> > details here.
>
> Fully agreed; not a big fan :)

+1. Let's not add more coarse-grained locks in mm. Discussing this at
LSFMM as Liam suggested would be a good idea. I'm definitely
interested.

>
> --
> Cheers,
>
> David / dhildenb
>
