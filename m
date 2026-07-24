Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A886BB5B
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852657; cv=pass; b=CGSt2/Om9vCJt6zcri8ustc9FOdLESBb8wqUabPRZjIOEIAECXquYCt4g2B3xXJLUwmz5yIE/n9Ct0NvJZ2hv2N/OYUK14ge4gz1bvoCtu4mOiuiL0JInOLO7kq3SHaAAec6zW2m1RD1td3R7Z1TQ6Jm4dtjaXnC2FDOfkR5T4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852657; c=relaxed/simple;
	bh=rAVozhzSrd5UJMrQDEsjLNmra/5ADL7/PfARkvnc9q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzP7Humv2ZTjmJ09c+Ciq164R3Ue0fipF/EobRhWV9StULgS/pu3Jr1r1q4E6ESrNM+2r+zH0BDLuEZiySruZ2nURG/LxVGJPAOLsDCeFrCrpcVRklfEjrYTnmkbvCAo02OonrBIcQaW3APIuG8l8Mz6NKM9lw1/NaHXoRACeCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0xJz1hp; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0xJz1hp"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c10ed63c0so22541cf.1
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 17:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784852655; cv=none;
        d=google.com; s=arc-20260327;
        b=hu0Mcnh0aBlNu6djO47Yx1TgDQV70o9XTX9MIaex0JaIVfp0fAeNeWdYaMO0TTUsdw
         YcJpVkGJCfpvLDGY4dBkgMiwwNTqHgdeJ3TkGBHi0bKV/izjg9XQJ0AH8PKF80KQMoh0
         o0pBYr3t3JKYU7gOqKlWLYe7rQDxvzf5507uSxJTd9bZ0jdz+IVdQ1oLAAT03L0VSTAQ
         CIg+NPnSpCXOd2Nfm7Uh0UD9IxHBvTCp7c6n9x/cDkS3TxU4nuEstXQfkbSKCGR5031r
         UNrLJQKGZmvbvjBG6ysghRRwGLPOv17XssAdoy7SwnxzF9ri/AFJA+WzWt6h0zhi7Bq8
         /GQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rAVozhzSrd5UJMrQDEsjLNmra/5ADL7/PfARkvnc9q8=;
        fh=3rucfQrEJsdE6jJbU8xBFozXGlWc9mO3Wy7QMXFxP/0=;
        b=R3+77Y2pCECnPlDJAs2rwEGVF2bc/Q0Z7wIC0w5iiSqxgLjggy8PuraAjh6BWi2x3F
         9Q++YUquacZRrfTf8SKsSKr11+aOo2qh0hgvbdmU5Qyb2dfRD2VjqQKiorzKki22DSjR
         SX9M/WC0bSTK+7Vruz+8cvIW5NScJPBJnO5pd3V6L7fT4RUZnbSxX9P0y+wcyi3YRbCo
         brnTnQ7CRL/xyLVcenV7wAaJn6GoqgAhEgplElYQ7mhnUvlJ+xFkSc6u/Y1k+Doe3ZoA
         9x3tRcpLFKms7ZuIxCYrm7B6gQZoGy69EV8cUvMCdgvKfzxvhNNjeBAgHMy4IgXYQwlo
         IVvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784852655; x=1785457455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rAVozhzSrd5UJMrQDEsjLNmra/5ADL7/PfARkvnc9q8=;
        b=L0xJz1hprJ/d7N9/jkWx6rbZ1EJuYc646jswV/qoajcYJzgOrMxA/KGTxt5gXhhlYH
         jszKQRML7X3U1z4/WlQE8aydn5hJE5H4NwZWqgDWYQIZyqjsNiBowErNmdjUUB1J3OTX
         y95Cim/n4nbFbN4CSdmCq0DmNKTcQb/kPoHaLYaWFyCs9Gkchm4t48ghw1GkW0q1DwBG
         vlZ10rgtklAKiBShbDjdjndrZFbqf07rgFFDmVSiDFXowaQ7s+dAT3D7BfVaPS5bkgE4
         ZDG0ExUvLH/+Hqt3vU0Qk5e1TtbBoqPLrgET3fu0VYbY+ZCEVEjuC7VoJmzMMm9tZ59B
         5hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784852655; x=1785457455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAVozhzSrd5UJMrQDEsjLNmra/5ADL7/PfARkvnc9q8=;
        b=NwSGyXqSvbMPYMmWENTXMLb25KYU3YTaHJbHyXQ6Da0J3HlQjylnduw6vDmtLVJt/N
         zB1FRr7cvb52xxdWnERYrAtByzuEcAc5UO4ZHa/a+nkMf9wEDfE+JjgEm5GwSoKASZq1
         B7M6mZIE8CTj8pgxtzFrymneouaXXBY5IUVXNjkpbMFhWLvy4pu42MFCrviwZ2i4hFLW
         L1twAF7Q/pO2LLjr8NNqpRh3uuy+1FHO4CS/RgWNxOMCknSLzHh3R2rNKUsJdqHNpzOn
         qdxwa4iMt6OO/VxOIlRgRtRWREcL2YndIvVBgc/Ipp+aIQaOYf1JyKD5Punh5DjCu6j7
         sCEg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6FqKs+It0ZByfDUfvK1E/ZwoKUHF3TDrvxU3hxUmWIocf7lIDxj9Nk8NYGSO2LBK+v55Q/uF0@vger.kernel.org
