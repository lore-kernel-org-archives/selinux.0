Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11B211C
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154932; cv=none; b=LESp6g8bJIdu1Xfw4vBmplJzzSYwPtBrTgJHnF87g1k3PABxl1d2GeYNbxSUcu2ZhZoIzQViqf+999km3G0wiOv8eRh0zxyOXwj3HcbSobHBSMKSbqGSX7y01n+Av97ljbH3cNLPnvWFQAKeclqcXfnvs1dEfNxiDSX28I1zZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154932; c=relaxed/simple;
	bh=/ZbVIeVYqGYvbsgmREnTSgDE5d8lWWgn1carZLdQSKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSpQpm2kHDdNR+jbmgKyTv2mLxYgs3HdZ5BtqR057NmkagA80lPVAa2DNv4Fzju24zIINgLX8pCurVvmiftV/7yf7Ofger40DpK0SB9SIrvHYGXU8tkKOHhP7+baowGQS9QxTyhUAZaf+YpAg19nf182ZAd/OXUPe1tbN5vtq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/HsnFB3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/HsnFB3"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-572e153494eso1836e87.1
        for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758154929; x=1758759729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZbVIeVYqGYvbsgmREnTSgDE5d8lWWgn1carZLdQSKs=;
        b=l/HsnFB3kPI2YV65rFUpTJvWOo/4F4idtN3jFNO6dwbxn8wLhxVr2LZyToJWuP5QZ/
         S5/PcpldKQd4Ys/9wEdf4ZjZN/k7t5VX1j+jW+aubKPK9X+3zSHKFj8wcJb7XRtTdaCP
         +LFhbrGbyL54vN/I9wEXeZP+51PvdcEbj9k55wKtdxgDCvuqvmqdgoytQVu+9gaL+Ns8
         +hTODgF3471tlyP0ewYPNCg3jtc7mSuKNDjXCLc8XtUC+1C9Nrp7JhKgT0uUoUBOpkSQ
         1FH83u9LWRSuWrWbrozeW/GeEBWHBi8jVmTwNtWGMzUuDsVgqT3M6cfNYEHUF2kE8IaX
         NwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758154929; x=1758759729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZbVIeVYqGYvbsgmREnTSgDE5d8lWWgn1carZLdQSKs=;
        b=MblhUzWXLtZO1ipGKHKjHQsZSnX9zOlNWEn+r1OLR2DPa5kFEGE7Okl6mj8GOH7wne
         bvf8ajpEPMZ5qRd85IQVPTV95hj8I2kDMgFbpYOTyTw0edAzCpo57oZmdFew0VvxBmd9
         FYG9flsiuXybfaUEBgnBHYVCwo07ELu6Fb45FLn4QIvsTNUyIb3+vrK7XybMMbj3ewdG
         4eM0M6S1SBcZc/i3IcrI8rdFpf02oMz5QtOH+IkFjDaGi/yErjQd9BUuyMbZIYOmSVTs
         l3SF6wQyTSCtMIGG2ylNqtk7PbzdVr+D0hmBJ44tS/oLMLtve/8Q499kpDojeNSKw6fO
         Sakw==
X-Forwarded-Encrypted: i=1; AJvYcCV9VtNR5h8usaOcEy1kO3mwlXNnoWiikYHT6nmZjAF7BAhNdoNOlPBSjLlTdWt0a3AKkTiRTRiL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2v1A4UFDb+G2WoCCQV8Hfd0u6H4VqSc3ds2F6OiMWw/neWb4
	ANU33721Unw9VFWsVth6BH8OexYIpy+AlpAIH1vSEm9AsZF/EfQQhhgToPYsxgcxzllzSL2SL1q
	0PIjBVlqxgx33a0FnTTtkIWsRcU2uWYBXUwRjbsP0
X-Gm-Gg: ASbGncsWHv/0jFbVfG0q/xeRQ66XzE07TnhQ6vZiMjRhkwQyMJEK/m7UqyGgC5RwV1t
	x/TsoxFCb3kk6GBwRBYVQp5HXZXhPS77V/+lpXdKevu0lOg4dAJQaDS3weqbgnUgB6X8ep+vPDU
	YB7ogWZTIN5q4wnDKC8vSmI/f86cnSfe8hwZ+bz7oPnOTXIHXA7PkcL9NKe6F6OnW6O5OvP6C0p
	R99f+o19Fou87o5iVV3YwPkPqJJaQmTtviCSSRV7BlvjM11HKfEQ8Yq4kbn
