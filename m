Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12B474271
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105983; cv=pass; b=XRFZTIAfmKdG/RblYIYwdbwygDCKh70M4J5nHoClZ1ZS0zf/JTWO2dcLEHnczj6yNbKt3s3s6E7tITWTLsmGsv8SDAFPyQSFNvIo+vxLtHRmVB6OjVUF5KLRDyUq7S5bPi1+DwZfIdfRiQWCyJ9Emc56ghpm9sMYFiDKO9fjFTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105983; c=relaxed/simple;
	bh=qhoNyWfImRO/7gQY8HFAqkOeDNoNZYYGfIvYJqwKZBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqbvSUb+fdmQCfcxT8uIyrh0erjHGMJ4ghCAFIylWOQog2cMq+52SuCpHxEd0G30E8ofIt34QDQELY5QamrUO+COqrCM7zvKSkRpbGuVh8sJA3CgMvCUetYZbnbK4XmVRil4aJN3vDT/ZoON9UPfmPxzWgB+pkftHV8ja1hPMHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLPB8h4B; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLPB8h4B"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43bf9548df4so2170103fac.0
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 05:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786105965; cv=none;
        d=google.com; s=arc-20260327;
        b=Xc5PmDqPcmfOrrZ0ZmlyUfQmWf2IiNKo6QzdGQsVJy58F9yyypEC8m/y+Ue9SqX7pk
         L5d1K1X75jq8QNkwHC3iz17rGb71a7tA+FwKVCigorZHTSEGXgFcv2+DJ9mO3/tRS+c+
         Uectwfj7BEVPNJIMJwTCJvFuj6Hop3iTTHHiTZONqOFRfueqez4TX5/OgLkOSZgm/Iy4
         OCaAQ3IOfwAIFH9B7hK6TeD+ph4ailrVXb8dXYeMu10RYj9hm1Yps+ykJb7Gez38KUTf
         X2YUDtUHaYOMiZ3MADohL6bUcQgfryLfgprowQLjdJ1ARLFf4bu4eM/LjJmUCBStZk7f
         Da6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ny8ky2MuoNDrEya2PnoltP3JSFo995Gk7ZsXf4VntqQ=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=Jg0Wog+pzzdNiEYQWT+3+/VCIA6hPHSOmKkmFz/jmQukp3hUOvDT53/Jrgntomt+Wm
         0yswPYWlfTCaGmz2rKO7Xcu3Ai2o5VZzyYLDAt2eAK8TvnUXaN6n5Eg+j+Rj5DCwXs7Y
         TbAIchCT2hDs2F5pEje+fOgYWi7Eb23bwID1XSYNVuEvBYeqTcQHY/ciB4dzfsj0mvSN
         nJwOcxzbO4b9R69MohgPTu9p1wrvRKOvu8g52UxWJZVrk/Df8W+Tg18p+WgVsQTODjoO
         1XLY00oMc5ahIZT0RoFksj1x58ZiTSJcS94w9fUzGuAuirv5anFf+d6Ms1e4QL6pJLgG
         IzaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105965; x=1786710765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ny8ky2MuoNDrEya2PnoltP3JSFo995Gk7ZsXf4VntqQ=;
        b=rLPB8h4BJ/h/gfFBBGTgkJKK9gm144TFVSVSqmy97q14x41xmQHAx2mbQ4lzsMbdsH
         NDLPNafFHHrviGt+oJksVAt8rasiEUVzZ24i7zRNj60JXxb6duSpVePeBL7jQi1RQQXz
         Ke2ZOJgxDp5Ta5nSoaH8eJojLTDxOY+NyEGdawJo1+cm7IntaRGiThzty1gcIhDAyRcK
         C7vMZ1LFJlZ//EQiyyVv0zV1P7OIRvCmvUWQ8Pm/LHUgHp+pln5FglsdLGSREmlKboPN
         shn5keO5WQJ309MVZruRLTlt2LTieEympH/m/FDPAb6OzY6weGyBL1wwvWoFs4vIrRQO
         GljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105965; x=1786710765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny8ky2MuoNDrEya2PnoltP3JSFo995Gk7ZsXf4VntqQ=;
        b=MsQkCO1JnRurhns0jnhoz9l423rlJzyjpt9Wg3WM/L+Ekh301LmI2BHZrGsCE/jNxg
         rccpR/V1g+J80eCRQEcJSmiWTXY9ffXvEjLDjunq8fG/mYRTdvZUO3tcs2RLaseszVwa
         CXw7f/GkzPZozHE8aVogJL27yW/9dQ/x7Yyy+F3vxBPnvBARcMnXhXcinQnweNKiUoPc
         SA6ob+IK6Ma08QXbUmmyQRXnRJPtU1Cqe4M7pEXYqlCqD6tSPkngatn6cQxUOYtmw1uW
         yCoP+kEwFVINmTTSaqiktQfHQGVVOvs2lASb8THOidkHYo8CcTcn7ikhzDNAX/OBXytc
         x59g==
