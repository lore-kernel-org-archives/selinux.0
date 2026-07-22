Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEA2AD3C
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 00:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678877; cv=pass; b=O6dXJ5hvgA0FBM9n8OFZPVJnzuu0XyknjX7phBdtgmDoZftJnUtZW9l3O4XxwsQNIKPM0pQjCGIPOluPZ+o1oBDi8gu4SEf8EtY/jniqd2ynKIoEY82gbZwSTQ/XpvCmWUVmTIGAM+sMVP00+Sw4iuCYqcWU65AyTkcM8hyjFLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678877; c=relaxed/simple;
	bh=HaHCyLQTj13R7BqNymKB7lrq5aEUxgHOgSJlFo7JJB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivmhJ8SKpf7rXYZrj8Y4PoxPXMtbWi9AeXON87HpJ1fvmBoV4DBfk8vHHnkiSDCH/ymlggEvU3VRGmhkHg7P2cYOl9DMPSxuc4PqdE5RiI805r2txpZd/hfoPpd5X6FZJsmDRB59xbqtT0lDlmam/MzbQ3nW5hyX5GLBq+JID0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvHJJRrZ; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvHJJRrZ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10e86e52so1363271cf.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 17:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784678870; cv=none;
        d=google.com; s=arc-20260327;
        b=JLWJ9bgerpt87sPNc0y9k6Ajn7oJ5lumC5of05t2sBZUdmBXgQX1WrnrevjCMTUUwP
         3g9C95aEVqxGOkUl1EFjvoWj1umxDUY6vgKtglc0Rr0Inin5mAqdYyizQet92XpAf2lV
         QlOuWXdIPiHe5xxWGAaGOJkGj31u6LVw+7fWwiAE/jQVELME7HqUvbU50fkE8NjWGW/b
         ymQl7cf+UQZwHuMBBntPUcV7DyUlqsKf0lyUjBfZao8EX05W5hcno+loz/MSrDE5OBRO
         b+te7NkSLHQWEd4MOT9oHOep+3RQzOZ6pCZ/NYfwM7wt9csqBSxUom8YrryDzuvx6H0O
         6J7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HaHCyLQTj13R7BqNymKB7lrq5aEUxgHOgSJlFo7JJB8=;
        fh=gG5S7vEwfoAvVZQU3muc8yt24DQ+wO/lFxMIXkdCZOM=;
        b=RB/umf/ufR8/topi22LDe+UC5Fw10i8ULQLjMtBKK0Sf7ZdizKgvGwGixGd87j2a9E
         GtkFtNdBvarRzpzkjzibM3KhA/eYN8uLaRV6IrgV+iZl5FbZ0T/C8rFkIaf1wmshOrpx
         iACK+/mB2AmtU49ymE6Gh3agJhR3g04ItvrDm/2E9NXibSUZLGyBdmdwMgPQjmUzMeVl
         +V8c28wEj/nL+h4I/OYfHwf+ULO8XVXAc13NCfBbjRVQcF7WrHEO9DvnINMit10Qkqec
         9WXoRg3vRH87cESMZ9PhG2Ch7ElrxRSuqFKw0Gcj13De9/qANpfN/0HD8difUGLbGXfR
         UM5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784678870; x=1785283670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HaHCyLQTj13R7BqNymKB7lrq5aEUxgHOgSJlFo7JJB8=;
        b=mvHJJRrZqMtevf2x0qqYSCIHzj9hQNPdHSbJlEIqSZBCZqD+fp216HY4FbrjVCt3NU
         mAwVCCFIlt03pGfofMKbwDVC5nZUyXYyrlbcESY50vQXX2rp+qXbRKc/Y8DmOYvGrGFF
         HWjZFb7zvVxjlVZ3vXQA8oGJDzQxO4hm52idamtANA24MBH44+nfYVOI9jAIuFcczkwK
         avUmT8MEz2g8C+ZLyRUahBTGILMauSg8pnMjcy9cwoCEUILCk/c0OY4ubxSb/xiLTfNg
         cAWluWP71pSKA+2DTtVLPzFyRKkb3rXqBlgA1UoNbg8/HxddQngK1GaXfxn0IqLpHQzM
         J5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678870; x=1785283670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HaHCyLQTj13R7BqNymKB7lrq5aEUxgHOgSJlFo7JJB8=;
        b=BgMl9DEZ0MLbe+G6yIOzbt2Yh1UIbQf1TQqiqAbMexj6Nna9dgOu+juDJNAmgQcCGq
         u/AX9PM36AZv32Mi0g+nKoFR0wnrKEEtoqYdLDi6Me16yu6MVltVE87SgOMISwlnWL8K
         Y3DdFzUvPWC6x/8TH4V8r2xkSN9As11HWbdLYaTNZVcYeP4OAltF2ina5LwxjmUYzq9H
         4FJdU1CcPnUtuDEat9O5i3fmNKiuc1lkSyJ5N3ee4pHyxXSgBt/7QJi5Tycw85MssNZ5
         QXJGAh37s5MF+zjdTfnWIadkstqd6+qOCLTZWQClkH9c+Utc92uowazHl9qiTI6+EC3j
         mqbQ==
