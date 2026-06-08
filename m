Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A063E0220
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943603; cv=pass; b=l81vMpDCml4tMD2xVWQ/u8Mm4QRNhmZt+RVGbK2R47D7b+eyLnyTkWERr0+oLFJ0OLO3jha4NLkawVW0yE0TQT6C6svvchOrqheA49iaQJsAi8IWfyjSxSK5MEGFXT+xlUplUjEb3YhC/sT7KJqZQMnGGfU7AhCsiUaHmkfncyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943603; c=relaxed/simple;
	bh=ZjOa7vVSu+e1HhA3PcQX0AaGjHwxoi8IUzTkBgPUOpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJKM6PCRYYq7pVLtVvER02F5VzSAQBMpIDD3r63SkJ6Njd0t0FkrwZKEgu3YiDIN30mbdvmXwnfCVbNbUqQUBnjDkO773h//KXpgyyr3N1BXH+jPAmnBVqZpY5x2bvAsssdDnhhKFaLMV6f9pQHE9sCtvINWazTII1Wbrnn7J5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIK2Y9tO; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIK2Y9tO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so3301289a91.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 11:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780943602; cv=none;
        d=google.com; s=arc-20240605;
        b=iM2F6QHjAsQq5sf0CBWlp5aL2jUFdysQtc8DHYXjbcyYj8X1TAbwxz4C3EY7eUK0ky
         s9isRdpoe+DZIX4qYfW6dpscoeZhneKToFS/D58+mFMmkqkFGA9Rjrb5CSabNa8yhB82
         8B97N5FEyjUT0bGB0Bx7D8EXclmJKUdTHewW/kFsFPIf310fe0xJQxvG0C7CosxlACru
         DQfZIatTdrdPbRHjGXyREbsuBzQmRFlE4IebDikcjsPWI24XFF/f/0482dA6EUkaU/Vr
         UlsxNYXfPM1nJ+VGC+B5LYlEQwX9QA7a2M8qKBxbYqAVF3uGiU5UkHd7dL2mhYBLvwe5
         T9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5pkOqTmXUMCtLHQxqtnXH1twL/c703U1/n27W9aSJQ=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=lbiFgq1GhYxh0UMoe+C+TxKeEX4x4xfaiXscgFOSNpEuPUZHMSZvNg3vbymRfDN2NA
         kbpwPpAsf+PfsU5y8BD9EdA+OrsSQU+hnK5MCmxA2CuNAgzlzEN7cBbbf6Sq4py23HgB
         JTPi/R7nequJwepDk7iYXAF1zQnRDyR2ZRuXASOyymMwdDqJOLLPnPKw4dK3K/FXZ/6S
         i84j5nm5h6L8WW3zukFPx08FAr1x4XYP9Iffl72T2GK4TmjU7on+y4Mim3sdw6EGLall
         DhPqQYUs+H5Hpo+lz8bGCh8hMuEO98Le7Azv/ggP8Fjo+msCSQnhUcOMJXYcJC2JSBEk
         ddqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780943602; x=1781548402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5pkOqTmXUMCtLHQxqtnXH1twL/c703U1/n27W9aSJQ=;
        b=bIK2Y9tO+laBsgOuofCs1PuhLTxYYngMBseL627BH5SmqfW0oocccP7zRaUWbzuYdb
         LGrkFtPR4t5dPGCZtg5dnmvaEdmYE1sHmQq9VCRX98aNyuxomDNOiuykPlpzA7DbrwD2
         kIMIYg/Y+764aEQL5iWijlpdhWM5WAvNvb7j17DRmT0cyAiEGubnw9ouTbdTCYueO087
         Pu3JopcF5GUBAIqb3kk/p26XCaPDftbxkPMI0l7K8WLFDayOP92uc+pp35cJ3r8jvvCY
         AJfVvYcEQah0rvEvZvaPGqg0SHbYFTGHZXAxVuN8e8FDwvtsyYHlscGLr1P2n4NmiQ6K
         6ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943602; x=1781548402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5pkOqTmXUMCtLHQxqtnXH1twL/c703U1/n27W9aSJQ=;
        b=EU06i3X2N8QiJpMB/yyv5/+rYy0YEW47QTgUWJjQai/ADSXMGdAJmBS7y/EVah/NBD
         CkEiu/YZOi6cya8tzOFNFj3dbyHrpg4lsXju81w+bfrPo0QLjv7mFutUlkXmQmKr2B2t
         uq4rN0if4YxJttpAYm6uLvMtMrlVm8IP5sjdek8WSyCQGr/t5AjMErJ4+w4JiJbdk3Af
         HpBLr+gzhNwwVgDLXF24+z+eI23jg/ePReRm64ZdrjozI9KA/vUlm86l1K9826AqXYB6
         tZvOOFZoL3uG3F+Dl2rY8tvfwSa82HWCP8RB7AxUwfrlme7zuPq7y/QTuXftyS733AcG
         IOBA==
