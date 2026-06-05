Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9633B71A5
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676603; cv=pass; b=gwrarn+619edgvxPI0oZ0HM6yusZ/0JPiv+MjMm9xjtWEL5f8TQullAwE2dnzhuA58KqS7r1CRwI5GnUBexN+QWKfrazI90aZOGKyEKdMJPjINOv9k+LhgSc9DcCLsoMTwemI5Ayk4NzPCGaBBDblgNEmP0WR/pJjWnd293e5Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676603; c=relaxed/simple;
	bh=8aOTdUDXcvJDYxy3c3UKJGcH4+s2uiQCw0FSG7SmVD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geRU8PRYnyWm2G49eqnlSiFcqCx2tKraCd5hshSZsISAtotxULrP1pz3Ajv95xj2g4OEwIJPx0VX4vguOf9OdXQDBcy3om5P+wWo+/sSICmJ9XCaV5I51blRLDFy7gtz89ZBNsN0nJBSxZZm7JoU9vvJs/hUKetcBu/byP9vqDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjqukOwO; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjqukOwO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c132ac5ec2so20735865ad.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676599; cv=none;
        d=google.com; s=arc-20240605;
        b=VZ1UN4clyoWBVVLk5UZUaK3ZOyUTBLBNteIMmCli1xGUSDXCo5JHfu+5UnFE7k2EQA
         Q9fCZtuI/6Z6bWgU63y+Jdt0o2tW8Ei7aVe0Ssgk9WWYHkBh04gQm5Zv+kpgIWlrdmQN
         hUJgg/aqYPgSfaerVl16zaZsUq9n+qmhiY8c5KSypcJkcsvCMcHF08uxpH9zfuzsPg77
         uHHpJDe9Hq4w76Slgm+oLbelzTOfXRM9hZF7/+FV9/TDDYEnKhNiUQxV8Lv+jGfi5ZOV
         ub/1/C1lKPwL9G1fHXmwJLLLT6vrcK6kDEZ/dkxk1ETbC7zNLDZ3mk1z+gC1m18SVeQB
         Q63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqo7fFthYVt+QPgRF5532FL5wCx3v+hT1rk4VTGlkiQ=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=ILytzvqfLzeHBMwLKB64e1XrdoII31c//f6vdj/s0P27NHztYYzFUqrYQloJTe2Q8A
         EWLfmsAp1PzphDM/lkpXJMoKBtNft4jJStTlBM45zMOfRP2Tf52i0BLY9n1R5LNlqGF4
         4itJjHy584DZxtQyGEGDYTpZMg1Bxmyx023b1dJYwO0qNpntX6W2zTQt1bgilLMBVYTR
         uZ2nXHxoYELzEpFo/2SrX1Inx2sbGs213WQ24CPy8J7QWCwsTiz8RmsiaqKofOsfXX3d
         h8ePqrKfJphJYST9SXBeC4P+4SUNDm4z7IJuTs/aOkPw1eixvO9FRV6nt0h07vGyDdaH
         INgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676599; x=1781281399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqo7fFthYVt+QPgRF5532FL5wCx3v+hT1rk4VTGlkiQ=;
        b=XjqukOwODz5B28MZkF3L7TjMSHx/KvgjsEAnPpWkGevt2Je6ymth+qF6dbLA/7boFE
         RfuYDAZZFFw5PidxCV9EmXaMNLD8Tq7+U32wE8AI1wbgKhAg+S+0Ji3J9XEcPr/zduFz
         tYYnYuEquN3qjQT6fa/ujXoUnmXt2OWkFaQLwy0m78nYqW71bT7E4Ac/P6CyWqlSReC0
         kS1GtrTqoskIDCWPtJgf6RMyNboLSVETLLNE9E8Hqi1UE7M/gXnmZtDglPgtN28rYb8f
         ImOcXkbX6cbuyUxxIF2v4BM18YXiDGuJN06TN8nYeEdmMQVOjpw3W7dwogFVFV5N3CL0
         RFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676599; x=1781281399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqo7fFthYVt+QPgRF5532FL5wCx3v+hT1rk4VTGlkiQ=;
        b=E820HV/j8UXzKgMK+5KMaQ9oOc2b0ECDDgbrLMkzYtf1y+bPBKXHyyMTPJvKHbPFtg
         03d89WdVEREZ5C/x4IQ3Nv5PadRj+pRCh3QxgKctfqKhH9mQ+if8mOe/6AP5fxuhh3CH
         RaF6awFLr2ZszsGEdQn0tw0OD2srtdIJAjfKscQUotxUcjJMOgWucvuwLRmXvprUJaEY
         7fsNqv+8h3gm/KzY480tcONZREH4WEP2ZG0QKqkJFyFWvrZhYAfj/XdTK/XA72KePn3F
         0bLDl7mYW4bxBg+Ybn6vBWf/FLZnbzSb8yE7tg73mOrn/U0DXupCuWCk9qpfEQFXcUsm
         acpA==
