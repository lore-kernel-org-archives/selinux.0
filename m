Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B83CA4B6
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698816; cv=pass; b=Of4oFC2icKJRJgPTVKX0ltLFNR/K5wq+SRidoqBvXkY6SiibaFfeko9xWtHew3R4aOWlIdIaXKK8GG/ZGRfjSap+ax2Wdo5+0nP7g4cYQ70CsOsolatg0rsqVUnrbUqzieUhpkdxWIaKI2nJNpaZXtqTbxgMZapu4Xn5PO32/q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698816; c=relaxed/simple;
	bh=bGL6iw012aTfw6q6iysapvNQ0krL/KV2tpa8YRUM6P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFZzmFPskAGh93Caokj5LnM7gg1MZYsqdlkee4ZXiSAXSjC+pNdmLgRu6PxiTQ2MzemM8P1de0E1XhAcchOHUrKat5i63OxGXMkdWQuQSWLIq3TMhgN5wTavoSDQ7lEAWb1a0BEsg1mEEdbBbTMMtYHO3mbp9mqdtDBdx0hLhe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiHXM8kr; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiHXM8kr"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b33a26so25321557b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790698814; cv=none;
        d=google.com; s=arc-20260327;
        b=jixHEkYOfTtNI12rLZNp6ryYiZeDfZ1eDREeenIC2LqwtRj0uAa5wmAw0lF40x7iBm
         e6Tt9LSV9xjLZwSYSa2pIqg0cU8EDHzErwLEUuaR1gqdQvggo98tNLNbsbcpiAymsG4i
         d6XVrXHTWW9OAhwH1fIQwKvD/pnydHdS03isJXpyM5IH6lZKyeQk6parlPDNjBF9YonE
         w5kcdmeWVt9DlGg6hC2FcrMX1b8xNflC6yWHTipK36vTaKUZUxLi469vuB2Wpve7DDDl
         lKy+hmVxNmqTOCV/5uI/PrSwE70SpUxIm9VMrUDLVtTHQL8M/iCWgG48ekYiYqTZOWsE
         qkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzu3jCTWNoijuNjBG6q9GymLM9Je+XhAWwwtXGgNW10=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=kYe8UhNPg2mg9nsUb5fDJnFZw9SwW+RqXtnfg4FdtGc56M6U8NifvaB9+Z8mBxjQTU
         l8BPYuOv6QQrSa/DfSDvSYJEjK+mPCzIQg+hW/lS4voxbu9tj+58wAJQc9MVNNg3Ru1W
         j4iwnIE9wM9vTl6Gn+Gbl/k6lROOKtFuFgE+EC2vG7O2kDjU+XHh9IjFHd0YHeoxp/o7
         w3pAKEPvrUP+5G/+j7PWAd+wfJK1bS8wHk5edIWepybJPgsuBosO2ia8vvy8K/ohKgnk
         xF9CbEdd0SXbs+jgDr6kM8ah5J4fqqQqiMakrN5OxVuuY2yd8WOZbuB5j11GsMszAfRV
         Awpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698814; x=1791303614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzu3jCTWNoijuNjBG6q9GymLM9Je+XhAWwwtXGgNW10=;
        b=DiHXM8kre3Q4dfU5PFwBZNfe5MpEbIP1HdgFK+Kt5Qmpyw9252nEzNDw5CQgQdno8u
         BTY0bjUXD3ut/hiUNwutYUFuUdIIlEyyp+7pQZOih38qS7CtYc2SWD24U2b0G+41Qkr9
         uDv8X3N0Sw+GCTSSwILd2VZXNJ4DD+9foRw4hUV3fo5S2s9Xhq1wBA9O1aKGJIy5hKI1
         iX69LvlC3DUG9NqEDEZpWC8XKqhsyAOaNdFREe/z5H4nt8RxFa0roD9WBlLuNG+ACxrO
         0QkEXE7xYfkmqukG0f0yuu1x4eIC7S8/RxLUAxOamY8Me8P0i4hJVxnkwI9j70q3vlw1
         3ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698814; x=1791303614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzu3jCTWNoijuNjBG6q9GymLM9Je+XhAWwwtXGgNW10=;
        b=rDBzYBvKosMzUisaNOWNx0vcBfnBQ5Eun6KIffDbLB5VoytpTt3j0i7eItYHvcTaUd
         s0shd4oTo4pC+V+JL2VQ4zyQbPgzJBXa37Os+vLebC4s9cqbKlxRWBrc+t3SmLbJZOfh
         Y46+j7p0hs1S9itbon7PkHrJ+G2ztfG83DRaBQiI+ogWxosajb+KA/tmW2VVd4YPFutm
         lcJuHfdgDorPs3AX8zGu7MuQNRZVk9KEiNR+xD33S2buZQkxs9KxbWnmmc8SnKNRa+jt
         6NuP/fPN0bD4s7EEpVW9Srl+ryTnW8Ya6f1/ztxyPApN1aSR0q++E7iSKylquwlbqLef
         l+ag==
