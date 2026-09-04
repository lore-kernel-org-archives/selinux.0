Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A531A065
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534770; cv=pass; b=MfdDAjJ9ZInAk6GfvpepZM1dA8Ug6nbbq8C8cBgh6Y13Dv5Utd/QXgLXlrmYM8AblrdOP6SWZJDWWALMso2E7H6St7eh9r7JAxWeWPY3GFwNZeHWqjvI8ZK1lvt65G8Wc5gjlyt9YOIWe7uS5bCj6IvtUeb21/hg1W1l+a7pd+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534770; c=relaxed/simple;
	bh=6hRhcMoI9Hu1EZy7RwAKnL1nt6py31TUm3KAQd+OHg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfllgrhQuYgkYlop2rWQMHNEqOJPARbcK+T+Q7xjcXZqFtKUigNLzcY6xYrM4EqXuZ6Dr0uup3i2ak9/nN/RKYzg6PYM71LW4X4R9lIV6uqthsNHmL+f8xvOAIuLaT0/guh1x+bAeclAtZ1bzIa9HBbYIxdyvzcQ8btlpQWpZ8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OitNHy/T; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OitNHy/T"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-46556b9e02cso867461fac.1
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788534767; cv=none;
        d=google.com; s=arc-20260327;
        b=flOdMvu2VS2XWDlTbBOSnEnc4yC5hSskOq3b84vxZdJzjXBdlyRnqJiTi6aAK4EYmc
         L0hfxiCcErBe4uYdXXctaIqt2jQdRUR0xz5TUlEiicc0eeM+qEfUYxau+jzmfFlYPbO2
         A6itC4tp18guYoGd6kFcDmaFnSzrxIBxVqSSkVPRWC/x7/m7Um7QAxEUDpGTV5vKbska
         7CEpKyZWPcmf08QdI5bzHibtIX5zKfqMaOVRVyMoy+B5PDNzJX8hWN22EH894BT4GUSw
         zNDgI0Jr/x9ImH214N++3mrkhXb8L6RTRc+T2kYpjG1SdMZPBlAbQCsq0aSMqB+v+Znk
         +b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W7n2hE65htytNoRIKdMwGmB3xxzsNFcq+DO3KTDDtTQ=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=Rwy+K/UVH/GXCBr9t61zqQ4y5SgS0qPcRCqqhkG1gWvz0RvgR7IEyKv0kngUd8xwdR
         HbrHTwAU86oSei7XxPIwwsS1AXfScjwT3C2DH2mzt30/Hi5Uunc2ygfUF5FDUqoVF9/Q
         nliFlHknVTR36xyvfrsa0jpiNprnIJ4w5LIxeOiAG+jRETQLqwALVFfgn+2Fhdhx2YrQ
         pGNxIEOj/E+aOtTkPyfZGp9P3lbdvAyd86f8Uvn02cCLVxKl+gj1bBy/M/0Hu/vlAqOF
         43ZrS0p7PwBR8PJUTcCXwwnJs5wSweMNaSz2ymWEOT5hkgsWI5vr85nR9eKHgv9rzwTQ
         +aiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534767; x=1789139567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7n2hE65htytNoRIKdMwGmB3xxzsNFcq+DO3KTDDtTQ=;
        b=OitNHy/TjU7ecb7zSl0ANmGFDUjtIYMH6jj7afv9fkhI49QkabS2hSjrW65Fh8z6tC
         MDKGI7sfCrNipKKSt9H/uQnQWjIQYu1lAoXnpYWyJZJZMJDvc7Uzu1Yj0B6teR7EOpKJ
         +jrTN294+qFKF5cr2DEhA2jqleV5n2iIlEumZOF4fvABAVe/b1Bp7XQWeEesN1jtz5vn
         GNzh3nAw7QlBPEwJtKYKuEWDqCKoQzzs1RjnAZ/o4zVTGKfVuNSV0HC2ytU0s4bwJJzD
         dBUGIkwm5qnJG6qPIPGza+00Jc5ZaEbVfA2AdRbrbb7PffyWeyrh7k4whqzx33om4oPI
         lzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534767; x=1789139567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7n2hE65htytNoRIKdMwGmB3xxzsNFcq+DO3KTDDtTQ=;
        b=Xm2RaTiiLcyoHAJPAa5smE4JbWCAeufdMIWhaQs+ZnYTuczhH5O8l0vRFZGWfeyR9q
         xhZr964XPcnccfIRq8TADPbqQXsmVhRLf8+N136mG4mCEPNqeXU4RG5bCGBjBhav7aiR
         vMfCA5/Lk4U1kjc9Ji6YoxrC1hk1Wvvv5oZLjZGfRPm4BI7W3xU68uEbseeVx4VaVnbX
         VWqjYAt9H3+EI37WA0pJy2mDAz07kuRNHCalV+rLhMWOdX9xZZAuBNdVv0j/1ZUPuVAc
         gd9YfpihkUOEM9QXQJEThYCjQEjdDUPj9+NeFf2+p4803gzTvpG9wXlszQECeBycHQMJ
         TEgw==
