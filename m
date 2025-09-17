Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157B27FB03
	for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153288; cv=none; b=ayCm4tvTkg+4zVBwYbE9SkH0X/rSnW1Sl2OV3s3ysFFd9/oINXBU8sbFOCpxUlVHHlc1x09i47bAJH1S1FNSkzkqZwzJIRvVsJWHOyeS5ymhNwOprUDtxWDslIf5V5W3ZvTErT/6yP9Y3udB969llJNC1gCgyDvsAaaER1rl4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153288; c=relaxed/simple;
	bh=HHCnuILI32O9x2s26X3qLkgSbmrinFfEy9j6OgOq3AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB794nAbOpWd0DoLUWpg2TT3iOGX8jSMB87ILZygIsdwW2Mh/YM/4Jgdj4ZJy1p7ibsJTjkW8MMS7LyVC9IWoDzvl88fhVCldfJaIEnbC8S28ww/ih7SPgQFSL4vOphBpa3HGpg1kW7FD+4F/dYD6ElCfo3EI8bBgzoh+jGWXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HnEMSHgw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HnEMSHgw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77d37d71967so70215b3a.0
        for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758153285; x=1758758085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHCnuILI32O9x2s26X3qLkgSbmrinFfEy9j6OgOq3AE=;
        b=HnEMSHgwLGZTh81pI8uxCHrQSosaHV74tI4aqCte3P68GsC+K2rQrsx24g9f7y789l
         NdFBCN+SzAwwE4Cm5xiNiMpQcHmjvgT/xLDMfBSFKNdhmJGKSM4b0zFtbY2FGxTuTCoT
         eKCeuCV3/m8VrHpK972NGEYwUUsj+bDXtD+n9Z8jQ7a8bDVVOfmIaYt0SjOAJ7qoD2oz
         zrHr/o80cNshSasQGrvwqjxV74inG/5UlWTSDMR0Xgirjoc7EfvwEBciedCtV1EZb/TQ
         XNN9AtVEsb8nsc4oJ/UyzmQVj/wcCSKrGEDwcSMS18ya01iCu6Yw9rNTWaCOxvjZLUq9
         t1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153285; x=1758758085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHCnuILI32O9x2s26X3qLkgSbmrinFfEy9j6OgOq3AE=;
        b=gaD8N/PoR5CXm+IbEEun0vYhW4qfYsbYiBml1isiz4mRG9h9R4vd3bwBzo4JHjOjup
         FW8LNVQ9wIBMlSDYRe9QYik5ZHyVrhAPFZI47AKHncUgmf1/jbruYFJdjNW8/zMMnYle
         jz9JtzZBLOtSMn6/Y4aEmaN613SaeErQGWuBXnpPO1cyM5T9J0lWbtOIxcN5LGs/2CwT
         ZejG95x2cWcrUxNuess4n9zvGJBdYlogcRVygWrLwE9FjR4Ii7FRdz9PLr+kUdkbV1Ua
         DYVRwBtXQjaOqmLiVjA2FoW/g5gvrEE25aP69T4La8k7ojXKnCc2WPHseNaanEj8xyei
         s3VA==
X-Forwarded-Encrypted: i=1; AJvYcCXUMhGi8THiLbj1H4pbe3nPnVgOYeTmfSYo/7y3DjdFofnQGqsrbuFAxXdAKAoNmgmXK6b14xGj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Sjswyy0f8KeltjaKrTEzG88vqnMdoJVhxhlf0vy3BEGihzlp
	bgSF6xoEfuy9C2dgQKAsKS7hR57qLBiP0RNfDKpj4KcH0xzQjoQhxQIOpBjXpDbM32E3EatRL3b
	+KXtsKIUW9z6j0wZFcbXJDZZR6vZSRp8MqCwXBYcXgniG8MZJsqZw4w==
