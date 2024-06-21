Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AA2E417
	for <selinux@vger.kernel.org>; Fri, 21 Jun 2024 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993273; cv=none; b=sTY/5IL2atlt6UtLpbhsxGLnEFnyiT6XAStAhpQdaS/oqMuQ7aXmVLmAxvqM5UGI2A4wjTvS8Xszc/R8GQUAacM0mmm3MU8Wuf+aS95Oe9iHAo+bEBR/Tx7Hl3XR/UmM9x3h9Ay1x5fRFMVZ9QndRifFBMvNTpyI12WseZPKKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993273; c=relaxed/simple;
	bh=RlPKWEi8htN/l6/tfDoQEXpM5mYznCWO6uKrhOgTaGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=actiYCyq2raBh5Iq8fwrwakKrP0++jb5uvMHbta13AZcC6fLLKAGxXh3C1Qq8lxKypXyKSIek0kWtQj5oXW4Sq0/GDiMMcdAOjonYEnI9PM4SeUePx5JxFkkd06SkA8weUFBxdsbD4X96jTSCFCzYwHZMh8Aaxj+azbNUagVmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP93ucvY; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP93ucvY"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d2472450d6so1237341b6e.3
        for <selinux@vger.kernel.org>; Fri, 21 Jun 2024 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718993271; x=1719598071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZCCop1XpYxdWOLbpuSJGzEkDNmJEA6bUFkfSelb7ok=;
        b=GP93ucvYfqL7DBYu2iX7uuL+6pDOQXIF4S2mra2Vx1iEqzf4yhhVRn6EkbA1q9BRMG
         +dDkggIbS5R/aqvsfmzK996IA8QMr4CNSqEJdI9hFP8pUp5gTXZFg98LU4gtXJwRzEbx
         JVwRGXst7kF5KloxIXlYZ4mTspB4WWST8c66M4qbT+7j3rS5uPJw2dTimJfZzmzbjrGz
         8C7Bu15YduqUczMAYR74Yt3McevJayJ8thS6LOhEiom/Z8McmXl23OaHENKXDZ5tD0YQ
         EGMS+tnoSawfJuw+Qnz41lq8rdcWsPtbakmrQKt0AJDBoCyJxvZYhjtbTMwfbFxS2Tvr
         kKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993271; x=1719598071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZCCop1XpYxdWOLbpuSJGzEkDNmJEA6bUFkfSelb7ok=;
        b=FZE7yC0zydGeFcDHgS9wo0IBETM+4LIpbwqxkz7Z2l8zspILyJfR07Lu++KiKizD1X
         eNb/xbedGX3t7Qa1m2TneNclJSOqBGjvYK/jfEdQzrixHiziKTmvE3Yq6yf50ZdLgLUj
         F9P0I/uNb9IMKOPDdTK/0W/pKmqDbxlvi6wJ6JdxoUu+iXLwPAQx7thdgbI4ElHmzxfi
         7ElgAYTGEsFnHQ+6tLAxF8FOlO4Tp4SVaafr6JhqTmRfH0w3TPc/bmRNMmF/1DT+/UaV
         EfmsU9Y9RWLflh/BsWJmkDbIdgfVON8kQ4BdgE3gpca7Mt+mZm8+pT6LPYL0ghh84BRx
         hNvg==
X-Gm-Message-State: AOJu0YwKnNSzs1++jDLoE4cI4IdakApar6XoU2myqwq7Ypg/hCpH82hU
	xM6p7wb+BOq6Dl9kvL9+eQQgL+w9gI11aFFSkRwMO2DqXrjidV2PSHy9lu1ilcCv+EBHF8gXaNS
	/TFp65u7e6kSDtS2NpShIGrdU7ZPFGw==
X-Google-Smtp-Source: AGHT+IHmgjh1fELNl17g1TMF9bZtfEUWBCocWoOq3AUixlOBSl797kNNUCpiCY2GuczO2BxMifGTF62BrKqsTBvf8kQ=
X-Received: by 2002:a05:6808:238e:b0:3d2:1bf6:c572 with SMTP id
 5614622812f47-3d51b97b690mr10651306b6e.4.1718993270645; Fri, 21 Jun 2024
 11:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614194500.631810-1-jwcart2@gmail.com> <CAJ2a_Dderor=tkxK9YDNN9r_xb-rpcSHXJcBiCf0nMuhakBUoQ@mail.gmail.com>
 <87bk409bq5.fsf@redhat.com>
In-Reply-To: <87bk409bq5.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 21 Jun 2024 14:07:37 -0400
Message-ID: <CAP+JOzS+zNB8kV1Va_9YhzN2KpeYKwY5w-Eh5LEd1F1SO0y6Bg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Do not reject all type rules in conditionals
 when validating
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:10=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
> > On Fri, 14 Jun 2024 at 21:45, James Carter <jwcart2@gmail.com> wrote:
> >>
> >> Commit 1c91bc84 ("libsepol: reject self flag in type rules in old
> >> policies") actually rejects all type rules in conditionals in modular
> >> policies prior to version 21 (MOD_POLICYDB_VERSION_SELF_TYPETRANS).
> >>
> >> The problem is because of fall-through in a switch statement when
> >> the avrule flags are 0. Instead, break rather than fall-through when
> >> avrule flags are 0.
> >
> > Thanks for spotting this.
> > I'am probably going to look to enhance the downgrade unit test for the
> > next validate updates...
> >
> > Reviewed-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

This has been merged.
Thanks,
Jim

>
>
> >
> >> ---
> >>  libsepol/src/policydb_validate.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_=
validate.c
> >> index 9746f562..2043e437 100644
> >> --- a/libsepol/src/policydb_validate.c
> >> +++ b/libsepol/src/policydb_validate.c
> >> @@ -1076,6 +1076,7 @@ static int validate_avrules(sepol_handle_t *hand=
le, const avrule_t *avrule, int
> >>
> >>                 switch(avrule->flags) {
> >>                 case 0:
> >> +                       break;
> >>                 case RULE_SELF:
> >>                         if (p->policyvers !=3D POLICY_KERN &&
> >>                             p->policyvers < MOD_POLICYDB_VERSION_SELF_=
TYPETRANS &&
> >> --
> >> 2.45.2
> >>
>
