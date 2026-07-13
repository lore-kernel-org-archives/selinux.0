Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8178F3A
	for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976478; cv=pass; b=APxXfcFVhKfkK26qAa+z8597QeLqbfLrLfbYwMVujnr3FkSAdEvZOQ1FE8CJ/K8bccZjCbHe48M/ZP09CzoyXg43Du97oOAIDIMgHitWWooUpqo0D5KC4qvvpjwKdJeOopbFzPCM+bLWR7KhfolkCayibq+9eaf7zLKv6Lt56JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976478; c=relaxed/simple;
	bh=XE4NrChARLocDMHLMSlgzoQetqN4kd66D5Z1Fdnbzqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXHcsoTRbBNQSC8O8p8gtmoh40h61NiOTGScllQ35OY55pCeEzPKOkTJgsuZ7AjR1UCXWItKcLPmY9V9zvNqgkne1ThPPMi2Ur4+Ul6m1+9uObSSN7EdMU2Xy46TofZ8eu+LkK+M4dLkm+AVqxGeQBXWbiR5XnwOq7kbmIDo9so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d5yWHvHZ; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d5yWHvHZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caced6038eso4186525ad.0
        for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 14:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783976476; cv=none;
        d=google.com; s=arc-20260327;
        b=QzIZGLLY2jbehm/zVn/qte+Ysrs6Q7GEltX9pQnaKJ16BQr/ASp6tsULlfBizx5qsz
         y1fQfE0Ns+CQ2p3RIh6zlTmkVavG/27y0ywCOotJU94bodp6S/o8tWF5ISXdP5O+URwz
         dig1UchS25uHt3wvcIo305d9pQgVFFoDc4qNeb7TkowJEd1eKsdZ7Rqq3ZcouHWNZNQy
         Vx6IzkdUR07G2AIrlk1M3qFJuSVhHz3z5ORjCB/X9qLXULccuRZFbsmaeRE9dSkqfvU4
         2Cw4rDWYNYr8LHkk6V+4yjlrYoCLq2OtzMxYkoIXGvdGU60OEtN2+99pQ8rmQEGHJsbt
         18mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XE4NrChARLocDMHLMSlgzoQetqN4kd66D5Z1Fdnbzqs=;
        fh=9H7+DnRm03oe08q1bumzCcROr21GkEAriITW5cT9dLE=;
        b=WVMv3vXeRVW8ryPc7s6wHe2HZEkDG8vibrIZ5Dvl4vVRzeyWvWpRN2qV2E9RxHN0/p
         mKFK5iGQRXQ/trETtHGVzpHGl6HANzAsNnRyu4rfoR2zCo1ZQDIk/bFOdZH7lG6KWjJE
         dCt8P0u7yelBwOhx1r/yCcggAatWW6rXaYiueVSpq7rwul6ovPvi+tjNUYTbBmMWkV0P
         eKWYpibb9rigg5gaICSsGxKIfeY4XVCRYUCniT4vwAaum7935fasffGm/MJ/qvkmUwTh
         j3LIjnIa2mAASajf3FxyFyfduwUw/Bdf6wAezpRtElxjJFr7YHIJvCAuKJ2fqtTYxfpK
         Y8Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783976476; x=1784581276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XE4NrChARLocDMHLMSlgzoQetqN4kd66D5Z1Fdnbzqs=;
        b=d5yWHvHZrRqZNtzgRgb6rfh+/paXDDZZHgWnxcPSgHDr+6PnQ6MpUs2q+VpmOJo4ls
         3tGQzUPUSKYdhhzvaBAq93OYkgJjWSX6c++wsLLqKabQQl8rl4dgAq88971z7BlMXS9E
         ZJOitOWg52lpnOzxmr5ucXO+F3o3v1fXpwYEej4q5u3NV5IDC0AkMdwQRUt33bqgLBpB
         wyyzAvfwfSlUfzQK+1DkJpwN7e/80g8vxUOQLQkHaCFrKa3s96y/ZWlu6wQXNUGJutda
         GcwsfLetvrQbh5BollCbFqZ9RHxVtID3sl/DXf82o7veRhjU3dv9WLuXqX5TpswWtFSi
         yO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783976476; x=1784581276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XE4NrChARLocDMHLMSlgzoQetqN4kd66D5Z1Fdnbzqs=;
        b=f7fzaqDQJQAHDUGWFp1gLqTFpIOlmU8LEaX1VSaBYCH7xRemrXMQxRM2GQlXR5ZwnL
         /euVkYRt89hMIQoGt0kqx+h83b5z2nZyTUXlVhPjcH2d0pa+6b7X4DlaINc1lsEUVZoa
         RJwuuLeZGka1QExkbKe3xm3WAlTyC6mKtEC4uiv9dO0V4iszOFIpBanvOYRvPwJB/fCC
         4rkWLfCJmlLqOJf3X+5331xHOqrGpvDEBvYZa0VeFI0qx0AWWQIusyjKUDi+lDQweyyv
         bGHBiTbNwAoXWrKa7vCRtzZxUbtbdd+Qq6aNlAYANH4y26HSDzoP2Bs6g3NyB8ANtOpo
         kL4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpFwujmZCmzqruc+UnjGlZ//luIdrNxJNrYcfD4pT4+VO27JFNZKxbFjcLChEGjeSDc/IvtNAex@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4ybKYORAw65nWA7OgFtq9Cc92Ettufz3+Zm4LtIKMEfa8xkc
	xjOZv+JNpCjEA41i9/gjM6Vi+DUrZS3rCRqJ8Cwp+aATlvT+gPSmbYvChDJIjEic/6VfsZz5GAF
	cucnGC88n+xVnPBO8OEXO47BqKHTiZXgN+xiIRLTyB01gRK5Nv0ykNA==