X-Gm-Message-State: AFuF++nG9vnddQSLOAjibvuvMYLcWrXkMawprRkAX322rXfXKzTvK4Wy
	mum/3iBn04CbSomLHeaWNcbYHXrO1TNzsuq908CCYcQvko4ehVLGctSDH2oW7y1a4IVIjpgcUhg
	mwkSRPwKgsrmCGRWNPCUefNsIan8hoehkGQ==
X-Gm-Gg: AYBFou1TeoBiW2JGO7P3eFH1tY3U2LV2B5Q0cg/j78iR1GRJ4+F0ib20qB14EZqbHCH
	bZRspo2SzBRzjD/1iDd7KRvjuJ0pjcNVWs08rqSyyvt/36K7u4m76sYNJR7W/W638P//2nXPTbA
	szYyU/Bn4JQvYnkA5GWT04E9nmikDkdCnU2p4ZxjCDrtg3+iW3kuXBKL1xTlY/KDgK5DZbuOzFw
	QVkLzJNx+en20lfl0/+zvrERkK98RIyBiUkQYixS3WoHgnu4C59n8/P3wz8cS33Z4Eeefy0h+nX
	C8df4tVQwHgE9s/ROiO3q4W975CLKJ150nnnDEuXTCY5Mkp1wAeRY8Mc
X-Received: by 2002:a05:6870:4581:b0:470:e97e:8f83 with SMTP id
 586e51a60fabf-470e98e3795mr4839080fac.19.1788534767308; Fri, 04 Sep 2026
 08:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904121559.1658789-1-lautrbach@redhat.com> <CAEjxPJ4SNx2VSSm3ZXNoh425vOmP-SjBcrgW52HA_TcE2wbAxA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4SNx2VSSm3ZXNoh425vOmP-SjBcrgW52HA_TcE2wbAxA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:12:35 -0400
X-Gm-Features: AcwNN1W-cIP00gQ-2rl9qdUnroQiP-dNwOfWSC0M1C8szgLiDIyXM1cVanaEcFs
Message-ID: <CAEjxPJ40TX0Q9YX_qh1x=MejNpTdH+OjuGyqrn9fKfF9GjEmJA@mail.gmail.com>
Subject: Re: [PATCH v4] Add support for UTF-8 in file context specifications
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:49=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 4, 2026 at 8:34=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Implement support for UTF-8 symbols in file specifications. Strings
> > representing paths are processed as bytes so if users need to use
> > wildcards on non-ascii symbols, they need to put them in pcre groups,
> > e.g. "/opt/=C5=BElu=C5=A5ou(=C4=8D)+"
> >
> > This brings some overhead and so it's possible to disable UTF-8 support
> > build time using DISABLE_UTF=3Dy environment variable.
> >
> > Fixes:
> >     # cat unicode.cil
> >     (filecon "/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=BD(/.*)?" any (system_u o=
bject_r user_home_t ((s0) (s0))))
> >
> >     # semodule -i unicode.cil
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts:  line 2145 error due to: Non-ASCII characters found
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts:  line 2145 error due to: Non-ASCII characters found
> >     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Inval=
id argument
> >     libsemanage.semanage_validate_and_compile_fcontexts: setfiles retur=
ned error code 1.
> >     semodule:  Failed!
> >
> >     # semanage fcontext --add -t user_home_t "/opt/=C5=BElu=C5=A5ou=C4=
=8Dk=C3=BD(/.*)?"
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts.local:  line 4 error due to: Non-ASCII characters found
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts.local:  line 4 error due to: Non-ASCII characters found
> >     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Inval=
id argument
> >     libsemanage.semanage_validate_and_compile_fcontexts: setfiles retur=
ned error code 1.
> >     OSError: Error
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
