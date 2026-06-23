Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0FE37EFFF
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227764; cv=pass; b=HOwV2f9/axHyDNYlrGOC0+bIF4+iF1PKOMDoVgDNET3/2fv78kYUgvKePwOoQADOgyHdIAHELIpF0XLQOGnfyop2TNTlqqzRZDfGTYJpk6Y2qkGE/VN2QqvRcINn5C3MbZoZzTymyjE31hNW9DtJQt1UGHwWBPj5Im5286yuR/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227764; c=relaxed/simple;
	bh=pgMi+5lbX4GNQokrHYYXeYoMVLh4qsxOy/50f7n30jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULAm+4aQa0+SBINRdVYlLsBSwLbIC+p3sTuw4HkutM3FIJjBn11QBQJuaicTQS2tZGHWr/Jjf4yrMwdG6/GK8BaGcGRwXUGFc3HrUTZEvn8LYSPrE4KQ7NAdyVTsTLBkpemHAwkiaCJdFcQQU/iN3mW/z8oXQOKd2iRfooTu+cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALf8v9QE; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALf8v9QE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6be9cd7afso24991925ad.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227763; cv=none;
        d=google.com; s=arc-20240605;
        b=QjOFf8O6ADlBxTY6M0OnVw1BnRl6mmVXt1ROWFHUl5IVxPuDTEHImV9YzRZWfCABBO
         mBkC9/2NbzXr5KMzurF11HXw6Q+DrWn4JGzXfUPzZlbhnR30QOi3AC0uTUi7s9SEtIpt
         L28AcFXlPlgvSvie4Qd6XRAVUt/wV5zi3XMqOlyz++WM5PEkXxPLJBmXIWFqtwK9v3xa
         N7HRJuHh//TR5MYJihCY5N8lHpExKecWq+cXZM0GJOg5tgb0LN8y9v8LUf1UoIt58VNX
         IeEZ6SV1Cc7aSj1D9uIbvQn7Dh3li/rYrN+E/4+7G6mJ5IcdnH1b2TrULwL1IlIs9YxY
         0LCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rYXRz5n4/P5srDHWbEsV6b+fsjLtPFAd3k6p/AOX/ag=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=MINaLg8jGDDPeG/ekGMK8SlyDRWFIM5PLNtiL0TH2k/Z2+ncvvkG6sy0cPJkICnLla
         FgPOb1zgRGV7+GGiQ7WguTiqarG4rsDWmIpGCxYQ8T5gBKelkk06Fa6HrcKYIs5m7xKe
         5TOxCCoxbYE/hI1Wz+eF0/83vDa4oqDOwM9qLVajNfPHNPuSWeJDrSgvgKGTmZcllQeq
         LL/Mdqogw8D+q9eTxtPjoSv1xYZa23JugqsJN5/TdjnnjPJ8CnjIMAUKwoqralGvfGpx
         RnBLtOR8W73tLU5dooYauIDbmE55BHz0mg0/NBnoQW+jeMkPrdB7BSe0SLwqU82Z5bUZ
         0y8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227763; x=1782832563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYXRz5n4/P5srDHWbEsV6b+fsjLtPFAd3k6p/AOX/ag=;
        b=ALf8v9QE3Z8Au4wYI2TpE2aMKyGpnhTjA5WgNPwMWYi8QBlXOQTqFf551u6zqtZGSw
         Vp07zcHfstVDumZwvPzmtCagvOxB1ojnMtpuP8EHrdRECG/LAqJg5Iz0kwewjIySEghZ
         NMardrKvA6Vrsl5s/Ex+YGIdBtY/kFrk57vLf2x36QcZ58N8vhWhWxYMHz172H96EfsE
         J9Nuj1UdBEtkNYAsKDn/KcQeMk6eqhBqDZh0nDi5zq0Q5qLLgtlrr5+VmfwW6x8tEo+Q
         1Axvu95EHHMt4Coxf6o3TnSWxd+lAkOUULZ5hRQhY5oc5aDuYJGC9b8/WN+vNK4ZHXB/
         rGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227763; x=1782832563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rYXRz5n4/P5srDHWbEsV6b+fsjLtPFAd3k6p/AOX/ag=;
        b=Invunp4fA7D/9F8U+jpvYjBVw/5upvPnGyCeAfKptODl577TlUHlTNZQSKwyLsmrqb
         Zzd+pleXBmblMb9EGgjaGcewMUrUBqCbm3ey0Upz0IMl7oD1O/mMqlayEZ81jciidKiI
         l/t5yVwD4FFNUZyNGR9YrKH12B80qnIb6YkwLeF/O7fd7tqHYiRcxO8mbW/wUQI1oYv/
         W4HB/VfWbAMjUPY/QWNIt4/o0xnpVOKLnkS+p+tn8ly0lQ4iH8y5tL+kJiFbi4YfR1EZ
         0QB5Ysitb3H2408Go5onJjeScXiyQJz1UWnc0khFaJGeEpbea4u2xuBRY1lZ3+gFn+M1
         ZJUA==