X-Gm-Message-State: AOJu0YxCao+qhUgPveG8YPwi6MEMdKpxKR5yY7kpmRZ+hPyiq/fw+mer
	GvQPUxGx6G1aKCABNOzJdQW+6P4ZCj1z3Uj7nueeS8xZG52O/wRgOM3gMCWkqwCsjluvUNxlgbu
	m/lI+voq2fuR7tvbQXR4x7TNUby5xLFC4gw==
X-Gm-Gg: Acq92OFSnlM/iHTQKjdSB4PVouv64SExS+jjiFJD+xOux6vSyv+Rmad/DAocQBs3nlm
	zzOaDsMwAJ73meKAvsN7GTDeVluUXR92ItGTDyGEIofGl9u4Gt3rroA9+3NNY1s7Lt4Ees6GEdt
	f3m8cZJMOEaOKHRwwZW2fqsGHlz3Do0KXUNHOL8zuRFNJe0hamXWQ4ktala60HLMdr5tLSXRMkl
	idHqnwkmVKzpjFcvVInnf0aoMMp3G0YA5BNRVRLZ0jMpL5z4f7yWMIAZfToq0UnDU5jM/h6qicW
	dOaaeLFX1moXvzd+4gTZ8KSeKhc7
X-Received: by 2002:a17:903:244e:b0:2c0:ab92:584c with SMTP id
 d9443c01a7336-2c1e8209b98mr49576845ad.25.1780676599132; Fri, 05 Jun 2026
 09:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125715.255605-1-stephen.smalley.work@gmail.com> <CAP+JOzTeGLEvZ0yWNr8oueObe+k97QZe2f=sRBZA1MMDA_X66w@mail.gmail.com>
In-Reply-To: <CAP+JOzTeGLEvZ0yWNr8oueObe+k97QZe2f=sRBZA1MMDA_X66w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:23:07 -0400
X-Gm-Features: AVHnY4KyztVoaG6JuoYPCWFBKA_XnfTaz6M8orPesQz69gQYIDzh80Ux_f5cKTc
Message-ID: <CAEjxPJ4-bkvVFGJ_OuCy+DS7ZPTySn9RY+LRRzQUtdObgQR+8Q@mail.gmail.com>
Subject: Re: [PATCH] restorecond: avoid busy-loop when watch list is empty
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:26=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Thu, Jun 4, 2026 at 8:57=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > If nothing in the original config exists or every inotify_add_watch()
> > fails for some other reason, firstDir will be NULL, watch() will
> > return 0, and main() will busy-loop. Just fall through to blocking
> > on the read() on the inotify fd, which correctly will wait
> > until the config or utmp is updated and further watches are added.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.


>
> > ---
> >  restorecond/watch.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/restorecond/watch.c b/restorecond/watch.c
> > index 86dbc77a..333f0af0 100644
> > --- a/restorecond/watch.c
> > +++ b/restorecond/watch.c
> > @@ -313,8 +313,6 @@ int watch(int fd, const char *watch_file)
> >  {
> >         char buf[BUF_LEN];
> >         int len, i =3D 0;
> > -       if (firstDir =3D=3D NULL)
> > -               return 0;
> >
> >         len =3D read(fd, buf, BUF_LEN);
> >         if (len < 0) {
> > --
> > 2.54.0
> >
