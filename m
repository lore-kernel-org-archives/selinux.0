Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F1426ED6
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380831; cv=pass; b=FRgyHW4hqUgxPCk6LePk56ivNCgvLAPkEzR2JRqqpUTPOMLqA32djNb88dPzt38c78rhYhP2ZHxoDSZyIpCWKGv8oHT6sM1oEGiOD3AQWkKaoAWb8lqYyGFDO6V+8sKQP8sCSyHDrMJHEbP44y8cXsWjL0Uib1BkqHuYJwdB3Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380831; c=relaxed/simple;
	bh=wUZEKH7hP8o1CyK0RfefCRZBTn6oa2OQiJTcJiKP/o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svjYu3EQP45kZysOYgGdCpCXEBF1RvaSlGHb1vRgvhZStD93WRPemJn4o+3+yx2WcO2PKO+EC6IOhOpyOoQOibMqr9LwjZ/f8TG5rL57Lr/hUyphcPjqFgnNZAgxFLekTDzTawkgjCviM9XKC2QnQ3D2jHBsKROr7WiJWSHc61M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgZdwKVh; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgZdwKVh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-358ed696623so5027206a91.0
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 05:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777380825; cv=none;
        d=google.com; s=arc-20240605;
        b=PTo1KWyDAZuL7TCE0ZzFJj53KroqEIxtP+zsaEKBAA/okDmQu9vWFUSmpfd7U1iwrH
         YBuw62LX9HZ/U6UwsH3BemnV51bH54y+MUks/RuKt6mOHvqQHGPoIY1YaasI0As9/BXf
         Jn3KXuoSpId0m6Pr+7e9GyAdkhXbJ7pFOa0K6QXq4V32H9ObGhjXErNPlw7755c9QHVf
         ggAXIkWCyp7K/8wY+19zD/xzNJGzvyynaGplygj8/QwVe4EI8JcULvVXqgu77jSJMaIN
         MPhW3twf2P40rhG88YUnsA1rXzAvft/ci9P1oduCd6YdQVZRzHB5IyVPFyxEItQRGq0O
         eCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mpSuarvKqxreeVZ/O5bDwZ8PARRC+aGvAr/tXOTxd68=;
        fh=PQ9c0cqNZEx8z6DXNbb0bdcSA3mtTzKxO1NP01n5Va0=;
        b=KZ/0fSusXmOyPEiMG37duKqK/ido5s2W2C91FH/XIO+kDYG6HGrmSGQK3k8pVJuiQf
         LZyszUiPTYar3+ONqZO9LP077Zh1mZzBiEeBKkNc3ElaTCNnsBawW4vFnjdPAP1W5MwZ
         JIzVf+oP1jPIGFvlL6mBICqDqmRK8L5eNkiGIBlc3Jp/fIh3B/nnidiR+8Yuhr42Q8v9
         8ftTJszet/Bnx5rJER+YdkoaJzTwoqbZJkW70oq/KRXRId6fMosORzcwYBLzPsByWNSi
         TYsR/Tn9jrTerGbBF6NxQu/sIBDGbOrGOQRpL2tQXPggVYm3iflTZm/bxwYu1/Y+OY+a
         QeRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380825; x=1777985625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpSuarvKqxreeVZ/O5bDwZ8PARRC+aGvAr/tXOTxd68=;
        b=pgZdwKVhfpHUh/UbG9eSaX8LRvejrcxWZN1qk9xeQsCzdRlGjjN7LTC/JLlaCNzlGz
         7iGR6p5K5hd8rdLuNTy1ryetgdZHrHS8aCgNsCtThC7nve/r/D2ZMN8MGlb5oCDUHjI9
         SVTImXmbOARVDjl2D/7yh76Owx6IFqArlzeE2p8jzEL1yjIWt7MWlqau3YQnMCXIfYkb
         n9o7O4Q9akG75H9RXAOVyEh5bp867uYdvcMF6/87D2VqJGlZmI2q4ZNVRtY20E34/dwu
         oyTtQYHkHSZ8IsdD2Xp665m6Gst8ip2fzcCykq5h6IhvwUzEQbK9mFFhIC/asVDt8Gox
         DoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380825; x=1777985625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpSuarvKqxreeVZ/O5bDwZ8PARRC+aGvAr/tXOTxd68=;
        b=OduzaxAYVX9hJSmB+s/4qcNINkc6U4VkyOOBSrx3K4VA5NuXZhzNM4Xt6JsOv6ZAze
         o5lFOYJkYMzy5ln4hNL+8TSvSSbqFIIpiqZgioXgz2BKLNgyoAu0tl+2CWqtCTsa7LDC
         tiOazZAoqk2dU7I0lmHlF/hAod1ovZF591NnJom202RkZ2NYnmfbIQW50bOTdtmhdfoD
         tbKrvfmpVd5wj2DR6xJwtqzKnrpbyXMeEwZZ25cO0oeJJ3cV1z3pu/EvwCToxd1MGTRU
         ti4ElRWtrIrUogPU4WHiSuClvgK9Ys26Z2P0/SkrtG8Q7QcuSsxvtN5drQ1d4iPDiQPs
         tf6w==
