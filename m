Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A4338937
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061502; cv=none; b=umW5ltrQ/KSITYukY7tRAGZ89dPXjOwprIBBfAYEPkWm340Cx8ibh4fFzRMxFgnvsa7vjDg+Qwk6RPJD+nVfZp51Nrb6ht5nLQYjIcgKu+ayu2tkaK+sl4CvKpC8h+IvUtBqqlxH3Q/69oK9XdQQpHPkbfeuf6yrczvrENkLOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061502; c=relaxed/simple;
	bh=2PFyqNZSot8EDSGMplRBObbfqgmY6ztn/ALY7W+G8Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHh0kR2ckMQPTF12rUqCxtAnCoWDvSiLi0Q3H7nbB/L4BRsPdbEQx8gf0ZYF8/soYe/cdNXbFhFaKQc4Ug7E23azIDmVJG7jxkZUppkFG6LjtHhiWBkIugtwtEhY2X/pTIKDw7QIje33Yb6X/y4MNNclR8DgaTTgDtogtXjdImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dLkeUeFl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dLkeUeFl"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso22997a91.0
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761061499; x=1761666299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MK7K2Vi99xas8WktvZiAjv4QT6t/qx7SHQF2LdRMWg=;
        b=dLkeUeFlb3efPsoHwrpKxIHc5dh1aGja/uhFZ0nwX2XlcVc0oKRkWzXWEdcZuHC1ti
         0cgpbkTwMz1EDH6bbYdL/GWCg3Fvnbt0vS0Vgy8KZx4HlkV0+dcZtKx1lBJX+zZZs4Vg
         Wu/lkGvcnOG35aSx1qBwPWayjC03iQdMzT7QPGryTuJDFWD/H2+dUQFD2Yl7Rp9UhrKF
         6nhaxTaCdyFTJwTAKqw93a8fg4h35szY4IYDjyOWvPpfG/G6xIencPcMdT1yA5qJy4Dq
         CCDK5SqphaIfuofInBDESesq5ikqPyOOzhMHh0UtOPKLkm/JxV/41a6m2YWslid0+SpQ
         w/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061499; x=1761666299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MK7K2Vi99xas8WktvZiAjv4QT6t/qx7SHQF2LdRMWg=;
        b=XHn2KtLAvS8ff0rOn5jroyuFajv/3LBBT8TQB4GjyvLMM8jTEy1SnlCFwm4A+/qE/J
         kA48vUSEskHyeiKR67uF7Im3dDYrlvR0u1LvPEbxjmwS3HOXWSaWaBzmfnL9HpAxT92i
         6ND4lWsJiGGm+elMIESME5BbeLlZjKZNxCiDmWcw9pNwz/AO1hwmCAb26d8a/AeNkAoU
         IzGFFWR/mjYQonEYIdoq9NU3HX0fer6GqCvzkrhvKSWsE2CWH7D75yG8ZiTBKDHmOjwb
         DwPEVQw7n86peFiadGegHIIE3kftFU2rEIcHbBsgZ/stX6P1bXV3m9bA+sZfXtgdFgh9
         hlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoV8QSh2MWVSlYfTN5YVQtgbxpJJp/n4cGbIEW8Cp8Eohmq3CdwT+c89dBwxu5GHIeB2+oBulc@vger.kernel.org
X-Gm-Message-State: AOJu0YxOup89GHAVGqwfE2CZB4HI7ei01AhvLeexlCscQEgZjAvyBhuU
	kP0DLUUuXbapNXbjpjt/KL6kehirg1jsd5RedbPF9m0X7iXR6QWeKoua01H99ShpsafWDxwNMSq
	hvT1LjTVAp7RImsPa4fNrBdMWQltMi1WM65sfXjCKPg43anQJrXcsKRxb
X-Gm-Gg: ASbGncu+jn3sjZddLh6gabyRyOTKlbspJS16EnSTRBlnOtDu38PT++TvdY62azE/gWC
	MWs+casHjgrRyHSpBANZ5sFWXfr0+GEJJbzm0M/AwxYYGbXov5OD4Rcdl/93FNlqtMawIzK7BNt
	PiVmDIjlVXlhumxX9+LjFXTTBIb/MrzZ300wCUIYEiEWjrBALXJejezGA8af40/xqQ6zRS0Id//
	PrzYKWEAO+bDItvS4NPlfRCcEXVtBSP86XPEzOc3OPH1yYaDkQg8vt4otJ4
