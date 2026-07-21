Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A94318BB5
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638309; cv=pass; b=btuGRdjH2NSE09lC8HpcCdhHqml4ikgEMfVwInj2+qHU8b0sbnc5jXO0x6/fPimfMHjU9Zn3bsourwRjbIcgLdsYsRFh72tGUwKnYoZVFP5fhK3XS+n9CrI5WN5MhbG2JmFRployANfobpElAVcK2bKseKGCqTc7G3PowSgdyJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638309; c=relaxed/simple;
	bh=NLNK9CjR6HvKwUF7ZGsArRYQ5lGRB03YXFeAGvJQwgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQso+i5AUaZsUO4Q4Zh5fNfARVK2avjdFuAM9pDHrn7qlojibhqUqBSnVeqg6pdRjo9z2wtP8U/GzLDPNnzSkrBT1io3L4xva3qrb1/NdHiPoEPsnjjFe57m5lE3UYgHxUmmTegG5lgoMo0kiPAEA8zMQ1uJ1Ut4VToUDdCdfX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lasG1V56; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lasG1V56"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so7293552a91.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638307; cv=none;
        d=google.com; s=arc-20260327;
        b=hNavU7WV6J8oBpnxcO3cfHwolQ7lW7C+YfSSpufEeyjsM+2nhtG9yQmEAs2huhI4+2
         hx/SCPpKylMIR6yihZ5JsAyXBXDo7nABIR0ghgxBGEQj6/gcqjPP4blnLQC8gb7pPiCN
         kiXKHFYHwnLwtcZjFl/5ZHrz65aXjzdSxhViO6K5mcBlQxFxWPLEeu02DAyF47zt2rUq
         sqxuycz4TiJ5s5P0h2XdCZ/Eat6d4b3FB5+EkAaanJexREqgSE/mGRl/tcnIn1/B7+ph
         52KRZfB7W8+8r/6kWhOxBvbfEIPcrjdSh6NeizRswuupTP9DXC1b6vzGaHiLaEnvcUtQ
         tKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bSRnlbkTAA/LdvkBPa93txSJ4N6AVWjSdjgh2mfPIJI=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=Vc8miMvk1nC3uPjz5QULfk/l4QclfRZT7G5UUsNHioCMzxXfswXkoozBMnxTCv4ar3
         zDDGehnxciZXoW4TSnt8PHR7QLcPxfqf78F9ZqF/ccGhOrXvfl6UmnxCzUTToRaZ63BK
         4ZdE74OYNSh+o36iHrdmiF+oyzzIri+XqMst43kuyqRgfh8dthJGHc++PYacvzzf8+sV
         Y0fpYhuo9KL7aZ4AWrFIpBfq8XSayAR95r3/Em1lEbkf4WGOhCPPWhhKoLZIdT5ulVA/
         NDAO1zztgfyJBpIXemXDN73ITOT9iaRSun2ZHNlkCnmTGeWuLNbhyXxtPR2UaizVG/gH
         RzdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638307; x=1785243107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bSRnlbkTAA/LdvkBPa93txSJ4N6AVWjSdjgh2mfPIJI=;
        b=lasG1V56J1gINfHv4cPhg8eisNEEo97sjBGDHeNvN0CBK0n2R4uF4NiFECiZm4glXP
         vOZwsuS5fHXej94ufAJ6HzYPQNYRrkLxLljXU/C0SMXZIy/EYA1Wbl86FeLrLFR14GQL
         p5YvdateHr6SVFxBoDPHoZc0XJS06SfOuDMeJkK6pT4JcJGo+/Ll5eGXJnk9U2EnyVZl
         YcFL54z9JaDfHrOndgXAQOL7/mT2Jh6X9Yg64XR+6OiWoIMcU6OJ2vhjqrycfuFQsEZM
         fgt8i/+0PEBKEYrkT27uppMrQMYNlVr8KscsWbA9TnOJ+UsLUBAAsAQOcTtL5alhuBa/
         UWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638307; x=1785243107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bSRnlbkTAA/LdvkBPa93txSJ4N6AVWjSdjgh2mfPIJI=;
        b=HSBnhgeCrvELGr7T9zSqZ5xy10RNOWJNDywvcTcdVUS1F8z82uczUkjMyCUX1T4//M
         esMkvV59vupLazWN4hKZCQq3He161P/0ubBl93RP01K6ENX2OIYYBnX5cy0O1JlhFL3W
         GnF3gddcDeqOncdlNRErTOXXaSdJbj1mXJDE3qu4M2qHeQjLQLq1wGiw5V9aDYoUk7pa
         5r2isM364AAfLjsMcPjuzO1o6eHEYHNhSy9t2fsb0x4PCQPjOSdVhJ4FtoauIO2eCRYs
         XCGtwtNsEb5xsSA+VdWMRuI6sea1A0hA1gciyOQFj6HDenZoRosb6jDVndNq72FD9B9s
         TR9A==
X-Gm-Message-State: AOJu0YwI3NfUXALxTaGe3gDgi+SarKXS/UHXEFdiEm/zTyjWom+aJ7DP
	btr7j6wVJhliM7v7htzPdqzzM7ImR5+2gOx5AE25/FNLK11ebQ81B5q0ER2pbWuuqjMrtJS/uY7
	CyCqXAlUgNUd2OVgvevqtdoPY+Jxmq1gZ8w==
X-Gm-Gg: AR+sD11PJx/3mIoqDGCC6jYw23UNvqaJ11HCq3tNDQU9y3R4VdSFbQZAdYdQHY7cNQj
	oqjrheyy/dO6N/mvrk0THD83yrkovLvrf81mQHrbsSaFTSA/lw1UtmwCBjbBoPB/WX/8ALKDoTu
	fMVDXSc+WAMtpICexnZ8L5YPqsQPtT6MyVMzR8crwTTbT1O1a+RulNgVx2hbuvNbHvQtQ/q1ECO
	iJTnVkVkyhkgouFlIy9X0scYdo1o55klk2XA/YRMrF1RUD3dCTPHtRbyANE7A==
X-Received: by 2002:a17:90b:574c:b0:38e:4011:465f with SMTP id
 98e67ed59e1d1-38e4b516626mr18392898a91.23.1784638307300; Tue, 21 Jul 2026
 05:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716151405.9158-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716151405.9158-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:51:35 -0400
X-Gm-Features: AUfX_mx2occdvjlF5FPGBzEYEzJ1tt_YgvoA0YDHt9IgqwOo0iF1leBzjQaqg3Q
Message-ID: <CAEjxPJ4aj0zgmUVxT-rTMGQDMBzBOuj3SaQ8=OSZBo9J0v=WjQ@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: fix inverted alias skip check in compute_trans_from_raw()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> ebitmap_cmp() returns 1 when the bitmaps are equal. The
> skip-if-alias-of-last-bc test incorrectly was comparing to 0 as if it
> followed strcmp() semantics. Fix the comparison.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index e79aa3d5..8ed1aa95 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -1623,8 +1623,7 @@ static char *compute_trans_from_raw(const char *lev=
el, domain_t *domain)
>                 if (l->sens =3D=3D bc->level->sens) {
>                         /* skip if alias of last bc */
>                         if (last && last->level->sens =3D=3D bc->level->s=
ens &&
> -                           ebitmap_cmp(&last->level->cat, &bc->level->ca=
t) =3D=3D
> -                                   0)
> +                           ebitmap_cmp(&last->level->cat, &bc->level->ca=
t))
>                                 continue;
>
>                         /* compute bits not consumed by base classificati=
on */
> --
> 2.55.0
>
