Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC013BED71
	for <selinux@vger.kernel.org>; Mon,  9 Mar 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060680; cv=pass; b=G6OSoC46oRISuWnCeVZGEiwF2epmQjU1DfcKWvge5eCJB0suA3ppQtfGUhJC/vVGr/eyK4U9f0CCK1lFvLFjNmxOua9/Enc2sqaQLuqNF/vdxplF65A8XxPchVP/uh3p9AUX88Rn6FxrJhFhuqJ7v0Xo94QarETRguPvnkDpeYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060680; c=relaxed/simple;
	bh=KLPLYZ4DRnlGSt0geno7nczmOBALdwCOhXCwvElI9bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtJAvdMoIJjudQYodZipq+mI3UAvxXTWXDjAaADPhKMFPtNOyydALIAJynMUxmti09bWKkCnMCBd2J91TTbcf79Rqbnzj0cYt2/C0dgKzT74EUFTR1xYQBZW/sGPVuSeOYIHq+NkbjGM9HSNj3jtqnsVtgAZG5C90ustC6CMpXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtrWt27G; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtrWt27G"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3597c40a838so3405806a91.1
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2026 05:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773060677; cv=none;
        d=google.com; s=arc-20240605;
        b=R56V9pG8L6HaE1t/qqcQvpRXat7l/cxwmetI/Z44c0WpzqREKu6tR+GHU+PlThfVEW
         3erzeFTWFZ5TG8bAFb5XrtyeKQ1Hw9yQi3tnBADB+2/IWtlJ9aWxnQ+TRqND6yzZPFF7
         eiSW11e66orwM0oKurR9sjQrFyy2WwofeUjnGbDtTX+e0SjU54mvYBhzA9OPbLTvXSAF
         4KF508O0YcELHEQn+j1qhPwCOoPMb+sXrfIg7h6NjQF/UvOaRYhEbc9yzztqpQd1QwjT
         1C2yH7ZkhMlLhooEIk/5yjpC003O6uVXO3cGS4JwGTvs5RDVfDknqxXPCEsx/i9A9+zH
         JMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQhiB2TsIP53zhyx0dRAWIHcQmatIF9DH9vkNNVPm+Y=;
        fh=x2Mhf3hCaWx+ktIpQCoss3dkJF3mceq6IEg7nlK3baY=;
        b=GTwsZKAP+cvDWMkS+NJ1wsRCJ1jkqRcFTLgB4kYkpUJzpJPkqhu0IdSH/Ygu6ljakx
         gAgc0Rr1NMhssKg3cwg2t2dNdqbRbIDxSbKILj+ADoH4y7RT2JKRBY86Ac5gCB0r2/wg
         b9d1LZlYs59Ih5acsZNCPA1HWFZ4uxeBm/lIDrYB1tJbm33vMwsF3UBo/spLyIodeJas
         yUTsXS9ljvkc1I/d/hNOHVyEK82MsZpuE4lWOgSqdrCNOyc2kgcIbjyjp62VvKvKgjAx
         JCS8SyCJS/FnIzToouDfrFx/nes9kWFQlKppQLw2m4sNjQKUCKyXTWvAC4tk3BOgyc6X
         wv0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773060677; x=1773665477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQhiB2TsIP53zhyx0dRAWIHcQmatIF9DH9vkNNVPm+Y=;
        b=PtrWt27G3HwXtILDmR6BYVuglsKx1R0tuO+D8zWxjC3EEicC49klxqqjTU3JRU601+
         yFfk/gb3sS241gaoE7wHrw/7P6cPorIZDIpbn3bmHIrGpFVEby4U2K9eN5jYUiMKIuAd
         SjY0KCN9KhYKPatT6Bn3rdK5HjAYvqUGiZKhMebF09KC9uzHoHsv1WOynIrPXZOEKEY1
         WZRiJQUrmazSxlVVae2DTLBW9EUEauvTmRXG0ijkd+jlFlrSW4ne9GnNE7SWyrzp+MhH
         CWpGrH83lDlx5sHhAXrgWCeXy0p+o42/WXiyKiJl0jDvCRlqsdiiGQZBa02zys+1/ZmB
         GAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060677; x=1773665477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQhiB2TsIP53zhyx0dRAWIHcQmatIF9DH9vkNNVPm+Y=;
        b=iaqlxdH4bagR1U8xuKOgrw4BEDo9DYfapU3FcZBNHaLz6GLzcywW9gaxTmaMAG6rSW
         IvSRYK/lKJliLerKKPTFZleUe+lB8w3uUWs88ybR2af84G6wWncMdppGcIoCrrqUs761
         1wVW1uRqkFfANZ/Bt5aB+sqSsqJ08ClTfuDCXtEn+oiVE2/vBuU+EXbkTPkzZ8IhjLT8
         WhSJnBXIDJmLbBK4Dgx2qGnT4NRqT4YBnGvff0oD4YtRuGhcK/TjNKO3c7Z7WUUuPhFd
         8pjBU2Y8KzYZaZv0Pww0AAipWYxgH9uyHt75xluCnG2IdzF6et8URFzhxhFc1QhPxa0Z
         Fdiw==
