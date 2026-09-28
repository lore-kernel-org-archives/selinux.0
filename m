Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA054E7800
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610815; cv=pass; b=tWB8foB0owuStfyo7uFBT5USzfbZUf8PqhA28hFjUFzYLe4VtyqNz20N3UGkRNiGwZxhpAMDLS7de6Vw5L1IqKfrO81j6VAmmIac7wCO3PcC6DU64kVtKzFucB+WSdb8autyOvevEbiKzuP8ZMCQiHn1Rvl71Djz5WYtBnlYwPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610815; c=relaxed/simple;
	bh=vTTB8/rvIY26bdgxK2zpCBkL/q3mTjNrJQqgzN/3pfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieeuFT+iu8o8KtEOjFv/vEowZlfvV5afPeN7A3sHbJLzXooLUklJZnZKwWwnIZHUUvlPv352qbrwO4nbVc7WnK6mdfrm7BG4YJy1kXpynIP8qXiP6YGkUdtduRs7FkiPoBtItUs5KY0K7QLyYNj9FXSgK8mPzuTxic5VNZHu4cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMzuQiT+; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMzuQiT+"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa1a91809aso10997237b3.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 08:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610813; cv=none;
        d=google.com; s=arc-20260327;
        b=rvUAt5bmAb3J9z3bDdDGB6KSKPvhFqzuKUB1gVQb8/jLXrq+JwTNayDJwzGvQoT45l
         JoGnTahv70fE28x69bZTdpM2zBkLXZtUhtjPs3OQaZcyHO+gdhtbnFZfv193+rU/Na81
         YcH3wYNKZjdnDBTvjIXN97/7CBwvyGcR4r8mBnNM7jXEqirj+01Pf47hVb5aufSP46LK
         sfkzjeCbYg5joxnckv5U+QcZ3bbUoYcYnLvBLCemBUxr6kx3sy4LZV5kgDqUFk7LlJWg
         MeJ4Ncy3ct0kdXRHiqb0Ox/14tELcKsSqQBykuc8N+P23i153D02rBlKmxNyQR7tIhPm
         HHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vTTB8/rvIY26bdgxK2zpCBkL/q3mTjNrJQqgzN/3pfs=;
        fh=XPfnPeS4wglRmelDXjWECDrUzh1HlzFzhPotAf04/Ag=;
        b=hIzMJC5v0v1CZ6n6fmbD+jfVRA51sUu/s9ceRL14v50L2/BspG5tZMAauUdjylhwpt
         gPUM24gqKXZEqXZrUY7oXqIM97rdoewMoVYbCLNyectnj8OW9KtaJzYZjv/jF+zhfjf9
         XS7S+IbYm+IVKort980Tm3UU/ZxmpIp9+iq4nrxxkz1dI7nk2dREfTC5AJ89ytQjQ3zu
         2s3EY3UpEwsUU4uOAt0dTSMtlxsDNFxYqi8n8cKg6wuDUpz00rD3vAcPDnm+9c7w+fSg
         zzH6OvfyGZGANOq4G7T0ab6orXz/cih4Y006oP+L5R2lKIXPgMjN8JJqIgWWEteY3wvk
         WNcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610813; x=1791215613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vTTB8/rvIY26bdgxK2zpCBkL/q3mTjNrJQqgzN/3pfs=;
        b=jMzuQiT+EEmM00ZLFjz1JbiPDclDpOkCE5kFSDF6i//Je6IRwM+5FlahdavdSv/har
         mcryH6NK5LmvKqpxBtz/KOQpR+jhJthSNQPW9X7OG2Eh15wLS11FhnsnGpvlicI4UoGe
         CO2jIH1ahPmEpMwGFNv/vrwOhk1AMy7q1UMjaGDIcVtq2E6iH7n2W5wZVrySCqBfSKIW
         UyRhlp06mD5VPew8aDlP/5mVzbwFljTVeRPnSWa+U/WXXJ39TVYLDoyYLl3FHNKNihR5
         guP6PNz5NHOJVkUbD2OotMEQ3Koevpi4GC7oJf31IO+p1OfXsH/Tu4Ebn1iw05e10AIT
         awdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610813; x=1791215613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTTB8/rvIY26bdgxK2zpCBkL/q3mTjNrJQqgzN/3pfs=;
        b=U1ExdHJBqGd0p1w8SFH/OvmMSd8ReCJu8NWokfQ3/VyeZZ6j02PQ4UjpZckKdSqn0I
         qnqYhu2AesnEB4gH4ONNQSaqax9rgto+nauV4EEt14Yn/REEPGyqnSUnnvQSN0c9N8bD
         0X+c8JfPFLPacGYkn/ph/kIPaKWBSHSQASqmOPFEWAKj2uEYtUHrWkM6awMp1RHEVf0l
         IepfieEf4cHX6pT4Q2jCQPnH0Pdz9qE0Zs9qsbrlN/GmOmOm1xs7EaOE6SHa9fhd/wxV
         o+9HPkuo/UMDDb0XLrxvUyDNOVcVPF5JlUqaPY8AojZDSXSad7onvZyZRf+P5IGKgVvz
         IraA==
