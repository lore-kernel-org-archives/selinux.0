Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCA381AF7
	for <selinux@vger.kernel.org>; Fri, 22 May 2026 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454022; cv=pass; b=La4KNbAETtG07tofYJd6AnROdtJwgp3pDRN4kIfD21uPrNhReaHP5ZTE6gxBlEzoBWqJheYeUddKojY9Xsftk9ejunMshvYL1cUjDZ5x+N+Ut5MehfGBZ1xof/t8kSORvvo1a3enLVPGYzF2LiyTffQN0CHsMAJRFGEq02Z8UG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454022; c=relaxed/simple;
	bh=wbHssaUOBOpKIAq54HOB2qSTvXS2b5qFvd6lHdLcSC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj+FRuIzPhP5I5+t7gEVsrqpegnVabiddopF7ZymgRX/72kM1cCfMw4bFgfCRHr/rVPzRM6GA0SomqGBHJcSCTwFifo6ZjeACqfDTCgyJOWPHZRQmA+0peXosbHYj9AoBQyBNugPLGQtyC88EpCjbOfBW06dicILg7eMvOuw+wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl3TD7Hd; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl3TD7Hd"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-365eecc5885so6683996a91.0
        for <selinux@vger.kernel.org>; Fri, 22 May 2026 05:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779454020; cv=none;
        d=google.com; s=arc-20240605;
        b=Sp70qNMvS+nXpShsQ30xKpTdQIqc2mq7856SRB/1/qMSzNKWo9LFGjPdMLz34xKaa6
         ETy+ZnaYqNYEz7lRNGofKFD8aQTrmQk0zkBUJGjjNYRhgl9wx5X46ATnml7wJt8BXriE
         hAxM4gUA9IcC+n0uNE5KyFX6sR+Rt/KvAPybp8mSJjXpIjIeRl33VT7QYDtFzzKOON1P
         mgVtkbbL6DMKRCc2OSQkCiaMDuoCpyDIG5GFRjh0YRj1uJEUKUPAFnK7qo+pHhQi42N4
         zl689YfTWMQ0GprrIsKVMMByUMYFzkMqX6vXaGoaVMJuW4aAr82PpO4EJHwpakRg8qFD
         cMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZOuXWQgv0XOgSDo47Iuw4POAOsAdJ8UiVMNeIs2aik=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=cOO2epRyf1MoB9kQgXizessZsMLFL1/rJCz0hW7mYp3MAILh8f4YmbFtxBuK2nri1P
         KMcFwoOzmykKUhMxOS1hFL2rfOkyOUYhmIEiLSN07a+OkoASwLjWPNGIQTKAQNy86mP0
         9zV0mzTmMOnjWxHpeCQXBtJD+LkqkqNIkySrtRiRl+6CU81adiG7UagYgmZooc3CYAut
         JMgNbgAJIyMqaig1JPVE7Mw077WSdR/FrJ79t5bp+8q1pcg6XP+EpZAwZTvIog78foKF
         R6f8dHyZyCcbkn5Z4rF3Qjc3Uo6SrVOWMnwW+Iyw+No8EdkUgfHzrAE+/RHuSJgKC2pV
         5mrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779454020; x=1780058820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZOuXWQgv0XOgSDo47Iuw4POAOsAdJ8UiVMNeIs2aik=;
        b=gl3TD7HduM8dBOpuhBRikwX0B/ndb39UwMZuqWIeygnStWSyW6ZNOAB+HRyUusKQby
         khBWWQbbobs5hvr9yQ8aRG6iphV9pDXBI/VuCXD21Y04fod6B5K8qTTFchdWhyLgA/Yb
         oyn2bncLftcBq3vn1LtCDGY+EtjDjmSEyBeR62ozuMABIOCtC2QtvHPwSyLoKUnSBY9v
         4fLWJdMRGk13t1T8IhtMBlUOJEo9n4ur2Rw1oCmHsdUHzf9qmiTOJEJS83VlQJMkbSl/
         d9ww3AKf9dI3jhPta3XzDsAexN3b23fpSYb4ptmQhO5BCjm78rNxTllT82tXHzd7PsIy
         J2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779454020; x=1780058820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZOuXWQgv0XOgSDo47Iuw4POAOsAdJ8UiVMNeIs2aik=;
        b=pu/29uhxTt0OapqGil36Qv4eE9YQFD+Q1j1Xvw1U23lbR+ymrAYrjimEJxFnyzpos9
         YrH9cUGJGYMS1A53HDnc2NjRnfDJmG3FxKWs0qdO8AEVeasd/5g6ioJhQpR5CIyERfVK
         DzBQpbfFv5YTtUIs6w3J/ia3svYNyAwI7or47/kEDrV00yZ6nP7KmvLXgpu4gW1P/sVV
         XzUuhSD5487GDzm7B5GOg7iPPtax1C8Y4rnz6F42N7Z2+UTRoWEh1XsG9mzW+ppoRUpi
         pT00r8da3uEtBkDapkS17a/jEOiWNVAwk7qMbFKeapYwqZ97iBa+Y6+gW+EzZKSht1JT
         vfJA==
