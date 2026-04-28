Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A02EBBA9
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414619; cv=pass; b=M4IpqXER1aLwkgZGgh22XjgvnKCemMVfULKMlN56U/HA97jZRRoJIBmljIK16XOaPPNJ6kQc5w59ubTrTTEg1fXVrVEXV2jkRTLQU7bARClu28j9krtZz66aOVZUndHQ9vgqnC5d1tFJN9LYrGwAqR2FsUs0862/WkQYhAahhGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414619; c=relaxed/simple;
	bh=F5UG19CyofsdmD4XoErBxuH/D0TQE82baneEu6I1HJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQOwtdU9CARy8S7kxRPcl4oYtc3FHvQYoYuRywfFD/imnIptQkTBZwjJuEeYnPwD4TPdGYzTiEcGmVbfTnMxV2myPISDnC+FM2jGTNLLaxrZOX3Dqml3X6rDwrWzikQ7FD2uLutExLnNlw3tRm2ZSolcDLi4ahNNvlDLZF222yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cGgH49/d; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cGgH49/d"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9516a653so60624265ad.0
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 15:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777414617; cv=none;
        d=google.com; s=arc-20240605;
        b=cNiplCjgoUc9oYavBaCdGeLPsD1SFwrrAtEn5hr+2fegRFCVOUIW0x6C7IROSPNk11
         wri7S8tPixffzJzUq5Nti6MwdgJ48Ck2frFmj5EcUoaTPYSjdbMaD//tJ5PgFnk6DhA0
         e3nAObvfR2YJF11P+jfMgvCwLIbfGug9vu0fLuX1HwWxuL1CxLyvLAxT93LiA/QvVZY1
         OaI/Nhl3JsgVVSTksP1wQTIAuKyQzdVb411qlO/x/mXZTv3O2lNZhQ6t6XlxCIV1ZDZA
         AVwsETN4m8hzOhV29p+QorOk9B/jSWuXsbr+cWhf/h+mMQIvAInw4zxryjvcKh0YzcKO
         p2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=36tfPcpNoTI5mvMC+2/ZfW8ifo4NlBsINqpt0zh3R3w=;
        fh=lOev/QwE9DXSi83P/KluQ9UjJBSvfLYOVkCl5H1rM0Y=;
        b=MvE1v0Ui7K0rf32cZWlQk4BgmoWVLktKNFo+7Z+onhjQhwBcBlvskBgaUuBeHnKGwx
         F/2ib99PRAyf/b0nEWfYTg+7aMlg3aMElJ7N2JruzX3+gRlLUxd9HZtzXpzQaaeOyNRg
         yamMOSsV0caUntUjRknibOjrG3gdEsusKij75UgMFmXCvk+LaXoUNj0JPmwUlVMVZrRX
         uEfT0IgfUA24AtBHT3/eqvw7rj+JlvFFxRrRMNtT/N+7EBtmGVLoAaoetmTrsjegyGpD
         VVRRRnfgBd2XCkd+vGiKVY/nfJ9njJdr5rMm/36bxUZI12u7iBK03KGBsknvvFUjhPiL
         twzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777414617; x=1778019417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36tfPcpNoTI5mvMC+2/ZfW8ifo4NlBsINqpt0zh3R3w=;
        b=cGgH49/d4W3dukfjePGGKO6hyDhCHrAJwBIEyCq28dKKoGIGsYi1DA4/GEn1Lwqidb
         DAtnqFaip9myqye+fUtdLQ/92/VeE/VQ+fVEyRafy+j81COQ1Qk6I0yQfDY9kfrqTc6B
         igcusun6tPznvURSmkXxv2eP9iMpgBQMjR29uFn9gDcXN6Mq/UfIOjmtFViCJwN2GA8E
         O292UyuC5Wsc1+wxOrHLZ9K1tVjlZiXZysBMjmS9GpF1CAL7tbjarhxL2iswIS/z/H6a
         EW34fQgBXpmfury80bnT5wyR9Xg0xjLweeuq3hAS2NguGgpfIUE1QX+8NGqjjYkSJM2r
         P1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777414617; x=1778019417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36tfPcpNoTI5mvMC+2/ZfW8ifo4NlBsINqpt0zh3R3w=;
        b=aFNWg7zxTV6OJRX+50yV6PX7oXpUGrXIhzJs7nibGWvqteNHVh1y48xbkRita/OQln
         MQ2FYDZdpVbSOj2WjkjpW5gYMKINdWwCwVNOQ4djddMzLvU6IeI+e+zRj8kkBCVWXW8C
         GqplNKhpc+zZS7WNpr/klj5TgX9sOSpg7jWyyIN9yrmNgvoXBoBq7YnGKqCNejpHcqR1
         /Xf02wP4A/UVQsUeVOrjMsnpQmvVsha2G8qJRqtp7BvEZu5ercyhRaq23ilsKP29Qq2K
         hpIomcKcqFEdhlwnquhGHtJq6rAud5ZS+QFJEubnYWuhrAPsAYXOi9DDlpa3I/GqhVTW
         z/gA==
