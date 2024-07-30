Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0D1A76AE
	for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360039; cv=none; b=jobfy+5yPAbjOMWZEkoBzsBF9tCo/XSTqCNsbs8JTTS5Ag8w2IhAvPuwZlxrvWyHxh4FzL7XfTYC5FvcjQ4HT+BUtUQCofWluZJHnhuRc8aUCya/1wtqJbzdORUFS2M+/1nh2vFpUg2rjHXgh00/N6lo4JbVaRXtnFmbO9GE1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360039; c=relaxed/simple;
	bh=agoqW9pGKzbatQ7etoTMgOORcS7dTFbNMZuO5WbnK8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk8lfFRAY0uxtsd3cWVcJGGt/6Ds/ybdML4J/DHoegses37FcZLhZJ9uvUOKp/Dj+6QGs6gL/3lPL1TaMumL+s4coQmMG0Z0/ttMX+FXyS9t1p1my7QWj7NzRf6Z0iaRpBP3SVMDti8qYMjoCwTTHBULCUzzGj2s4evch6nLd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc/rQJmU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc/rQJmU"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so3061248a91.2
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722360037; x=1722964837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CddvouCoOUo01dk+JCAE8QByfpCRmLXnNb+L/QJ46zw=;
        b=cc/rQJmUA2GGPEYhAki5mqTBqDSpkB9lowkQFMOYQJgcmyXbWllNY4jI3NXzE9Q9Ru
         SgVEC9tyEQuxHg1PoQJQDuJD66YBlo5tFTzc3vZwehoSjfAO7tPhEv56+w3tANhPCvDO
         Wa/EMO6bxC9Z/Ea1XofM94UsM2E9yUNjHCMp2anjtlMBtD0HSrxLxlc+YA8ZWWCG5Ol4
         avq4uMHgAM/6B2kSvVUBjseaQfAyY9Oq6avI8Fi8nWf5/4UX4FvfI3B4uxhzDzafXSHX
         i/JtDS4nA7xszo+91JTCPDObfOWE3dUrWAFDSBT1W26UIR4fqSpi3yN1BtZ4wbgYFYrP
         eYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360037; x=1722964837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CddvouCoOUo01dk+JCAE8QByfpCRmLXnNb+L/QJ46zw=;
        b=CqlG1PP5j7wLrUtamiAMNYVHLikvQsMARpc+54IlttG8NXEYZK1id/LDIxCu/hBcHC
         kTyXr8tzv9sOdinbwPbUgm03G6OuS+RxtwjwTB5ezCIKv+n9g4wDZWWZAAFkkN1Pp+Vq
         sYL5IwUqhzwkb9p7RSmrmrLt0qzXNMX1w8/tLBTc6a9syUlmQuyg/PwRCqh3u88p0ow4
         a0MZ+xfKBFJQ3cVe4kljnuNdkUnBz2d5lnD7jhaM2htVs6Ua/0lkH3iDQ4nxf/pttMOu
         1IVbTueXspF6YzbhXkeUVLv6/9rBw+HqRLLZ8XtwY0aBZblBhTVMn/ScUjTg8fCQX0Ht
         vXBA==
X-Gm-Message-State: AOJu0Yz6tQN+/roqg0tYgkadji/0d4KxrotwSWSKN4r9urOgKXAAkKd9
	BdZ4j5O3UmJuwjVM0yba0gYgTj/tg5HgrvJ4jJUiRLv6jr8lkrtf4D0yUrv37Uu+C1qMk826y9g
	RBvV36TKi51tkUCY5+iHn6ZX3SQVoYg==
X-Google-Smtp-Source: AGHT+IElY8rg2mSpv8beQIqq6rQ88ormoFzqFwM15zUkaiVKefGf7JKSlLBnussdNzNQEN/XoD0DXk9uYY+yp0asdpo=
X-Received: by 2002:a17:90a:ea93:b0:2c9:6632:a12b with SMTP id
 98e67ed59e1d1-2cf7e622a4amr10093215a91.36.1722360036892; Tue, 30 Jul 2024
 10:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719161713.963130-1-vmojzis@redhat.com> <CAEjxPJ7PQysT8OP7oeHu4NoOc4vQih4PoOWwETkXtQ3Q9U=Www@mail.gmail.com>
In-Reply-To: <CAEjxPJ7PQysT8OP7oeHu4NoOc4vQih4PoOWwETkXtQ3Q9U=Www@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Jul 2024 13:20:25 -0400
Message-ID: <CAEjxPJ7O80Zn8rD2z4BTG0=zOtNDZMs_=_Yfur60v1q8Rmb2Rw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/sepol_compute_sid: Do not destroy uninitialized context
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 19, 2024 at 12:17=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> =
wrote:
> >
> > Avoid context_destroy() on "newcontext" before context_init() is called=
.
> >
> > Fixes:
> >   libsepol-3.6/src/services.c:1335: var_decl: Declaring variable "newco=
ntext" without initializer.
> >   libsepol-3.6/src/services.c:1462: uninit_use_in_call: Using uninitial=
ized value "newcontext.range.level[0].cat.node" when calling "context_destr=
oy".
> >   \# 1460|      rc =3D sepol_sidtab_context_to_sid(sidtab, &newcontext,=
 out_sid);
> >   \# 1461|         out:
> >   \# 1462|->    context_destroy(&newcontext);
> >   \# 1463|      return rc;
> >   \# 1464|   }
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> BTW, this function has long since diverged from the corresponding
> kernel function security_compute_sid; originally they were identical
> and even built from the same sources but we forked them long ago to
> specialize the kernel code. Don't believe anything is using it except
> for checkpolicy (via the -d option for the
> transition/member/change_sid commands) but no one should be relying on
> it matching the kernel's behavior.

Applied.