X-Gm-Message-State: AOJu0Yy21nW7iN1XJkUgTpKetjMbI0g+SNzF5FAb2WCuyAUmFkJtQFw7
	QxtU6avxnUz6AiexftHei1JGBTrUXBhRwSmcd0gqb7mDnpWjOz2HKuWkyV76mQikWSHY2CHMPRp
	UxB8rLXE4hs3PyHAS+6JCZctW2sVbNlY=
X-Gm-Gg: AR+sD12TIbSkCASF2OaG1BphDIyPj0e3Y0CHzx7v5hlVxZDAfBpzwl5jkkHuSBox6gc
	DNW0OJKKcsFw8cUusDMdXLdtOGiIiuTAGGAdPusM/6kCDw+3Q6nvk7N9JICY7XowMlfMRKpE3US
	Ppmn/VhGfG6eC11zu5SPTnGKKAC/Aoj5Xq6CoF//BgG6GXQ3U2EdCVvJ6QtLES4ybPznbl3+0Sx
	ck4345jfIeRJpWfQphtzloj1/aB5E84QK+s0kPtJzA7lKNYOFveSIA4h3EWqk3RfA2Vryrw7+Nb
	MYEncE62NedZyx66P3vwE8eRZCYlwvc8NO9ivDBzSQ7/
X-Received: by 2002:a05:6820:2084:b0:6aa:a1e5:f596 with SMTP id
 006d021491bc7-6ae96c1005dmr11187222eaf.3.1786105964888; Fri, 07 Aug 2026
 05:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806194125.371718-1-vmojzis@redhat.com>
In-Reply-To: <20260806194125.371718-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Aug 2026 08:32:33 -0400
X-Gm-Features: AUfX_mz1vnbPS4WlBtYhBKbcLDIwP_XisKeyJGeSZcHOS4Ixsl7K5Fzv6-RHv80
Message-ID: <CAEjxPJ4WCk27pfZQWbxiU=SK_VNbGWeeZuD0--Ws6iqT-GZRMQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon_xattr: reset dir_xattr_list on
 every call
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 3:41=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> selinux_restorecon_xattr(3) documents that "xattr_list must be set to
> NULL before calling selinux_restorecon_xattr(3). The caller is
> responsible for freeing the returned xattr_list entries." Commit
> b5a23d7f30c1 ("libselinux: restorecon_xattr: clear dir_xattr_* after
> freeing") reset the dir_xattr_list/dir_xattr_last statics after
> freeing them on the internal error-cleanup path of the recursive
> walk, but not on the normal success path.
>
> After a successful call, dir_xattr_list/dir_xattr_last are left
> pointing at the just-returned, now caller-owned list. Once the caller
> frees it as required and calls the function again, add_xattr_entry()
> finds dir_xattr_list non-NULL and appends the next entry through
> dir_xattr_last->next, a dangling pointer into memory the caller has
> already freed - a use-after-free write.
>
> Reset both pointers to NULL at the top of every call instead of only
> in the error path: by the API description, any list from a prior call
> is not valid.
>
> Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>
> Verified with an AddressSanitizer harness that calls
> selinux_restorecon_xattr() on one directory, frees the result,
> then calls it again on a second directory: reliably crashes
> with a heap-use-after-free (when compiled with -fsanitize=3Daddress)
> before this fix (reproduced on libselinux-3.10 and libselinux-3.11)
> and runs clean after rebuilding with this change applied.
>
> https://github.com/vmojzis/selinuxproject_selinux/blob/libselinux_AISLE/r=
eproducers/RHEL-217622/reproduce.c
>
>
>
>  libselinux/src/selinux_restorecon.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 4233ba65..49b8ff7e 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1968,6 +1968,18 @@ int selinux_restorecon_xattr(const char *pathname,=
 unsigned int xattr_flags,
>         if (!fc_sehandle)
>                 return -1;
>
> +       /*
> +        * The API contract requires the caller to have already freed any
> +        * xattr_list returned by a previous call before calling again.
> +        * Forget our own head/tail pointers to that now caller-owned mem=
ory
> +        * here instead of carrying them over: leaving them set would mak=
e
> +        * the next add_xattr_entry() append a new entry through
> +        * dir_xattr_last, which would be dangling once the caller has fr=
eed
> +        * it, resulting in a use-after-free.
> +        */
> +       dir_xattr_list =3D NULL;
> +       dir_xattr_last =3D NULL;
> +
>         if (lstat(pathname, &sb) < 0) {
>                 if (errno =3D=3D ENOENT)
>                         return 0;
> --
> 2.53.0
>
>
