Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F21A9FB0
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929413; cv=none; b=M+iFbf0QIRx5uxg7YtrwlnC/asNboUSwTcNYYPK5vNgplm/VZuiscLrqiqMEncqnVnwc5H5T3owymNcuUEoEIre1h7ubN35Am3wys2g4LYo68vsm+sBQlZtzlOaQNA7unsCzDM0jYQCeQzMJdyIsEpON/re3AJOBjqxpzg8LNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929413; c=relaxed/simple;
	bh=KE15Hb8fmJFtP+GfilHjb+mRdntA4tohWAiEQP80qvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LliAq52C99+pe3nX3klVsuo+sXf5jvlLmvqRQrm4zC9ZByBZyx0IUasZ5YVM4S4Md/1t5cKDX8GevB5tiyHsGj5E3XZrCndCyL1L9J9eFC64SNOtI0U3v1EYg5VIvwBQljaQ21/IbUH8Sak2Mi7kEdAx4GCzZxhwLGSdH01JnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmMybdTh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmMybdTh"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3306d93e562so8002651a91.1
        for <selinux@vger.kernel.org>; Wed, 08 Oct 2025 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929411; x=1760534211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdZ9y1XbuIaBo7DDk33UpCaiOafWEzU9OeTqDZVnKJw=;
        b=FmMybdThE5+WV6QGRANIomLZo3cUSC5/hE7QheXH+KGOrTtNpQGvyi3Z6Fxic86bI1
         1gHMMDe8v4x0f27eNE6fPL6II6KZcvRk+ZvspMz6QLH00jnez6b7AU9NV5vSwdHNbs90
         E64WZNdfpwNR18ra+dWqJMZKk+8I/KayM4KK13d6Bfw0L/YtA4J5cg2d1MC/45kC1J0w
         /An9+z5SO2Ez3wJtTkxkKSNVV9pM9Cfk3d3pmbAEgCw8ZncH2H53zbH6KSVXohuWFT+P
         n11ZJX0ASH/mK1S89KdjSrw2WGY2eU5e2zkLN1YZ1btxxf7Ay4/F1RcWbIGQie3Mx1wo
         UIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929411; x=1760534211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdZ9y1XbuIaBo7DDk33UpCaiOafWEzU9OeTqDZVnKJw=;
        b=QUNY2F2HMCj7id47dfY0ZIojdnKl1z8l0PFJXk4097C+2gf8mJywpmVX+ZzD7MZJbK
         wjQDwo0h3bUM5T6JqdF486w4D8psHeQ+wkAz3XCL/7jtz/z54oKtePCXKsaKhw9hJI4A
         BsC1e5eZ/Te2Cl12sSY+y5ZISWmKLN+7nySmK+3IPxaDffYNNBC3D9IlHOuTlOfEaNgd
         jLTQ/mtpIWlGP/uU8MR3d7wfBju574LQfQzafNP1Glr+LdGPaKvk48CcYlsZyvmTAXXT
         OhFZAV5E0bgmqxg670gJ2TNgt/+htaYGPCWlQSk7C++NYMYE4phh57la/JvH4bBeNuOC
         fmPg==
X-Forwarded-Encrypted: i=1; AJvYcCVWrxyvrZlnreHF9FiEianKq/MtM0ixteI74H0IM+9F+hN75dMMu//jNw0TmedHae9tjc0H2ca7@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQuh/mjR549QG7GW6xBlKHzJFbiQtuQFC+WYeo63AZAiCpzNr
	1DICStEBaggMPWfQn5VDTQQiiCgKMWRIsLqHFOaG16DXyXywrwSeAoYJJqF36RaqG9a5dsVMorO
	sm+QEPeRu0BpuEh2eV1OLh1FloUKUfrg=
X-Gm-Gg: ASbGncsW+rXIYoL23pfUoZ1CltBnoGZFQTOSKdi8Fko7fjvPgm81dBy0ZS3/ZZtP41d
	0LIugOi1HRiJ9/v1cT3vpkZP+3vAfrEH47LCK3DLrgA7xNIv13PncgabaQmml4kOD+pUkJFfWVG
	zeb3UGemBVDMQYG5mLgqWbn69U1vI1ttlm5HuJ2cNnBV9L0J76io5RiRyAcYAVn4T8/3/6C1okG
	U20cvdBvIRVkbTxmJVaWAFJ0yrLbXIX6hd19vTkaA==
X-Google-Smtp-Source: AGHT+IFC1S6iJrP8LzDioqr/2fsJnONFC1C2qrXHWcT+h1efZ6u2P8c0wV1Hm7Ufb8uGPyicHawa5WHa85kku9erKzk=
X-Received: by 2002:a17:90b:1c07:b0:335:2a21:69db with SMTP id
 98e67ed59e1d1-33b51161d5emr4177448a91.10.1759929411387; Wed, 08 Oct 2025
 06:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7xRYnSgN2qauMPHT54uV5PB7z+8DO1=PPOtT68so6=4g@mail.gmail.com>
 <20251007180906.507115-1-nvraxn@gmail.com> <CAEjxPJ6rpJNpFviGHDiJsx_A_APdMTOS9Nyr0mcfT5YCWUtfvQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6rpJNpFviGHDiJsx_A_APdMTOS9Nyr0mcfT5YCWUtfvQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Oct 2025 09:16:39 -0400
X-Gm-Features: AS18NWBDsB-v_UJ6D-mz6BQVcWZ3ZltQoS4uZD4OcLRAKegjBvPvsKg-5qoY6mE
Message-ID: <CAEjxPJ7ZmwEKwFQmWaZ0QTsrj2NgyvH9AP94bweaXveP1ndkBw@mail.gmail.com>
Subject: Re: [PATCH v7] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 2:09=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
> >
> > For some reason, rm is invoked via system (3) to cleanup the runtime
> > temp directory.  This really isn't all that robust, *especially* given
> > that seunshare is supposed to be a security boundary.  Instead do this
> > using libc, the API designed to be used within C programs.
> >
> > Also make sure that we don't follow symbolic links; the input being
> > deleted is untrusted, and hence a malicious symbolic link may be placed
> > outside of the sandbox.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> 7th time's the charm ;)
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
