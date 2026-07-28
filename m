Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CED12CDA5
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277752; cv=pass; b=XIyU4QRHoY01ye0PBe0RkRlTCmp1b7BP/LyQSHxoOEFu6s0Lh1dEv2UsXSJhvb50U9Z9GUyAXmViOEmFUszRKnlk+JVHdC3PwugBWCirv2/Km5A0XEGnxiAQDFQVTt2UeG2L6UKl8Yio2wSUBS/RbYyLlSHz1z7CiZSl5XVNbsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277752; c=relaxed/simple;
	bh=S1XqISWOX6OYbO6jXnSbBXl+DIrSlZf1O/NWu84DERU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9zt+L2mVZI0fGUTvXLawV4mIBvIAOm/UgZUx1f8jhD9PRatdrUNt0tfjSJ5gIlEsRaIUsIQxh9LBYTqlaxqin7daZkb2rLEX+0+Ojl5s56zVV+yGHpEhHBUeGKU7E3YEnmvT78nlPCjKLRmtUbBrYnS3owaeEOCzP4Sz7XK/9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=arNfd7km; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="arNfd7km"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1070782a91.0
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 15:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785277750; cv=none;
        d=google.com; s=arc-20260327;
        b=TUa0o+TX2f2NfQHur41PYG6btjcw4JBP9ynsjctFcz9xijcpGwN4bAKZbPLQnq8RFY
         w+cLrspLpu8NhhNeSEe/zkN9wDmHiTU/J+qzvSb0a1EwK0hcLNsPXP1OioNgROTFyKH5
         8nW6Qpx4+c07OaYao2Yrq0XIoxKfgqZn5FZEXGpBCDM99idlPbmXr5ORsJwswEzJ0Lw3
         b92k3wg9Kl0qpnnflXMsm1LKd1MF+2Rv3OpYYwO+LJgLC6VOoxpB0CrJDi5+GPszayYP
         jqJAAW5wswjWUPocrZfMtH3OuMAha+vVYUqKpJqN7lqdcdhywMtEkbJ7TkOYZGrlanhP
         mqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bPov0M0CO8Rz4/k8oGeIS9HQbcezaRyfv1qhAZQ//pQ=;
        fh=TxEax/h1lKQlM22bF36EEML1zDSZqnZB5Sxye9/dLQs=;
        b=U0/npogbzC4uCmbXeUUlpEt7dKMPCgol31f7lIhDDRQIHyE5fsTnOviyPVLGAoNkKV
         7b81qWeWeT7q3QJh4i79mndxAjvVawz0LFZzFOXaec9NHxKExepgSXsZANY8TDm2wUTD
         EPwydhW3GiRgYnF2TW7O6hcUutncDFLWNtFqCcC5BRvqyDQKAvy7GRfTlaez5KvjcA77
         oPw+KaZs3eXkWoR1B20NDznfYroXt7Uf1IEciNEgVJDdDTeRa5rV26akxI0faCdPMeBv
         XynL/ILPNTAG4MZcTHqYajUqHxk2UVRbUAtENAkKtEyQ3sPC5PkDALOYaXB7GqOBXn+K
         UudQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785277750; x=1785882550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bPov0M0CO8Rz4/k8oGeIS9HQbcezaRyfv1qhAZQ//pQ=;
        b=arNfd7kmHcc3fpPiisHKuwnlBmZwo83tSMDlQ5Xqa7EzdtvIq+nfI841b+VGDX5s7d
         okTRmttTH/DQR7AITI+RcqrhXmo3plwxNrr69d59bRjN8R+EYumyKqoHSTnmSHqLSjA/
         TUtvK/rA5Gglri1AxXVbXwkez+a3vuR8sxwexumA+57JrHhkF5MNuKP6UE4RLCZn/6xr
         OBcb0AtLvfUeNt7gn2eCBNub2eHONxiEaehLp6A8mPZrsnszlbeTNlXqoRAHKiEjR6nt
         bhQRNevznSPKyxgQhjL7qi+pg2AWLrtwEJBnMe5eyoq1KaPMTkn9qrW5h4nMjYWdpfgM
         muiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785277750; x=1785882550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPov0M0CO8Rz4/k8oGeIS9HQbcezaRyfv1qhAZQ//pQ=;
        b=qtg8TKrsiiKsvgvI1dv11JcWbOfjEGjYDWBm0qth16S1V/eGdjYFq2ntzdvEW6mPjD
         drnT4VyM6SwHOu1dBzgJ89cIObgK8x686TzpRjBIZ0zNj8sa6ysigqcyfCazMl2o20cS
         aMyo7SHmXFADnVeGY/f2w1lea/mxbEcHQ4pnzN4Lo8IljGaMnsKp6XQuzEp+zuERYu3y
         faQe0dZZ6opDwBDoOF0E4+NRy/wDwXC0mM0MIthQxUSavQtAmJfJzh047mKyZhlBh7oc
         0cwTJjbKTf+Zp77Vozz1ORyzXAzuH0x3Jcg4OG3rIJPxniI6PLH5eBCrc+bzDEI6HFRF
         qj+g==
