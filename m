Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3741C5F39
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676834; cv=pass; b=IbWsVmJBcSU8FaxHS1vfKafAWk9bE9LYi5NdydTWWrsvfK+Q/Pvc4nunL3cX4LnHacSL6iMC1SrqTG8ARGWEIhgfk/by3OQsd8UOIpcxKFgpaeJV0tcAK6FDo3rlzevP3n3lVo3dAwNkK4zyWeZzEkdkSwaJJZbT9GeimF7wvHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676834; c=relaxed/simple;
	bh=5L+qDFYmUgKja3kOSdiv+Dp62RnAE8/Jm1YiiqyOFgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvxcVpr7rxO033Eos1VU7Dxig4q8wcfw8UVIyZfBAJmXD3BATgejChTyChsbirQe8W2QXxa2B3BHmbSslFEQv2nEOe/zAE0w7rwgAi8lNKOhEg+CprMOwGNIQYzmXeCITgnGxzYPwh7C2KtS0lFWYXXzC13/lICXM8enk2HDn2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnr7Pral; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnr7Pral"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84237c55ef9so1100340b3a.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676830; cv=none;
        d=google.com; s=arc-20240605;
        b=J4G+uqmHAdicoQgiyQypkP99U7VV9O77fs9bes6RIPkeSH3QOE73PYujIsPjDLYF3M
         bikpJIBNQ6dSTFd5FsQ9PbBfZbunHCBlBVtrUaspzc7Dv1v6i0UyeA3czWnn79wqgNkj
         uukUdUtGMTsUC/Sp4M1GOjHbz3AhB9deOkbQMSUl5URhiSLwSwxl6A+Ky3cRi/YnpKFc
         dEomDjQuT0prEXmKJwxfCoc5ybS0sAbrBAbiA2VPKtuL96WuxBKAXDv/3q1mSuQmegiv
         Tt3j8QEo3c6bwgcd6uv2s+FXIiLfp+nkgLfeeVo3FDnU+F05n+Glwj5QaQwWpuuOtMlm
         U7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wnPymv4nlVIeZqWlg28YO2Vbmpbupqo+SqssCa0nLtQ=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=LObUycFlvax4lRJElPFqbHufdTxktATW0vsiN7V9JPzlay6jY5jLsiOYTtYFDHkHa8
         WcoT/onyd/335XlMqvcQXZf5lvYUd1cqXJ5IGMEKsXKLSyUTHBWwhffY5wj0HOVziqQB
         uPW4XNpRgcLty1+uFhkEBlPfkZMSCPTu/oFf9WRz+zlpsa9aAy2QTm78APxDQVV+S+wH
         bI/trlZ3Jq5DjeI8AUozvPbDTe5gEhpoOccRzmDlmiEYvW1ih+PRzBFPk7xi1qq2kD/J
         hbnHqPy5qYMSZzz5c6mAYnGtTe+J1BsbpWL0R6bawkTIeqs9VVPc/n3QRlPsahUgUvgE
         7gwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676830; x=1781281630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnPymv4nlVIeZqWlg28YO2Vbmpbupqo+SqssCa0nLtQ=;
        b=mnr7PralyF6qkUUL9U4/DjKZonOkFyeVPq/vvBbh18kQFSJNYgeTwgsAgZ2WL835Yh
         7BoXKGSqsbbb3oMmJUXad4JQsox78C6KXmf7dv1CmAsOUC7N5qccUEO1VtGDwzhFhob+
         hXdHrAtvUridQBS7zN/u8/Np/JBsjlyhBM9t3JVzJ+UhIh8xxK1Pd3rFpfoub12xFsbs
         1el+dufn2KeLqYqJWEe56zN2GxCKPLmXL0O8F8In+w85QKAX3zDKc9jVrCnJ6B/dolWO
         vR65PhtrClcJCTMFpsLAYwTE82nQTcC4q+nP5VeFEnkANJUW/g0kz8euHaPXaAv+WfgB
         xFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676830; x=1781281630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnPymv4nlVIeZqWlg28YO2Vbmpbupqo+SqssCa0nLtQ=;
        b=mTEuLrOAacRjOAIsT5XzQlv0Rx8o5UN2yx9t5H1V34+3bI+wco7QMSdbU+zFDt5jwT
         2QYXf9QtCMrltj7SOhp4sf0laRNwcLo06w7WL3i+BOT3yqKqEQCE6zbuGz2qWpDkMwQp
         1dFze+M4MQYwe1JksU4nMG7dvBeJzALSOa7XqQEJ95g59rrLDe4T7D0nl63+GXy9JzBL
         toekwVKb1utLqlXaiB78SLdxIsFW4LvMWLiZNJ+QIy9BiOna5tyNpnIc9ks5FXVRCBns
         a4tTQbsFDaBR0z0sWBt/IMWbEqiYm/iyRrvffGD6a/p4oOmxaqZqnEvVjqo6ZQagEKWw
         FwWQ==
