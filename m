Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017D30F812
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514956; cv=none; b=i/qq0xL+dLUaNCy8tdvw3YmrLUTjH9bUdZD9vKN4KmQughPUYgG66JuYLiDwcRO0o5QRh+fLYyI3583mH+QY0Uc67MNXwlnpum6qJCWocJzIiAnJ61EpLWS1al4GFJJtPmT0XBAzAUZFs7QYDufPV5nSgffq0v56jaMl5fqDeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514956; c=relaxed/simple;
	bh=XZbwqsLbNh9ocAPvvxkKyIrW1hZekPhZjGIjJhPs2TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DncNV1lLPwzHQyGVihaxPL/ucucwhJiQRbmj17wXvJF9GMW4kkapGQ5GxW/zjWoeHDfuN9vxxfnyKjcaSdFsCHnVP53dqYbs/xeeuf/eSwdk9geZZs+DXeHriE5Jocp5lYbodNCAggig1e7exeGTYKn6SEDdXwEIJefRd53uNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkVfX9R2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkVfX9R2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32b4c6a2a98so7169324a91.1
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757514954; x=1758119754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmtYkgXjrUCq1tCQTvwSjKKZL9wgMqmW4GMg3XxyjuU=;
        b=OkVfX9R2qKyz1hNeJk9+mK/m8q7DIoQHSBsAUQBT4V8EU2cZWMe9NzFRxGjn9rrIez
         ctSj4NEbHD0V80BGERXicBEF6T1QbApxzbATIS0h0/67rWr/xWk0iQa8rVRcekxahddI
         +Z9qBLDaNB1pAqMkdWMsh4LM20z3p8VumD+0/rLKlmQv6FiLRjkUH+uosnf3slKBIg3k
         yTKDhJIld3Ze7vYsUsWt7Zy7nDTOt40F6HPhoOgLy+UPKy6ahkjJwx/x/sZNi1Go2r+Q
         7O9MQe/eAFrnbafcXFFosHHVELtpof8BrdKZwlTWo8l6MLWY0A3pCCvxR45wC0g7A9nb
         SSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514954; x=1758119754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmtYkgXjrUCq1tCQTvwSjKKZL9wgMqmW4GMg3XxyjuU=;
        b=gJlYKf1eRPdbwokeO0uL/6TRp3iRUd+8cbOFZciyHIwrkL+Z+SpHy8PW19AgnLg86T
         1cv73zuVmWyr2XP3s5WlU7pTe5W2RseiIEPp2Okho+wivqjmtr6c4GJ//nFNbQwWuRou
         +ZaHNR7VLjrx6lLkw41Ci+zC+lMOKnA2TsYYES8E6h55c+2P3KxYIWtroB78DKfUwT2W
         DF8D72mDnnYymANZVAqTwUQK3tSWuYDSB2XFs9e0cH9G9njpN/7q1cJUdxO6PGuBxDHV
         uGj2kWOXhCJd/Pc8pq8/6pe7tBy24cWjGyKIOUnc+gMfHt3uQgh6HGBNc8/LlsRCV/+D
         7lmw==
X-Forwarded-Encrypted: i=1; AJvYcCV+wsnKOCmUbo7yryvuPWDSYPcWQoM86scNk3RBaKzHIHBQjWW0eOyNdW7Z8fcBQgSErbgrsMYZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPA4Ts6za/lyygYG44/8pVgbSNcXu42YO9rf4I1Xoq3yth5AiW
	im2twnowvgCFJUS4tJYD/+E1ZmN8Ve0+VwH9AQS+qBv9tHP46tIzlyC6VEcxBYxtLHg/EmXYabD
	eZodDh4AI7u2eQGJgDzH3D9UyICoqDLU=
X-Gm-Gg: ASbGnct2fArePbO4Tq4rD1y2oHbDykcstWn36J2z1IzeUZd9O4GKKaf5qco6X5YuHgv
	GBLofMviDgVujYjHs1bI/htW41g3qgZiWyTBEX/0H8L87wh5+G0iYS6yksnj41V1gF2GWz26pks
	t9PB2UNmQPn9v6RuEvmltfmZcarQJ++J7LMwmZxzxw/Z3JG7FKFkuAGhzba52n3d0IJcqGvF7fA
	P7LNLdIsTJMJDJNIw==
X-Google-Smtp-Source: AGHT+IFyqlokrW0f5b3I4g2U9Nl70RLqCnSZZJVkEVHxiJOhEBM3wnxdL/N4jNte9+rhfU7nHfiKNLkvPX70aNXaa90=
X-Received: by 2002:a17:90b:530b:b0:32b:d502:6ff2 with SMTP id
 98e67ed59e1d1-32d440d9ef6mr17677318a91.34.1757514954311; Wed, 10 Sep 2025
 07:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055026.617170-1-tweek@google.com> <CAEjxPJ6HmLe5c-iosTvfDYy5EVz8xNRq0=A-jDKTKXvCNWMypA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6HmLe5c-iosTvfDYy5EVz8xNRq0=A-jDKTKXvCNWMypA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:35:43 -0400
X-Gm-Features: Ac12FXzxxuH7h965Mx-UU53-DesCSSuI89ylX1xqfioT1ONpZVUwr3FObSn9v2g
Message-ID: <CAEjxPJ61HCx3xz5HQwVKD+-9ctOL9WjuQ1mXu435eg9k+JRsTg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add memfd_class capability
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:20=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 2, 2025 at 1:50=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > memfd_class was declared upstream in [1]. Add it to the list of known
> > capabilities.
> >
> > [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@goog=
le.com/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Will re-base on merge.

Thanks, now merged - note that the policy capability number changed
due to the previous merge of the functionfs_seclabel polcap.

>
> > ---
> >  libsepol/include/sepol/policydb/polcaps.h | 1 +
> >  libsepol/src/polcaps.c                    | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/inclu=
de/sepol/policydb/polcaps.h
> > index 0835ea21..1f8e8bdb 100644
> > --- a/libsepol/include/sepol/policydb/polcaps.h
> > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > @@ -19,6 +19,7 @@ enum {
> >         POLICYDB_CAP_NETLINK_XPERM,
> >         POLICYDB_CAP_NETIF_WILDCARD,
> >         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > +       POLICYDB_CAP_MEMFD_CLASS,
> >         __POLICYDB_CAP_MAX
> >  };
> >  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > index 7ac0ae7c..22f0905f 100644
> > --- a/libsepol/src/polcaps.c
> > +++ b/libsepol/src/polcaps.c
> > @@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_M=
AX + 1] =3D {
> >         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xp=
erm",
> >         [POLICYDB_CAP_NETIF_WILDCARD]                   =3D "netif_wild=
card",
> >         [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_secl=
abel_wildcard",
> > +       [POLICYDB_CAP_MEMFD_CLASS]                      =3D "memfd_clas=
s",
> >  };
> >
> >  int sepol_polcap_getnum(const char *name)
> > --
> > 2.51.0.338.gd7d06c2dae-goog
> >
