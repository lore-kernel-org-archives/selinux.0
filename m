Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994663;
	b=olAKdPHi0jp/o6z1jh99QwxD+IQv0mIjAF7ZPz55Y+CpU4M/tHDKITNS0F7XEdG98c1O
	 h3Zyu8XuR5jbsqj+73fxb6FzF4cIXYloF0zLrEH+s2sCa+bZDFpVbXHCq07GB4WzVAYSZ
	 8DLPzmWUeqXyKxxlcR5MWU78MjOGlO1B/0lZ9uTSheOuWTQ1PP1s1fADM9rFstfSt4YkA
	 KJp9BAo/5+7mYmbxuEW2hdQZyyu7F5jBAtgaqNT8HXRTCwD8JQZ6N00/v8nRbtGiCmaCv
	 8W0oCO4seKwDVOeqFG9zHYwYzh6IuvjCrS6/Pw6oC/WVqDJANe5JGBDEtHqA3gy7+7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=myAXkbCh1vscCZV3UJh0Sj7oi0V3m+SprEZBxE8qVMo=;
	b=ipMvJqDaL/0i4dNVh5PWfIMRul10zWQP2Ek87o/VV8rsDiANBaHGyv6vjyOn6PjZQtyh
	 9EmPUEnfcoExdIUGSe4CVXVrxMzOVgNjXQQ4fkG8Q4MjAFnJp6SCTzx/4+FRFLbXA4sve
	 Q6ojIKneN0DGR1fJjnwBuTTsV0XNT91F4qWO4NEgD6MDJ183EMKc7LmX9ECnDTODBGIi3
	 LviByqWSpM1Vo6edygfCZfORP+gzih/li/AQOVasXXiVpzBr2Q4TLztiJOOVm07Jl8O/H
	 oGYZMbwrUhy2sktCYsvdbSUhFpFYFyXMDJXgkcQVcmL2m/o7hooTNhKQ7LIm364yfUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUxim4J8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CD606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 476CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUxim4J8
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so1228477d50.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994662; cv=none;
        d=google.com; s=arc-20260327;
        b=U7/yUYc1jNe0ZBLBzz1bzlCFyX+rrUs1xCpnRM3/EbvCV6Y0FVhmhEym+NGBvEJGcK
         WiWGEYswtVJXvxa/PvEO0y0SbMXpEIq/RcH9yJjbdwKWAFLNcigEsvdN+j6CTtuqjQFa
         LX7gThkmHHvYaPqBvFSDimN+JJzpVnMHDebuNJVJqGj9lu60a3aQdrfl6zCFWY0XtePL
         teEJK91YVsRDf1Lgas4m1YX5MdKKyFStgHrgn+5B6DBhsKf2TPGdW4c8xYIY4tnoIYy1
         vf0GjuVRB6My7igzQTQjOfXJCH0Kwbfp4O4J0RNRcB/7751rFM03jg4i1h+vBWBkLw1G
         02Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=myAXkbCh1vscCZV3UJh0Sj7oi0V3m+SprEZBxE8qVMo=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=IMX5Me5+MtFFvuWpk50juOjksNEqWYZoy+lOH2OfvvGDDYSY1j+hCTCJBQTtFWCWDG
         pqhSwm+knXlYHreUljHzREPM0j6/yOZCd5OLo9A2DOtAGwk3mIE9loIjZXFqhYJtAbbx
         4yxwkv5ADust1S5gH0nSBh0CmSZADnpzp0h0qv5bDLYsM3mPprMLgz/tHtL1NPf34u/C
         xQpuc0vAZVHCVB1O/ZY/VIXuj60xkdTBJT2K3L70WErE1ntmLjKkcMvIPKxoApzyFKuO
         DjerG532hn5NjGHrMvd2ByVfwOgd+xUPdwHXEkLIE1YEkF0Jrk072dlr+V31M4yWSwkc
         6SUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994662; x=1794599462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myAXkbCh1vscCZV3UJh0Sj7oi0V3m+SprEZBxE8qVMo=;
        b=DUxim4J8qDJtU/vaIe4tg+LamNFuVspSI0wWwAKdKAIZ3mqMu4XPIhsH/VK9v34O3Q
         ak/eTxzCQxIZLcU6YHU8AFoPs19kkO3M8bRIFJcyerNaXYgva88zbMg5NjNYSyxWnibD
         0VwkmDceh6D51mDbwoJkiIZiHxrOp8ZhjLAM7hMUC70R6kNJjxe6PNsI/kzpaiVyO+Ch
         XEW0jSz18jN7ow09K3gn4+6OQ8ftn4RIdQslptfHgpSSlDpInse0sNTvgMCHs34WqLI0
         MZLnwVEj4lRYz/oYdzHJ3/X54xJ4X9tP9USxtDkZGJ3R8PAdkf0FcrTcQAoXYyjcDqFD
         nbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994662; x=1794599462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myAXkbCh1vscCZV3UJh0Sj7oi0V3m+SprEZBxE8qVMo=;
        b=PM3SFCA6n188IoK5dkf00zg4WFxtJ6FK+nJQ64GoORqaZdy3zRO8oUEoC3gNkeUNVA
         3bqstQ+tuNGnQ4ihIZF/5RgfSKqMJiGrwVNk2s9b1lnc6fYc8Q/gajoTtsj4KGBzMZBh
         xbodt/YGXbzmC6URveOtLzl11tJeKizXiWzLIFD9/zbbTRPMk+mMZ1Ms1T9VJT7v/fdL
         W4YFKhZgMwouQwWio3WZnooGlQ56bR0qlqy0t9Sgxk4VWwWTqZxFQ3mwKJkaz1DMUkVu
         m1RI304qNtRO6Lbe6aDBf0V9ICM2H+puWh0tmx6L7LP2+5EKad5VFPBE+Tm6Zg6dLfRp
         vTgg==