X-Gm-Message-State: AOJu0Yw+UVyqzXcg1v9E6DThF7mmMF8Z6VNdKIaPm6W2ODSynTjFaUb2
	5bJO8vmbcDfkRJuaiZwnTF+Gh42GuEqW6onfG757otDrTAjitBO0AIneLpHxy96Lvdsbqco3enV
	/N3bc6NXZZURmFJ76835JktYQfCkor+o=
X-Gm-Gg: Acq92OGLU9fqqXdD4JuAUWhc8wmFvxYO2k0Ja0ik9EiH/aA51e48R/lonsRGhANiIxH
	cMEGS4dn4FaHKCe4TUG+2RArmXZaF/hu0zR+o965Y5PbVmKepMRG+7fSDDT7Xf+dkbfTZtWLnWA
	w5Af0fwR5CoMdLIi6OTCUtrbVwF4asgiEcwlUr6Xo9DltUUqbZ3HE7hoSrHRZIsDx1TDDW0iIno
	DaXIbzM2VUKyTukkHOZum05NS7GIDkfz2RqF7mzqvo/2y5LG1CEUFZA3/s94d87E80RzbKiBwrn
	H0vEMjK3mj1H7G/H7G0HsXrFj0OU
X-Received: by 2002:a05:6a00:908c:b0:842:688f:3089 with SMTP id
 d2e1a72fcca58-842b106519amr4418720b3a.30.1780676830530; Fri, 05 Jun 2026
 09:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604182822.265426-1-stephen.smalley.work@gmail.com> <CAP+JOzT9hRsDQp8w+DrAb55vopYiUoSxXoA1MvT4+=tHMPnm0Q@mail.gmail.com>
In-Reply-To: <CAP+JOzT9hRsDQp8w+DrAb55vopYiUoSxXoA1MvT4+=tHMPnm0Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:26:58 -0400
X-Gm-Features: AVHnY4KvOlLHj2JRrYhyhmJIHIUENx8J9xsVG6TBy6hXfQ2cJxFpc37BuiHJHCs
Message-ID: <CAEjxPJ5Ey+7YmM+Yw8xGffyDZxYswb06RUfVW+wG8W1tpxxJew@mail.gmail.com>
Subject: Re: [PATCH 1/2] restorecond: avoid clobbering last character of
 config line
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:50=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 2:28=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > We only need to chop the buffer if it is a newline; otherwise,
> > we will clobber the last character if the last line lacks a
> > newline. The NULL-termination is handled by getline().
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  restorecond/watch.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/restorecond/watch.c b/restorecond/watch.c
> > index bfaf4f29..41497f49 100644
> > --- a/restorecond/watch.c
> > +++ b/restorecond/watch.c
> > @@ -384,7 +384,8 @@ static void process_config(int fd, FILE *cfg)
> >                 int l =3D strlen(buffer) - 1;
> >                 if (l <=3D 0)
> >                         continue;
> > -               buffer[l] =3D 0;
> > +               if (buffer[l] =3D=3D '\n')
> > +                       buffer[l] =3D 0;
> >                 if (buffer[0] =3D=3D '~') {
> >                         if (run_as_user) {
> >                                 char *ptr =3D NULL;
> > --
> > 2.54.0
> >
