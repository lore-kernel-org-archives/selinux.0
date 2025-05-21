Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC261B4121
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828024; cv=none; b=qOxlh/5OoZmV3hYgpXlAQ8O4kmaRRJi3v7NOS6bKbdke1BjDwJHg50L2hJ35m1aAsASMgFbV0aVCbdC+GJyN2TgTCNWttWiy2UkfpWMKAVBQHjyZHruarPYxNhrU3nhgSYNESIkTBnguWFRXgyf5SSAyPjO/P2Ha31odLGd+xsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828024; c=relaxed/simple;
	bh=Q9tD4PjoW3LYG73N2pW9ZHcUCfTZOCKcFn12dMvxkyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1FE3dTyCa0G0g1c9/zgNfuoHm9D1yTjZQ0iEV5GYoBtVhUrSLNA+Jkbk8U9gFcUbFv5RKtKjbKOSI/oDrtK0HUMs2OUIhXIakqnnhw6gjdWk2Md03H9is0P4kgJ0/oBUqviNK5U3whsuJGxhUx5f4tMm/iU0/K22GWvOHwxwtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYe/vQqw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYe/vQqw"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74019695377so5067229b3a.3
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747828022; x=1748432822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqoyS4v/Qb0L4/5jKBcCIoW0N9NJv7yYCSRfzxFhjs4=;
        b=IYe/vQqwjbdAP5ZFRSuGIp6cUSRI2syxgqxZ0jrQECXpzhl8YcAfFOW6QrF58wnkk0
         Rqiyq+qukoI2Bi4y2+1sz+69p3vA4j+maoAy1aCks6DSXV9ZuN+NKWSBZP0e3CHOb0OB
         Rakl46rC7eR795azNQeYCiq4umZnGZmCfivasMRWaSCD3WGk4xFu2y6uR5v3etIq9Qcr
         DzqkJnH/4twCfDsh4TuLz3ImTOLCpv29S+WzPCE6Cp8kCr0nY+lEueqkCHP4kklVIZKH
         L1jcv2DHnIht+GwR7QL5RfTou6MUZrUrL6bfVpIy84IH2xjSknsxxL1Xshaz112ie0/L
         pV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747828022; x=1748432822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqoyS4v/Qb0L4/5jKBcCIoW0N9NJv7yYCSRfzxFhjs4=;
        b=TwTaq5666+BpQEz2trYbIowPbSq3HqbSZcZy19zmXDDW2WjcJirjWJJ0alDs6AnFCo
         NcXNSG34QgTbWa+C/zOVvldDU3hiIJX1UJW+/eCWcQ6+cDeyUl8vfrprUWP0yVkCsKTL
         85xtA9xHutuUpgd4ghXHzvBOG8mwvCSM2IAywuXaLoG3Z1/5nkLAmAnY+9UWY2xMhrFf
         KHtRnBThLES32oggL5MarU4Uh4uzfuAJlXyaaXomIyU2qD7dVbllyriWfiOqL6NBATPF
         lX4Yn6U/c+Y12Q7PCE6rSbmPv7zrfNgyLZDkH7X3iBnvItAfiYpNyMQiFb7PAP89DZZB
         svhw==
X-Gm-Message-State: AOJu0Yw7bn7w2yIS2LLVUpbDqADXl+wlm7EgFi/D8evzXLYRtKb1VtlJ
	BBEZifQz/arFb+9KxmiDkViS/7L9M7a4/N2a/D3erkO/6VX/5QgsbioKHlC8XsXnTwKqqtUCAjx
	MXvFi4/PYyqXUafXiazKXgH4YcZM4ZLZAnw==
X-Gm-Gg: ASbGncvXKzeEMwdKA40N9S/HDnJiXs+sr/kY+eIJ15yqEOEjDK175WxEeloF2AFMBuH
	JwHoFnz7q2YvX013WnafxvwQ3mSPo+WXn9715nJ3TAQSQvvg6LI4FqcQhz5dAQRYYSRpKCvuKRi
	MeGap81MXd8W0xaF21+xWKtR1bhaXTAlFnAoh8jUEGIWU=
