Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DEC1A38C9
	for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343569; cv=none; b=V4R6XfJ9RFCDEVF0jUMXaHrrj1OmjiS/xb2AuunXHOhrEZsmacDK3iumJc6h+0rKTOXrtHivvt1kOgBk8fRCg71D0f4EEqjOqJdbhAwBkLXsIbbVJqMu++PJj1X+cgFc7UZocC5VGX9sfb26YZjuXhG2E57b4g/XavrOH8JPFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343569; c=relaxed/simple;
	bh=6ZAZ2aVB4xdBFaHPJzPaAWTQqw5IZ2WeUJsk5GR+LDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cM9iEeUXShsistYcztmcfrJWFF67Lxk9dTJAO5HWojC4xqoHfeqXQL2d2neGs0VKsdPc9btOVJGVpXtvnfzhEjVwZKsQ9fMv2E3Dh1duMjf+8B4RunhuyQwr0Vczmb9ZXr8wannoVLJQ5VBJnv0PvESiQYCYwxkxC+53WNIU/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTGwTK+l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTGwTK+l"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso2873232a91.1
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722343567; x=1722948367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+++bAesrRQLvrtULNm6KXVQiyw9oEcFNFd6R5PjDyeA=;
        b=bTGwTK+lYtUongPbdE1wQQx7dz1a8bivsH6bWcRsyUQa72oBvEw6yy+BW3As1t7Ayq
         H1rXGnGBDlkdNFk22e/TPyiUjgVBfA3XQYHRk4ss174EF5+ZzXMq5KzC6RTmUJiA94n0
         7HRA3A0Cb6cO05rxACo5Ps9KhjAdLe6cWXdluHCl+bhCtNNEEUXhwOPWQG7345i5dccN
         BSmZ2adH2necm+AcKA61z2dO9Mm5edyDAyWAuka7kpor+0m9Ox9hpYBQApWV/eNddctm
         B3P2W1Me2h41p4ozHVlCd1tPDnWEp/2ejNqzcc1lkZELV6A83GNY67C8xaadTuWe8M6T
         4H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343567; x=1722948367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+++bAesrRQLvrtULNm6KXVQiyw9oEcFNFd6R5PjDyeA=;
        b=ZEAQ+fdMbYjrzjLEFwyuxPgFh4tTOP3ztphjLmqWXFYnuvdtG0KLT7T5CYitRc7XBJ
         46JDza2bcKKZgeG/N1P/Sg5b3P1DHYZqS0iWH/pvorCmhVL7JWug5/EVzyN5NtMO7MWK
         W49O2bXybxLmHj99UfMJ1+L2V3pI1s3pUvRpUQtBdy0T3OGSl5OreOfFP57fXXx9AX2/
         oYzRNlm1O9EwuVXJBkrEXNhilmc1fNLJRDF2NmEDVJMMo2VFFRk6tjentfNrN1hintoQ
         PHzhx5R2DfMgm4vpv54Y3vAWKAhWohP/CxmoCjV5irOzaP+0wiME7f4trDWirGtEGPrZ
         fKmg==
X-Gm-Message-State: AOJu0YyW2/DB4aSRLNca6PqsejV7CDifPKtsuQFcb6IUsEG+5+Dilo5u
	AnyHpmtQ7I6bMYH2kirK7l7/+gMC7wMzZrDYFIRnUijZ9ooddfSc+GlgWFD0xM/EVRlGK+LdJao
	mEJgUzm+xt2s1jsshrpp/fC0YFxUHkA==
X-Google-Smtp-Source: AGHT+IEHNaJq6tyTNZOeUnCn2eRPvouu2QwGKM0bsirsJSUUVvHHo0jydYvXFaJyqSpRg6kNvrGScIuhg/AyUPEjECA=
X-Received: by 2002:a17:90a:d249:b0:2c9:6d30:81ee with SMTP id
 98e67ed59e1d1-2cf7e1a1efdmr8773961a91.8.1722343567215; Tue, 30 Jul 2024
 05:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719161713.963130-1-vmojzis@redhat.com>
In-Reply-To: <20240719161713.963130-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Jul 2024 08:45:56 -0400
Message-ID: <CAEjxPJ7PQysT8OP7oeHu4NoOc4vQih4PoOWwETkXtQ3Q9U=Www@mail.gmail.com>
Subject: Re: [PATCH] libsepol/sepol_compute_sid: Do not destroy uninitialized context
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 12:17=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> Avoid context_destroy() on "newcontext" before context_init() is called.
>
> Fixes:
>   libsepol-3.6/src/services.c:1335: var_decl: Declaring variable "newcont=
ext" without initializer.
>   libsepol-3.6/src/services.c:1462: uninit_use_in_call: Using uninitializ=
ed value "newcontext.range.level[0].cat.node" when calling "context_destroy=
".
>   \# 1460|      rc =3D sepol_sidtab_context_to_sid(sidtab, &newcontext, o=
ut_sid);
>   \# 1461|         out:
>   \# 1462|->    context_destroy(&newcontext);
>   \# 1463|      return rc;
>   \# 1464|   }
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

BTW, this function has long since diverged from the corresponding
kernel function security_compute_sid; originally they were identical
and even built from the same sources but we forked them long ago to
specialize the kernel code. Don't believe anything is using it except
for checkpolicy (via the -d option for the
transition/member/change_sid commands) but no one should be relying on
it matching the kernel's behavior.