X-Google-Smtp-Source: AGHT+IF8O1tlftjEtMw9w16/HqJR/vZc8/66abNynQjj5q1J+puyGUNupLYmhlD6Ea5WoppnQq3+2jeNYvbRyLKGUhA=
X-Received: by 2002:a19:5f15:0:b0:55f:68fe:76d4 with SMTP id
 2adb3069b0e04-5777921204amr276447e87.5.1758154928537; Wed, 17 Sep 2025
 17:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
 <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
 <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com>
 <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com>
 <CAEjxPJ4387JPN+JOQ7g=Z6CCXYR-mk+6tr_VeyprxNJtCy1TWw@mail.gmail.com>
 <CAHC9VhSdKTUvY3Tg+dVCWHLfwULV-Vgzr-d942eh_yHa16HyjA@mail.gmail.com>
 <CA+zpnLca1_fRqcBq6AK0-hGbSb44R73xq2jw6qiYTv32GhKDfQ@mail.gmail.com>
 <CAEjxPJ7SDeMCq=0XFERiFozQmzRiJN9X2NB8v=_X8KOKYCrBLA@mail.gmail.com> <CAHC9VhRQJ+wZd-bi3Svg+RWEg+sC+YodvRfqEg3StoMAy5Rwow@mail.gmail.com>
In-Reply-To: <CAHC9VhRQJ+wZd-bi3Svg+RWEg+sC+YodvRfqEg3StoMAy5Rwow@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 18 Sep 2025 10:21:51 +1000
X-Gm-Features: AS18NWCaJ9fKEej7zhIT83djro9SGIX6Y7-BkCwc4d7noQpVantSHqyX8p0c8Z8
Message-ID: <CA+zpnLdJZ2yxWqTCBGXRJR0XmrCPpX3N4F3n=ZkSLc00WVyn9g@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 On Thu, Sep 18, 2025 at 9:54=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Sep 11, 2025 at 8:13=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > At the end of the day, I don't strongly care and only Paul's opinion
> > matters for final merge. Some arguments for each of the different
> > options:
> > 1. -EACCES: Consistent with the majority of the SELinux code,
> > particularly all avc_has_perm() calls. WRT POSIX.1, it seems to be
> > primarily for file access checks but broadly can be viewed as "access
> > denied to an object", which is the majority of the SELinux checks. In
> > the case of this particular LSM hook and system call, we are dealing
> > with a file object, and hence -EACCES could be viewed as appropriate
> > to this check.
>
> Let's go with -EACCES, as Stephen has already mentioned, it's
> consistent with the vast majority of SELinux return codes where access
> has been denied, and while we can debate the merits of EACCES over
> EPERM as it relates to the presence of a clearly defined object, or
> the EPERM usage elsewhere in selinux_bprm_creds_for_exec(), at the end
> of it all I don't think there is going to be a clear choice here so
> let's go with the most common SELinux error code.

Great, thanks for helping by making a call here Paul. Respinning a patch no=
w.

>
> ... and don't forget the WARN_ON() :)
>
> > 2. -EPERM: Used for several cases within this hook function already,
> > most likely due to checks that mirrored corresponding Linux checks in
> > the core kernel that were also returning -EPERM. WRT POSIX.1, it seems
> > to be for any permission check other than file access checks but
> > broadly can be viewed as "operation not permitted for this process"
> > with no object in view. In the case of this particular LSM hook and
> > system call, we are already returning -EPERM for several other cases,
> > and hence -EPERM could be viewed as appropriate to this check.
> > 3. -EOPNOTSUPP: Used by other SELinux hooks already. WRT POSIX.1, it
> > seems to be only used for sockets, but on Linux, it has the same value
> > as ENOTSUP and can broadly be viewed as "operation not supported". In
> > the case of this particular LSM hook and system call, I don't see any
> > existing uses of this error value, which could be good or bad
> > depending on one's perspective (good: easily distinguished from any
> > other cause; bad: not expected by userspace on execve, not documented
> > in the execve man page).

Thanks for the clear comparison Stephen.

> >
> > As far as I am concerned, feel free to pick any of the above and post
> > a patch with it along with the corresponding rationale, and Paul can
> > tell you if he wants something else.
>
> --
> paul-moore.com