X-Gm-Message-State: AOJu0YxAx6jVkNi0HSTPtn3nS+O+Ywyivq4DpahC4RTyoVibNAtaaAoM
	JhnYmVocUiJtOj7rfO/7WXMrEWiAg860YBBPCb0vrB+cj1oLou7E67r1Z4uwpldJg/BA0bLmP+o
	yW9pCfSjvOEa+hA3z+idHeOeyG8UTHds=
X-Gm-Gg: ATEYQzyx9dy88B5lH7lSFcjWSXHXutrYCm+UKYB2pbvyWrnwscmWQpyPZbzCqb2M2qp
	9RRsmrPuWB55uFLTwMRQ2rerg5F/m0D0y8Itu7M3ZR3zP1HPvj27g2QN7w/YISusNqg2/n1cocT
	qzqgDsKxws7QByW4ga2kQwnW/pG5+tLV/GH7fe2TBDaSCwSdWzqZ05qpmJr2yiMg01USp7lA9nZ
	3q4RdCCYyU3NViVZSdbk0juB0Nt6JCAWXtWv1pTN+xUgwKyhaqIqCzUMdIwbDE9TvRsnOGunGiU
	xH9uW74=
X-Received: by 2002:a17:90b:2891:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-359be32bc8amr10072726a91.16.1773060677534; Mon, 09 Mar 2026
 05:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302232439.1930003-1-tweek@google.com>
In-Reply-To: <20260302232439.1930003-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Mar 2026 08:51:06 -0400
X-Gm-Features: AaiRm50UJq_wIJwnVpn6tU_WslwEKARjWfHvuUGLymJmI5EFfK3xTxwlVi4FJis
Message-ID: <CAEjxPJ5JOv6wOCoBxcP1352QJOw5tzpvU2F3yCs6_EARc0g1Ew@mail.gmail.com>
Subject: Re: [PATCH testsuite] Add tests for selabel_file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	James Carter <jwcart2@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:25=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Add basic set of tests to validate the behaviour of the selabel_file
> backend. The parsing and usage of file_contexts is confirmed, in the
> following scenarios:
>
>  - selabel_open with no options,
>  - selabel_open with a NULL SELABEL_OPT_PATH,
>  - selabel_open with a valid SELABEL_OPT_PATH,
>  - selabel_open with a valid SELABEL_OPT_PATH and SELABEL_OPT_BASEONLY,
>  - selabel_open with SELABEL_OPT_VALIDATE and known types,
>  - selabel_open with SELABEL_OPT_VALIDATE and unknown types.
>
> Validate that substitutions and local customizations are loaded
> according to selabel_file(5).
> ---
> Some more context on this change: we are currently trying to upstream
> some of our internal changes to libselinux. A major difference is our
> support for multiple SELABEL_OPT_PATH options which was discussed in
> [1]. The intent is to follow up with an updated patch and tests which
> will build on this commit.
>
> It is not clear to me if this is the best location for these tests. Some
> could be implemented directly in libselinux, but the ability to load a
> test policy was required to confirm the behaviour of
> SELABEL_OPT_VALIDATE.

Currently this produces output during a make test:
file_contexts/test .......... 1/4 file_contexts/f1.fc: line 1 has
invalid context system_u:object_r:rootfs:s0
file_contexts/f1.fc: line 1 has invalid context system_u:object_r:rootfs:s0
file_contexts/test .......... ok

We generally suppress such expected output during make test runs and
only show extra output on test failures.