X-Gm-Message-State: AFq9FYKmt+0RWnozpVIb0Rn2GIY9gX8s4SPIzNDh/G8SgWI9jFiwiIOP
	la9r+A7cUZYNWAbpUXnQyF6/pKbvMuuTMBwqJo5tPl6mBrZVRhupYvqd2yfxiOxeQqBE0U+gpu9
	d8NGNi3LEqBM0JG+sKOaR2oFIw8wdUeW2DQ==
X-Gm-Gg: AYBFou0TE+kYyQSN/+hHzru+/elWweDplqLPmNRmZpFRr31+S1kLNujHdCB4AARUMPb
	2mBG+a1b00co1CuQZPpUOXJtFIPurDATqs5qgPEtiFqpPMfC/QDJnK3Dg/ahCNZatKaNPqT6wy5
	4PqjDRpkv13mgJf2PVLkv7v2L8AqCD+4tEsIJMre3lcf+L3xlRsMm8qaSxqBqme6kLbZmfUAyLJ
	MgwaIjdgRNGKoczc/9+pEdOKGCkD8dK4yS3RgeikZA65AbPsOPFjhcoSXHJ5as46++V5B+3NfGf
	vTXSnGUuI6CxWcjY6bueIBz8KxH6nqSHgLNIsUt8ZBMn5l4mwk7OxhkO
X-Received: by 2002:a05:690c:c047:b0:89b:6e01:b805 with SMTP id
 00721157ae682-8a64a088584mr53042717b3.57.1790610813178; Mon, 28 Sep 2026
 08:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
 <20260925171755.2029271-13-cgoettsche@seltendoof.de> <CAEjxPJ6TJWjEHXwy8nkMguQcshFfDQ0HsV5G=U0Sk14+BxfTdg@mail.gmail.com>
 <CAJ2a_DeWnQUPkbY+yF=10wbxq6E0Ot3eVEK5Jvv-nKu6qM_V+A@mail.gmail.com>
In-Reply-To: <CAJ2a_DeWnQUPkbY+yF=10wbxq6E0Ot3eVEK5Jvv-nKu6qM_V+A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 11:53:21 -0400
X-Gm-Features: AclHuK-sYkbV-n0ulHwpH2sp6f_CdWAm4FbgNP9hjAA9grnzziWN_WhU8LaJ354
Message-ID: <CAEjxPJ7J7gF99ewmzP9CX2d0zWXdYK7xi-rUBmg4Ai4n5eG9Xw@mail.gmail.com>
Subject: Re: [PATCH 14/21] tests/notify: work with CONFIG_FANOTIFY disabled
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:46=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 25 Sept 2026 at 21:12, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > But, but, but - you need that for your anti-virus product to work!
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> So rather drop that patch in favor of the defconfig change?

Sorry, that was a joke ;) This patch is fine as is.
