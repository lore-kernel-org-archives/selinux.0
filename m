Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794330396;
	b=umhogiphlCq+mdGF3lOkd7Tiv8YlDSYa6yZx05m4Xu27O6OluhZu/wClXUfiz7hGoffY
	 dEAVIOxBpGlDObo2vxoae0nkdHQnv370dXpfascg8thc5Mc/BqIR5PgR5hZSDZySv6C+S
	 8mb8MhTCd9TkG4en8FWAl5Qw9xHD8pCB7YEwKPQWxNhw9zSgnjsRCe1xKr6b7W1PGmyml
	 GwDSH7+n2M0URZUiwxKzZRjLQlAJVRWCcjmgt3EEvVoEKeif5RNQKJfsNZqA5Kt2GRyb2
	 jw+AeP9o+DjRxk+UCbxxDs5CtuZXD8x9FDRF50Dz0I89jNrMH5mEIpQjFdvYD72bzDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0+Lj8SdAE5uQOF9klUC+leKucjAphiWrEjdvjPFfUew=;
	b=Gp91RZmjn3qV7yzlG9E61EL8D2cEudIHu7sl/OJJXZWWs9+T5PaB1qJINNUmWsAPqYWn
	 BDnmIHwtMVt9BBYAOI/a0sN0Pd0SZ/qznfhasCp1c1kWFdoWJWw6mJ8UQp+drTI/2W7xM
	 uuFj/BrOHEtxzZ/7f5wztjf8uH3EHAJmMvqTmUbitOsat+GB4dCQjI9OA8GlvGgsRGeEP
	 DvfWIeU39TXhFwwKskxJyVetb7MjomHKOzNgOX7Jj+3Q/fWA0xtNwXp8OgfskSbZu6UWi
	 bpQ8iiV8VFJeTgtAFUVGmjOpRFwKiUnbc+YAiN8LfDbPec+M9+sbgjw9Z4MNcay53wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JsqkhVAo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79A606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 17:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F79A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JsqkhVAo
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso2470576d50.1
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 09:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794330395; cv=none;
        d=google.com; s=arc-20260327;
        b=OCQZMKH8DacuqIYZQmPwPEanszT4TpV9eCXDgkH08xqz8NL+A87XyNSX84tbbYzAhs
         lcMXdPEypcBFkRiXKnvrzQ0ASjw2xPe0kOBfYJrI6IL/tYJ+K19ZfwwIRp3mwX45yjRC
         sEz6rxKUNZbCd7dMI/ri8DUMVopcIDjQX8cOO4qxWiQLes2MQP62MRoqsZcCmsEtJpOy
         0k5USxkyg7MABKiqiz8XqWw7ocNTfb0CZJOL8Ak0LpVQ/cyCDCVqXhAxPTeyHe/NnNFe
         wMPGoTyog11EoJc8tKAp1Q21OhLTQ7del/Lgo8GsVrycBAHonoviPcZM8J+y+mRDAu7U
         gknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+Lj8SdAE5uQOF9klUC+leKucjAphiWrEjdvjPFfUew=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=SI4H8YPFHZZkUw7TwkX1W/ljUkDke/U2Qa0J9ztzpQcjd5UNEBc/0knvU5Y9+6xidC
         UWcY/1x3lXok4MQJtxu6OYZTkwdA4w1pKoVIAySCiRirVL819IAQKv32mN/VKdwFO3gT
         AiC6gFCtjvQerW6AvWfZYgVGu8N3hzPFJRSt+tzduDR6klKmkZmp+BXcxPmSl+dy0cuJ
         sMkpUEMLWZYgyfAvCAuApL8tZiEFudB5+r4CAGEvNkO9k+0I4ZAc5Jzf2wumv8QN8IbW
         bsKoNl8mxII5PqOYhjUO9l6uYaK8nfeFmpZuABo7AVJ5wwPrhdoU6YUpQ4YfAzZrCmI5
         HHdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794330395; x=1794935195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0+Lj8SdAE5uQOF9klUC+leKucjAphiWrEjdvjPFfUew=;
        b=JsqkhVAooPxda0J0QdV7el7Hzea0NXfIHtcHLxo48HXwe6K2EHt5q9FVMEvbx8b3Ri
         vQYUwqpQLJUqQBUD8mBvNjZbauyl5ohpAMrPjvSLA6siAcJa2fM6CdIkAmYoWmXiXNaj
         2nPc/dMtRS9/eCFUFhpjttnZTDXzuaLBhIRFlAblubSm9w837Ke5qfYOgqmIsIZVJMua
         PtRZtTUCfQrU42yHnRrv2pVa7AmjLqjwXfyn6GEIldK6KwxhuTJz2P6uZ42jl4QsDitD
         11pw8cLruX1pa7h3+eVMDp9+NI4SLG1Agb0/9yLyGSpQ69URXqXyf4XVWyPXlO/+8bWI
         P29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330395; x=1794935195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+Lj8SdAE5uQOF9klUC+leKucjAphiWrEjdvjPFfUew=;
        b=YOZOWb6vq58b7f90ZaxvHNgnm6J0RIeRx1kNzVEPcp9PmgcIMX9/QJdbExUup9GiOj
         7aP3zzLdWCwJC52jpuR7SOFwfRIt10v6wpcKYVE9CbeuWdyhSdxb1rE4iNKFm2SAIRQb
         pp/1taSqbGm9toZ5kz7Zsrm8iU0CknfRnT6s3gBd4QVj/ufey4XjaAVDGX0ggLMB4AQA
         SQQM93ojncz3rA+ruUs5ZhV+G+U0QijHU7BBRdXQCbvKgEf/CoNi0GH5SJi4HP2EIbXJ
         zHFJST0QtIW50moKo1nyQuruYvbeESFCslyA3X8md/MnPAz0JYRZWPW4dKV9fq1mkTzf
         8kKQ==
