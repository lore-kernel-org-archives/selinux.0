Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDA43D4E3
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517855; cv=pass; b=X+7CXKkZgT25FmOWPwI2Wfh/us7w16c80yx/JoVn6GwXFf2SzIqxXn7DBBP9YvdWUVMDsQ+R5/m3q0o0+53fkGbXeyzhREk1MIMEim/69Duo4nPz5NVKuabt5NtuY8xXODh+1iGlQaAV3VOCTiGX1tbdyVdUZ/T5WyCX1IAMCHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517855; c=relaxed/simple;
	bh=XAY4deVbL6PCLq4OnUQxczq962wpm8oqdaEYtqHZHa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMGPokE3wUF6lZ7yB04atT4v0A4UH4KM0q4srJQWMMJxEGqEz7obY81GB1KrHDsUUQ517m4vL/blJd9h5t7Ur1+A29KQ/qrnNpqVm+5d9aGwgKBruCxnTv7zvzYPe0W2XvfLWQ8p/vZgUxOn4yv7lTVI5909qyEOBpOh5jN/w+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsWAgSJ8; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsWAgSJ8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366087480d8so4120068a91.3
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 09:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778517851; cv=none;
        d=google.com; s=arc-20240605;
        b=KKvxwXuQSIeEAuIrfFHlf6/lDxlBy6vPP3OPEFSxcArLMAg48tQfefqp4q7/V5fi0d
         CM/15G+AZNJUm1OZKit6M3eCmDCS7vTkldvOmmGqGrdXKF0zmEaEJuT/J1czEOvNNiFr
         rHh/9oGmFOWJSUjFvGWwG1au3HBrwyP1rCEVtFLqyxJLx3xSzxMfSiGpbqxIz0V2atcv
         kekHk8IJmwB6MVUDigGTByt2rOJ9KiUNFtvMNrGGFMlc+GmbEUkpCiQDXIwDBAJHOEYB
         M0Hu0WEG7xHBTXimS2i0etUQsA83PjhO5kFmpACZ2k1dzPmZqTf+SHllczhx6UqsRpA2
         QszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XAY4deVbL6PCLq4OnUQxczq962wpm8oqdaEYtqHZHa8=;
        fh=EnFE7FVktvLek9Z1xwHkSXm4rPNtIClBcbGNqbB8kvE=;
        b=Vy8XwUVB+5EM3aoeG5lJDa3G2tsFZEE6mSsF2vjzraxk5/2MYFUyHatl6dS54ygNO7
         JLCVjoL+NpD/pgv0RqHINZNE5HFtSS3xSzXqM20fWacuikGMoOgnmmsmG9EiMuhd8KG0
         ujAB2SRF4MiPE7neuISufft1L3HdA2rTVEGcI/gWAYjw3yREXqLBNGf9gakNeiXc1ZyT
         4BchnykjWX7SivCCt0qjykEWsY3zSDX9dvBZTw6YUC4ibSYfGm5JhzkR7vX+jPTQ2wY4
         GwS3msZx+5rHI4tksFg5g77WtTFYBAjqGhY1i9hHXjUucGrI6Poo6NQlDjE4LiJsDNZz
         uteA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517851; x=1779122651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAY4deVbL6PCLq4OnUQxczq962wpm8oqdaEYtqHZHa8=;
        b=ZsWAgSJ8V+EpNFZzFJu2Sm+LkFwAWjXxQsm3/CvSFKHt3kyN7mfswNYxRyOCoh0LPf
         ZM7qPaDkybjhjMH+ShUSFBZY2HjcN/R3Vsv0BHCcxTJkr7ogHhvhTkqF4k5HZwdfF5JG
         k7XL2S4YGHRZgBzI3q7piy2gNzFUW5ktcFayqvHmonav/xwYZXX371Dx5aE/YtkD5hNN
         EJoal/Upyod3BI9Y86pSAMKCyYwdQ5E3w0YkTXpQCnOFXd3J7taOaP3CjrMWDFwMps2O
         iZCqpczalXR3XGq33W4mcO30dB6SktFCO0mZ4D6C0BlZUHMZDNgKRpEvBSqfy7/AXkgZ
         SFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517851; x=1779122651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XAY4deVbL6PCLq4OnUQxczq962wpm8oqdaEYtqHZHa8=;
        b=jTPDRattXPvb6OjFz8TDPemLBRdkf5FlSU4yfA+5tkYJVXsNCevTyBPocg+YSyrVwF
         t9umWOm7d0igf7XY1Ws+DROU/wQLY2s90qBKOjU9w1k3bkUuGjRjZEiLsttgLyxomO3o
         ATxbm0PEBEW6IUniIbcGQwXQ+l4yIXegqy3ckVBdgpHUuV0Otes3NM2Crd7SA1rOGbWl
         K2eW42IXY7ZgR3aOBRmiDcUDNQMSXYfWgcOcS6qn7TkDxQE7wPYhBeO8Ofoy9VKzZF/s
         o5MIGmvn76Zm+j+PkAAqPpJO2KBbj4V3ZQauWkcl+nSSN0EreLi9JNtUijCHNM8+OtYe
         TdfQ==
X-Gm-Message-State: AOJu0YxjCOLDg/lmcmkB6gfQoRw6F2aEb5i9w2gBhwxUcsitiGGzrZ9N
	VDOxHZHkpbI5oFshoZfNVkVu27MAL5cShIEHfBjzCR3eky0gyXrYO+9Svx/UKQyoGaP1QJ9TXjc
	cvAOFAv+95IEpzpS3tc/mgYqcqAAgGL4=
X-Gm-Gg: Acq92OE/B/ujLvWNfSRh2JJjBSm5sHOcIflJP4L9sxJonv2qklhSMNF23Qt1cmpjldQ
	h7ojzN343qBv6rUn/Ky/JTQI8E06ymUJ8z/I/Nq0aek0X2aPMNUJ6mlLiNvFlRBVjtfnyAhXEmL
	q/CV0o07LajBYYwg3OdYIhvQ7pyHDQowKkkciLWnBVEe00U8G5SJavIYCfDcn1Bmtz2AYHwb3bT
	fZZHtlGcI3wUNMu0I7YEdXmje4KCsWIyjtsNNsw6M1Ibl5HfoaYgnnx612N4fN4Fzpq6u4PeocS
	HeJlT0v7rQ7bQbjo9A==
X-Received: by 2002:a17:90b:3149:b0:367:cb53:7438 with SMTP id
 98e67ed59e1d1-367cb53764cmr11887699a91.15.1778517851266; Mon, 11 May 2026
 09:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304200238.26493-2-stephen.smalley.work@gmail.com> <87o6j952cu.fsf@redhat.com>
In-Reply-To: <87o6j952cu.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 11 May 2026 12:44:00 -0400
X-Gm-Features: AVHnY4L4eNiI9Ld51gNOmIRzobNmnO5QEHo6025Ef1-5Fqd_UeaLCeTi6R08XnE
Message-ID: <CAEjxPJ77Y5s5bS1JeMHU7PJJG54sMp85V78YVQ0mHnBsDF1O4Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Do not fall back to /selinux on a sysfs mount failure
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 7:43=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > Even if we cannot mount sysfs ourselves (e.g. in a user namespace),
> > we can still try to mount on /sys/fs/selinux first prior to falling
> > back to /selinux.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

I went ahead and merged this.
