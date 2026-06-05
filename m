Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66672416D10
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676855; cv=pass; b=cENVUY0sinaq21ixalbIY9oew/8VZPX21NJ7qNJBAyaJpDHtw5zXrWGD0+uOC7lUcEH6bn66vZwdsn7H0e8bKTq/mUJGjO9C8x1uwGd2vCL059EMwvtCrG4lAGgHnukW/9uu5NG847pY0ztYAbQ9l9AWj89561xTfBxxQbjs4/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676855; c=relaxed/simple;
	bh=w9yz73l2Up5+tBjMez8oOmJAvcZcQRi4nuuLqcHnUQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg6g2eEHf7a0kv1C4nQwn4jUiUA8+FmWl1hFmdBYZ6uyglz9805s4ZTLGNJxzK/MQJN1Ix7I4vJWxCxT8jF6mR3yAPikvQ0fP+IKQFY/AGMCbI5uWFyo9CrwVf9Nr0yUmpDmkLuV38u+naH0nw9LqF9Q0S+/pjko9IUfwOHhW+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL61ps8C; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL61ps8C"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf1cda2b17so16031765ad.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676852; cv=none;
        d=google.com; s=arc-20240605;
        b=lhYkZoJ5FK02pwB8/NgLZ8+mZudtWYvIPRYOhqbx8XGE1CiiyeP9udyYzIdw7CEAP3
         KY07fmOOJXwqfVKZGHeC2ROAIBlGavsd6miNH2OwT5A244nY/pX1Bevewmw/puuDAPIj
         b8Zf5GLCcidpz25XBCgLYzZR+4HxAtrvzf4h8T5Qz/bQocYtBzWrfLLIQjpKnSiL5Oln
         V5DxNkQB+8+eiv3pK12YglJFPku+9QiXkLthytybd4Lq17UWpq9mst1ZDNueTkOK7Qjs
         lIQNZIwkYpwaX0X7BpeIrRlEOX2hOSbRUmnW1MLtgYvsh9pNG3r5npksiEWgKSiEMOuB
         Zg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jOf7mNmp5TVXRs7zsAYKiNaFTYLzZT8Q6rKt3zro92A=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=VFejNAuI16i/015sHrstCT1atVnvm0MDUczGdGhpB+ilp48I5kyUgiDyk+ord1slBa
         VIs9DO6Iq4g8LLhxnO213kYcSPnRLwDT3OIOaKEQYmFgixMJJEvtkhxvGfvzYgXupOKu
         zoz0eOq+yr/87twCGmVVj8YjMV9pq3MblG0lXaGzcKcSf6lSQOMmZyWGjzweqJFmITEc
         pvG2jKyXXyO7gvuX3AxsTF/TeoqarB6fTquf9KQQUKqtGiTnQOm1lLM/rIE1cbr3oDgk
         TIlicyk7dap/tKO0q6W8mkw89BAm7LOKae5cMBxSzgK4dgEw54OSZ1BjD3KX1mcrf/G9
         kvaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676852; x=1781281652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOf7mNmp5TVXRs7zsAYKiNaFTYLzZT8Q6rKt3zro92A=;
        b=WL61ps8CSPHiNsFHfjBSlS3OoeIhKtN/gXZFC26YRtbKuHXe5WP3wjJZCp49NphLIo
         GSPM6kDkdp9QhbJqZY196QNCSxnBuTcbM10uiID+1TwD58U9PKPILxLD1+Aib2YHhhgn
         dlyf4Lx52EGzu28n3OF75nqnqYkaLZ63xwwQLXcqx6npxHu7Ks0S/POTptFs+9enfn5S
         L0Qj1VPc6xJjNZSnVLrw+oyh7HIokJazEVeURaiqvmJVPF5mGfe0/OaxioOtgyS8ZZT/
         Yc7XKCh2DLE0/n9Cmo0EJjbJAHpBg7BsQMPvxxE1oRauXOux7vOwmrY+5UrX+ngy0gYP
         jlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676852; x=1781281652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOf7mNmp5TVXRs7zsAYKiNaFTYLzZT8Q6rKt3zro92A=;
        b=qFJMlqleh93i5lE/MYZy2vApr6tNcvY7teluUhIce8WDlE5ULEg4u6UxZlcmVSgcl3
         tY9Bf8L6QjD4Nfq5nI8Y+XuzPcT+1ljZ9CjO4QeMbM631y/6Vlr0lDgqpSh/SLvq0Uvi
         VhoEYI4nOahhRSyU47asqIBxRSuRxBffgUEA3cxnwtHM1S2MpfSZKn8WVmakpnnlz9Pb
         Ut7ucH/fVvoLFAlnhayRJTmHGXelns+EKJBQ16EkWRRYoviCYt8R7OyDDjUcjTE6tfRZ
         lVgDOv8uvzaNdTtIHoBWmbN8ldNoqfwXBZza/4W7iNJV3GxxI27jCMDGdwZT8FTb4wFp
         tHcg==
