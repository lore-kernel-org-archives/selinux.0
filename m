Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD243F087
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537348; cv=pass; b=LkINR/oe0iACX/Ia7YrBLdGdo5WWAD6X4adjgsV5N2DjRZ9lITmIkTsIvz5KeqGBzLfdEfiYj6xi6JNbJnH/JbyZil7ur8p1pPsEDSdqZDOZAfxi3cB+A7DBN2D5nHsubQZBevQcDgXSR5phiyLxD0ZJ0ppgE5MO9brnzNBbvNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537348; c=relaxed/simple;
	bh=tMQOD3GsyAIk8WHaphc8DUmmlL0WXuQgcwkvdeem2qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWh7ksoFffusZ3H9hsmhkzHDOp7eZ1UOYXsXrCVefWYjQHKasyIJB429pP2YlfpGB+wP7E73kBwNp0s9/X7kU2KF9GC+idzQOBi1kQorSGve/wv7ZaLXvLhNcMwa95dH7IgyVBrIyqbj/GyXQWBZuzRPGRZgld/uJeNORFS8JJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzHBzEnQ; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzHBzEnQ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-448b69cfc6dso1003501fac.3
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 05:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786537346; cv=none;
        d=google.com; s=arc-20260327;
        b=Bb52wObka+VQufbSjM+BYBc3JLxl4BWIPPXpNELtF23Nk+PRfKsVjH9CsVlOGAdwJ0
         0fYKppPeinXT4fawH5cfg7F39/hu7RUQdaPXbUo7QduWsrS85rv72wHvaplYqXQiZD13
         hSb132xnAAVLvT0vYSJMLb+RR615/SXoO48D4pr2wk5FmuJeD7u1MzhyLUjkx4J8nA9o
         NaX4n+k83YGghBp/y2Q6TFHbByzWm4yI3v+SbSU4hfHePoPi+JwkjSWieGKey6LUSXGX
         b2zsE2Kozfc72H3sp0zmD9Qr8H07bbnN4IcYYO9Abjmu2ZM+626DFnUr5uwN6K3KbM8Z
         0zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMQOD3GsyAIk8WHaphc8DUmmlL0WXuQgcwkvdeem2qU=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=hA4F7kr4orowQtib21FU0MLmdJmN4xvKFZCZ4hxpyWlyCIjz1Twk0Aso96FKjyYH4G
         YQGYvWtyoIU32F2yqV3qQ2/HhutLBIH39pUWDid2S33CwLZvMfBph1ETgjzlNtAU0M30
         zQEuI/rdZQyaUkbdjV66mcTKRg+RDlOh0/iUER/NJzl9ulZBao7nF+eKZN5UTb881SAn
         oBHfGCfHD+mOBRXa7RrODvfGXv6qHkwPLl0y2BC6ORX8OGhXJUTz4ylONnRRMo5vjPbp
         pftQPfrjpUC1KKyIje+bXuOEgmTPHrrqPJ9ssIUzT00/l4I3oodyJC7yrYNq18nhXHPV
         yL6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537346; x=1787142146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMQOD3GsyAIk8WHaphc8DUmmlL0WXuQgcwkvdeem2qU=;
        b=hzHBzEnQ4FxxvbMBu8GaeXSXpXcIBichBk0YUXBkNx1udNrYDc6h0hvWVEToKSXC8j
         czolXg1BHNLNIM55/+R0dyhBai1vmGHDWSTAZ5dzMLoq35kJDthTX2oT3SkGjfNH25vr
         w4dUlO6tEL6LDbQZUGSaMGP5Y0BglsxfGXeiBQXOnwfU6Hxyae9UtmRHF+Uy7DStld/J
         B05ap7moCWATL54zqeQ3F3eP9VzzRCseRlIcvnnT0+iAADkkLj3XwXB5QpoH3Rc5sQT/
         +Mq3Y20QyQ50vju9HrooqbiJHdFlhFsXIy76LnEMVy8rd+2ef2W4sVKRB5aZxCEk3ylV
         KCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537346; x=1787142146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMQOD3GsyAIk8WHaphc8DUmmlL0WXuQgcwkvdeem2qU=;
        b=l84Fzkp4Eew5WgirB0XNEsKrrXZsYpcbPkc1gjYYRFGqsWvtj5BAa5wtsj+k70N4Dl
         Ja2gXc+mJSMWexTUlpqEG+pKcMn1ebcloWSFcZ+qFRA0uDypO8A3DPDWRgtnJ9D/tQM2
         RWx2I488Ih6U9v6qUz4yiwvf+8Jnd14epXXOAXq18BsoXTydIuyHPycO114/H3YZzNA/
         xIYxtHi1CnpHOqNppKb2opcskZqJ7fQNGQzLpr9wf/3ln6k1qh/UOhPXjRSlF70PHcpo
         BsWf8Rsh2j2Ekz0obfgI46yoKg5+w17/I8yOtFsFRERbKWkiur+FDYZLdADgHp4kcp/A
         1xog==
