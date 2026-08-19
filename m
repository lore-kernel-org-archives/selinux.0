Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D63B9DA2
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152168; cv=pass; b=C0lY0pmOiEapGCznipekcjD4/g1rdOqYAboZhJmmLnX0ywKXGjbsULwHyAIGnlHdRjHSmH8zplvSEGBooWg3wqf0d5XC8qE9hWV90dEQpF2DAzMJhpnxWZXYKOks2yReFezTBdG+ImsPHV0nnI/5KUWuO7ynF2INXavRUjgTUVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152168; c=relaxed/simple;
	bh=1s4h74ycN/6J8YWEWxkR24xPdj5bmsr9ULMMtB5emM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXYFmHd7weQPTClLCsfPT2rZ4QJTciwrzYgtfYLMXEGfhWUogdxuGw7y4Btu97WyFSf73owIW4nc1oXSGKRYf3Df62YZ0IoTrB5/uZ+xjbKtlbRupU3cc9Cpf3D+BMPd8b/6gmu7fKoWAkzdyl5ah04A1tOScVvFI1qJTjX2E/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWVJbp7W; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWVJbp7W"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b026020b92so657246eaf.1
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 08:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787152166; cv=none;
        d=google.com; s=arc-20260327;
        b=Tw6Ypfl1kwBJh/FRsr6PfhqGUW4wL5F3er5pi6mDvoIEJxnFLFJXF8s8nV6YgDG/Yv
         K9EHU5EwndCZFSrBInZaLlAOioqNsY6Zs0HJIB70E0LVpXWymTyIsqonHlbcFkr7IT3O
         qygl6mr/aG+QW8Pf02HzRzxrc7c3dgIlRSewv5E5TJjF7QtCxbLMA0F7L7DQV5dpBN8c
         AFC/dpR5BQr1VxthIKdGFD4h76wC7A6zg1gN25O2Uh/uVA72V1HFpg6eGI5Rvr+PHTkx
         Yjg3wjyVv1pbNyIwjGyL33XuPFBl1yeIMNt20mMERcWt/keBvYNzeQfkHFWAVH0+I5dH
         djiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nfg+0fr5PhuIKssATLD3gvNroL0YX2EV3+di7y7GztY=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=fZrPL3DqAPPi4DtkJtKB+M3s9l5A8wY/iCdMnh5aV0MSIWrYqk/jtGMLj0HaOgDH9T
         UUwT3ktAWRxYilMkJuME4MGaLpA773AgMO0HKWca5hFq73+wrRD68ZyMIzhwQ8I7GrYU
         3k16cQEOcWUDIb0+aP2axQuk2tEOxaAb/8bDGVqTSfLUhkUK5phALlOyrvUoZGS0quIP
         1HpJCQzyY2l+ehLlMAZWTDz+QiEhqeK42s/GK4oVMtn5/wyr3n+cgtMpXAQ0goNaY04U
         N2hb/z5wcPJUyGhvsEABO2XhuK3bWizgwSJCH7Q22nXtpXaSxNcca88P4HN9ZbS27qp5
         MYog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787152166; x=1787756966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nfg+0fr5PhuIKssATLD3gvNroL0YX2EV3+di7y7GztY=;
        b=LWVJbp7W+7ZT9HULqDR2uTCHC6PNy8PFkzYi0T+4tUePz8+BQMpA10aXx9YWirEpc1
         rADJSGdN4ocyyTopv9Y8VuqPA71AcBjjFGg9AG9HNyaHVs/5VIAydbhuY2KBpyz68pqt
         cweApezNoyTldKfnJClsLLSqdGJZACa7vREneC7mmHlJJwXUtXW891q1gRKTqMy2Skxn
         35LtbScnTllokmQzrcVsneiuNcr0r6/z+W9fAHe7uNtmy2YrT0S2moBBb/QIAXYiRYmG
         ul2/Y48+zzkrUURGpTPkrbfwZnN+3YSCzILi8gYS3ct1JFdFPZ+4bCsUOwTD01bsqTxC
         aFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152166; x=1787756966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nfg+0fr5PhuIKssATLD3gvNroL0YX2EV3+di7y7GztY=;
        b=cj/AzO/Zlyx5ea2mIMfV6oij6cCTLqIY9wjSOOWlPXpBv7+lvnKc3W0/kDauciTolE
         cqesmVU3NlsZMU5oqz0KCd6l/4AxTEd2CK30SGoBE18lCNJXKotPc5Gtwu6x+7jVX2lo
         RI9Rt3DjiZSVOh399e13eisLKpoiJazPbkYjgTziqa8lyEz/+Fu4RsCruqHwNfWX1wkt
         3QNfSBCm3omlGSLiwNN+2MRNkviVU4oTVsV5IoAUUv5RyjuWDdp0HVhAITyNdfqoOUUO
         QFsQrTOnVNIEp329iU411N4QLIH7Vv7tYZb9XTtJO8cHBxfgyYSyiKe+85hN7lr+CbQX
         d2BA==
