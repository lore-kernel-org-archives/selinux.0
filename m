Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9734E4332
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363742; cv=pass; b=nH7x7C1qMqXt2IebuZNyCH8z42YkfnGr5qperkFA+bXhX4qpDLVHRvuaLWp28TmQ2VP9aFaZhwUB/OlQ0t0jF0ispaPvOVxhYAHWP2zHBMHSReB3DPKkD3ak+L/QR/CBU7tCbD0IBtrzZUqX4xViADTEqkeSMGQJukYTigttmnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363742; c=relaxed/simple;
	bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGAkMCKKaAYJ6oap8hw4Lxwde7mwmeN+xS8K+N9E4HOKC77Tp2XXk1h+F9VVuVF1LvF84SWFxpCPh4GUQ+9YSH3NQQOwzj9Lz7sYkYJUa1LOUwtiNtyTtchBHp7h1IvCq855ueJ+rjJkkGzmW4ysZFmrRbVpAwg+3y+tBAv9zv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqVSxO1L; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqVSxO1L"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532bbso11372887b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363731; cv=none;
        d=google.com; s=arc-20260327;
        b=VlyFVPmaPAJmwkXMZpwqVOgM322okYd4kPvgObMn3rT7Z32eRlhOIQDs9lkQKcaVVO
         Xp7P6n9+N7nmhhotw9CYYrLH7DXoU4pdhPQ6QCnAuZ74SVNTu6DuT81IgA5a1mwAwnXc
         VUOlpWxxNmz0DVgAF3fAeGZrs7YYYHKUPU1vFoFyblNJvqk6Tp2GNFx7dFvMcEK/gFCc
         qY4l1dP/EXZMX9lD43GW+oo4V4JQKihua/C7EDVFIXf/yuODwAYYF4zTv7qpW64Lcm2E
         N49oM4xR08T6TOKZVtuC2WpnJfTBmgfFbUfDKjZTyKYhwPdrnyUKO/gUzqRKxUZI64aT
         XAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Boy/DCvB6JkZOb2Lfk2+B5joq3V/JyQG6iJkAMe/PYVsm7O7sqb6vhZbroKNtOpVHP
         Ja0bvVEVoIRn9AHI5BcozD/DMZH8Exo9DdQc6vvEYP0VOtsz45T0DRdusXdL+Py730h5
         9Q5ttvLuLCG+gfhcQ2+hABWTvyrRlbPkJSaGCNjKUPrt/+Nz421mNqYjOH5nquUeLaaR
         ffpGdBZLxdcXuUhC1Jz3voprNdxoPPx3LOdpVhU+4V0hMJO6kLZAluumG7WZ4cFfr1Z0
         t79qJ71HivSN0s9E6NNcvLeZGYGG2ut8KcPfaR0KO1ZCqEmfNHdekeh4GbPZ5y1l50nw
         vhOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363731; x=1790968531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        b=TqVSxO1LVxmEmZN1vNqRw2k0qHtFRrfNQVrK0L6Cc08CKZjgOZLutCciOLRYMDPU7r
         61vHPHzY6rP6ukh0JPeQ/FmEYnRhkibf7AHxWLQUAecGr+shpxQJQt5WtrjXPcc6FtQL
         0jcWvGxJVr+PtEJOXjHkn7f2Ve6LDZKhZgVeE2+Q7ElhkblIHgQMxLjagVVMwgMhvROE
         AfUb+U7J3utlF+952rlYBwZOTNcblVEOkYBwktPIschotyIi/fvRuBUelJhI+t8h3FfD
         s3JsDVd0/iVpuX/Ym+st/78bsKJ1l5LV160zVBuKL0u4c7dUD2ymSUPhJVAX+tGJ4A9+
         Rm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363731; x=1790968531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        b=A2fxmQsDWUSFTrNcVzYvQ7P3473a89boU1hjC6qASCBHHBT6Phbyi4Six4Zl7ToBTz
         HjTyKWcgI03VSjR87ozwZ1vNVWGeWwrs4t55HHwEeQSo0YQavFwQ4c98KYaie9TgsShu
         x7o8Vlh68jMm4a2SS5Kxr56kYNA82APdmyjJ0PPmDXYpeMlHsT3e2HyeUf8ddAEO72yr
         k4BZCfo6CAQAEnCBrODHAb4PCh7neJ3izHdDm8A7cJkXbZsBNCpZn5pcWlTEmMTSDAaI
         t+/9ccoza7xAHjTl64IGPruqx0aXN8pOAzBASDRCfjsHOhTabE47Wp6T+Dz6DP5BoSuh
         cmuA==
X-Gm-Message-State: AFuF++lDvoHJgAkGMsDiDyNZOeLzk6OTGP/RNI8tpydv0CrLQXIG7ukP
	MfZcQXltChbdZPVSd7PVrtcz4PocP/zlw09GLWNJMlSbaz7dTx2CS9O+I6D61+U5ELcQb+T2LSo
	Xyue7chlEtIe3cut3igAiwsYn4+iSeYiT+kQ+
X-Gm-Gg: AYBFou14i5rmHDp/zDd9e81qO9NVSgxpwmWwvnV++a6gnkGHYpxWaPwEN3ROKc3bl5q
	f3dYV9XYl4Utzwj087nUxMcAjtPSct6TTNuVA4MoAz+TpZEjuu23IG2xoRGCl+MVB5o5Ru3LfxP
	jHfVLDwRoyHWugiOmFicgeImp6E5LTBGGS6Fnfzr/J60x+bhUo3Nn1KLbDrh1RuB4S9Z6N1DnGQ
	d9dHmLne6kaZwONAn3OLZj8+uNa4C1O4ojz0SWxyQoVKng7KnyLg6tkZv41ULeYktwbrdTCxi24
	B/iekaAAundM7l8F9L/O2J6P7lViHhpWCCLK0gumDLV2a9XHAQ+L2Ga+
X-Received: by 2002:a05:690e:bc5:b0:671:3f18:73da with SMTP id
 956f58d0204a3-672ed21a829mr2655854d50.29.1790363731109; Fri, 25 Sep 2026
 12:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-15-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-15-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:15:20 -0400
X-Gm-Features: AclHuK-IIKmMkaR1OFkonCy4Ky2-5sAPtqnuQXSbB-RvvVYnLD-_ld45DVzdivI
Message-ID: <CAEjxPJ6q4LQ1AQv0z2O66RkS9zd5fez7dSUpWESGuGzYwzXGpg@mail.gmail.com>
Subject: Re: [PATCH 16/21] tests/tun_tap: skip if not supported
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