X-Gm-Message-State: AOJu0YwDb8LAhAY6Om0WTmJ42h+lyyaonwmV7MXyhxcpY5BQ8cSDNIiz
	nOQIbkKmbQDTUdUUyKM8HSmfyFA3Pv/61DRE9giOtt7UjEOHbZ0VXZw4sT0stEKbwXr2hdSgIiB
	zd609oiFy7KUHWd66Eak1VirRyQrmJcM=
X-Gm-Gg: Acq92OGxxd6FBKa0amh9McZymUdWVSkZWOkoE5qxVlXmQHc3MbFexa3N6WDO9uvNl2l
	4vVs8SSjgp+gllj2LWTUAaDQoMR1igR4KDeTpzAEFceCxKgr9h7Kddjj0Fhx1HKN6Tzm76nPCA6
	cVuejd/NUEC0wPXzSK2xLcIwpWDo1ujOUoFla0VGraYFpa24Y+awxWC+frYvmeA47FXDJh1qwF1
	5zfear1wLLzF3Zhwu3PPHPNGCXIHw+hQaCuRFXyPd8OCrWxAtBEcoCgKNEhwEOjETUcZRR8igFf
	DbOfKXA=
X-Received: by 2002:a17:90b:184b:b0:368:2074:b7a with SMTP id
 98e67ed59e1d1-36a67422603mr3538254a91.5.1779454020010; Fri, 22 May 2026
 05:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521183432.22333-1-jwcart2@gmail.com>
In-Reply-To: <20260521183432.22333-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 22 May 2026 08:46:49 -0400
X-Gm-Features: AVHnY4K6QPiAXRBw6BdyG3rIm3kmPFelZm5-WZa6R06vYPHBTP5_ZyISMxmux8Q
Message-ID: <CAEjxPJ5bpa-Jq7rXBU==RdvSCxkhdcqqPr_HVC=rLizO_1oCPQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix index off-by-one errors for categories
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 2:50=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The category bitmap for a MLS level or range start at 0 as does the
> p_cat_val_to_name array, so just the bit position should be used
> without subtracting one from it.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/mls.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> index a37405d1..7f53c61a 100644
> --- a/libsepol/src/mls.c
> +++ b/libsepol/src/mls.c
> @@ -138,14 +138,14 @@ int mls_compute_context_len(const policydb_t * poli=
cydb,
>                                 if (range > 1)
>                                         len +=3D
>                                             strlen(policydb->
> -                                                  p_cat_val_to_name[i - =
1]) +
> +                                                  p_cat_val_to_name[i]) =
+

FTR, this and possibly the later uses of i - 1 are intentional to
reflect the last set category in the range.
May want to compare with the kernel code and synchronize them as appropriat=
e.

>                                             1;
>                                 range =3D 0;
>                         }
>                 }
>                 /* Handle case where last category is the end of range */
>                 if (range > 1)
> -                       len +=3D strlen(policydb->p_cat_val_to_name[i - 1=
]) + 1;
> +                       len +=3D strlen(policydb->p_cat_val_to_name[i]) +=
 1;
>
>                 if (l =3D=3D 0) {
>                         if (mls_level_eq(&context->range.level[0],
> @@ -216,11 +216,9 @@ void mls_sid_to_context(const policydb_t * policydb,
>                                                 *scontextp++ =3D ',';
>
>                                         strcpy(scontextp,
> -                                              policydb->p_cat_val_to_nam=
e[i -
> -                                                                        =
  1]);
> +                                              policydb->p_cat_val_to_nam=
e[i]);
>                                         scontextp +=3D
> -                                           strlen(policydb->
> -                                                  p_cat_val_to_name[i - =
1]);
> +                                           strlen(policydb->p_cat_val_to=
_name[i]);
>                                 }
>                                 range =3D 0;
>                         }
> @@ -232,8 +230,8 @@ void mls_sid_to_context(const policydb_t * policydb,
>                         else
>                                 *scontextp++ =3D ',';
>
> -                       strcpy(scontextp, policydb->p_cat_val_to_name[i -=
 1]);
> -                       scontextp +=3D strlen(policydb->p_cat_val_to_name=
[i - 1]);
> +                       strcpy(scontextp, policydb->p_cat_val_to_name[i])=
;
> +                       scontextp +=3D strlen(policydb->p_cat_val_to_name=
[i]);
>                 }
>
>                 if (l =3D=3D 0) {
> --
> 2.54.0
>
>
