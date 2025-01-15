Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE208F77
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971916; cv=none; b=udW5eB6RWT/mBL4RSvi4ULu4QzLu+v19a5iOxTAZZOrWJ8SXbo5inKNKpzwp8tq1HOUqyY6wf3o66wLl5ZAJxLYIf0FPUJosq6i22DyYCahDLnLHdmiFaALSWyzTmDR3SwkmGGcc8dqgRoZLf3rU1Lv47Fs8BrygkJSzYqO04qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971916; c=relaxed/simple;
	bh=7JfJYLlwj+WySmKoV0CkHpDcki8lt7wheTBeNYJU4Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru/VQYAunYKGNLyp+cK9tR/1bgG50IMgP+syy81y5Rb+lMfhp8PsaPuab/B8YUW24oQEyGU6V93HRTKYzudtYWDhBVAe0CpicDy2aibK1XkOQUnJ4BGRkefctImu5Q7am++TyaJdHazNiK2A7FNjShAOkRtupgry8hYVDC0nho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag/WILDC; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag/WILDC"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4aff5b3845eso20207137.2
        for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736971914; x=1737576714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JfJYLlwj+WySmKoV0CkHpDcki8lt7wheTBeNYJU4Ds=;
        b=ag/WILDCWqXEZARweZMZJ8kqyaVyWqaPhqkv3mOipVd0FfIQ0LMIiK6qkV0Um8V6eQ
         9njr7zasBg1qlYdZhN3Mv8KwP4YozHI3bR5x446gOF1Y3vcNeEVriQeCiwOtI96hzszL
         45tIBEN+y0W76hfLn5WrES27VHXfOcn2sKBWf642u3f5Z8QPgHHLOpPigZ4EY8mZ1MhG
         sL9PD4flTs2TjDDvUxtlUDWxix2xtZ9edttN/Zqgyvjwtxc5Xpnv9x1CdYgzOuqXF3nM
         C5nvGySpKl7C8S301sJI+L4i8j9WujpLvWr5aPcv2UkYujCPgJheqeLW7JQlbwtFgOrO
         +70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971914; x=1737576714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JfJYLlwj+WySmKoV0CkHpDcki8lt7wheTBeNYJU4Ds=;
        b=qBqP6Th2MaSuFDmePTbhBX/+FG4Vv9OqQmYo5Zp11EdzDfYgBYHLKzFJtffrl0JKK9
         1Y5YS38eQghtkAfw5fxqYmKTEJwZGIe303AlVeiH7EYept/xbNJmJcVHh52YhOsXN1TQ
         Wou5rMzXtQO139iqhqGvRCuPUtLzCrctjxSewN4dW9Ac7bPhbwpeuKUJMxOcxiWraGZt
         XraR1XL8T24AZzweu1t4hmq7HP7Bj4Nu79/H12jmqz8bfxzg9PvVG3JUyCLj/v7BgC+k
         JUF2PLs2TKGHOa7lXTq5L+YocKyi8oK9xYskCbEZ9d8F3aig8P2q0qXolAY88m/vFYd1
         Orig==
X-Gm-Message-State: AOJu0YzvE7jwJGD8/X/2wFYm/1u9pNiMfPIQsRamAipYi5PNDeougkmc
	1xqj0Q3RNFRWT0jgO6h+dpnIGAxFYD/N0Dpzp5XAcyauBEA3CEgeFDT8Vrfgq7tXy21P4FfixVf
	Zgv3U6cuyFQoRhZYxYroU8THyQGEi4g==
X-Gm-Gg: ASbGncv/klFUJti9Riva5gldZdjgVOh9FvNu01k+HH9bpylMST5i//cpAKKFNGoOHTj
	kt90WU0/wZfh2qVurc9QmhFJIjQPvoyoIi7qVNQ==
X-Google-Smtp-Source: AGHT+IHlPfJoQuFiG5gEqQgkWlDCcruQJ1phBK1ct96rvl45d0jcYw//OMXC9mJWtYChD+DsHt3Q2ygsKYXGugi1rfI=
X-Received: by 2002:a05:6102:1504:b0:4b6:1efd:5c with SMTP id
 ada2fe7eead31-4b61efd01a7mr22784525137.16.1736971914055; Wed, 15 Jan 2025
 12:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tta9xm89.fsf@redhat.com> <CAP+JOzQZY4Bji7vD_ZaEQksvUP04-9u+CvRHDWXsHCD8zdss5A@mail.gmail.com>
In-Reply-To: <CAP+JOzQZY4Bji7vD_ZaEQksvUP04-9u+CvRHDWXsHCD8zdss5A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jan 2025 15:11:43 -0500
X-Gm-Features: AbW1kvbC7U1IaIoYNtwDajCcsPbzYMttEpSQ_4JeoOBhJ6DKwDGFThjj-2M9sB0
Message-ID: <CAP+JOzQfE-=yKC_CdbuerxeDDmFd70D0fDGd4E9u197JaFpnEg@mail.gmail.com>
Subject: Re: 3.8-rc4 or 3.8 release next week
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:27=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Jan 8, 2025 at 12:13=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Hi,
> >
> > there's only one change merged since 3.8-rc3 but it looks like
> > there's some important changes in the queue so I'm going to postpone
> > -rc4 to next week as the last RC and if there's no issue I'll push 3.8
> > release two weeks after rc4.
> >

Petr, were you planning on doing the rc4 release today? There are some
patches ready to be merged, but I didn't want to merge if you are
preparing rc4.
Jim

> > Does it work for you?
> >
>
> Sounds good to me.
> Thanks,
> Jim
>
> > Also feel free to suggest all necessary information which should be
> > included in release notes.
> >
> > Thanks,
> >
> > Petr
> >
> >
> >