X-Gm-Message-State: APuU4Z+2odhOEdmcWoftNIwSyVfOkXG41HmvmdUbBROYdeWWlNNyWK9P
	5gZD2fRRn+TxJEbHaRXgVgBP9Kfm0J4/wGb43A6cIWH4kNR/xK5OPFShyRFSYx9YEJLP8Ckj9s8
	cjhJUyueW7aIrCeOu0XKGRhjm/f9Sqjju+v3TZAg=
X-Gm-Gg: AYBFou2HITQ2awmDkhW96ML7Hl9+lZTcbQfV9xUVux7QEftDfU+JvrI9AK2qiveszvs
	jwk8RMpZ4591ue3KbmNvsAlXxqpCDSp6CPtGSJ40T8yNKeHydAl0gHenDW+uBc8MUPfGSgfZJUw
	tgaQvqaZ/WjMYyEeW5SWMs2TxPC2iu+cdYz9VsU5pf09AHGZ8UPjYSTQZ7BkovaPmeUI1nd8iYe
	HW0eJ/Tl/J4HfDCjE3Yk7UaAAXUJK5Xt4EBPXxlvMIXfMoDt+wp7SV3dQaxYn+4ta2DniU7Gdv5
	iQcvpivhcBYf2jjXg2HYQ/wjYWCeC0rwcyStKoz2EoYhl3GUvZKbFw/QxVdzTPahyiu1w09p4Gg
	4Hfuvb4V4hVY4IXPl50FZjcUz8lakr/xfl38C4u6LMhpjAxH1C3JXU4fvrn+eSJesp/36K5JwUI
	gRddR9e2LFjdThqgekhLQC8TT8jR5SbHwAQVidHv0WGpaGb02hCtWYALqqxujgvW5QkSttwWBIw
	tJGrC8=
X-Received: by 2002:a53:be4e:0:b0:67b:e92a:5ca with SMTP id
 956f58d0204a3-67c146672e3mr1297136d50.104.1793994661375; Fri, 06 Nov 2026
 11:51:01 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-7-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-7-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:50:50 -0500
X-Gm-Features: AclHuK8YPXW4odrJngX3nGWpIyYAOB_8qI8-2s_kZSocEDIffpSsIrzo6D2_qsc
Message-ID: <CAEjxPJ4nJchGTVcN-YAAVCYC49zwY7i88rDbJN33LsuLh10taQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] checkpolicy: accept a class listed twice in a constraint
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> define_constraint() creates one constraint node per listed class and
> then assigns the permissions to the most recent node of each class. A
> class listed twice, as in
>
>     constrain { file file } { read } ( u1 =3D=3D u2 );
>
> gets two nodes, and the older one keeps an empty permission set. Policy
> validation then fails with the unhelpful "Invalid constraint expr";
> checkpolicy 3.11, which did not validate before writing, wrote a policy
> that libsepol refuses to read. define_validatetrans() likewise writes
> the same validatetrans rule twice.
>
> Treat the class list as a set, as other class lists are, by skipping
> classes already listed, and add a round-trip test.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
