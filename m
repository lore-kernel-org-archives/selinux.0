Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182A424D73
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537392; cv=pass; b=caZp7utQqt2YT4ZfW3zNGdCrXJyyOVqrq5ji5BUdjdBeJ+RwIlgTlH0zJFHZ5DBdy7h3Ga9W0kBaotBS/vso1z4W3LIIR3yDUPNSk7npWVbkI3b5MgZ5iOSXjGPmrHrbBMpXqhEIX91XfLmmaA28lOaXsWoIDsJ9aQU3Ck48LQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537392; c=relaxed/simple;
	bh=NHR0tmL6icefGmnQ6pQB02sOwiMI0ld4+DujvcR7HcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0GH+I/ZyoazzuGJnbNPpZDM253Ro4LgZZNOPnR3sZbqAggCpK10b1WSx7L7gZElhM2PD6+KHyV51EWzY6MWp3AY6nc/YJdkY4C4O37NI070hjjjsZflFcktvVTEyfrqXMyAtgwjbdW/CYB+pO54PHiyhm7HA0Jj+rPNUP3sDGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYn3X5zD; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYn3X5zD"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-446f87b6de1so861790fac.3
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 05:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786537389; cv=none;
        d=google.com; s=arc-20260327;
        b=dH49XrUNPkBRzvW2avhTfGIUJ/0dBYXWUv2PuEiC6ocTt6emRpy+Jdxa4/lXHhNoPA
         jRG0gYh4Xw7FPN3LABtvcOjTxqXaCoyAxF3SETFm4+FGitQXcBwtd1uKLlgIS17hE3xr
         MtNSaIjvTDmVB6B2zOjwv0wWzfrnHCJjNIxJsb76zQHy6Vp0020jAavFuyYzZLubL3iV
         jg0gAZqc8wBhe+6z1pI4voK4Y4GSYpEJO7eo9cxNJQy2eOZtLMVL7X2Z+1dAQl6yJu2U
         YLoPidp+rYxJ0W9F0E0wfADMbpSAcMkj7mkda1IuGuVS7DPAfKIoa1rEvuC7UDU0TCkA
         9yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHR0tmL6icefGmnQ6pQB02sOwiMI0ld4+DujvcR7HcU=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=OlgSane7SDoRRXdaH9LhkKsDOJLrYJ2s0XP3LnHmFQv57G0okOmMKSkGzxvy4VsgsC
         sfyFMuw1+lWA7olXosjKN+gM41DSSlGdkEy1PQIvQ7xSxsBuxIBTwf65Obe33ESajjiY
         djpLtsipwVXQ5Cb1dSZ+G7y6k92LJ2/BkQaA9RlTIF04eHrhyF5R8auhI4DK2NWDkzTT
         oTxuvLfH37HyVQzMl+QXHN+pnYHQxlgwfGTIQClEOAtVWLWqLSJvz5S6lFKU+iLSd+N+
         8kxAKZAm2fpz6ea6Yjoh4FEbFI5PwFPIANk1ZYK3JzcDNs81Wroy4kKVWnjKhqrtbs34
         oNBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537389; x=1787142189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHR0tmL6icefGmnQ6pQB02sOwiMI0ld4+DujvcR7HcU=;
        b=SYn3X5zDsJUgRw5FjmbVjU6H7oV+7wAP3aBbR0AMivlvSV8Bc1xHUFnAK8vNWU7V4a
         R+sYdFfgzD0uOOHI9elI90lQdu7CuAEaJS3lNsgCmbQFhl+4kMg9pV9FMBMeQM9aXe2P
         3cj4L5Bc3N8jVF8Ff39MHakU9H89XJqg5h9YM4FVAwgvBIKC25IH37QzU8JV5Yuvr86C
         oAVzSLbvKzCrWSjaGAih6WT6yAAITMigazLt5aGkSIFPG6elMumQl0VTzi7kcTTV2w92
         z4pCJcbaCMoQMuZ606puxjkEMyF5XrMB9B6ymNPzqFHi7LSr9uxOreB/2N/H7TmrKhU8
         1/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537389; x=1787142189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHR0tmL6icefGmnQ6pQB02sOwiMI0ld4+DujvcR7HcU=;
        b=MXEj7Zu6ymHk1mNgnRRhCQpc1wpK7eoWsCZttE/DTt0LJkKw9biau0yRLPYEEBqM9c
         00EQ1U2rpLTuX8u+tTwHmJ3F1NGCWoJG1fcW2HhV4nx7qyg9dCN8H25WFQ/+8g60bTXU
         MHBH9zRDs+gKRD1Hr7Ao3AVBbeK3MWjUqPDasbDxRdPbLT9pSO0r69rFWejh33PigEYh
         S87LejNgpbagGbjoWezHLBnxV15NSkFUq9aMcsc4JiPAowTd6EqxGu5YqcZ88Qb/o2Gh
         MguNKq3QJtpqqxxf6bxmBku71B5ELY1PyUVXYbQNqs05o8n8aTqSxbjUf8BkggqLWTGW
         qy6g==
X-Gm-Message-State: AOJu0YxPvevsb5I/EACN2BigiefwWdtwjNRn6d60bFOteHPALPnn4u73
	bPfp7hCVwHrbw04MLtQ+Nu0KXSBSZbOWgcJ/dDQXeysTx6Z6ae1uo5TnZSUkW7z8KAmdr3kJdRr
	4xOmogQH7b5CpZOM+XBWavAZkTdK8oD0=
X-Gm-Gg: AR+sD13rVO/F3l/FLQvq/4dsPRZ79UQ65/Ff//UiC8gpUa+vzhNEhPx/ziCVkVziJqA
	gPwOQWsibG2tXscAXmJc1Sp24j6QrygGshw4EXu8WvlYmmaKG/N6caSFtMwer7IMKDY2bwzp+Xj
	4C78/jQbzqyKtUNnJuyyaUXKU8tO4hO8rJrbuITQFxs7U7DgZiyrGFANXJv3TVNrUzWR7jPd+re
	pc+x8rMBRYq3nEPhBGfxWjogRkMoRS7TQSL+eP6uTM2QkeqqhUx/+aaDLtS4tvdmcCSFBKj2vcA
	BdZnpldCxS3NMvCFERWoThpzg/gZeF8hG4m3iMsCx3DafpOnWAQ4uRM=
X-Received: by 2002:a05:6871:824:b0:451:d77d:f2d5 with SMTP id
 586e51a60fabf-45e3ea4b596mr3685209fac.13.1786537389263; Wed, 12 Aug 2026
 05:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811123712.84028-1-stephen.smalley.work@gmail.com> <CAP+JOzRKSw6MKoKp_tGHNziznvgBQ8OOxLQT+=48kSzD4-EzWg@mail.gmail.com>
In-Reply-To: <CAP+JOzRKSw6MKoKp_tGHNziznvgBQ8OOxLQT+=48kSzD4-EzWg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 08:22:56 -0400
X-Gm-Features: AUfX_mwgJ8dGo8j02W5_ftORV2uk1e5TeK9dbt2J4gqRGbljF10dHIqtVhPMhR4
Message-ID: <CAEjxPJ7nBwEkofc0eQr-UNv6wMxNWFVFoG6Mn=oDum-EsBJSYA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: drop support for modular policy versions < 10
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:56=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Aug 11, 2026 at 8:37=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Drop support for modular policy versions < 10 (boundary alias, a bug
> > fix to the original boundary format in modular policy) to mirror what
> > was already done for the kernel policy versions. This brings a
> > consistent baseline across supported kernel and modular policy
> > versions.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
