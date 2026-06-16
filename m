Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2A3CEBBD
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633086; cv=pass; b=BqT/s7Sm8T0KXV4o4xp2z1wNGa4FGY4B3kdvoRtZfHx8oUSd1gvPGI0q4nBn1HHODsFvxv0mb6qnM9SNRl+R7zGclHhhoxzb1S0c7sbI1XfwyTtNZxM+6HSg6HkjJK8jOj1zwSF/Jf9xxLSGs4EY72hOTX0XGf8AUq648PXSGF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633086; c=relaxed/simple;
	bh=goOMltvUTJ6yG5r/Fuow1xkZhwahVDoYnD5Q3nxaOEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1BYMiJR+UTpsQZl2LG00eMuE0IklgjgM0kuIBTIHmRQMopAKCBtcOKMw8rti50lmfYcXT9W5Rge8O/IgwlQFQbGESBZBnX1Zm9mo/M398BDkVkhhLUBoXKUs1m+1ErzrMXs582OvetfcehqWDeHJI9ZZtLkK1CfJIx5XjpIbsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3OFuUOa; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3OFuUOa"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so2952428a12.2
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 11:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781633084; cv=none;
        d=google.com; s=arc-20240605;
        b=cnARa8Kg9k85MofNToD0xI/bk9ANtquNbsulVllrGLBzryS5BONz8junKcp9LkGxUH
         F9ZNFo56fpzCuzGk/35YNBHE8WobBhCVCJwe3L2Y44SRE2Fla+ly/h/9UP/AP9Gb2vnO
         +oVebZFe/Gpk2abaB9DWEAJHznGQ/nPYOc9RqsBUDjkNM3/SKZjHLGHTpU16aGFplqh8
         uzt7o2O8mY1rGBK25U2y37DFjXqokKPi250GKBIbEE5PbSMKVaGs2sIeutr9vFVZoCx/
         2Fm/EO8OeXF0Z3okVWN+jXE6hLW14sNe6Gp3DY57KINA/4nSfPAjDnpx+BTnIs1UE1dK
         EJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=goOMltvUTJ6yG5r/Fuow1xkZhwahVDoYnD5Q3nxaOEw=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=FXuP/OCCXG6+Zx376SMCPeR4BD4FQgyLSJc/7ePtYjgMcBLub8EgcEuSgSrt3Gyu2P
         dqcDiPIbMY7T1CIuwl8ZI/THcK/bItiDBAYb3c0YEKDR1pYkShO+WBf7OGD8AAsEEeqV
         gOP9puliKpeWGdg/ucNP1lczdsVPe0+inszdIJjCudZ4Yj1LpvkYlH0xx72UoYEbDr5C
         sA1YVUH7F4o1X7yS+/VZzvOLtFkvz9GgiLFdGBBgN3nb8PX3K9N8C1s2/PPxhmXdopIw
         NOBFwBlYp5P236Idfcfnu94Mlb0hdhWNSwvfUTkTaqexFjSi1Ch71x5urTsznIbz5r4u
         h9+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781633084; x=1782237884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goOMltvUTJ6yG5r/Fuow1xkZhwahVDoYnD5Q3nxaOEw=;
        b=N3OFuUOaT60hvJtER2cBXmI7b6UutwrnwuAVxdLYq4mJtgoqCCu1HY9pc9Vg1r7uPg
         pl/Dqag/ckD6tpEt84OsHvlbUM73sHPnPJvYfBsOWPpVKI7Zpx598noLzMlc1HrunM7q
         H1pyocvAMmgxS5xMPh1ScyEwCBimannEAMd2vm2pUtzJx2Gc66bbIJhLuxPDa8WSdPLY
         U3LqkJmy7uou1u7aU9GCzPpdTMwJPhOm+UYJ7zG4sPt5mHDpXZScA1wHclr9QuL+F6NO
         qsyLqcTMpNTV0H2HRqp5RmLGE01svj2M4C6gp6nA/mRGPjxMSwO4R2f8nxIk/bS3mc8V
         RLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633084; x=1782237884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=goOMltvUTJ6yG5r/Fuow1xkZhwahVDoYnD5Q3nxaOEw=;
        b=KJFByP1fenYnyui/PZS5vqNlPUO14TENAjZMsoAOZYAYvSBRc7iAaeSakpVtnPlXBi
         YNBQ8rzTPH+wJUi/8s39JlBjMAJ6evMIK84rwtibSXuCfqR5vhTNBhxkuBApFNr6D5Ny
         bbYe4pKRw/1gKwpt9eX1vs9JLNvK+A1yv3rd84u4YMvt/Ur3ICZHQLTaf3jsHLbWCF2D
         dDu1Z8sk25j6tOoG6DrWIO5+ZMsW1lJi4bOh1kmW5p4waXFiLXQBnlZZSkjcgm537W+K
         +RkszJRnenIGRf5ZoWJX34MGAyXJcbV7e1r7HpxuNfNpbYEiZqd7Ug2k+ocKT4BkeMrr
         z+HA==
X-Gm-Message-State: AOJu0Yyyd1qniVwn1b4O15myMoSSyDR28gc4W57FL5epi2xyp3e6HgTB
	tMZ+bz9pt3mYrJxksZ4tdgYfEP1vuJ6ITffsdSIAT/6ASscEFyoN8c+BLemXZYOyTM6/sDU1lO/
	9pOZgMYah4aXESSAB14yVKk4FRWTnO9plVw==
X-Gm-Gg: Acq92OHGjt4iZ7CHCFyqnX5gqdgYFsw4ejmbjh3BeS1TVKqHOSRXwqqBsRXYSe+ebSx
	mFYRjxghevVZRKLDVjUd9hlxP9cY7VaXwp9GluHW2eEEyZEn+hZNEz8iytCah9wJaYe2rLmtRuH
	8uXoQjUJlxUEcr17TKDwqMvgH9thmsoz/AaxjGRwVFaFwaQuIx5ng/FIY5hkD8iXOPur4xHCXrK
	jSbr5npcW49fVZQfW6dK+5fzi1k+gnHAWbDUGNvOkgHWU4npHgvdmjqnPBWw/WsllqHVTyP4J/N
	yPgLQQT9/XgtTmxKtg==
X-Received: by 2002:a05:6a20:728f:b0:3b4:6cae:4a50 with SMTP id
 adf61e73a8af0-3b8b646e877mr408073637.20.1781633084308; Tue, 16 Jun 2026
 11:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajGNgKCKVcmvVUeJ@AA-94-54-42-0F-E2>
In-Reply-To: <ajGNgKCKVcmvVUeJ@AA-94-54-42-0F-E2>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 14:04:33 -0400
X-Gm-Features: AVVi8CcetzIIVbSbinrRIk8X4boVTx6pg5Jg2WNfNxTjMSeGgl9gq-RMuDXlcXU
Message-ID: <CAEjxPJ7HfVS2iUOLztp1VGn0hQ9+4Jr=BMwTY0y_ZzEnwHKVcA@mail.gmail.com>
Subject: Re: About SELinux userspace AVC
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 1:53=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Hello!
>
> When going through the SELinux userspace code base,
> I found out that AVC is available in userspace too.
>
> Just curious, does anyone know if there are many
> applications that use this feature? As far as I know,
> most of the AVC decisions happen in the kernel side.

It is used by a variety of applications in both Linux and Android.
Sometimes indirectly via the newer selinux_check_access(3) API.