X-Gm-Message-State: AOJu0YwcP5kHoYI53/pkQXYjb4Wa9FXmvWypf+3RZlhlBR7opfujgZWZ
	DuLzsySbv9y7kc2TgiAIHEAsbXO9d29f5K03lSh/8Q1BJRUlqx7gIueOfCOtuABRcy4c7w6OvG7
	HsA/jt3p5E97LI/BeePQ8DMusdgUoxof9C4NK
X-Gm-Gg: Acq92OGE3CYwikhECs18b60cBwp/L9cnIXkJuOJmbaWgQrY3fhJMdhekYsqa9C5kyP5
	onVeUGZWFzq3mVXJxd0Ia69Lb7TUC4mrwZJO92LYgBtR2HzjGPy5rwYYGuY1rfdZNRDxGQpUuAg
	U0slxHJURa9Aa9+nN3mYSfxMGwVsId/v7F9SnwziVufmzcWDx3HUh+gGZLlVcsWcuxnFreyTgAo
	A8IJ8Lmzdw6kvLqxd4hENrZJ67M48bzmwn3KyyBJjax8C1NyopxNRNA6PP+S1V4f3/Kh1DtRoe1
	RAZFsybo957h5ql72mgj37gl8fWd
X-Received: by 2002:a17:90b:5285:b0:370:aa94:1662 with SMTP id
 98e67ed59e1d1-371325b7e6cmr11771381a91.9.1780943602041; Mon, 08 Jun 2026
 11:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608171652.314902-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608171652.314902-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Jun 2026 14:33:09 -0400
X-Gm-Features: AVVi8CeOdjxCXhHAleTijJx1qwslHhADHqw5BR9Qh2O5qbY8OXFWlalKnBUtTnI
Message-ID: <CAEjxPJ52DM1j7HjUSajv0=eTqZYxecjerA2q_phR+GYP++m6SQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: sha1: prevent overflow in Sha1Update()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:17=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> With 32-bit i/j and a BufferSize =3D=3D UINT32_MAX (passed by
> digest_gen_hash() if the specfile buffer exceeds UINT32_MAX),
> the (j + BufferSize) > 63 and (i + 63) < BufferSize) can both
> wrap. Extend them to be 64-bit to avoid such overflows.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  libselinux/src/sha1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
> index 279625ee..02e05811 100644
> --- a/libselinux/src/sha1.c
> +++ b/libselinux/src/sha1.c
> @@ -226,8 +226,8 @@ void Sha1Initialise(Sha1Context *Context)
>  ////////////////////////////////////////////////////////////////////////=
///////////////////////////////////////////////
>  void Sha1Update(Sha1Context *Context, const void *Buffer, uint32_t Buffe=
rSize)
>  {
> -       uint32_t i;
> -       uint32_t j;
> +       uint64_t i;
> +       uint64_t j;
>
>         j =3D (Context->Count[0] >> 3) & 63;
>         if ((Context->Count[0] +=3D BufferSize << 3) < (BufferSize << 3))=
 {

This one isn't needed if we take the following instead:
https://lore.kernel.org/selinux/20260608182911.318358-1-stephen.smalley.wor=
k@gmail.com/T/#u

That one is necessary regardless and will prevent this case from being poss=
ible.
