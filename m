Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B1402432
	for <selinux@vger.kernel.org>; Wed, 25 Mar 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460212; cv=pass; b=o2dBGNc1BoD1M8cKBpvX9KmvUZMevJHUYxuLgsG/T8qACEZsjF5ZOjXSub+jiHrk9mPC52Ii4H3MP3CP5ToTiD1UuNxwSC6JRgH8UvrKHmagqewNN4OC9HbQYAzcxaRdWu1IQNHORTr+nO4vner+1gEeG+IH2tJS1zySOFyk474=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460212; c=relaxed/simple;
	bh=SXXvNMm4OOeTVI5sEJNC7nVh6MOtnfj6hXf10537/DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXc7PI009GCVj8n5FCpCk1KySvSQ4Kh3FrHeQm1pqCeP6kxn+4Kqo5t0p0rPUGHkv6C5zEZvDBZN0uL9LE7Ggd+kXgv0DVVTHV3Oy9rLkxb/sokGIfHyqrWCvyuq40F166vOtNARR/Kj4khhPzLE6ava0aezzFg34aps1Fr7L9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DD0nH9KQ; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DD0nH9KQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82c70e4654eso53646b3a.2
        for <selinux@vger.kernel.org>; Wed, 25 Mar 2026 10:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774460210; cv=none;
        d=google.com; s=arc-20240605;
        b=X+6OI8OdqKyRXIndj1jE8hxgPER4vlhBSG2ih08B80RstRJ9yKKBUlzZmmRUyXPhXI
         MUFeFSwuJsHYACrDXH8IA4aWLQEwtandO/AWsd/eUEsdi7iToicYA4dyGvLxWPHrNQFb
         PFXy34hWEz74RGJwlElMkWdT8w5c7wX4joDmndXFnzq7tes73GK95/RIJ/NGR/OPDuOt
         d48SiXLvC/6KZEmQCWED0WTMCT5kEEq552akoDvWOir+ojsOivar3gSZCWI3lnbuVTYd
         KAbFscUobEsk2VnpTTYllznEkwAZviS63kZIM+f0Dq0FKbeqWFxSzb9XETDqs3dSI91G
         LXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        fh=FZr4OH9eqYEJx3RSc4aFtebDcJMBnrhCSekP4Bk24As=;
        b=EixgX1bAb82g/L9BMOihTOs3ClFy2rZ635uaTf0UDuaUFBPyz57L08IFwlaHDkzRGT
         PLZrB06lf2ZmUxq4qjSJPRBLwBWjytU/dclNqDc5Bw3XBlKgWMrD9mlKV4VFE42K0Wm6
         h7jsXV79Qhw4cjX5T8d7VaQEIWFydpR8RLChVQXZq5urlZYZ6Uz5WLcWVTRziEIy9JYt
         Za66pjAoMPs9vCcaXdgfya69ejVCayANkhdqM8sAg2aWTmMJ2mS5wmNW46LLMHO68rVo
         xWvHSJcxl6yHsUWWkh3NPXdQsLhDPm1yV5LRTvgBIh23iYfDYGr6qAb1L8tJ2wj6uw0t
         5WiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774460210; x=1775065010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        b=DD0nH9KQl1IYWPF404uwuX/UIwWdC4xPMi7UnOVf1ppDz5q3jCBTjDJdhfdvWPI3fc
         LIMP3cOmjdPwlRGycoQlHYGk6rQH1RpOqPJjt0IC3iuDQNkNvVVQm/dbKPGlD1UAFZhR
         qdV0RHP73WosmwNpT1GlSz253J1A7GAjwLQQTg2qKjVBpdCL36jNUDIg2HvU2yCbYsSp
         BFYp8s4s4jAA/bI7fyHZZlUCTxYKQcdqCHiP9gQ+ATwH7EDOe/X+8fVlRnWhnVEGLpMn
         MVKvZdmsOlbEjJpKgFV+ZoDBcFnPs6I+9PxG6rxAFW04FS/tT2DuUskI5BxjIV5s/DLO
         1GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460210; x=1775065010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        b=YdpzxABBkcsm/usI5IW2fEF7Kyrd+k8OjqJnWfs1VMw03vAMiNhEkgpM0YaXrAvXIO
         PBe8/UYsefoqvzgG61jzllFFxNv0C+W55TMLkOabLCW+LCYtqWbiqMV3SEP+CV0EQV95
         YcWUpQ4uSAHiLUEayIca22hKtpyObDEv5PZUcdmaktRFBbbLB66FoqQo8FQ6Qs79+5Zg
         D/0bCcPkOEvhfsYxlmDEW28QINuhZty1fvfmLDPplwK/8dl8iNJiIqiOoTApcP9m89S6
         R2pRy0pSnS1oHYkKkFrCcIbD1YKhEZlgoJFOt8E9D1lTqLJcD3NNSpINUmmntM0TzCn6
         CdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJRTgOoVvZlyR0jp6vFs4GGEuW/l6+Bq/bhjAq5FEThPfs8aCVdttF6PfTECCqMHZf3QqbAzFZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOQeBuBw24GTzaXBZRkUQZz9/kJEVF5YVrx1e5zWv/B2r1Q2e
	owXfBG9V+oXRPdlqLSQXF/gA/waZ78N3hUrXUQA8AA9ccfkAe9zpnn2JPDlZzxNyt3mcPM2Z4Lr
	RasYbyRhVuLehhqB3nhXLD27nkoZc49Iro27wpTXZ