X-Gm-Message-State: AOJu0YwZsBTPnlS+TW6hkyfiOsiNaNeAtBJvL+8+yU8nRRWCNTMDS8kN
	qmhk/tBQiyy6b23aCT7INy2+UNxuM13yXOH23oL7smMvCV+pEk7LUv40BsOhH+qXaE/zco+E9FM
	SPxuE7xo6PPAc4yT1al6PKxlTq0HD8DY=
X-Gm-Gg: Acq92OEEsIv3Ez8Y5ty7hI6Jdm7hoVwzc74B+071cEv3jHBkNy3dtEWlgfN4if5IlcC
	teg/UzuEf7f1lpFR27r6csc8LJQb8ohoT2GvIefszY4S0r5TTJ4xtOUS/u6r8KSlXMUlWMK3Wte
	h6FswoMgOwT7tnh1k7KAZ9pVfjcFReKLvYOcbU/vHFLemQKpnkX9nB0t6e3llsJ7eEgE6hoRm9Y
	MJxDCsHwHwYTzWl8/NpqcgzW5P5v1xUbzPS8PLmfr4Lj86cBaFbXsaMuK5Bp8u0+gSXb2gq4s6a
	8DNfForbJS+XwJkGdw==
X-Received: by 2002:a17:903:3b8c:b0:2bf:361e:3edc with SMTP id
 d9443c01a7336-2c1ec3f61a1mr32592055ad.2.1780676852405; Fri, 05 Jun 2026
 09:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604184219.265741-1-stephen.smalley.work@gmail.com> <CAP+JOzSNORjYhvto0_OiomqL4c2mMDWc6-m8q+wTMN-yeUK8ng@mail.gmail.com>
In-Reply-To: <CAP+JOzSNORjYhvto0_OiomqL4c2mMDWc6-m8q+wTMN-yeUK8ng@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:27:21 -0400
X-Gm-Features: AVHnY4J0QBQ5LFClTczdPZ-TDUusQpVPBqiVrvDBWLnqPrBzz8_Un-bDESk98sU
Message-ID: <CAEjxPJ6_rvuPw-kryCanB8Ws7owySO06an8JWjUGKmY_J7EFFA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix REQUIRESEUSERS true/false handling
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:00=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 2:42=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The man page only describes setting it to 0 or 1, but the code
> > allows for false and true as well, but reverses the sense of the
> > comparison. Fix it.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> "make check-format" complains, but that can be handled when you merge.
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged with fixed format.

>
>
> > ---
> >  libselinux/src/selinux_config.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_c=
onfig.c
> > index 364e7dc8..1d3a441f 100644
> > --- a/libselinux/src/selinux_config.c
> > +++ b/libselinux/src/selinux_config.c
> > @@ -210,9 +210,9 @@ static void init_selinux_config(void)
> >
> >                         if (isdigit((unsigned char)*value))
> >                                 *intptr =3D atoi(value);
> > -                       else if (strncasecmp(value, "true", sizeof("tru=
e") - 1))
> > +                       else if (!strncasecmp(value, "true", sizeof("tr=
ue") - 1))
> >                                 *intptr =3D 1;
> > -                       else if (strncasecmp(value, "false",
> > +                       else if (!strncasecmp(value, "false",
> >                                              sizeof("false") - 1))
> >                                 *intptr =3D 0;
> >                 }
> > --
> > 2.54.0
> >