X-Gm-Message-State: AOJu0Yxdux1wlLtscAwjxBZWEAtufjov92gi8O/98jyntDCC/zC625tq
	kzkzOH+WjdT+HF3oe0EDpwLiY4rwr1pRrQXOIJ90nB3kV7d1FGIqemaS7/mN9RMjodXITE3PNKX
	5u/9a99pIkoE3z5q+m2cb37Vsjlf5uzW6ig==
X-Gm-Gg: AR+sD11j/CH21VmYgxlcFfm5fg135cRtVt2fISrriPnvn6cBv7VGR0Cnl6St4za42Px
	RxhexwmR+QWw0s8Zpw9NcTDRgDKALqcMwqs2YpAW/0oMT1Yd4FSlspw7vioQibblCmTUb+l/8jn
	g2WR7SQm5/9Ja7cMVytg8qX7aW20W+yn9yePamr4sqfQ9Cvgz+YrS3y4IljVwMa3lpnohoMO5DC
	4EGeThh1X49p7JyWulIotaT2+mE9b9J/rvmXgqYDhpgknjDauVvH/n516Ah+kEsD57SfBok4hSh
	++4CKRaZpgyCdrB54F5lZSf65EAlKIMAgF/H+y20HB46
X-Received: by 2002:a05:6820:1c9c:b0:6ac:b6c0:2c09 with SMTP id
 006d021491bc7-6b13c2fd483mr4903280eaf.1.1787152166171; Wed, 19 Aug 2026
 08:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819145702.71314-1-jwcart2@gmail.com>
In-Reply-To: <20260819145702.71314-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 11:09:14 -0400
X-Gm-Features: AcwNN1XnN3PhsLhifWToILedGARF2JPqEIXbvWKoNi_aFAkzRP_CO35rCHV8w08
Message-ID: <CAEjxPJ4gbhbrGR=o3HKf7KA=0X4XhzDpNByEvWzLUhntAckL+Q@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Check all the permissions in sepol_check_access()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:57=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> The program sepol_check_access() takes five arguments: a path to

Can fix on merge but both on the line above and the subject line it still h=
as ()
as if it was a function whereas it is a program/utility.

> a policy, a source context string, a target context string, a
> security class string, and a comma-separated list of permissions.
> It calls functions to turn all the strings into values that can
> be passed to sepol_compute_av_reason_buffer(). Unfortunately, as
> each permission in the permission list is converted to an access
> vector, the previous access vector value is overwritten, so only
> the last permission is used in the access check.
>
> Use a temporary access vector when converting each permission
> string to an access vector and "or" it to the final access
> vector before processing the next permission string.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2: Fix commit message based on Stephen's suggestions
>
>  libsepol/utils/sepol_check_access.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol_c=
heck_access.c
> index fb3b7edd..e80d6464 100644
> --- a/libsepol/utils/sepol_check_access.c
> +++ b/libsepol/utils/sepol_check_access.c
> @@ -12,7 +12,7 @@ int main(int argc, char *argv[])
>         sepol_security_id_t ssid, tsid;
>         sepol_security_class_t tclass;
>         const char *permlist;
> -       sepol_access_vector_t av;
> +       sepol_access_vector_t av =3D 0;
>         struct sepol_av_decision avd;
>         unsigned int reason;
>         char *reason_buf;
> @@ -58,6 +58,7 @@ int main(int argc, char *argv[])
>                 char *tmp =3D NULL;
>                 const char *perm;
>                 const char *delim =3D strchr(permlist, ',');
> +               sepol_access_vector_t perm_av;
>
>                 if (delim) {
>                         tmp =3D strndup(permlist, delim - permlist);
> @@ -71,7 +72,7 @@ int main(int argc, char *argv[])
>
>                 perm =3D tmp ? tmp : permlist;
>
> -               if (sepol_string_to_av_perm(tclass, perm, &av) < 0) {
> +               if (sepol_string_to_av_perm(tclass, perm, &perm_av) < 0) =
{
>                         fprintf(stderr,
>                                 "Invalid permission %s for security class=
 %s:  %s\n",
>                                 perm, argv[4], strerror(errno));
> @@ -79,6 +80,8 @@ int main(int argc, char *argv[])
>                         return 1;
>                 }
>
> +               av |=3D perm_av;
> +
>                 free(tmp);
>
>                 permlist =3D strchr(permlist, ',');
> --
> 2.55.0
>
