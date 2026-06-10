Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A641169B
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103315; cv=pass; b=sRKB1sKCbQ1Dom48Q23VXwR21mBtK/NPoe03wNMAPcg94ciA/nT4ebFGTKuWewp2UdxpslY9o/jZbQXofBhyYTSKaYelzf2oJzqZaovd5v6EE1wGEkIZIq6gR+GuQ69qcJeSSP9tzCXnNJwZnLvBifhyCEc/yZsMzY+HtR3sbHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103315; c=relaxed/simple;
	bh=Ee/OAo50rZATKum6RqRTIpMNTJgCDtwZYU+3VehOuVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwjtBjyeK4qtyMPbZPSLUDz1rgENLlUUEWtswtthEM84DimjORnTN7UTc2UhDBSlkUmMEe55ksEIKfD30RK0rVjCVCwrSGBXkZcIXMkYW7eg6TFAMUlBAcQLX5Kyd3pawCoPVgbXo/hzfBGKEky6MGdKCz/3KcOPFj1Pt8AxsR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9zjJlG1; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9zjJlG1"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3965d76090bso62889581fa.2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 07:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103312; cv=none;
        d=google.com; s=arc-20240605;
        b=cyH4aCKFr6su0N3wlWEcgi4cRtAEpD8VMrDMaqbcMXX0EyZ65w+5ejkD7F8y499DTE
         7hYr/FGH2PUynjOv/jdTDX9t21Zvapz+ShGPgGPQeqTwFs0uXCbhbwEq2//HKe/mb55A
         gyRvnLx3ewBOM9FIbpi0EK530I28Iv9e7SDCrBRTjvY43BVYSkGcCY89inOlXKo1uwWz
         1G7DdbiQAwkT7yiUsqHXWyJKySmEn5/lsmEIqaTSjVVENVmve7hSNzNmEErnXGfPb0C3
         zH+s5fR/3A5uZu7Otv1mP/cRFN5ZGKsITlNg8jwes4JmzjFv/i33aUMWo0CtLChSJ8y1
         Q0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/oOH2KgSVRetCY1xTVsrdENfTGG8mbOpHM+inZ8YgY=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=eYW/DBM7qOT7FXI3FEgKaRkBGoU8oAj+dYopwaO9hHSipmtMllRsSwNXXr5w3xTJSF
         Hoos/po8aQUJ98k9pCI4MNygjHeHbESxOa2gcuDjx98N0ZBDX0yph94L7Wdm9yOPnNK/
         /HLyGlbqKu0xPF/QQ6aqFuhAW2nuOxcMPCyaT7yeZQIh6glaycl5dwaE5Rr6BZwDepdJ
         VwakfQc41Df2A96/ujh/7kP4/+qT8sIwTAOkymSBKCsoRiKjqxEJWucxVfYRSvKrNVmC
         3/ux7SkVru1CGi/O0sHSxLaOaNNViJdznKc1v8rTjqeQr+lTMNI+0rdjG49rLagm6/d1
         jVIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781103312; x=1781708112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/oOH2KgSVRetCY1xTVsrdENfTGG8mbOpHM+inZ8YgY=;
        b=b9zjJlG1ISXM4odmKg4IjlvDw9kce/y8Uh7o+kRToySF/S6L6PhqZcfYjnlP+8NU2v
         /uM/kjw0c+Vs29q/oIyi1QmY7coXjOAowpF/FjtrD3hNOZ4yBXJAifWg2fd32QxAU2yg
         KDnkBM0cIlii5MkjLLEJ6B6wuTQ35M9yzHdEKRG0yTgQ2gteeya7Ar2PDJ+eeCM/uCYL
         T5vfQ5rh6cmBos9cJrMSiqd0IUoEGGmsHPCqh0d+5h7v53KegII1eqHxZtj02qHz2Rp1
         McyEzhrHD2QuQQ8Bxo+mtjXYIJs8EbW7+mXnOEBnPtwjd75G39jKZRptKljJeq3DcKDg
         wbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103312; x=1781708112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/oOH2KgSVRetCY1xTVsrdENfTGG8mbOpHM+inZ8YgY=;
        b=AMjmZhcRtx70i5XkfxIwJqBBwsSBPMiKFvhBhxOkN4eXYp7bh3OuHJ82648Ine0AMB
         dbId7FlzBnzuFXoZuxaZ2LuRPbTnBrf8v9RzhB3kcBKZGmen1bl3nlZIPcCiM66GTgXD
         F89SWW1wqmJHRqmR8HcakaHXjZEmzTO1+kgRD0picWCsDgXJkIKxuaVGv7QU9h5N1CRg
         /pogIZsZ8ozyxEMQMgfZYN6i9Hdia12ruWQpjv64ktvWVHqutPgjTuX06d64lr/GmKok
         WgN3kd/hk5YEYeU7l+iWnSVL8S45VCQ5T9MXflTlpB4553lVQL+3eigx/gREWR3vqver
         aGGg==