X-Google-Smtp-Source: AGHT+IFQOGllR5Jxi/TrF28dWQPOXUr2TUQ1LEG9JjC84pIqFv6UuDKjZ+Hh5UHwdDry6HVzfiTcPXTufR+x4+xdPHY=
X-Received: by 2002:a17:90b:1a8f:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-33e21ef11efmr200209a91.8.1761061499140; Tue, 21 Oct 2025
 08:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQ_hv1ri1csrgGP+9RssCuJBDuOLSDowZRD5xZcDD2mPA@mail.gmail.com>
 <20251021123842.968605-1-zhanghongru@xiaomi.com>
In-Reply-To: <20251021123842.968605-1-zhanghongru@xiaomi.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Oct 2025 11:44:47 -0400
X-Gm-Features: AS18NWCTB9vDb1wg1H6rs7OmAJYTQeAAWNpZWN3LNEXMYxnDXbB0GiUgNAMn0pc
Message-ID: <CAHC9VhQeW7fFtB5uGRJhU7882MsSLazHmOZ0UKj=pX6PKiwz8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable
 during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:38=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
> > I would imagine that a very simple implementation would simply convert
> > the selinux_avc variable from an instance of selinux_avc to a RCU
> > protected selinux_avc pointer.  As the AVC already uses RCU, I think
> > the number of changes should be relatively minimal:
> >
> > * Ensure we wrap selinux_avc derefs with rcu_dereference().  This
> > should be the only real change needed for lookups and insertions as
> > every search through the AVC will start with deref'ing the selinux_avc
> > pointer.
> >
> > * Update avc_init() to allocate the cache slots with a default value,
> > fail if unable to allocate the cache memory.  If we ensure that the
> > selinux_avc pointer will always be valid, we can avoid having to check
> > it.
> >
> > * Policy (re)loads which would change the number of AVC cache slots
> > would allocate and initialize a new selinux_avc then swap the global
> > selinux_avc pointer under spinlock.  The old AVC cache could then be
> > free'd according to RCU rules.  I haven't thought about it too much,
> > but I suspect we could do away with flushing the old AVC in these
> > cases, even if we can't, flushing the old AVC is easy enough.
> >
> > > When increasing slot size, we could directly copy the contents from t=
he
> > > old table. When decreasing slot size, nodes exceeding the new slot si=
ze
> > > would need to be re-hashed and attached to appropriate positions.
> >
> > Changing the number of cache slots should happen infrequently enough
> > that I see no need to migrate the old entries to the new cache
> > instance.  It's a cache, it will fill back up naturally.
> >
> > > On my Android device, policies are fixed before system image release =
and
> > > don't change or load dynamically during system running. Using kernel
> > > parameters for adjustment ensures no additional locks or checks are n=
eede=3D
> > d
> > > during runtime table access, maintaining simplicity and efficiency of=
 the
> > > lookup code.
> >
> > If your system does not update its policy over the course of a single
> > boot, and presumably doesn't drastically change its behavior during
> > that time, there is another, simpler option that we should consider:
> > setting AVC_CACHE_SLOTS at compile time based on a Kconfig tunable.
> > The code change would essentially be one line:
> >
> >  #define AVC_CACHE_SLOTS   (2 << CONFIG_SECURITY_SELINUX_AVC_HASH_BITS)
> >
> > ... with a corresponding entry in security/selinux/Kconfig.  That
> > should be a very easy change, and if you set the default value such
> > that AVC_CACHE_SLOTS remains at 512, there should be no impact on
> > existing systems.
>
> Alright=EF=BC=8CI will add a CONFIG_SECURITY_SELINUX_AVC_HASH_BITS in
> security/selinux/Kconfig, the range is between 9 and 14 (512 : 16384),
> with a default value of 9. And then I will send a new patchset version.

That seems reasonable.  I'm sure you've seen it already, but you'll
likely need to modify AVC_DEF_CACHE_THRESHOLD as well ... or honestly
just remove it in favor of AVC_CACHE_SLOTS, it's only used to set an
initial value for the cache threshold.

> I will try to submit the final version in Q1 2026 based on the discussion
> (Because I have some planned Q4 work that hasn't been completed yet).

No worries, thank you!

--=20
paul-moore.com