X-Gm-Message-State: APuU4Z/DL+RYcFwOAzlIqkaaU1vIJh3kyOIpoHc+QF6QnYaYagGJEVv1
	Eldy2j2jmqn1u0boedyWeeFtICu2hZRaXNhqUgPl0vMzxhXJFZYWFmDgOUEzLuYGwsQ3xktgtXk
	xcdjAZs8D5ILKvIWXVIAHbIW/DiekYjcSH/a9
X-Gm-Gg: AYBFou0QCjDQ2jlGD/1HV7Hesshrw7YGL7RMwqS8Lp46KxTxXs2pMM4fGZZWgSOhk1g
	unHLczQH8SbktcKmtC/kuhFxdQOgbuqkyaS9zJ3u17PpfQxID7jPYKFHlHL6+/BTTEszK8vI5FH
	HuEj8w587zCxZ4t5dUGe3JNUFOFUjGSATyK3MnxllzuJAkbg3As8gIuMKxdJZskFGCyJN6Hpdh5
	WbrAfD1zkLXAiOqMB+wuUuqM+P8FeR2YqusQDV/stvvafxdZzH2ceVwNiSnVmrGzRuaDIPFbscB
	xe+meacRmn57shT/zmzEAs1ItwRWHur4RvcVXrcW/XkmZRH+hZP1nFTMZND8dj0ynaTmErvs6YW
	anxgCGg1v67zcUMXCdIJapfD4BfK7HT5czV2nDWhQnau3keM7scGKjoaDNTtEjdKbPsC+StgCIY
	5hhNwSDXGKBdXtH6CziCUt2nh3ivOexd21z7Z979rE1tkopbk1hxObkguoOg==
X-Received: by 2002:a05:690e:4594:10b0:67a:5135:14a5 with SMTP id
 956f58d0204a3-67c570ab45emr1262826d50.46.1794330395120; Tue, 10 Nov 2026
 09:06:35 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110105906.58509-1-cgoettsche@seltendoof.de>
 <20261110105906.58509-3-cgoettsche@seltendoof.de> <CAEjxPJ5b7fDYJ_PdAVU6tRwdUjRpr7VfQ7=g7wSD7mNp33-bNw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5b7fDYJ_PdAVU6tRwdUjRpr7VfQ7=g7wSD7mNp33-bNw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Nov 2026 12:06:24 -0500
X-Gm-Features: AclHuK-KQ8vIQ6rfL3f2244u9eMvkv0mhlY-cE6PjEPNGmoqsMkknMSvHxCsqGo
Message-ID: <CAEjxPJ6s=3ocO7k+c8+y=ncyk4fP39M=5U19fbh4V8Bqr1ORCA@mail.gmail.com>
Subject: Re: [PATCH 3/7] libselinux: set errno on matchmediacon() failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Nov 10, 2026 at 6:04=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The not-found and empty-context paths returned -1 without touching
> > errno, unlike the sibling context lookups. Set ENOENT there.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/matchmediacon.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmedia=
con.c
> > index 6ef3a217..38311413 100644
> > --- a/libselinux/src/matchmediacon.c
> > +++ b/libselinux/src/matchmediacon.c
> > @@ -24,6 +24,7 @@ int matchmediacon(const char *media, char **con)
> >                 if (!fgets_unlocked(current_line, sizeof(current_line),
> >                                     infile)) {
> >                         fclose(infile);
> > +                       errno =3D ENOENT;
>
> This will treat every fgets failure as EOF and return ENOENT in all
> cases. Preserve the read error and use ENOENT only for actual EOF.

Similar comments apply to patch 4/7 but I don't seem to have received
a copy of that one; please cc me on your patch postings to ensure I
get them all.
Similarly I didn't receive 6/7 but it likewise conflates a null cached
list with a missing file. Preserve the initialization outcome across
pthread_once().
For all of these, I have to ask: are they fixing bugs introduced after
the 3.10 release, and if not, do they rise to the level of medium or
higher severity.