X-Google-Smtp-Source: AGHT+IHN/yuOhcqUmWnGKnmz9ynPXvsOi5QPu+rokY3jgBf4/ntkF8hA0+rYQmGH4VRJOmobEJzmZdvh7h5HUticwRU=
X-Received: by 2002:a17:90b:51cd:b0:30e:7ad7:ec8c with SMTP id
 98e67ed59e1d1-30e7d55be50mr30836316a91.20.1747828022151; Wed, 21 May 2025
 04:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-2-stephen.smalley.work@gmail.com> <8c2770270a9d4a217e22102ddf91327e@paul-moore.com>
In-Reply-To: <8c2770270a9d4a217e22102ddf91327e@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 May 2025 07:46:50 -0400
X-Gm-Features: AX0GCFsTxmV2pe17b9TD7jLJDN7w8umTcJxj4P4Z63BVUdBRw2YSfiQ44dGlaHY
Message-ID: <CAEjxPJ4NQ-OoXXK0cn+jN50bzM01hBoXkSN2UX3HJv5cO0J3uQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: introduce neveraudit types
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May  2, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > Introduce neveraudit types i.e. types that should never trigger
> > audit messages. This allows the AVC to skip all audit-related
> > processing for such types. Note that neveraudit differs from
> > dontaudit not only wrt being applied for all checks with a given
> > source type but also in that it disables all auditing, not just
> > permission denials.
> >
> > When a type is both a permissive type and a neveraudit type,
> > the security server can short-circuit the security_compute_av()
> > logic, rendering the type equivalent to an unconfined type.
>
> I really don't want to see the word "unconfined" in this patchset.
> Talking about optimizations that can be done when the permissive and
> neveraudit flags are combined on a single type is a good thing to do
> but I don't want people talking about how this is an unconfined type
> because it is not, it simply mimics that behavior.
>
> You are welcome to criticize that stance, but understand I believe
> this is an important distinction and it *is* a hill I'm willing to
> die on.

I am a believer in plain speech, and the reality is that this patch is
introducing a first class unconfined construct to SELinux for the
first time, which is something AppArmor had from day one. That said,
this is NOT a hill I am willing to die on, so I will change it as
requested. If I understand correctly, it is merely the use of the word
"unconfined" in the patch description and comments to which you
object, nothing else.

>
> > This change just introduces the basic support but does not yet
> > further optimize the AVC or hook function logic when a type
> > is both a permissive type and a dontaudit type.
> >
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/include/avc.h      |  4 ++++
> >  security/selinux/include/security.h |  4 +++-
> >  security/selinux/ss/policydb.c      | 19 +++++++++++++++++++
> >  security/selinux/ss/policydb.h      |  2 ++
> >  security/selinux/ss/services.c      | 20 ++++++++++++++++++++
> >  5 files changed, 48 insertions(+), 1 deletion(-)
>
> ...
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 7becf3808818..1c9b38c016e2 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1153,6 +1153,14 @@ void security_compute_av(u32 ssid,
> >       if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
> >               avd->flags |=3D AVD_FLAGS_PERMISSIVE;
> >
> > +     /* neveraudit domain? */
> > +     if (ebitmap_get_bit(&policydb->neveraudit_map, scontext->type))
> > +             avd->flags |=3D AVD_FLAGS_NEVERAUDIT;
> > +
> > +     /* both permissive and neveraudit =3D> unconfined */
>
> Nope.
>
> > +     if (avd->flags =3D=3D (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT)=
)
> > +             goto allow;
>
> ...
>
> > @@ -1208,6 +1218,14 @@ void security_compute_av_user(u32 ssid,
> >       if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
> >               avd->flags |=3D AVD_FLAGS_PERMISSIVE;
> >
> > +     /* neveraudit domain? */
> > +     if (ebitmap_get_bit(&policydb->neveraudit_map, scontext->type))
> > +             avd->flags |=3D AVD_FLAGS_NEVERAUDIT;
> > +
> > +     /* both permissive and neveraudit =3D> unconfined */
>
> More nope.
>
> > +     if (avd->flags =3D=3D (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT)=
)
> > +             goto allow;
>
> --
> paul-moore.com