X-Gm-Gg: ATEYQzyDkdrCBpAp00ZbSmiL25U8v9vpBOGRy+g7jO0kEek0IEK1fc1HWVYMyWxxNmk
	bqbae4+bmlcpeM6X0aV8daxoGJ73yiFPGgTC8dBJ0wvCOHUS+XlXJJ4vCkhfx2xIF1ltZow5Q6Z
	4QljbI0wWF/0tTUpv9O9gUpbEaG9cdSBpxVszN1vWaGZNTxqMSC51YUb5rQ+xfK4XBgC+wMuYU7
	ZEO0pe8QRHaDALpdRD0aRh5ZF1uME+SO+T/iaJZi/jDLTRYbfSTovz9+JsbmipPq7f3A0Kvmeje
	YdFMfxM=
X-Received: by 2002:a05:6a00:4219:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-82c6de7aa7cmr3962195b3a.4.1774460210073; Wed, 25 Mar 2026
 10:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323042510.3331778-4-paul@paul-moore.com> <20260323042510.3331778-5-paul@paul-moore.com>
 <CAKCV-6t=m-8eu1xoTORnLwhG4kQB5u1v5diJDQDFcat=tH8WgA@mail.gmail.com>
In-Reply-To: <CAKCV-6t=m-8eu1xoTORnLwhG4kQB5u1v5diJDQDFcat=tH8WgA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Mar 2026 13:36:37 -0400
X-Gm-Features: AaiRm53RXGI_5fUjjLSR_a0KxLZyxKMzyTIPSX8PFvRbx9JxRVkJ2AR_0Hlvr9w
Message-ID: <CAHC9VhRNOGk0dGERbD+RRLTWebZu1-7cbvB0a2D0njbnqBRNXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] lsm: add backing_file LSM hooks
To: Ryan Lee <ryan.lee@canonical.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:01=E2=80=AFPM Ryan Lee <ryan.lee@canonical.com> w=
rote:
>
> Hi Paul,
>
> I'm currently looking at the patch more closely to implement the hooks
> for AppArmor, but here are some typofixes and the like below:

Thanks Ryan, I appreciate the extra eyes.

> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 83a646d72f6f..1e4c68d5877f 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h                          unsigned long p=
rot);
> > @@ -1140,6 +1146,15 @@ static inline void security_file_release(struct =
file *file)
> >  static inline void security_file_free(struct file *file)
> >  { }
> >
> > +int security_backing_file_alloc(void **backing_file_blobp,
> > +                               const struct file *user_file)
> > +{
> > +       return 0;
> > +}
> > +
> > +void security_backing_file_free(void **backing_file_blobp)
> > +{ }
> > +
>
> Should these two placeholders be static inline functions, like the
> other ones around them?

Yes :)  The kernel test robot found the same problem yesterday, I've
already fixed it in my working branch.

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 573e2a7250c4..020eace65973 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -293,6 +293,8 @@ static void __init lsm_prepare(struct lsm_info *lsm=
)
> >         blobs =3D lsm->blobs;
> >         lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> >         lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> > +       lsm_blob_size_update(&blobs->lbs_backing_file,
> > +                            &blob_sizes.lbs_backing_file);
> >         lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> >         /* inode blob gets an rcu_head in addition to LSM blobs. */
> >         if (blobs->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> > @@ -441,6 +443,8 @@ int __init security_init(void)
> >         if (lsm_debug) {
> >                 lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
> >                 lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
> > +               lsm_pr("blob(backing_file) size %d\n",
> > +                      blob_sizes.lbs_backing_file);
> >                 lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
> >                 lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
> >                 lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
> > @@ -462,6 +466,11 @@ int __init security_init(void)
> >                 lsm_file_cache =3D kmem_cache_create("lsm_file_cache",
> >                                                    blob_sizes.lbs_file,=
 0,
> >                                                    SLAB_PANIC, NULL);
> > +       if (blob_sizes.lbs_backing_file)
> > +               lsm_backing_file_cache =3D kmem_cache_create(
> > +                                                  "lsm_backing_file_ca=
che",
> > +                                                  blob_sizes.lbs_file,=
 0,
> > +                                                  SLAB_PANIC, NULL);
>
> Shouldn't blob_sizes.lbs_file here be blob_sizes.lbs_backing_file instead=
?

Good catch, thank you!  I'll have the fix in the next posting.  I'm
hoping to do some more testing today/tomorrow and post a non-RFC patch
by the end of the week.  If you find anything else that looks awry, or
just doesn't work, please let me know.

--=20
paul-moore.com