X-Gm-Message-State: AOJu0YyDVA6bQC+bqwR7HwSUaGDaDckFanidVoQfMLVzWw8JvJHyYvMZ
	fY1zhaZybaYjh6Lc32AvDjO8k+ruTk8aTyyTyh++Vj4gKOTw/Ly0C29QOP/XsNkZKf0xHGZwQOD
	qJqyoMYAJlhzc37u7zbWMkFU+9DGvQBw=
X-Gm-Gg: AfdE7clNLTsn4HRNy4+GyAqp1kjYljQypYZsmzDNUMfbXbqta5vdC6NAQFSbCrpFZaj
	p/14GDsko7BN9SsVxkbdKrwUxTN7r2rWQAgMF0I6ZSL+P5LcUmLoZZc0cYI1NKLzvF2rztPOzOf
	TENg0Tzac9eS6hjd5nsGBqF6hT43XAz1tJuXKrmfvVOv9rSeveql+ojr8NemNNik5iqBg6igb7y
	TAd2PK/Cqm8vbTkv9koQ3o1nt28yo2W/TN8tWAWCPKtk1oaNOVqCUARHItitf0ViEAn5Rpm
X-Received: by 2002:a17:902:e850:b0:2c7:9b20:37de with SMTP id
 d9443c01a7336-2c7c9908958mr29158725ad.4.1782227762738; Tue, 23 Jun 2026
 08:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-12-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-12-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:15:51 -0400
X-Gm-Features: AVVi8CcXJIkxfXN7gHWTk5uNDshXkkBNCoOYqNMtSDRwI4DwYtXdA1_agu_VHX0
Message-ID: <CAEjxPJ5W9H_1UzEDopsa_4ovg1o1MP2pmAi0wMXqm8wg371GAw@mail.gmail.com>
Subject: Re: [PATCH 13/24] libselinux: avoid integer overflow in security_compute_user_raw()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> nel comes straight from the kernel reply; (nel + 1) * sizeof(char *)
> can wrap to a tiny allocation that the subsequent loop overruns. Use
> calloc(), which rejects the multiplication overflow, and bound the
> per-string walk to the data actually read into buf.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/compute_user.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.=
c
> index 6f058324..d81afced 100644
> --- a/libselinux/src/compute_user.c
> +++ b/libselinux/src/compute_user.c
> @@ -61,7 +61,9 @@ int security_compute_user_raw(const char *scon, const c=
har *user, char ***con)
>                 goto out;
>         }
>
> -       ary =3D malloc((nel + 1) * sizeof(char *));
> +       /* calloc() rejects the (nel + 1) * sizeof(char *) multiplication
> +        * overflow that a bogus, very large nel would otherwise wrap to =
0. */
> +       ary =3D calloc((size_t)nel + 1, sizeof(char *));
>         if (!ary) {
>                 ret =3D -1;
>                 goto out;
> @@ -69,6 +71,14 @@ int security_compute_user_raw(const char *scon, const =
char *user, char ***con)
>
>         ptr =3D buf + strlen(buf) + 1;
>         for (i =3D 0; i < nel; i++) {
> +               /* Bound the walk to the data actually read into buf, in =
case
> +                * nel claims more entries than the reply contains. */
> +               if (ptr >=3D buf + size) {
> +                       freeconary(ary);
> +                       errno =3D EINVAL;
> +                       ret =3D -1;
> +                       goto out;
> +               }
>                 ary[i] =3D strdup(ptr);
>                 if (!ary[i]) {
>                         freeconary(ary);
> --
> 2.53.0
>
>