X-Gm-Gg: AfdE7ckPgziCNCikNmgAXJBxBKdX5P8gyB4HQpTgKU5/IOKORzxqhpaBXJKe3rKbhsj
	kkeh37YcW4dIf9M53870c7enbWtrSfwnRMAckPAwS6xwCXphS2gu0lf/8tTWprDNohd1AmKEdDM
	FGzPFOOHEAf28u2qyozKvjdUdh1IM4btTTTNb8W0bhLty8dwK+gYwm9iql6n+qMFnJ3fxOMDC8l
	l+xqDGKm5dH1av/eGM2sfEqXNPqRRUfPNE6mATNfS+TPGfAryMvUQbo3IhClQyh3jyI/6lb+zF7
	9M1XMss=
X-Received: by 2002:a17:903:22c5:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2ce82879e00mr149683675ad.8.1783976476600; Mon, 13 Jul 2026
 14:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703114733.1243995-1-omosnace@redhat.com> <CAEjxPJ75Le_hOqNeu2VZ7DvVNBrxn7zo9zD3T3M77BLHscc1bw@mail.gmail.com>
In-Reply-To: <CAEjxPJ75Le_hOqNeu2VZ7DvVNBrxn7zo9zD3T3M77BLHscc1bw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Jul 2026 17:01:04 -0400
X-Gm-Features: AVVi8Cckq0S7dFCfC7KMKjsFZRhlrAE1rGCxm8o6ZFMOdzpPkXjyj3XHiR7YrwE
Message-ID: <CAHC9VhROJVpe7w8eM4oxtCQ8=BdtEEZVSTvTJv0BsWG6jzHHAw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix incorrect execmem checks on overlayfs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jul 3, 2026 at 7:47=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > The commit fixing the overlayfs mmap() and mprotect() access checks
> > failed to skip the execmem check in __file_map_prot_check() for the cas=
e
> > where the "mounter check" is being performed ...
>
> Sashiko noted a possible pre-existing issue in our code regarding how
> we are testing for anonymous mappings:
> https://lore.kernel.org/selinux/20260703115632.0761F1F000E9@smtp.kernel.o=
rg/T/#t
> which we may want to investigate separately but for this patch:

Ondrej, please look into the anonymous mapping issue in a separate patch.

--=20
paul-moore.com