X-Gm-Message-State: AOJu0YyN9ue+OMf7IcY283ZMRK90H1Tq4+rQrjT6WkcnpfmrASH3Hhu3
	Ek0NN6ipdmA1LLt+odQBRNsk2YrlbwIQsKLI9JZrCayvf8uGq30q7D8vPlT5Toymk9y8ZBwreDA
	3/x+hb2LqUZ0MdW29RNsLGkQCufgQfNHPii3iuO2J
X-Gm-Gg: AeBDieu3Zi+VwNVhlSkILEKxc+9KQdDk4WxykybUREOVF0ef712rBD9sIdKldaHoKZC
	w5tEZJzam/MQz4Jz14AME1wUSOHHQ533N00H0BTJt2P2qNzuHmWo8fvL8EhEu9UYTY/V6Aaqk5c
	nCKGmEl/5sfkOrq8YF0X8ZnqT9FXxTlxsRcnfhGarHrakyCu0t4d2AAOAO9cz4pb0PZ1sRSiwID
	ZndRv/Cahbz+4DUhFbd7NDLow3YuIXVZAOJFI6EdjyVvecIf65wwheT5/luHUQC9VAWq96KHKey
	03YP+UfxxHBh1SaKmg==
X-Received: by 2002:a17:903:390d:b0:2b2:4fe3:7b89 with SMTP id
 d9443c01a7336-2b98747c348mr9970885ad.38.1777414617060; Tue, 28 Apr 2026
 15:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410192949.16542-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6y9p0gs17s7090UcbAcA2KtGcj2nKqi-hBtNZ3zgwKDQ@mail.gmail.com>
 <CAEjxPJ4fPyXO6MWef7kA=gM3HTDhYjvhEbZNRoU=AG__K6havw@mail.gmail.com>
 <CAEjxPJ7ASrJSLOMrryvHGQT7R7rTvfZdfdTPu6z9SmCRUX_wDQ@mail.gmail.com>
 <CAHC9VhSDYr60mZSasYR+_0rGJ7_SNfL_O3FJmB_nFPQciVQ64g@mail.gmail.com> <CAEjxPJ4971km7W_MsJ3CzG_dL=_wMoLwzSpkZ+g2yrY-s+8f4Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4971km7W_MsJ3CzG_dL=_wMoLwzSpkZ+g2yrY-s+8f4Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Apr 2026 18:16:44 -0400
X-Gm-Features: AVHnY4KTNo39EYExHvShLuRphUYgOKuDOXC4ER4KWqQZz8h1r7tZ3wkxsATSNu4
Message-ID: <CAHC9VhRpb2XT7X9JUDf1FGi9aiYLG3UP7B-0nVU2UkbkwkgvVw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: fix avdcache auditing
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 8:53=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 27, 2026 at 7:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Apr 21, 2026 at 12:25=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Mon, Apr 20, 2026 at 3:13=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > Here is some perf data, using default Fedora kconfig:
> > > > v7.0, unmodified:
> > > >    2.03%  [k] __d_lookup_rcu
> > > >    0.80%  [k] selinux_inode_permission
> > > > Ratio: 39%
> > > >
> > > > v7.0 with v3 patch:
> > > >    1.95%  [k] __d_lookup_rcu
> > > >    0.81%  [k] selinux_inode_permission
> > > > Ratio: 41%
> > > >
> > > > v7.0 with v4 patch:
> > > >    1.89%  [k] __d_lookup_rcu
> > > >    0.92%  [k] selinux_inode_permission
> > > > Ratio: 49%
> > > >
> > > > I only compared the percentage spent in selinux_inode_permission to
> > > > __d_lookup_rcu since the changes were localized to
> > > > selinux_inode_permission. Aside from the fact that v4 is measurably
> > > > worse than v3, I also noticed that even the baseline seems measurab=
ly
> > > > worse than the selinux_inode_permission() percentages reported in
> > > > earlier commit messages, although I guess we didn't re-measure when=
 we
> > > > switched from the per-cred cache to the per-task cache (but that wa=
s
> > > > necessary regardless).
> > >
> > > Actually, re-running the perf commands on the older commits show
> > > similar results for selinux_inode_permission() as I am seeing now, so
> > > something else must have changed in my VM or the kconfig.
> >
> > To clarify, are you now seeing similar results with both v7.0+v3 and v7=
.0+v4?
> >
> > (v7.0+v3 looks pretty much like noise when compared to v7.0)
>
> No, v7.0+v4 appears to be worse than v7.0+v3. My comment above was
> with regard to re-testing older (pre-v7.0) commits where we had
> reported lower overheads for selinux_inode_permission relative to
> __d_lookup_rcu.  On my current test VM, those commits are now showing
> similar overheads to v7.0+v3, so I think the difference is just some
> change in my test VM, kernel config, or noise.

Okay, thanks for clarifying.  Let's go with v4, it may be a bit
slower, but as you already said, it should be easier to maintain and
slightly less fragile.  I'm going to merge this into
selinux/stable-7.1 now and send it up to Linus later this week
assuming all goes well.

Thanks!

--=20
paul-moore.com