X-Gm-Message-State: AOJu0YyUW5APeU5ieZ+XA1wxA10qZB/kLlH9FJHItUuM1Icyy/+ZFmQ0
	CdWwmSJNascelU0Tls+8t1QIs/0Ek6V9V1EuanbxAldsI8UVoQ0w+jz0v85EZ12MCc4Qs2e1zA+
	Bol9GpecO7iDi+AYYC2e/jOiFf0kVixYSc7XFfWJC
X-Gm-Gg: AR+sD10W8I9ZiK8eb40PeD1vDx7Tgp4Z3oq+RL3lx5RTmK0FnfmX0aDOZZ9uZlqLodJ
	2+/6ppoaQSaOuXl9PV10FAxm/GR6k2O9W79+qoJSNc5zPbjhL1/MgHTNnZgNVJbZabHaNR8bRbd
	ZgKCadTZ9P3MovxhV/+RWnD3dU47smWa/rVfOJiIHTske2jj+XrOw+8LKospP+6LpPVE/P7kveD
	ON/INrzwRV3W9AOt1LU7EXKvgbVoQhFnstgZ2ZLB4RCDK6KmEOnapMm96TY9l7MSNR4FkGZCVnQ
	M0KkVEGcRaGKFF0tuS7nBCy4at7R
X-Received: by 2002:a05:622a:6084:b0:51c:289:6979 with SMTP id
 d75a77b69052e-527efd1f994mr2180171cf.21.1784678869555; Tue, 21 Jul 2026
 17:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021157.1314051-1-tweek@google.com> <CAEjxPJ4RGmQ5PArL-J_29y_z7s+rn4FVq8Fhzh4oEEKU9mXcZg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4RGmQ5PArL-J_29y_z7s+rn4FVq8Fhzh4oEEKU9mXcZg@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 22 Jul 2026 10:07:31 +1000
X-Gm-Features: AUfX_mx7G8UxwGv-dN7ElOWOS5MPAnbWN2T2sTD8Mne4emk5Ou6HqbW8Q46rn2g
Message-ID: <CA+zpnLfh7fq-_bqLwUULkmr5skci+mtJe+=5PH1PKB6cwqWmuA@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/2] tests/file_contexts: refactor existing tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:12=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Change the logging format when reporting an error to better capture the
> > location and context of the error.
> >
> > Split tests into functions to better isolate the tested behaviour.
> >
> > Format tests using clang-format.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> To date, the selinux-testsuite has used tools/check-syntax for
> formatting and this doesn't match the clang-format. Not fundamentally
> opposed to migrating the testsuite to match the userspace but that's
> up to Ondrej/Paul and should likely be done as a separate series on
> its own.

Sorry for that, I reused my clang-format command from the libselinux patche=
s.
I'll update this patch and send a new version.

And yes, +1 to any possible alignment on the formatting. Thanks.