X-Gm-Gg: ASbGncsTO6FND0JB3Dn0RyKHule5DqSusL4U0VyO7uoMdwon1Nvnp3YGGsMLTQmoVcw
	hvTZArN8imV/NjfdYRRWj0N2Dr++bcLIaYJ0FQ/wbr19AaRAknpfebiINrvCQxQ6qdTcDg6dzaB
	3nOyoeDXYqVs9to10wwsxU/XomwR3WL6Pejk890CHc+gJI9weS2G+Db/Z40xi9u/vp3JuGs5P8y
	uBNkfPupFsbeomAobHm4+AWdQ==
X-Google-Smtp-Source: AGHT+IH10RYpRGoM5hNhMG2ToKEuKuKROTQ1N8ePYFVBg1U/7ZXNLfnWCzi0RxFHEq4OTMHJxt6KjceBDC6sGk361wY=
X-Received: by 2002:a05:6a20:1aa3:b0:263:767c:28d7 with SMTP id
 adf61e73a8af0-2845e570e39mr1466125637.30.1758153285557; Wed, 17 Sep 2025
 16:54:45 -0700 (PDT)
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
 <CA+zpnLca1_fRqcBq6AK0-hGbSb44R73xq2jw6qiYTv32GhKDfQ@mail.gmail.com> <CAEjxPJ7SDeMCq=0XFERiFozQmzRiJN9X2NB8v=_X8KOKYCrBLA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7SDeMCq=0XFERiFozQmzRiJN9X2NB8v=_X8KOKYCrBLA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Sep 2025 19:54:33 -0400
X-Gm-Features: AS18NWBW0cvjfI_9Me-CiEWgU4XokG-4W95siheb6FNQilWnL4QeA9fdvPkRJVs
Message-ID: <CAHC9VhRQJ+wZd-bi3Svg+RWEg+sC+YodvRfqEg3StoMAy5Rwow@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:13=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> At the end of the day, I don't strongly care and only Paul's opinion
> matters for final merge. Some arguments for each of the different
> options:
> 1. -EACCES: Consistent with the majority of the SELinux code,
> particularly all avc_has_perm() calls. WRT POSIX.1, it seems to be
> primarily for file access checks but broadly can be viewed as "access
> denied to an object", which is the majority of the SELinux checks. In
> the case of this particular LSM hook and system call, we are dealing
> with a file object, and hence -EACCES could be viewed as appropriate
> to this check.

Let's go with -EACCES, as Stephen has already mentioned, it's
consistent with the vast majority of SELinux return codes where access
has been denied, and while we can debate the merits of EACCES over
EPERM as it relates to the presence of a clearly defined object, or
the EPERM usage elsewhere in selinux_bprm_creds_for_exec(), at the end
of it all I don't think there is going to be a clear choice here so
let's go with the most common SELinux error code.

... and don't forget the WARN_ON() :)

> 2. -EPERM: Used for several cases within this hook function already,
> most likely due to checks that mirrored corresponding Linux checks in
> the core kernel that were also returning -EPERM. WRT POSIX.1, it seems
> to be for any permission check other than file access checks but
> broadly can be viewed as "operation not permitted for this process"
> with no object in view. In the case of this particular LSM hook and
> system call, we are already returning -EPERM for several other cases,
> and hence -EPERM could be viewed as appropriate to this check.
> 3. -EOPNOTSUPP: Used by other SELinux hooks already. WRT POSIX.1, it
> seems to be only used for sockets, but on Linux, it has the same value
> as ENOTSUP and can broadly be viewed as "operation not supported". In
> the case of this particular LSM hook and system call, I don't see any
> existing uses of this error value, which could be good or bad
> depending on one's perspective (good: easily distinguished from any
> other cause; bad: not expected by userspace on execve, not documented
> in the execve man page).
>
> As far as I am concerned, feel free to pick any of the above and post
> a patch with it along with the corresponding rationale, and Paul can
> tell you if he wants something else.

--=20
paul-moore.com
