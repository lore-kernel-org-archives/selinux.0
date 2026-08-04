Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AB4766AF
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861307; cv=pass; b=pgkWSyNhDIWdqqj8Uw3MOMYc/M/Gz6/x4k6JF+4VHBbHeGK9uaogkXpArz0yJctTKVfA4CYBJCz+XLgq2WQNy51q3qkqq+8ZNKgFrG3popipTbqzE/sN0SgWpd25EFeAnUU8Zb/AKoxadP8nuUSn5msRgStg1SnLIL2R2GJTeUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861307; c=relaxed/simple;
	bh=xRvc6x+8vsLAs7Z9mNxKlZ4gAAz9ZHVSVz0zBWwv+Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uxn4iGfmfngLRB5hC6zrpD+Qzlc/aHSfCi9W3tqV8cH3nCzFOPXimSKNCKIj3czdjv0g+R0NmOWgMsnZBBbBcc44wrDopIT21JgkP6vpi+Fyv7643AmGApxmD/IEImIAbetcVUYXEwCO/BhgW28T6zNZQV/gx/y9ALiRywD1mO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFwq54O3; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFwq54O3"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so444411fa.2
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 09:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785861299; cv=none;
        d=google.com; s=arc-20260327;
        b=ZCPPTx0aHxw6c+5Pf9HGSTyjG46p4iUD4t9MjJ4BvlSlwn1ziRjEITlzIQk5pg2yuW
         4GI3EKfVCAo+LbRLCEXvbsdye2vX/7a7lMD0SyAyBqrJA4OFvaPgURg4bpNX9lo7SRkd
         /0LePka+tXV9qnuH47AvWOAwxtoL3rVHdQIyiQWxOpzAnTG+3f73UzpZ00A+JKnExfqK
         ALhiyJkV5OBmMndrNyMkytvkhSOChd3BMPGmTsf1m9oMJXldn7ggude7WHuax+ESR4Tf
         RGtfI+UgrcQQxjnxR/82wBVAjQqsqCktIP7Q5zKr+CoINy0wrQc2n2Kx3tlsGvNXr6ad
         qEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xxVTIzhAqd/0otMnkRRZ0Ub2KVlpQEIj4STfde7oLMQ=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=d6UQ7VDk+KXwuW7djy0Rb3IgeqLZl6m5v6ldai3ifBvfK+qV6TInG/HEfuVwvXDwbP
         RkqqH5/4gpnVAzxLP6Aa6mS3wcCFZJA5aBw85BBKhkky9pObFovH20vi5h08x+FGBLcj
         2YAKKIGtNNb8hAvNtRyjRYBWvINAjCSzBU13GxMhO/MpEz9gbgxnFoxqnnyQ73d5wAgE
         dr/s4DxzhPQuy2pppwgC7f9c41Pdcr1pRSAvll0dRGq7N+UU4QURd/FQbG4M4kxGXVTj
         IHV9P/hqSYRD+V14zE+9dyp2/iXKRqOw8AIb7gqh+1KDUL1QncOWJC4Q6YmeXq0pUTAF
         yagw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785861299; x=1786466099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xxVTIzhAqd/0otMnkRRZ0Ub2KVlpQEIj4STfde7oLMQ=;
        b=XFwq54O3r81KO1bbh7g9kUQNx9kVC1aCr4bZNEjcoRMnO9/5feDUJb8RhHp6l1OJmx
         /eWmfQlr50zkuau0sVc0etcCdX9apliT+kYdF6hWfIfupe5MT54HSElZrrrRHBPECcbi
         k9LvROgZq3gTsaUCJhI76VR/d+dk+03vrmRRxVkaBcXS1OtTZQZ9CqQ0kMMNhSDIOLXv
         oGqzA0W/P/d/eYYImhSjOkbdwX1ZZi5+g7fuoU6egGN8tvhY36dB2pk+/6girClHFTz6
         Kp/zIUowsTsP2L/JEX7j/SMdVXvE48zszP1bLiACPoNFa0lq1+y4OtGPMFUKzZyFMZS+
         wPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785861299; x=1786466099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxVTIzhAqd/0otMnkRRZ0Ub2KVlpQEIj4STfde7oLMQ=;
        b=YV9rDjhLX1NITfbB6YEO/nih9sYEUl6FDi2AooNF3d9CNE8xtBTiAzbOH5DF2Haf9D
         35zXYw9fFXEaIFWi7REZr5fE7Om/YP+kdJWMHijd8OQQAZxNcfKcv9XBockbmPwFzMW7
         GYVlaXUaZpynqWBjK6UB5ddGw+xwbKwXYu5+jTZV+leAPjtvFTCbddv17uw5gtsh8TMV
         dCIt5dcHef3RVkUQY/iHmmr8jddYOHtEfDaV4PaP0sf9beBKIVZ4Gwbssp7LG/peuajK
         INlbgZjp9ZgBdnG0J0DkXiKR3LIylBsXPjLuCv1FreFsagC+kPZe5oAtYyWRHgNptJHB
         pYJw==
