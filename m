Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B071239072
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372770; cv=none; b=ogtP7oInLlr5edMR1T8g6dn1hZoaZkx4ceNPif9fnUrxWGRq4sxIy0TEzVkBI4ZvdzWfPM+MGpGeJ6h+2YLHOqhcKJ87ESYPev9sujRPkBqI5RnPgmdStVb/bYm6WCQr4QBkfTzbo06SAGWBMinFtcb8l7wuwTzTUNQyK18XCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372770; c=relaxed/simple;
	bh=Y5RZSb94nAB2oyU1qoO8afAl+wCOgH+J1m+ytAgunGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geUjgnVwF7sEnjucHZrcJIi65+NCAWpN8hTTD0S9r1MgrcK3fhYaygnpcTT05Egg1QIsnXZwvnPbCH/43nZa+cSC/HQEyzyUDLdQHkgtwXDuR3uRUEGeX3Xrg7wKXj5nwzhgcpQ+H/I9iWW78j6HoCSBVowj5t9N2wXtIi3t0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FuCn4CUU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FuCn4CUU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so4886676a91.0
        for <selinux@vger.kernel.org>; Mon, 08 Sep 2025 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757372768; x=1757977568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erv6ujYQyM5esz/88jb3LaQCpJ9LwDgjjS4NuHxBBhU=;
        b=FuCn4CUUjgnNvtegpU/nHCxIG72/RqpukgPzgn/NB7mzyhx8waHFDDfVtFZ84r0haq
         A5CltYE17oZ6zKlQ1KkO7Rh1IcvqXZaZ84CPwy3RHww4qXC2AhxZOnzqVjQSJUwUu/i7
         Sgrp5zVpM2ekQyNsnpxNcfPoJ8x8PTufkYZ0diGzB38hw0qmxafGRm00yjbZBoiImyrg
         VawHe2RPR4E8xX5LD1cAgcT+Be7Fkgxpi5zuy9afzLCB98yv5jgM46zVjl1ysuuqgood
         zH5oHWUNiP/27MAJB3teMsatItiUqzQi4/z3wMEyPSZ6y8ljkRDGGf61maLLITB8cPzL
         q3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757372768; x=1757977568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erv6ujYQyM5esz/88jb3LaQCpJ9LwDgjjS4NuHxBBhU=;
        b=eP2C0hqD1fpF3lbZWzIdM+eY2qcKTnu5srpUrymRGotZ/gGG2HH8qziKacnucWyFXn
         1xmO11UIUcc6zqVZH4AAFYn/i797q6NIfagm43b/UU3GCIFjvr96uaSxKCkZ+Nyx1tq7
         NuntoAsV40VXX1/NeopHq2jpjMWxw0EecrMIoyTf4yz6dj8KgbId8A0j7jeBweFBK+3T
         8K3+cxUuJ7ATy4OS1a9NEmH+lAKTjdKefONS4ci0h3gr1Ws3TPASJBzBH+VnDjC7NAec
         HB+Evaq2TG/kyPeqy6PtD8LCHMf/P4bAj3bBVrPO7+feDk4VqkmkIRQFye42A7yfn8/g
         f8EA==
X-Forwarded-Encrypted: i=1; AJvYcCXeI7tVtocRZt4PQEgBad6kABF8xrsk/w4hMifPHCahhgBV1GCzcynfidGlBBzaYbk8pBoRY8Gb@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRXJt1vyAplzdnZijtz+kArHnFE1C9R/hMKmuhTEXPFal5UWd
	yahHlhCeXVnW7ALZLVOtpcld1JG+bSrn6NemMGNxPfpREfcoHLHULTrxfEnXM2+GUQQkufxSPd2
	87zf/MfYErpaGevQSbrvJugNP+i5OlxUXrSj3tNwa
X-Gm-Gg: ASbGncs3OQtsct4nj1VpjeOozu5d7buCC2YnfjPBSBqwe1jtG5qZdxYROmHIYu+eHzB
	d/mitebtDeX+uy3NRzI47wv4VLIwV/1o/gZ02ekPjfyKB21S4+ieDTPXXq0my2xl1jY2n4c/7Wc
	ECR8laikbupYbRBqL1zalZLyqJFAQN+7AyxAbTvZwC6WH8QaOKYQrPBfKTHWV5L5hU8dFWfobX/
	jYOdAw=
X-Google-Smtp-Source: AGHT+IFB+FxnX4rjcAYZGM7fEt911DkcKdbHyBbmx41VKn8nMmV/AAJIF3WqaGwCTnbvarfbhMxVBFEgH0t3USpFar8=
X-Received: by 2002:a17:90b:1d0b:b0:32b:df0e:9284 with SMTP id
 98e67ed59e1d1-32d43f45856mr12879413a91.10.1757372768528; Mon, 08 Sep 2025
 16:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com> <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com> <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
 <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
 <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp> <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
In-Reply-To: <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 19:05:56 -0400
X-Gm-Features: Ac12FXxJDTl9FmflOjd4KGcqf27UBcWa5-_QkD1wxw_L_dqqk3VN6ThLKrEYEI4
Message-ID: <CAHC9VhRvdxdmyp1+hDpiOZTLdJjuK1u5Rvk5dTsbN=oDAyPkNA@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:07=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/09/07 16:35, Tetsuo Handa wrote:
> > On 2025/09/05 2:52, Paul Moore wrote:
> >> +               if (!str) {
> >> +                       str =3D str_tmp;
> >> +                       len =3D len_tmp - 1;
> >
> > This needs to be
> >
> >                       len =3D len_tmp - 1;
> >                       mb();
> >                       str =3D str_tmp;
> >
> > , or concurrent access might reach simple_read_from_buffer()
> > with str !=3D 0 and len =3D=3D 0. (If you don't want mb(), you can use
> >
> > -     if (unlikely(!str)) {
> > +     if (unlikely(!str || !len)) {

Good catch, thanks.  I'm going to go with the approach above as it is
rather straightforward.

> Well, memory barrier is more complicated; it will be
>
>         len =3D len_tmp - 1;
>         wmb();
>         str =3D str_tmp;
>
> and
>
>         }
>         rmb();
>         return simple_read_from_buffer(buf, count, ppos, str, len);
>
> pair.
>
> Just splitting the whole { } block that follows "if (unlikely(!str))"
> out as an initcall function is much simpler ...

I would very much prefer to get the string generation out of the boot,
and generate it on demand.

--=20
paul-moore.com
