Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D598145354
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267525; cv=none; b=ABe2vPT1qigoE3VQ8Qtf+A9Xq1ddfgw+u0VJjgHFabA+GhgrHIAUcWiooSObwQy8i9yTSJB5B3vRv42kvtjXiMuFCBTvtdNTfmUTUDabSrxrTEkjhEcvygwEGjsOoMP4n8yQ6SV4VGUrFD3j6e3tjxGgy3vs77YKBVWYDNA0KGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267525; c=relaxed/simple;
	bh=At5ey5L5qxYkNTB5acm61wgc/xnuSsUp4ee37hLNC8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSQbr/D2rfny8R3f0gY4D5NUbJbJAtNWNtLBzCI2mmYsFl4AaymjoSfmtsv/S5zyP8WGQ1aV4jEBicAOjlsTEzSMN5MR4vSzJRDBxf59InGndigbIjlHfaFw8oQKeuOg/7kxc7VcArl2jsoir7ipIJysVWxUeJ9LHQpGeVj+ZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0i+NZuS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0i+NZuS"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so1986882a91.0
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722267524; x=1722872324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SskQ1lAhimilivKsSyRwQIC0X40rbo4rtl0DIVdKsVg=;
        b=h0i+NZuSbQErCzctZCI0xeWKU36HAI/6tiIykVVc6l13S/idpEXktnn3E3pBjCdHug
         Aw7vByNu6adTlkTVk1QWn7R7oERO6bjISKsOXss+2sg+K1hKrsTPBF39CUyD4WNxG6k+
         6gnwwixPnkvtdSHbK7eOiw3X/ttkOcLAohnP+SoNAmEOpUreHNox2PKu4UR9EJQ26sLo
         VXGp58Dhpy2+82Lm0z/eXUl4n4Nj+uJjz/ijc+f37qJHLvM8hixYC7i6xkfr3YMnw90e
         IPxyKN/v28BxTfnfQfW55IO7C0Fnh37uEkH+qR7C2/3pcf3iNqLDDNKF+jm9Unu0lXI3
         Zpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267524; x=1722872324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SskQ1lAhimilivKsSyRwQIC0X40rbo4rtl0DIVdKsVg=;
        b=jPuTsEbhQxhFzJKMZ7Q/8gvdwa6VJBwWDnKuVy69Ut/7vu48XGnnwa6FpG0Op7Fd32
         Iu6j0s9yBymonNLYuITBqRVQm38SdOjfzUcpQRgQ7wuTuZgIiNEpsU1CLNlYxAUOS+r/
         fdYBRufR/wZAp/+ISR2vzaj6+Fo5xb+/510yuRk5wbsNbFBIAlp5DfVsA+Z0SNFWTJMR
         X+QqvfrjXjszpPN5ZxzZsgXDpHTQqA+h1KxrzgWDqWv8U7NKBgUmC/nQCNXVKZFu+eOH
         61efDkZ5FB8T7rz05FS/lLGE4f9AwIu4JCBqRcdc/CFuicavBOy6sUbOsme/Tp5p8MZI
         88RA==
X-Gm-Message-State: AOJu0YzD+PjBTCu060wg0SRnIki4xGCM7LyoGSRbDvIb7WFt1v1/Cut9
	3oLh5u+0SzzaDcNYIq/K/dMlop2OKZD6yI1PmbU0WXriUdANE13PHvDLz/q3nv0EPdeUNG4FXsE
	dhnl0IV9FcHcEIeXUdYoSanq0W6dX9g==
X-Google-Smtp-Source: AGHT+IHIPiHs0juQslUytrrMW3t8kJecNLMsZlAuQCQQSgUNGKO6GYaE0oYrxTiyRpi5xMIl4HdWpVx84ibAyN5AQRw=
X-Received: by 2002:a17:90a:67c3:b0:2c2:c149:ca4 with SMTP id
 98e67ed59e1d1-2cf7e733b1bmr5362093a91.43.1722267523691; Mon, 29 Jul 2024
 08:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708165032.86647-1-jwcart2@gmail.com> <CAEjxPJ70EufOsd4O4E-Sc+KRGdv1Nhbac4GbkewAejp2GrMWBQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ70EufOsd4O4E-Sc+KRGdv1Nhbac4GbkewAejp2GrMWBQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 11:38:32 -0400
Message-ID: <CAEjxPJ5re4XGfN6hny1eir0oTnw4YhNDg=EiWo5KZbQsZ8H5hw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Check the right bits of an ibpkeycon rule
 subnet prefix
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 12:50=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The lower 64 bits of the subnet prefix for an ibpkeycon rule should
> > all be 0's. Unfortunately the check uses the s6_addr macro which refers
> > to the 16 entry array of 8-bit values in the union and does not refer
> > to the correct bits.
> >
> > Use the s6_addr32 macro instead which refers to the 4 entry array of
> > 32-bit values in the union and refers to the lower 64 bits.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

One caveat here is that I believe this breaks building checkpolicy on
macOS because s6_addr32 is non-portable.
But it looks like a previous commit re-introduced the usage of
s6_addr32 (we had gotten rid of them earlier to avoid
needing ifdefs for macOS).

>
> > ---
> >  checkpolicy/policy_define.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 4931f23d..bfeda86b 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -5036,7 +5036,7 @@ int define_ibpkey_context(unsigned int low, unsig=
ned int high)
> >                 goto out;
> >         }
> >
> > -       if (subnet_prefix.s6_addr[2] || subnet_prefix.s6_addr[3]) {
> > +       if (subnet_prefix.s6_addr32[2] || subnet_prefix.s6_addr32[3]) {
> >                 yyerror("subnet prefix should be 0's in the low order 6=
4 bits.");
> >                 rc =3D -1;
> >                 goto out;
> > --
> > 2.45.2
> >
> >
