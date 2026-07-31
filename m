Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206322D738A
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520767; cv=pass; b=ZUIUlKryP8DFFkVgTljB6xsOjAWF1MO1mGqGO+jfi4gsbZ+lPImVV+ZuKLk2m/62icN1b84Y0/Wkb47Ztyh+wx23F1DbOwXwqgIGCal4XBbvbWL7NYXmFikIVTT8QGBmdBOw+MIRkIPL1AtrcdZ5XhYuCSdx/8W8RHux4MqXRMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520767; c=relaxed/simple;
	bh=kDfgYT9mORR40unlpLxt3YyPJlOl5lqP0ZZ5dMJTsDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwA6PHSuF8s5zlhseshBHLij2MuHtQeKGbbrpYEDcqUAUePA9EUtQ66KhY9lq1V6VM1F1v3Dywxb9WAnzhqsPN0K4uW1rSYF3W37n1NGP59IPx9yhPg9P8R4rHKEIGmQpf4+WC1afzW0efYxu8c+HJjg/YBx22QSsaVz1v5wAaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smhl8lbk; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smhl8lbk"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39ee96f8047so9380711fa.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 10:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785520764; cv=none;
        d=google.com; s=arc-20260327;
        b=FvNGX//J6SBzxcNklrFgiUy1etJhsXSeLESzTqgQh9A+/f5eOOuYDXrfHwAGQHGjIQ
         dcm+KYFblFriHftrtu+ZejnntVLlUIuadwMHx3PzIucCc7CLEg7rZWV0xo95FZtRqmc+
         EZEdcSgYKb5r+kFQSo+8GMZpN9K5ktdasXzwPP2wuCuI3PDYl1zMNQrDxPdzcUmT5Qb4
         oYCHKCcLzL1ikvXrpdqYNx2pjPb3/nDJGHlzGUMIOEruVN9hdZzGxjQwbYnmrN8jCorl
         RHuC7/MDgaQG9FToncRZwPNLvMpcH98KkxMFaoXr4QAqIEP2yf5vsLEOWcZbWZj214kM
         QwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MK9YFTiRHCseqA+FoD5siahMc2QzAs5NJIffFbBj+VE=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=VStyX7tyd2zYbSx2sr0n5vN1C0WF5OrH3IlsK3IsItjQQmoyVHqmsqzTCpiXVecPJJ
         tJF3cCOkjSL1nxJL+tfeDR58IMtVvCMAc5Qb5QdOUPuxS1qkiRd8vdlsGVPgv7p3KmCO
         XGS0XFBr+9ttBFrZ/ItD7Y6bs5qCLbtO3ZAddn3dY0mbU1dvL5ZmkKHeL7euDiYB5Xb9
         oOkuRu3PvuIV4YIbWEg0Pu3SaATz2ulApUiOe6NzZuOXD2E3SouWygcfGq7kpVhQpCXz
         MSmlZTdIWc8Fvxv3LzrXFZzsf9JwlbYMUWKf+K1c2UP/whKo+My077a/vO0OEGFOP/ya
         SPcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785520764; x=1786125564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MK9YFTiRHCseqA+FoD5siahMc2QzAs5NJIffFbBj+VE=;
        b=smhl8lbkDfeoQ4SeA8gRxt8AEvao2APhEM4A78Np8+38WWD6ufHZC5U02zC8w0oY23
         kqdhWa4yoaa8ayAgPWyxo2PcVO162IFZCA7C5mM+xlaXdRDe979+KceqpW/vV3r+/w1g
         ew6zbz9GsJEbpLuO7xW51xNRbrasolfKlf78NeZsBIRQPrSJbA/kXm7/0xzS0R6wXIJP
         FhRSw54RCQAfDhq2928gN+PCKj8syJPitnbMc8TwH+hW3C0HYhXgVP7FDgcHS4CfKafZ
         LTX5YuO/lFskzTkRpKp06T8NseCHkfVnZSxs567up6DmECfv6nkWGQ+fLaAOmCR320Mj
         0+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520764; x=1786125564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MK9YFTiRHCseqA+FoD5siahMc2QzAs5NJIffFbBj+VE=;
        b=CNB6xqQxmjoOnG/p6/2eTPQT793EpgqIrgg2NVPx/0Ai8PDywA/GPsExMff6sAhRz5
         7nUgyzPj/O3ktElat+J0u2FWoV+b41DsMMWRXaa8xALY8in1OOGCWR8GkJ3kj3mQgbvE
         gls6uJYVIqL81+tbOB1xSLCrjPIiiZeGypwvYmPgnkLxEsEFB7X+2mjyAINf4ThLicvx
         h8laeClxy9rXAX/hi96DqKJ6Jko+D1amYh18UliRqMi2DCtPSJTRV4dFydZxsbq11msk
         /OF1fYckOtQ03i8LwLcukAZeuFVQBwPpTRWVBFlfXX5PbBZ6o+oQhdG1h/foC2jsoBFZ
         0emQ==
X-Gm-Message-State: AOJu0Yx3mTQ/HxH1B4+GY0NPJKCpZ+dV+8ZlaDfvSA+cyoAS7r38ThJI
	pZKMbX5KaAFvy7ytKj9MJCtXoZgiq2Z6FtXASejv1S3YqdVEINT52UulLxwklgmU5G5Gnxat+b0
	BEo00r/xcbLk2q6wrJviA5utUiogVrbs=
X-Gm-Gg: AR+sD13RlwgHISXMP7Ju2l02PHnxnbxY491weLeLFfuS6/um/HnnDQb+eLBr4FQkMUO
	xua+z+cbOojEHJM4gWlzsDVCV/YyWvwK1/qYAEiRN7+JR5pvbegCeUGYsZyvXe4odqnaJEGNCvA
	K/4wrkR9DX5Xn88Rm5ieAe1h3S2zruY0Pfxdf5qgXmcCqV/mQLfBB7vtxjYqkL2cp6aoNAap8z5
	bG5DSRYgW7O5dZO1Hl7YWhZo+/nBCivIkhaYRDw8jiXA6xzZHTQdze98zeqvMha6KHyVuQuf70S
	H3LIPMNUVCRWHXCMrB5FeoiKlxRswtz3794o5it6B7iI1Y6khTcHfyuhmFBSOlWm
X-Received: by 2002:a05:651c:222a:b0:39f:8299:ed78 with SMTP id
 38308e7fff4ca-39f861a6ca1mr915221fa.18.1785520763938; Fri, 31 Jul 2026
 10:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731162033.19084-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260731162033.19084-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 31 Jul 2026 13:59:12 -0400
X-Gm-Features: AUfX_mwfzH5_9hbBVgF8jr5a1_2x6V4Af5JBN2-0Hzfvz0oFSvb0cdOzZICM_6Y
Message-ID: <CAP+JOzSGULoBDEv9unxpF8V7uj+DgJndA3Fsxi5e8=m_Z5Z6jA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix direct leak in user_extra_to_cil()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 12:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Free all the strings on the exit path.
>
> Reported-by: oss-fuzz (issue 539257834)
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 2aaf4feb..06fbdc30 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -3680,6 +3680,8 @@ exit:
>         free(line);
>         free(user);
>         free(prefix);
> +       free(user_str);
> +       free(prefix_str);
>
>         return rc;
>  }
> --
> 2.55.0
>
