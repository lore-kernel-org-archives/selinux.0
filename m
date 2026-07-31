Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15523359A9B
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527060; cv=pass; b=MHj5w4jzXYXEqab52avwWl3ukxGvEw4twOhujeJCg0y4t2kKZvp5A8Rqnmr3CDL/+k5B+S1IpopR1isLe4TKQt28tR6M8/eknP105I1zcsYl5kxsV8tLF1JA4+0am1qxDKqEdOqW3wdl2wAus1QefTng5OMPtPDTUjludezply0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527060; c=relaxed/simple;
	bh=w7fPfNuJMN0u9A+ZrOWogiZD1thU5nQhJQD7KpSmS6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO1d9ln1e1ZUEt6AT8HtHpwkiijjXgfK5hbNMZPv4VINhq59QvpUqwqRejQFud78xPVQAag2Fj5HwfLpi/VWfjGOt+TnH52z1rbSHgEqRMSVZ34/Wmt5ZmKiNSGcNqUaS0sDfsgRTOVqTtgokmubvjFAIg81CM14c+jNE7ekNBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJvxP6di; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJvxP6di"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44cf70de986so583124fac.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 12:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785527058; cv=none;
        d=google.com; s=arc-20260327;
        b=l1tdBA2wLFNoetAdw/s4XfDQ4Bc7yCe9onTXsL/roDnb05WMx1TQtL2RgadUuA1WDT
         xjacV8yA+URRd4As7TIWtgUj5Y77rV/W2qHj2VFPuvOnY7N05LjWFt8+MZxzDXZK4lwA
         kKkKpAtHIIQfuHvQabVtEIvJ4BSJt07kYGQZh1fUCOH9H3aQhoe+NWSZ4yk2uZAiN2Qu
         UX7bNH+zzSyiE+KOXjyFD1K2hENCsIFzPICC5AadoE3dQ6vbyjcvIPCCkq1VQhVIGrui
         yOanXhtaCzexjYmo4GcdLw3urjg8rVbRcMa5hkAPaerZ2mCT40fvQQyE6/jlzGLL3/Xf
         kihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7fPfNuJMN0u9A+ZrOWogiZD1thU5nQhJQD7KpSmS6s=;
        fh=SlWqAsY8k2HP2YzqEY9xSaBjnQsHgRx4qhP3O8ljNFc=;
        b=AQbTlDRgR3uyVHUaW9xt8eLMaHSTY7LuxZxBXDyAJ3qhhyyG3d1R8KbDhZNrPdB0xm
         LTYopPLQIG1CWDhBMZ2wVY388EOhj4rDpmSIPf28iBtlfbNWFLmQ4MCK6pNT5bvo8gBk
         6waoS1jAa5eHeznTky/moxPYNJrcdrlIlyJYvdpQbkx9WDAnmBHuvQyyW+H2c6oviKGg
         W3M1s6bzyY3eIC4rzLmeFfZ8eV/Ryyeb+at+28fIzGeFmI8Zwi3X3+xCZRCamm1eebUJ
         k+MkaptbI5wEV2cKCNxmD/ykymyDiS9IVK4CHqqS9yPizFCjT99YTZESc5TusVEqpdEi
         vFDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527058; x=1786131858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w7fPfNuJMN0u9A+ZrOWogiZD1thU5nQhJQD7KpSmS6s=;
        b=XJvxP6dibK6VYEs6SQV5mpetax3s3uPZJUx3X+3c3FwLubxGyAZGU7gFfKPY1RKKLu
         EX+hlTW4jPzOsnmRf3jVGXnM/JgnMSoNs8Mfjom/pCUVCZJbERyGcH2TRcdGtG8m7x6G
         itX7mef0MFndoYmySrU1b8fK3e5eUflJTm7VkZA8fE54xW9/SxoQ1porv6/6rV91MjIX
         UF2GahdxnUKPVS/uHYyajwOLKQO+X26/+JaeZJfeaYtRsIjjujXrlVRlhxSPANGdLpaf
         Lv6d72/1ciXBd1j1nxkJ9mr/J5zpSmog4FOBj8REOmXhx1rzHxEMbX6WKYLQUzW2oNP5
         hziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527058; x=1786131858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7fPfNuJMN0u9A+ZrOWogiZD1thU5nQhJQD7KpSmS6s=;
        b=nNfP6+jP8Ig8PyxRT3CtrpBGNYTsOzOfWLDXXErd7K8qoIX8o+/VQa9DwX6yKeQ1p6
         hsfm/QzwnqpmL2K4jNSc2HT474kvyulfdxucOO69ReZOYt/n5fD5Bpkj7DE8FKcfivYk
         J2XfWvPwpB1K78ybNykZiODuhK3XlPbrrdKuBl1HEYtkbRVnJe0fv1vyBg1FUyzmIFli
         EiEis6kVQ0fM3pfg1VfJmX0TB6pnr5yK8ZvLa4elbbEo4u5SNYtVpHATuKniDXx9fd2I
         U2aBuPtMXgHWispwaLsiHvU+8C4gw2IpGQmuu/JRG3KKBrhuJZTG4OUpdAujauBYYUv/
         jQ6g==