X-Gm-Message-State: AOJu0YxHyFYPVPrDEJDO9rMZq8h5C2cHvkSXdMhjrLpoxgnoTOTwXSwA
	Bb2z9g110Q9cGGPEACfodckl5GAXo0E7r5bmPmaXWRClgsbCRTtYt2012WqEjzI7UcT/bw0Odjj
	rBGr43Ihxw/068LGs6uel7sMg8jDAcEU=
X-Gm-Gg: AR+sD10zP3gBRR10ZKCjCSZA7R67LpyZ85hcC5QyVW/iGK/zpqEQKtDtiU1e36UVszK
	RteAQE5qclucwb3NayocNEUnaFD5Uxp+kl34wma4ZZEJCfjCEK0/zxdmC+braJH2nXZskVVMuPV
	Vnkr5Y5K5z+mKYNKcnyTIjYzK2fyI0dmp/aOsPHe7BmBvuLY+YNiH1fTTsk1fH2TsrOuO9GbJY3
	ANCIc9bq3PmvBJGX/6YlL8f0UPr6dqJdR/4A6N04UcljGhP8KBFUPR64z/65Rfc6OA9YnytgUIJ
	s2mN0a9ydNSUoIavkIeEx4X5tCM+6/506wpfL4Cb7IpY
X-Received: by 2002:a05:6820:201b:b0:6aa:e176:bcb5 with SMTP id
 006d021491bc7-6b0b2561305mr4017574eaf.14.1786537346361; Wed, 12 Aug 2026
 05:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811192216.140092-1-jwcart2@gmail.com>
In-Reply-To: <20260811192216.140092-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 08:22:14 -0400
X-Gm-Features: AUfX_mzTGShz8oCBJkCE-cdKLmUCscufzr0wPk_jnBkQUVtixwFImZMKTEO0w7A
Message-ID: <CAEjxPJ4HqYb08LPJSmrAVWR=M_gQ1DqrMZSqkhuYWH_+j_R_nw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] libsepol: Copy a chain of type alias references
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 3:22=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> For a policy with multiple modules it is possible for there to be
> a chain of type alias references where an alias in one module refers
> to an alias in another module which refers an alias in a third
> module and so on. When expanding a policy with this sort of chain,
> a situation can arise where an alias being copied references an
> alias that has yet to be copied. Since the value of an alias is set
> to the typemap of its primary and the typemap of its primary has not
> been set yet, this alias will end up with an invalid value of 0 and
> return an error.
>
> When copying aliases, skip over aliases that refer to an alias that
> has yet to be copied and keep repeating the copying of aliases until
> none have been skipped or the maximum number of repeats has been
> exceeded.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2: Move MAX_ALIAS_REPEATS to private.h

Thanks, both patches merged.
