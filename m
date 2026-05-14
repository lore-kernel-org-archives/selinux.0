Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39E42883E
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771536; cv=pass; b=Jl7NyqaD0q8y/TzYOQ/9ZbTDLd9ynXCeK3RbF4zSYgIZpsZ9m8UI4OvLqEhlnp1WaFJ6K1w+hSoc/F0nA0h5lGDQaO+9izYJcxcANTegluVZXYSmFp7B/ZqGIqRCrH3hVIY6voIFgWYuuvlD62o0lLnuh/NZj550jq1Tn0QOsfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771536; c=relaxed/simple;
	bh=IIg4x4SZBaUX1fANsFouPwVk+WlxZCICo3OPrxbNZZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGlCqvpcTSQgKxOAEP9Y/dZUbtX2tok2ivuacnFKvUt2jrkz/YOuH68rzpnlX2Y4SbQgZ1z9WfX0OAcE7aV9HNFx/wGhmW8jr+KLG3pH5kLyO2yaCxeWG3QBz0J+e6qrqGfePL+0TOzAXKkX6Iy8FQIxDWNmPBAZ8H5C/Fqw4Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW0HazbU; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW0HazbU"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so293857e87.0
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 08:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778771531; cv=none;
        d=google.com; s=arc-20240605;
        b=dFklTwocuuZaRVBe+Owp9Rs92f9D/LHWE+YJ1qp5pbk8VI3PhV8wUnCyGoD4zKTqOB
         u75W6GDdI4hxKIoXPKYtY+IzPoG9DfVvspd88i7SA14lPvKoFagSLNkUIhg0kaixV6aa
         lM+52cLVy+5XGiNX4L8K/7AB1UXFO9HF8lIanpURARMguo+5xHWA5PP7xs1r3GlCxNM1
         306Cfho9PpD52n3hVQND3mBfQwkhTZka8z062q3+xiqIJaZk+HrrCqzPx2i+BheSw1et
         U/et60psLSvW8xk8WSXQuyPh43t07FtjF4VLzBvjFHz4eaHHbR9BsuZmz9km68FK21Qo
         Ku2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gB8e4SQIIivQKMJHIP9sdP6kY1lTAyr++Jre6vDGD64=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=XCF+/10dfiPWDZc5YYp6WVacEtBF0B2pxKwbJFBkFzbj8x4mISPO21IHesygc0bTyF
         ODZU+lB4DLZY+R+r+SIPbkOuCFt4sb+dgHXb/miN3Wg9Bp8CeOi79z+OWkgk1mgEidUG
         cwk9qdOxqLicxoxlsvfj3DIOWkclZGmfR0IQ1P0GevZxRnMctNRj+cLSn13H2yu5VUQv
         u3C9i8PRFZNWjfhgsDgccZ+ksGPALT1pKUrsHSfgzmcxv96mPSHJgziUIoGADws/UdP9
         NoFQE6p6GhsoWqYkqUifVNkZvqaadk+XC3gpCzaJDw9kWi7ckJFgv8YaVgjSFSkNITx2
         xt2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778771531; x=1779376331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB8e4SQIIivQKMJHIP9sdP6kY1lTAyr++Jre6vDGD64=;
        b=dW0HazbUZkMuI4zeACNSUwybLTwhZ6FR3uogXU23XnqJwgEmppR/qot92wbxDG1U3A
         HzSSgdaGddPHaU359AaVYSVPBXVmCGlIJuHGqM7DTZ2JTUONeKWF4Nuk5Nmce4ivZvJ3
         3Kw06UG4EU3QbQ4wF8QxYiHCaXBW0pH+N+eHoUT5yGc+DMj/TCXQGMqfcM0DbyOhX/EF
         0EUHqFQaCh++A5FC4Yh1pHXhB/ugqBTt6QgeKdKBsu8mQrS/TqH+4Es9hK2BDx6eS8I6
         EaWe9iE5H39yLGqJcdvuYEghDiOppmxtCVme83VLWib7c8JqxbvSVUMPWX5JjPuw+BEp
         GqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771531; x=1779376331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gB8e4SQIIivQKMJHIP9sdP6kY1lTAyr++Jre6vDGD64=;
        b=F+khrgvg8gs0k2w39jc0ulKlZgODCkiHjDN92FVNzZNHdWpmasrk2QBU7lMVH492Gb
         0gCfEJz7eH/ZWyp5KJO2goZSiZUYZGmbg7rG9Mlbrn9BdVEb1VWFfg6G2GRpI9jrI89B
         655Y8X7L/nwI4qL1JZlCg1YfSy2Yq7dYEExWRVg3XLa3IVjkCPThmUHVJaxhRhxNPx6+
         xNUqMOxBDKlKdCJhSpfTO2RoyM95nrxWg6XgybqAJlapRL3Bx/o013/y10O0Wg+w7nxB
         hqhUrRFBVh7iCc7CHAN7poABbAs5KRL38OtYtOGEQf9sXTzNZMmEkRgLTYesR6YGABne
         XoEw==