X-Gm-Message-State: AOJu0YyMXgNJWgu/MUt8LcDFbVPNz7eWIer6tlQs6NaRBFYGLBuJ5hre
	L6cw6Kod2p8CgPqIVD0uB0CYYBTFpwj90E/t0sJufu80j5CjGsgEYIRL7Oqbz1uRpDJpQ49DBmN
	yEJovII/zQCT9vchoxrqgKYAM/FsQjFA=
X-Gm-Gg: AR+sD12IvcwBDMiF+mk1md009D1e33pm+A7wEUeaCtopZSzZlwN0qKX3l1fmIsRmVe7
	+NHN7Vp+54cHy1hNj86mvg78mVCI/eBkomYhX3w5yWFuXCuLiJ61BSoppMCvFgW/1xx0D0geiX1
	tPGU9z2JZ7xeibXJ5VW3Ph8I1ckiGEqNs/2++DRwT9TBCAmQo1QOcf3yXIa3Qj52sO8i9nzvpBw
	Po01zBzizTUfY/Ylu0uJGyL86kDGWTpdjXp9rfdQ41pPftLj9N7x3ZdiPo7y/qga5uJKDD6I0I/
	g6yE1WTqM9Ham+GCOS3WEzuIwOn6cFE16B+VhGkndNk=
X-Received: by 2002:a05:651c:1145:b0:39c:9452:15e4 with SMTP id
 38308e7fff4ca-39f862d6e62mr33562961fa.19.1785861299212; Tue, 04 Aug 2026
 09:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804150419.20254-1-stephen.smalley.work@gmail.com> <CAEjxPJ42hQhx66icUnDzhgHhe62xbKKEzNRNAoCBHpRouyixeg@mail.gmail.com>
In-Reply-To: <CAEjxPJ42hQhx66icUnDzhgHhe62xbKKEzNRNAoCBHpRouyixeg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 4 Aug 2026 12:34:47 -0400
X-Gm-Features: AUfX_mwA-N552mE8zLVNLTcvJKrmKf1VRFZ4-pOnCfd-6PPwuVJAgim6UjKXbqk
Message-ID: <CAP+JOzSZ1psCgy4FYYyeOip7Fjk35yKE9QptE5Cm7yLuXUqp6A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject policies with no avtab entries in expand_module()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 4, 2026 at 11:04=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > avtab_read() already rejects policies that have no avtab entries in
> > both libsepol and the kernel, but expand_module() can produce a
> > policydb that has none. Check and reject such policies in
> > expand_module() so that checkpolicy (and its fuzzer) will fail rather
> > than writing out an invalid binary policy.
> >
> > Reported-by: oss-fuzz (issue 541553475)
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> This breaks test-expander in libsepol; apparently some of the test
> policies there lack any avrules.
> Should I fix the test policies, or is this change incorrect?

In cil_binary.c there is a check that the te_avtab has at least one
rule and an error is returned if there is not.
In libsepol, avtab_read() also gives an error for an empty table.

I think the test policies are wrong.
Jim

> Also seems to run afoul of sanitizers due to memory leak on failed
> expand_modules().
>
> > ---
> >  libsepol/src/expand.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 8cb62d82..466d5bc1 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -3494,6 +3494,11 @@ int expand_module(sepol_handle_t *handle, policy=
db_t *base, policydb_t *out,
> >                 goto cleanup;
> >         }
> >
> > +       if (out->te_avtab.nel =3D=3D 0) {
> > +               ERR(handle, "avtab must contain at least one entry");
> > +               goto cleanup;
> > +       }
> > +
> >         /* copy constraints */
> >         if (hashtab_map(state.base->p_classes.table, constraint_copy_ca=
llback,
> >                         &state)) {
> > --
> > 2.55.0
> >