X-Gm-Message-State: AOJu0YwbGfwhmu5P8N8FV7Uhu2iOmAtCqEH0nAWvMghtlbAtCQLejpkH
	u7vK+EuP0tWlxpwvv9dAvRGvQCn00vp98CJ1+lPZ0eVf/P6mVfo8x6vOsnKNb5CIXS4INNxiX7S
	qr5fIx6HzEz4hcmOSFmv19f00vB9bMJtUpA==
X-Gm-Gg: Acq92OHgs+2qP7Rxb705JtdpN4GOpnCRKK4UUiEuyyvzYW78FON5xyItVAoPyY/ViYx
	N0gt6YPqI8j5j6tKSWgrZ2wJA7RcEGlOz00HdLp8CPFkVysFEWwhxHcWM3S7vHp5VRFTvmceZY7
	jz0fMrvmtpqywaxER5K8V3wk4orDGU06nFbnR3RQQUtrQAxoDaGZ1Vzf0zw+0/QYMaRNkUVVuHe
	o0TEPeTGa65z93CztzbswVclIbUByaxAF7+9gLJuMMJG84ossKl3sMb14EvbrbBaCWAYKNMXvfE
	7PcgFc/UIjXFONU=
X-Received: by 2002:a2e:a9a1:0:b0:396:66c8:1070 with SMTP id
 38308e7fff4ca-396d097445emr77448641fa.21.1781103311806; Wed, 10 Jun 2026
 07:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610124229.5628-1-stephen.smalley.work@gmail.com> <CAP+JOzRxCMaUBqPJyje-jmeePWpTg0PPCs4Sq3v2fn=Mj1PxyQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRxCMaUBqPJyje-jmeePWpTg0PPCs4Sq3v2fn=Mj1PxyQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jun 2026 10:54:59 -0400
X-Gm-Features: AVVi8CenY_Ywi0QlJeUZ9dQ-BJl6Jldk7v9NoOyOs-_AYNMz8VAlx2gibC-eYjM
Message-ID: <CAP+JOzTHJoDBgTP=iHSviD8aJdNpH436SQFuZR=B1zeM-6kyNA@mail.gmail.com>
Subject: Re: [PATCH] sestatus: null-terminate process and file check entries
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:02=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Jun 10, 2026 at 8:42=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > load_checks() copies each [process]/[files] entry with malloc(buf_len)
> > followed by memcpy(dst, bufp, buf_len), leaving no room for a
> > terminator. A config line without a trailing newline (such as the last
> > line of /etc/sestatus.conf) yields a buffer of exactly buf_len bytes
> > with no NUL, and the entries are later used as C strings in pidof(),
> > lgetfilecon(), lstat() and printf_tab(), producing a heap over-read.
> > Allocate one extra byte and terminate the copy.
> >
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> make check-format complains, but other than that:
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged after running "make format"
Thanks,
Jim

> > ---
> >  policycoreutils/sestatus/sestatus.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sest=
atus/sestatus.c
> > index d83602fd..528cdcce 100644
> > --- a/policycoreutils/sestatus/sestatus.c
> > +++ b/policycoreutils/sestatus/sestatus.c
> > @@ -135,22 +135,24 @@ static void load_checks(char *pc[], int *npc, cha=
r *fc[], int *nfc)
> >                                 case 0:
> >                                         if (*npc >=3D MAX_CHECK)
> >                                                 break;
> > -                                       pc[*npc] =3D (char *)malloc((bu=
f_len) *
> > +                                       pc[*npc] =3D (char *)malloc((bu=
f_len + 1) *
> >                                                                   sizeo=
f(char));
> >                                         if (!pc[*npc])
> >                                                 break;
> >                                         memcpy(pc[*npc], bufp, buf_len)=
;
> > +                                       pc[*npc][buf_len] =3D '\0';
> >                                         (*npc)++;
> >                                         bufp =3D NULL;
> >                                         break;
> >                                 case 1:
> >                                         if (*nfc >=3D MAX_CHECK)
> >                                                 break;
> > -                                       fc[*nfc] =3D (char *)malloc((bu=
f_len) *
> > +                                       fc[*nfc] =3D (char *)malloc((bu=
f_len + 1) *
> >                                                                   sizeo=
f(char));
> >                                         if (!fc[*nfc])
> >                                                 break;
> >                                         memcpy(fc[*nfc], bufp, buf_len)=
;
> > +                                       fc[*nfc][buf_len] =3D '\0';
> >                                         (*nfc)++;
> >                                         bufp =3D NULL;
> >                                         break;
> > --
> > 2.54.0
> >