X-Gm-Message-State: AOJu0YwOYcna+iIHb37E8jaBGAaIf9EJpq1RYz77skxbigjUPP2+58IO
	XqRE1Q+mi1C144xSzDEfTzsEoWCJnyJmPhezIhM6QKZqewl3o3ixcAdETnWjJi/jnJp7/S0HQSe
	u+qVpUPOhhq/SjcM0T8rfL+fLUKZQoSl94vDK
X-Gm-Gg: Acq92OE0XTKmGDWY15Kx2iGus0F24eDmy/ZIi9NUWgwWQpgoKTRcCs4Pu/MpwgGoJNH
	oW2TZyiuyhIPniYvjPE66eNhqyAqwcRCx7abRbXZVwamU/aHKW1AVaRk5gEpe/m9PWj0YMw8FS1
	IP5U9i4EWIkCTPHKgqy86q2SnbkZuHoyRFWLnnJ4P1brsQ/iXlhM0uTukkzej8+YcvAircJBVLc
	SdvZJ1A7x5JGMPvSALVR8Jz3ogtlqPooRd5aekepjsUGX6A9jFjcLgaDZtNZf0ueoM+V5/x4sE3
	kzjg
X-Received: by 2002:a05:6512:3341:b0:5a8:7f30:609f with SMTP id
 2adb3069b0e04-5a8ef934921mr2449785e87.10.1778771530169; Thu, 14 May 2026
 08:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513191302.81039-1-kalevi@kolttonen.fi>
In-Reply-To: <20260513191302.81039-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 14 May 2026 11:11:58 -0400
X-Gm-Features: AVHnY4LgVLvlCnPrSDoZ0ziyimafMPMX5xm1sjXu_e0k4r4_POmlJzgAv_dhK6k
Message-ID: <CAP+JOzRdTaTxB2QJg=DQ4vt_6pLGfzPnpY=Ofvde3omYq1wHZA@mail.gmail.com>
Subject: Re: [PATCH v3] checkpolicy: use calloc() so no need to do memset()
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 3:19=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/checkpolicy.c     | 4 +---
>  checkpolicy/module_compiler.c | 3 +--
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index b808e4d0..323e11ca 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -235,13 +235,11 @@ static int identify_equiv_types(void)
>          * Create a list of access vector rules for each type
>          * from the access vector table.
>          */
> -       type_rules =3D malloc(sizeof(struct avtab_node) * policydb.p_type=
s.nprim);
> +       type_rules =3D calloc(policydb.p_types.nprim, sizeof(struct avtab=
_node));
>         if (!type_rules) {
>                 fprintf(stderr, "out of memory\n");
>                 exit(1);
>         }
> -       memset(type_rules, 0,
> -              sizeof(struct avtab_node) * policydb.p_types.nprim);
>         if (avtab_map(&policydb.te_avtab, create_type_rules, type_rules))
>                 exit(1);
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 4b2f98d8..a6ecc939 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -842,12 +842,11 @@ int require_class(int pass)
>                                 return -1;
>                         }
>                         allocated =3D 1;
> -                       if ((perm =3D malloc(sizeof(*perm))) =3D=3D NULL)=
 {
> +                       if ((perm =3D calloc(1, sizeof(*perm))) =3D=3D NU=
LL) {
>                                 yyerror("Out of memory!");
>                                 free(perm_id);
>                                 return -1;
>                         }
> -                       memset(perm, 0, sizeof(*perm));
>                         ret =3D
>                             hashtab_insert(datum->permissions.table, perm=
_id,
>                                            perm);
> --
> 2.54.0
>
>
