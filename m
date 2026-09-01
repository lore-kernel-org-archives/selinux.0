Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1E2AF1D
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265592; cv=pass; b=IcZlllcsJW/fs4QfNMfzf19WrY8ylk/OUmtDAUzMshp+6VJpdMzcjHqYtCGUHFTbR5EeIPF1MtXzWrXpajFh0GQzKzoncx7QumDiLUPmKG9ThVtBoVAsELrO2QCTgb/9P3TxAL92REE1NkWyAZQlxj4G0RM96vWWXUyczFRG1jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265592; c=relaxed/simple;
	bh=yj8iz8zSuH0w3BI5MbVWWevKwsxlpHCXrtH9I8o63+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb07vmXtFkllsbW/UCDY+ImrG+Qg5+J7lEsuDfr/dwUErJYqlo06IgDzIvMV1EeP9fZJxqDYsq7jKAr4NlUT8mKKPu4uMuQWaveiQNpIxKoWxriW20TKhy9UMZXEuEiuvuvnyAxJ1zxkQePu5zlHXGUP2Oq+muoYgj8okoppLqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg8KsJ/X; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg8KsJ/X"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b1b881a8e9so1113664eaf.1
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 05:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788265590; cv=none;
        d=google.com; s=arc-20260327;
        b=V7wqt9zQKe4sRoZpiLMSifr01ypBGA3A4XcLTcaATQF1N4bL4Jwe/jayXIDfgF6qiy
         BJ2oIX1z3Z8XRhJdCLPFtbw0L0tJPmNn42/Nqt1nDUx5BQzLB6ciaF0JQNC+dSqAOY5d
         MnCMTSD7d5uk/Lx8AaXDKqgandSX4Jkuja3t0b0s57I8EA2g9fzBGpDRQZwNn3RRbPpN
         jmTeMnyF2lnlDBSiAXMgFCTO5KFzajJgJmA008MGH5OuOSltzFnxHKTNAnU/eP/wO11l
         5KmH0a6TQHNwy+/jgqApyIZq4opUEP861dGD2GWeDd/JHDRipM3tuMZUx3A5spzca32F
         oQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yj8iz8zSuH0w3BI5MbVWWevKwsxlpHCXrtH9I8o63+I=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=KSTeqKokw83EUxLCMC2iADPQ1w5IvHVr44IrReYtddF9cmIviObkIdEEUgyW+SBCyi
         JhBNhaVl4ubuJNtTbWqfWZzCN3TOKE/yCfttnbvq2AV2rNWKmDwHmKDvg8Yrcc4EQp7p
         8X3MLB8M0Gw/mdizgQ07jAiiOxKVUi8nnFK1pH/NIPr9iLQ3GxIPFqwHYQC7jjdOu3RG
         kaoo1ORSJ2rCpfg62dHjJU2KNBojrxzWsoqa5HTvWxOjFvjIQATlBtkhD/ta6N0FznUu
         gpn2DmZjx1TQQzSR81eGtto6rSrluaH9gvdgOOglwrsQbiLW1gT+GM0ZCqWwgE4HM9st
         vctg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788265590; x=1788870390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yj8iz8zSuH0w3BI5MbVWWevKwsxlpHCXrtH9I8o63+I=;
        b=Pg8KsJ/XnnNvUPdwMfVg3MOfK2ex9jQ+p/9+aXaNoyQ8Nzi5ezCG7uvDWZfQLgzI1I
         B4feYaaRTgp5SruiYXBKCMxhQHms7fLUdhQdQ2Fc+Q1ln3nK89dlhxYF1QkY9UBJ+L1l
         nCLElsViMHAeEQaInO5SxC4R0gLsyL6vZnjIjPgjBapKPhbv+hqXyjpX8z7lAd9qbm8T
         vP4aoPxoRkxd0sG2XDg29xDtELpVVZvqmggp9cLD4YuZcIJB6QaXGv+KxSwpLEmcydjS
         BsJYFUh7yL4Zg6Bj8GsfojPyG2ppC3vSCrai+Hd2c82crV8xM0Ord5Rxbg/YtH0Jkmj8
         sBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265590; x=1788870390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yj8iz8zSuH0w3BI5MbVWWevKwsxlpHCXrtH9I8o63+I=;
        b=R7Qn97EnrdV9b7ClbH/Nmy2C7v1Ge3GYHgKiMzW1CPvv8jDw2akJimXCRHJeUxSbte
         5AZWtJR0+GG0y1rT2a4fwL1A9nwp2wbnoMgE2itU0Cfjme7sSWyL//BD9S4wXuyfypT5
         6AJyFDQ/ZErVVshhcfd1rIRI9e0rE9Tq4NL8KhAH4dlzznydo2eKhVh7RyfqSyVI2X+x
         mOtpgBceTzF3kR+TDctt6QfXKaxy71Xzp758LZNsVpxt+21YGU1zeyrgRTk6bMI1M4+X
         R4bu/4sh4M5JkpX4FiOqWUP2Fo8qrvLIcO1DZt/1+3be0cIM5PvGdovQs9lXnFHsnRyz
         tcoQ==
X-Gm-Message-State: AFuF++mVKe3WaZl6HsAKeIRFIEOIQsxL7IP6duAfOOyE1wrCJzWaJrUl
	qygmdwKfGiHHvAd+ER3+bxcarGZxLzdJx8XDJc02T0D2AiWCAwk1Jq/iHGC+oIxPFpE/ohlnU7M
	lGbNJOhxqlVhqQkfX7Vf+xpVBdeCHzTo=
X-Gm-Gg: AR+sD12u2NDyvuC35vb7DrVOHeNpoAFN0i7+COuj/MiofUe8ZbxWuljdTGJaMJv7zhL
	Ok4iwGDPYzqjWfiNbyl4dg+OFPmZ6ct9M8lqQtmuD96aBT7FNLRdBGGc7xIPQ0Za9Zxg0gTWsNk
	PNyGX5mX6ohX8K4JAldtf3kzv4M/WKjcI1Yhp4/sFSdDhQoKmumwTY+cSyezjYTlPRatqqbudkw
	FZDOa5WxAIbJ1+GPQz18yeZxhQ1uq9xbTuI5uwnFeDyu2PWj7UgdYQn5E+iyOVkkK0fp5g4PjWc
	XLVZW8wGD0zniIePcaZl99mOnkeZBZVazWspiixj7UN1
X-Received: by 2002:a05:6820:2019:b0:6a1:8192:4d89 with SMTP id
 006d021491bc7-6b1c67370a2mr23954595eaf.29.1788265590195; Tue, 01 Sep 2026
 05:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831185851.80078-1-jwcart2@gmail.com>
In-Reply-To: <20260831185851.80078-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Sep 2026 08:26:19 -0400
X-Gm-Features: AcwNN1WBFBRIQYcPqs7naSKEkUgKjd1TyUC6rP3SPAC9ZtHMEBqXfvi4Vf9xT2E
Message-ID: <CAEjxPJ5mvrtTvpEmpdPss-_Tr395TsH5rFRreK3SRMZSa7D9eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/tests: Remove non-MLS downgrade test
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 2:59=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The non-MLS downgrade tests are done by reading in an MLS policy
> and then just setting the "mls" field to 0. This results in a policy
> that could never be created by checkpolicy or secilc. Changing the
> mls field does not change the fact that the policy has sensitivities,
> categories, levels, and mls constraint expressions. This has limited
> the checks that can be done during policy validation.
>
> Remove the downgrade test for the non-mls policy (that is really an
> mls policy) and just do it for the mls policy.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