X-Gm-Message-State: AOJu0YxECiV20uI+KPvTmemdzzBiFY8OYwo2LijbrkJPODoqjpnGhaBO
	qEVwYuW6CM6Gw+gYcl4RhaUUVZSk15pAgWnwIjp1uEIObX//iXHDxbe9E59K8XgC1uENlejeECR
	EBNpEZkBqsSPYQIi3JoxQj46PZGRyGqZTiGRQQGCc
X-Gm-Gg: AR+sD128m+v3ahuryUVHPg0lPVmddsPYFDcPlHHC61dgCRXeXEley+T+Yj5QuyfkO5F
	EhPlC64+YSKs3qDi7okZ3pWjlZc+MOgI1cWzny9M1aPCGK3vGqyTqqj1IcbrI+pkMgB7fibN4AZ
	KSDn+GDl2WP4U675BmotZXJt5zaT5fHhGTAv7Q2144n58bDp4MaqnaWwFiwthRONXN9qJsa98H3
	r7HDYpiEGF1zdur83whGZwu5ceRYzYOFoi3qi6SGwFBGKwL3PIL0nyVV6bJy6AQTZEgJhyT1/CV
	fIe7E+/V9OBND4+LOwhQUr9bMveUppYi+mukuWyj4WXtkA==
X-Received: by 2002:a05:622a:1448:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-5284d0af45emr2636201cf.11.1784852654333; Thu, 23 Jul 2026
 17:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <CAEjxPJ4cexAeJbQdDWzD=NiyukP_THb9PHhTYi=n8ww+3bwrCw@mail.gmail.com>
 <CAHC9VhTpaqdbd4NOZO=2G-OneFTnoi4BtA-JeB_o=hQO6kCUWw@mail.gmail.com>
In-Reply-To: <CAHC9VhTpaqdbd4NOZO=2G-OneFTnoi4BtA-JeB_o=hQO6kCUWw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 24 Jul 2026 10:23:57 +1000
X-Gm-Features: AUfX_mxUR1vliK3hUvGoEFvQ5HugIluvuj-6bvAXwxOcG8J3ks_zVCgh5FTNWQg
Message-ID: <CA+zpnLdz-s+yQg4EnpFXZA5XGxN4mF66cuXLFXu7AB8Bie2tHg@mail.gmail.com>
Subject: Re: [PATCH 1/3] SECURITY.md: Update security contacts
To: Jason Zaman <jason@perfinion.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	selinux@vger.kernel.org, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:41=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jul 23, 2026 at 9:42=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Jul 23, 2026 at 2:24=E2=80=AFAM Jason Zaman <jason@perfinion.co=
m> wrote:
> > >
> > > Part of the annual cleanup of security contacts, drop people that are
> > > not as active committers currently. Thanks for all the work over the
> > > years!
> > >
> > > Signed-off-by: Jason Zaman <jason@perfinion.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>

It would be great if Android could still be included here. I'd like to
propose myself for inclusion, if that's possible. Thanks.