X-Forwarded-Encrypted: i=1; AHgh+RoPIQKG1GxkKueliPpktHMp59/9GPlB6YAd6XLEq+qw3JzuHgiSzJvMYKhpYKywDkCeIm5oZjN7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfl0Sw0bIBoP6oqU9YcE0M7B/DRcyQWRVjIg9fO61wsbo0s4is
	2LATF5ywFDSDc+zbdEiSSvSTZGhpY3TYj0bzOhnE4LIhie1v3cz24TAIcEFM8hR2TCa1yzVXy6J
	+T/h09E+W5Rpl08P6UlE+TU7je8wshI0=
X-Gm-Gg: AR+sD132UYJoPhbAnS60VzIMuet6zT5usW8zHK02G1HzGBJHSYkTZ++FGD/EckL6nzJ
	U0CFQbVD2elzose/Be/9Cxq3BWXNmGXh+SNyXwglNFgVkJwz0pXechtyZ56vciKugY3H5Y/zVsF
	vlttfrCE6tAIyIMGQsJwcwsqGYVKTsJVZBJy6GzBIHma/xbTA8dkiSgJeMPadl2WU2yLYQQu7tc
	W6al38E+8OsXx/Hmbjrqo0DyAZZJyiId7ZWSWsLFjGaFjNOsX8oC2OIc735L+lHZloznHuKhFMa
	bwOPyerkBNowxKDDy6iS3QGQb01mu/P40rTL5prqcn77iWjVY4m7NFg=
X-Received: by 2002:a05:6870:d181:b0:43d:1689:ed9c with SMTP id
 586e51a60fabf-45905ad6a3emr2479446fac.18.1785527057849; Fri, 31 Jul 2026
 12:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me> <20260731-b4-disp-d32e997b-v1-2-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-2-0341d038ee47@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 15:44:06 -0400
X-Gm-Features: AUfX_mzoqFoNu6fFQ2Cl3B2D0h1dEonw57JGumt6zmxBNns6K4LY5u4mtuq-Ur4
Message-ID: <CAEjxPJ61_5ctF2OPRDS1fWeX1UapAF6iAn1DTY4RiySZswaqmw@mail.gmail.com>
Subject: Re: [PATCH 2/4] selinux: require a class's permission values to cover
 its permission count
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:44=E2=80=AFPM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> security_get_permissions() sizes an array by the class's permissions.npri=
m
> and fills it at value - 1, from the inherited common's permission table a=
nd
> then the class's own. A value no permission defines leaves a NULL that
> sel_make_perm_files() passes to d_alloc_name(), an oops inside
> sel_write_load() that strands selinux_state.policy_mutex and leaves every
> later load in uninterruptible sleep; two permissions sharing a value
> overwrite the first kstrdup(). Bounding each value by nprim catches
> neither, and neither would a count: the symbol table is keyed on the
> permission name, so duplicates pass.
>
> Track the values each permission table claims and require them to cover
> exactly what its count declares, rejecting a count no value can reach.
> Conforming policies are unaffected.
>
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes an=
d permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
