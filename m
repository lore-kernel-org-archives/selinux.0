Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2544770F6
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285650; cv=none; b=sWnU7LYPXsjko7AcySYVvbbkgSW3d+s4KqOAS3rNHgvMt6QdP87hkVVafHvOT4W/oH8mrENcV5qUqxqNCcUmEWM4h9kyiTnZ+ablkEDQ/IAP9xkgtUoCg8jnUN+TXjpvXogQg9SmgjXqGacioyeQ7VKCWa5uFia1JgdJxpjLlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285650; c=relaxed/simple;
	bh=uvMm/YvV7rKKVvUlkwvjjo5zivb1VpW9LTG5evmKNPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ox0egLn0GmvI1CQzvalw6Imi5xq+CC3MyUWeaf0E6yewbSHnRfMe8u7v3TgEwFrDpZYYusmO2SeZdHXPwb1HFEMpKXSmCdTZ7Gn1AAzzgmwL3e3h1OiiaEQzcfho5uWpV+z6/bkd56C5oD7VpPVmNqkuwjyhJDG/Pqwz4vMzROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FdqSj10B; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FdqSj10B"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso1540717276.3
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722285648; x=1722890448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bpR9KnLTvNMzWB0BWL2SQvPz0QXhGOMr/3lSuaeXTQ=;
        b=FdqSj10B0dDtCoZyDs5DsDrdLj6cD2KpOfQFprbU7u5OGY/cwFAwkz0HUCAZ133eY9
         S90v9exM//OEC3YBtvMJPK7sn0+J6O+szoqYhVv+CjvRzndqlN0P5z2QlzQfDfYf+xxD
         7ekg58XTQDieQls0jpnvOIK33j/aG6a40P0BZpvHCwHQKV9nX54bv5G5k/IWsKGep6GZ
         aYWhBnIktsC7LVQPU98yu90nl+2ktjgznAtzJazyqqcUonH//ATQhSKYea9EEJQFMvb1
         G2XIgVOkE+JDY/2GidqfkJlmj5qK80PoRxJBC2Y4MwpJDWhjAA6WjQ7bWnK3OTso1Q17
         2MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285648; x=1722890448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bpR9KnLTvNMzWB0BWL2SQvPz0QXhGOMr/3lSuaeXTQ=;
        b=sdvEqT0NqHSZwutAeLym2KZ0KJMflhRhvg1R+Oqvsiec/85+3vIrvi7A3BVE9o4jOJ
         7enFQRnBkVKqa24LO0kYDUJbo02YSu5kyi5SBxo2vu9Az46foFsvppbc8ad4IN0H9Kdn
         cBQRkgMYkO0p4EEUk2zJF5q2FaEv/WP3HVY6LQH4rb/7/lCiF+aH3obNSaYUZLJk3YJ0
         SWpOQ07PioMm/PHjDyTPRar8lVl5+aUwJ9f7b6GLqcUcAacwGZu7mnQbG3n8UKtlysYm
         ix0bLoqrlWy5JI++LsvshR5RdALNSQb1o4aaQKsWy+NVvmJLNIysU7xsodybD2R0VB6g
         R27A==
X-Forwarded-Encrypted: i=1; AJvYcCX94ngqmIZdbJRuQBl5f7Okoh1n7ioK8JNz87fzupXIZbiSVTOMX9qfL27se5FOidHx5QcDCOD6+IgkuxMA9QYE6Omhgx9I8w==
X-Gm-Message-State: AOJu0Yw1guI5HVE9S2B4ukuSU+Nat7JxNJUKwh5L/qZPFze2S+SmuU/B
	IR4LEPZwUHi7L47kTAM3TmghBykWcswgsPyOUXp0mRGPtSm28P2P+n34OMatT8i3wmhHHtIQ6N4
	X1WJKR3DzVH2EAnidAeJUfO6jN1dxZPmCkL6h
X-Google-Smtp-Source: AGHT+IH/RYHLRtsIbNoS5UxA+C29Edpt1BbZP5oMRgdZ4SAsO2Sg3xRUkJVa30nfZFtKQ4Uo4xvBHPTCZyhOOGaUiN4=
X-Received: by 2002:a05:6902:2193:b0:e08:5c66:7d4d with SMTP id
 3f1490d57ef6-e0b54468fb4mr9258020276.16.1722285647835; Mon, 29 Jul 2024
 13:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703025605.63628-1-guocanfeng@uniontech.com> <CAHC9VhQ8y8fYeLz8KHXVNrLmp3cLZtUPHsagf3fym3gJvoTs3A@mail.gmail.com>
In-Reply-To: <CAHC9VhQ8y8fYeLz8KHXVNrLmp3cLZtUPHsagf3fym3gJvoTs3A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 16:40:36 -0400
Message-ID: <CAHC9VhRRG2vYsi38Qfe38DYk33GMp32bErNjq7iFfAp4tDw1+w@mail.gmail.com>
Subject: Re: [PATCH] selinux: Streamline type determination in security_compute_sid
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jul 2, 2024 at 10:56=E2=80=AFPM Canfeng Guo <guocanfeng@uniontech=
.com> wrote:
> >
> > Simplifies the logic for determining the security context type in
> > security_compute_sid, enhancing readability and efficiency.
> >
> > Consolidates default type assignment logic next to type transition
> > checks, removing redundancy and improving code flow.
> >
> > Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> > ---
> > v2:
> >    Modify the format to follow the generally accepted style for
> >    multi-line comments in the Linux kernel.
> > ---
> >  security/selinux/ss/services.c | 36 ++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 17 deletions(-)
>
> Thanks for the revised patch, it looks good to me, but it is too late
> in the development cycle to merge it into the selinux/dev branch; I'm
> going to merge it into selinux/dev-staging for testing and I'll move
> it to the selinux/dev branch after the upcoming merge window closes.

A quick note to let you know that this is now in the selinux/dev branch, th=
anks!

--=20
paul-moore.com