X-Gm-Message-State: AOJu0YztSVc63ftkMYiKY2FIPXCZLLhISfWmTZNw/QAPh5Sdh9zdaxNh
	p5CdhNOm20FSiMiEvihJeUurZ6ChoxLaEmqYNmiSVjm7h+tUB8jnv+PjyEFyBtKXKUdEhNNpaTz
	3qc833RJjVGQiz/EQYq5YDh0wW9IaziRmyy605plCMZYK/YjjO+m+1Q==
X-Gm-Gg: AR+sD122DRJljz0njupKoUrAzVesyBKcCzwhGf0imNBmm3W+JAl1JLr4CAeEGkXVAXR
	Q+UsiEc9JDh3qUJ0ORbUPquV4eTxUrsbNmO9P+akSN7sB1+KCpG5OrzAak2J2rzby9wBriRy/Q/
	zKip6YTB4XaVUqe6KM5jwx4HUE3PGpl/14xjcZvWqpLInRFNDE/UMOdZPSyhJYOBztXNGmiS14Q
	UefSwPQdqiKlrjLpnMyosrp/+wmjG4bUVgzxg1TIjrWvWQYtEMrb7FgS771FNjP0QszdiNqhep0
	o46fOXKdKjFSn62FA35s07ij9wKGopYpOYycw+BxFfj+j2q2tJZQgiAJ
X-Received: by 2002:a17:90b:3b41:b0:38e:4f42:d0d6 with SMTP id
 98e67ed59e1d1-38f6a30e409mr4133624a91.12.1785277750304; Tue, 28 Jul 2026
 15:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728202632.4784-1-nicolas.iooss@m4x.org>
In-Reply-To: <20260728202632.4784-1-nicolas.iooss@m4x.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jul 2026 18:28:58 -0400
X-Gm-Features: AUfX_myFr2EUhFkQyTPJElzAJJYzfIYxrMrCVyN3NQx-9Jt9pP9p5dCaIMaU2_I
Message-ID: <CAHC9VhQUrfH85GNLTDYp0Z+KYmpqyVzs7HAr78+J+QM0p511OA@mail.gmail.com>
Subject: Re: [PATCH 1/1] SECURITY.md: Nicolas Iooss is stepping down
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:34=E2=80=AFPM Nicolas Iooss <nicolas.iooss@m4x.or=
g> wrote:
>
> Since I am no longer able to spend much time working on SELinux
> userspace tools and libraries, I would like to leave the maintainers
> team.
>
> Update the set of people receiving security reports.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  SECURITY.md | 2 --
>  1 file changed, 2 deletions(-)

Sorry to see you step away, but I appreciate all that you have done.
You're welcome back anytime :)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