X-Gm-Message-State: AOJu0YzRzYidfp36N7fa/gF5wapnWw38vwPfm1gbMDf+MKNvRBeQPnBr
	SJ8Qex+rQo9uwyFyp5WauWU4eM911ImjlZg8E8h1UntemENIFxfiKduOXCKFTG+3cOk+vE2GsgO
	8Is3z+1z3O/TvnrmXIFbK2AgFyfp2rFXF5w==
X-Gm-Gg: AeBDiesMww7rm9NSaa9DgcBVinS3fvUPrqNUjw/p1SBOm72q3IT7QFqFARE4S0kkB42
	0vJPvk1xrjhQTX8TCldNL7aUXlSQHbKueEQVnfUibgFNsXv9A1pZTqw00ZzU/YlzUZ/HzYXQoWG
	aLQFtrcw2BnFjkOH+eegbMh5zhVp6L9N2AANxbIZ/bGeWZrLu2sSw0XwR88MCQNUyTFRwe6snyn
	eUD1hdq0LIyQf/thnQiNY6u8sHYq6kWkk7Gx+SN1j19Mbz3SUILEoZYpjy3Hl1kOlX+hG3VOtGP
	nNqQ8Do3dLZgMIzNpw==
X-Received: by 2002:a17:90b:3bcd:b0:35f:b7c1:faad with SMTP id
 98e67ed59e1d1-36492048cddmr2967716a91.25.1777380824620; Tue, 28 Apr 2026
 05:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410192949.16542-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6y9p0gs17s7090UcbAcA2KtGcj2nKqi-hBtNZ3zgwKDQ@mail.gmail.com>
 <CAEjxPJ4fPyXO6MWef7kA=gM3HTDhYjvhEbZNRoU=AG__K6havw@mail.gmail.com>
 <CAEjxPJ7ASrJSLOMrryvHGQT7R7rTvfZdfdTPu6z9SmCRUX_wDQ@mail.gmail.com> <CAHC9VhSDYr60mZSasYR+_0rGJ7_SNfL_O3FJmB_nFPQciVQ64g@mail.gmail.com>
In-Reply-To: <CAHC9VhSDYr60mZSasYR+_0rGJ7_SNfL_O3FJmB_nFPQciVQ64g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Apr 2026 08:53:33 -0400
X-Gm-Features: AVHnY4JZ-qStooY2fzxat0__dnsciMz-GF1W4FqWGn6tPPpV8i9nkh56hUxuhT0
Message-ID: <CAEjxPJ4971km7W_MsJ3CzG_dL=_wMoLwzSpkZ+g2yrY-s+8f4Q@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: fix avdcache auditing
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 21, 2026 at 12:25=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Apr 20, 2026 at 3:13=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Here is some perf data, using default Fedora kconfig:
> > > v7.0, unmodified:
> > >    2.03%  [k] __d_lookup_rcu
> > >    0.80%  [k] selinux_inode_permission
> > > Ratio: 39%
> > >
> > > v7.0 with v3 patch:
> > >    1.95%  [k] __d_lookup_rcu
> > >    0.81%  [k] selinux_inode_permission
> > > Ratio: 41%
> > >
> > > v7.0 with v4 patch:
> > >    1.89%  [k] __d_lookup_rcu
> > >    0.92%  [k] selinux_inode_permission
> > > Ratio: 49%
> > >
> > > I only compared the percentage spent in selinux_inode_permission to
> > > __d_lookup_rcu since the changes were localized to
> > > selinux_inode_permission. Aside from the fact that v4 is measurably
> > > worse than v3, I also noticed that even the baseline seems measurably
> > > worse than the selinux_inode_permission() percentages reported in
> > > earlier commit messages, although I guess we didn't re-measure when w=
e
> > > switched from the per-cred cache to the per-task cache (but that was
> > > necessary regardless).
> >
> > Actually, re-running the perf commands on the older commits show
> > similar results for selinux_inode_permission() as I am seeing now, so
> > something else must have changed in my VM or the kconfig.
>
> To clarify, are you now seeing similar results with both v7.0+v3 and v7.0=
+v4?
>
> (v7.0+v3 looks pretty much like noise when compared to v7.0)

No, v7.0+v4 appears to be worse than v7.0+v3. My comment above was
with regard to re-testing older (pre-v7.0) commits where we had
reported lower overheads for selinux_inode_permission relative to
__d_lookup_rcu.  On my current test VM, those commits are now showing
similar overheads to v7.0+v3, so I think the difference is just some
change in my test VM, kernel config, or noise.
