Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF1246BC0
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282284; cv=pass; b=gsezHed/F91CTr2jpp36aBRvOharu/spSS3btwNY4TtEbmtF2mI4/akrFP/HNyplNvpv3LkAqziPcydiQAcAKJPHO6S6H7J+fAnVxnHMARf6Fznl65kybWpAGtmtZxivvlwcZDWSIYF8MGtJvt+JVJAbkDXREdzy3YpTwSwlxgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282284; c=relaxed/simple;
	bh=3xTxXQf2zA64cdy7FQLZzYMD1wBcEPIi8057RIKRhs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0Dwz6HA6D8gjLiGbdqJCHJimfVpgc7HPuNq3As8RIiKQix9Ux4tVpYhXCg2FzN7pRAZhuHf/mtnDMvCQRP+NpAFjO/66mzmu63cSpTA4aVC92ia2aN4ykUGkED4EyV0fCpIt25VuX1xYV2R/uubO1D6Ec+d0kLuTFSvhYLhrNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhsPQ1BY; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhsPQ1BY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3680540a6efso2522893a91.2
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 06:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779282281; cv=none;
        d=google.com; s=arc-20240605;
        b=lHLqFOfR1QTCbzeH1JFq6T31aNazRQpsPU4+s5NQQxmloZjnCP/WRqz9WuZ8U0iWHn
         wigXo53bE9Db9De89sdw+Cpka+Zn8qSiJaUpElggZQIcwPr2ryBLZYk6Y9h4ur+c8e9m
         evhd76+7FsSEGAAUTW4IrRZjBM6UUism9/Ff2F7dqbtmEE+luXhWNhl4IIzb0VSoi6GF
         zz79opZ3pXoEItasIyUWnAuJLkUo4bXUGvNwIyh3K6mVd814lCrgAzjhSittx6FHlMSC
         J6PTT8UiEvTaijUya/AhXt9g/akAasNOMgKSDRPRefYA8EXgamR3sCkaXmWoWBhBMj3C
         L/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kIFtrYoWNmypH/SBiuqE6Ekn1eCbOONOzZr5Xu3p5gI=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=I0WuMPqw/gX5HLAY0OZaYlj5rcGokR5/Bxc4QQbfTX9smN2vO5hNBZPsL1buSfwYtH
         bwz9YfdTEBMEo5YNSAv/JIm8X3wWo98fIrk8cBCZ9jFEMqWOHdgVJmDOVXF6Pf/bUBv7
         7MzAYVqrb/VYTK5wy2O5k4qS58tpnQAW5eBOix/JC1GiMrX0eVxokCQ7yb8Hgmh6g5Q2
         AhZJGg40rtXqhkJvCJ+KYFq/M3DZO5Luep50fGUVIpzSVt/+Y3NNyyWpvwACnl/tp6+t
         KmhpXdNGbapQnnINw4g7ayBU6a9XaXhcTes+RhDRLKKb28eDL2OmibbaGboQh4S5Ipz2
         RTDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779282281; x=1779887081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIFtrYoWNmypH/SBiuqE6Ekn1eCbOONOzZr5Xu3p5gI=;
        b=QhsPQ1BY02wLwmZpMwGiKtyOZovaQleHFXu1BsUMGAmgk+DvNYBEAe41Jhfjpb1iws
         sACMtLrIdfLJ7pV6rDFcKWFSYvQx9QCtk3MppkPVmF+FyF0bbwlxoamhixQykpjYfQOu
         rKdfljaaTRsF449JgZlzd8EXij+ffNwzvCC0HNBHIb79iFj1IpdR/RptjOtewWEBgVdy
         7vQuwutQ/E9dwr4H5NfwVokt/b0Y+N2T4dPNvDMBBtkwP59NNwz+Yrh3VZrcQpS92KnE
         phrYNFANLoAPT/EE0Zt0w0Hp9zoeVZp5jcWvVdh3u5WhFO27RI0HJWyqNCQK0XULVoWq
         O9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779282281; x=1779887081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kIFtrYoWNmypH/SBiuqE6Ekn1eCbOONOzZr5Xu3p5gI=;
        b=ChmOAoWyT5IZ9eH9WdPCE1QzwnrgdJPwvGYw56cFEdWONSOCX9oMDF/FA3ugwFSqRR
         SzE27g299dd8pMewAPrtMUr5FMXAd03ASPdKAlwaRuXROCcjxi6rdUCbi4LPxIcP9/rB
         Vw2IHFrdkvab9NnvdnYYWIUMeqSXIcOzNRvxfG3p5kwFPX1lT9+s1zTrBiQQqBTSaxem
         +/gWAEHQD9dlzNGyivJM5nMxSFW2itgcaHQXOhL2X84HvKaCK7E1x5rnTveK6PQWKERL
         EXLvEq5jWoDTiLMXZGSwdTcrGDAa1S1FdalwiG07mn9WuZSaHDv1lhJOBgVy6uJ2sO0D
         qlsg==
X-Gm-Message-State: AOJu0Yx5do+RvgRvR7Nh4gGt+nelDYdCms7lV5PoNitYJN9OX+yiU3KL
	jB2vQ+zuiaFk4mPdP2KZnVWQw/z7dImjYp4390263M+BX8qyQb6RTLMRTMt4155BoT5nWuKH1w/
	yc9LHcheen1GZXkNN22tYzLmqBK7Zbz0/Dw==
X-Gm-Gg: Acq92OFBn5SKOSiw5euakD/oUZrlsUBMmsBgcDyLUhBym7yvQInueI1yFA2vVMifE4j
	qr3jtyo4m6+B0OidepCC0sg3PgmKGmsbDc9LDKzhiwYCT4hQIeavBwE4DobdAokV8R49VLQ0l/Z
	yeh6ygj50iUj/C0qQjaAti8NjSadcvO2Yl8NoAfVdmQsT+R8cVJYZw7wblrTjMCKcropiZxbMFg
	m5rspjD+0313UILX0rzvsITzmXEFfN8+rAZCGramZuY8ehEYInvISm++LpWxLtUpIMZZgfHYgmB
	3sYJGe0=
X-Received: by 2002:a17:90a:2ca1:b0:369:b1d3:fa48 with SMTP id
 98e67ed59e1d1-369b1d3fb46mr8953678a91.18.1779282281407; Wed, 20 May 2026
 06:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519183507.402648-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260519183507.402648-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 09:04:30 -0400
X-Gm-Features: AVHnY4ImXa8Zi6SY9TsaSBHAuvQuF3Hvih39p1LqfswUmVrLHMH_i55V9AKoGvk
Message-ID: <CAEjxPJ6ToWSpzpMGJpRzcQ0eJe09R9MwyeDsSHNSKybNbmdc-A@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: selinux_restorecon: write digests during traversal
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 2:36=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Rather than creating a linked list of digests and setting them all by
> pathname at the end of selinux_restorecon_common(), set them during
> the traversal using the directory fd we already have. This eliminates
> TOCTOU issues in setting the digest.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 switches to just always setting the security.sehash xattr via
> fsetxattr(); this works because the directory fd is opened O_RDONLY
> so that it can be read, unlike the O_PATH descriptors for non-directories=
.
>
>  libselinux/src/selinux_restorecon.c | 140 ++++++++++------------------
>  1 file changed, 48 insertions(+), 92 deletions(-)

Merged. Note however that the getxattr() for sehash is still done by
pathname; looks like that requires an API change/extension to fix.