X-Gm-Message-State: AFq9FYJzN5dEIhfGn3ZfGCiXQEinKt6vGBhW+4SAnYfv/0EFDhc/wNP2
	33PjZewJynPhEe03+HxxkW3Fm4vXcdXBtBWwwDZZnB0Z+RNirpiLZ35YqtRL890YfItfarKReR8
	M4/T+/fxd9tFH+dnr1nXXATXeybKWHssowQ==
X-Gm-Gg: AYBFou3uJCfOBWnOLTLzd0e/SxKF35wp/5YAyZvdt/s+YHc9aiW+EXcLdhvdYK3zIl6
	vZjgquWCF3CnFXwb7kMCUb6dlv1oI38nFiiVCSb9ZOGq7X5qprFBZOGjw/TVYpAq6VXTbXK/lWk
	sQdcbdN2t1wMrxSnA724tTISRmWw8VjJg6OVGb5R7+KSTD8qJwyJoTJzE8KHVFN/xbx3/wmCrVA
	LP94e/5Rvx0f+3a4u+yHPTSVc5xUpYbZH386eva8geqTD8oYem2CNi5scURoCmeAQBAHpBFBY/Y
	ZII28kBixxU4TD5bqGgOBAm3z8Pz7saWtPKkKVdzx0FwOG+/6dbWQug=
X-Received: by 2002:a05:690c:f07:b0:873:5c7b:c0f9 with SMTP id
 00721157ae682-8a64bb164a2mr89339387b3.49.1790698813837; Tue, 29 Sep 2026
 09:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
 <20260928155753.2259807-21-cgoettsche@seltendoof.de> <CAEjxPJ5BYBkugQAvZD8FzUidGV8tA5zv7WG-EQsTEhk0F3L=WQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5BYBkugQAvZD8FzUidGV8tA5zv7WG-EQsTEhk0F3L=WQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:20:02 -0400
X-Gm-Features: AclHuK94A_Eovrd_Ai5duIbv9pNdXExWCzs3Aw_-Yqqs_4d98HwUWquvlLzYBDU
Message-ID: <CAEjxPJ7Uw15KjHkv=RuX1OdZWq9Sax_d=jX2TG0RsfsFsuSiqQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] policy: allow io_uring allowed in the io_uring
 test domains
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 11:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 29, 2026 at 11:10=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Since Linux 6.15, io_uring_setup(2) is subject to the SELinux
> > io_uring allowed permission, checked on the calling domain against
> > itself (kernel commit c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hook=
s
> > for io_uring_setup()")).  Policies that define this permission, e.g.
> > Reference Policy since commit d4084b9fa ("Add new kernel security class
> > memfd_file and new kernel permissions"), do not grant it to the io_urin=
g
> > test domains, which only get the minimal testsuite domain rules.
> >
> > io_uring_queue_init_params() then fails with EACCES, so the positive
> > io_uring tests fail and the negative ones pass without ever reaching th=
e
> > check they are meant to exercise:
> >
> >   avc:  denied  { allowed } for  pid=3D3493 comm=3D"iouring"
> >     scontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
> >     tcontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
> >     tclass=3Dio_uring permissive=3D0
> >
> > Grant the permission in the common io_uring test domain definition if
> > the policy defines it.
> >
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> I shouldn't have to re-ack the patches that didn't change. Please
> carry my Acks forward in the future for unchanged (or even trivial
> changes like updated patch description or comments or other
> non-functional changes) patches.

FTR,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
