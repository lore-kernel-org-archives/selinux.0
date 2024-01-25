Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76D1339B2
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212559; cv=none; b=KG1zhOdkGNGwScuWbN/QtWTni02OOeOXP1FQSBfI2ZnvdNOO3uVBUgLRGNSEnmLWRvBSfC1ipTlznTaL9+uTMzqDLTZ6qu1nTTQ3nj8mustgxthnQUNcdvV67b1yS0WUtQI6AuApYIaBSmDdhSgmiemhHlJa43nMHLhtReraLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212559; c=relaxed/simple;
	bh=NijhY9ju0elSx55fpS2xuTliCUNQMs40BmpTcuBIhrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKIrZOK7rEcjmHKQ1iAOh4cCPvaLYJLkLl0OrXJHmx4ujg84nL+Zfm3JIOuGsqZ/VFWHLfVd5k8MGr8oWrmoxvGyz9WC8zzufjJVw96ajWzME+DMI6kNT7MqiIQUnowG7mET3R/35iTATEp5nU1dnr3REIDLfcXUYOJbdg+Ki14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlHVP0P4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlHVP0P4"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51022133a84so604061e87.3
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212556; x=1706817356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRz3TRSM3G94aQTjYG1+cOOUds0sIjhl/03UWq3tlbI=;
        b=GlHVP0P48NOWnDH6ZlarjKX37TpCRlsO2G9Q0xl2lsBoCJAmkl7mW1VXS9Q8ZYC771
         FclwEyNPoxyT0xNdCGmYFITFz7LLD6kz4AKOOzcpw2dF/ZvDSAjjNtCg+lRn1FSDHyph
         XK5Dftt3qPcd3aOAt/Z5oj2xiqLN8giT5zD3NIrETSVojAf6W7mWDn8wRpA6NMqrn8gM
         pr+9Hy3bgZUNcG7BTKmKvf9/lFgBEMEO6nb6JOgLs7X1kgCI4OTJJFNyY4tXOsaWWzrX
         r9XBEWtr0KkrRC/pT1JMbJecEmQjQcxTuCy5PBF4HmGqVAc5WXXwMAJN+XeXgW/MN++q
         91rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212556; x=1706817356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRz3TRSM3G94aQTjYG1+cOOUds0sIjhl/03UWq3tlbI=;
        b=EsJzBL5OCtSVaz7IiP+0wdF/iEisYUcSXpvcKMsgv5F7I2D58Epo3V+YqjxCYCqtvV
         Jk0oahUkXHfV1MZ0uzqJCn40RiR61qu/RpYuck6UVYWMFWLGMdja92PMcNt2E4sww7NA
         SoPbhTexWZ6Jv91ITA1BzLM26lwG1rIoMYcPEW0ddsxjPWKzzv6sbomtRC06VDo6EsT+
         WwE9sefx/5ZN/KMADqiSYjzXbNt1xWh4mbDMuOEY1tuyLlOcZQCtkTCDzh4VBn05rARv
         C57rfjETGgXWvY67lDBP2Lc4xCzr5wuxjzjERyZiZWaM7f8XzM7m63UlYsgM0IC4Vlcp
         jpqw==
X-Gm-Message-State: AOJu0YxlKmRsuj7XBwzXakNmUJULSCe4pm/UKWsACuPNQeQ3AoHVopPz
	Y6mMP0Glxg89XGTyo2cblW70WGM29w5/hwwAmEipuvOY9nQi5serks3g1twVz2nNfILLyrfzkOL
	8gpd8wApx+HVY3S0XnV77OJwzVIavUmj3
X-Google-Smtp-Source: AGHT+IHrBS4En6Ciw/CHRi3JD30ycWVaTiSlZQCiyu7WuZb3aKTJvWaksNT/9MrStIFNq98kAIfPd2NnA7BycNsU4L4=
X-Received: by 2002:a19:3849:0:b0:510:b6f:bec6 with SMTP id
 d9-20020a193849000000b005100b6fbec6mr350120lfj.39.1706212555931; Thu, 25 Jan
 2024 11:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219160943.334370-1-cgzones@googlemail.com> <CAP+JOzQ3cCwAkrT4n1D694uoZkxh0RAuoN30tEtH7jX_PhxU6w@mail.gmail.com>
In-Reply-To: <CAP+JOzQ3cCwAkrT4n1D694uoZkxh0RAuoN30tEtH7jX_PhxU6w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 25 Jan 2024 14:55:44 -0500
Message-ID: <CAP+JOzRZghhqe_k8vEac7YzZjQ0J9VJ_oJXw5UQBizRD-BrFWg@mail.gmail.com>
Subject: Re: [PATCH 01/11] libselinux/man: mention errno for regex compilation failure
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:15=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Dec 19, 2023 at 11:10=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Selabel lookups might fail with errno set to EINVAL in the unlikely cas=
e
> > a regular expression from the file context definition failed to compile=
.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these 11 patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These 11 patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/man/man3/selabel_lookup.3            | 3 ++-
> >  libselinux/man/man3/selabel_lookup_best_match.3 | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/man/man3/selabel_lookup.3 b/libselinux/man/man3=
/selabel_lookup.3
> > index 4e47c3ec..e20345e6 100644
> > --- a/libselinux/man/man3/selabel_lookup.3
> > +++ b/libselinux/man/man3/selabel_lookup.3
> > @@ -64,7 +64,8 @@ The
> >  .I key
> >  and/or
> >  .I type
> > -inputs are invalid, or the context being returned failed validation.
> > +inputs are invalid, or the context being returned failed validation, o=
r a
> > +regular expression in the database failed to compile.
> >  .TP
> >  .B ENOMEM
> >  An attempt to allocate memory failed.
> > diff --git a/libselinux/man/man3/selabel_lookup_best_match.3 b/libselin=
ux/man/man3/selabel_lookup_best_match.3
> > index ef2efb4a..985a8600 100644
> > --- a/libselinux/man/man3/selabel_lookup_best_match.3
> > +++ b/libselinux/man/man3/selabel_lookup_best_match.3
> > @@ -78,7 +78,8 @@ The
> >  .I key
> >  and/or
> >  .I type
> > -inputs are invalid, or the context being returned failed validation.
> > +inputs are invalid, or the context being returned failed validation, o=
r a
> > +regular expression in the database failed to compile.
> >  .TP
> >  .B ENOMEM
> >  An attempt to allocate memory failed.
> > --
> > 2.43.0
> >
> >
