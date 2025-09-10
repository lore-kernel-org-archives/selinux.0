Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADDC277CAB
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520451; cv=none; b=rUUqd6yXlOyw/V8i6ER9qMxzo92VItSTKFY4gYArfCm969xkQ1aVO+wunmvbcoKRM1PA9zN+qnAi3ffjCIIkNUMS9Ajtoq1AMAiOJPbvQaEQ4brI7s30qiy+c5zwERNTamls1QKcIjaabeNRsMsz6zE5+F8CSc1NakaHh/LGN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520451; c=relaxed/simple;
	bh=KhQDNf7Hx5q2dTEvRXEt9KbPvFRrtNQjBvCUMncZ8gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6lMHazmtMUYmc7RWxFhSg2IwR6LTq5gDUNXH2EPXZlcFqt2dD3Geog+OOjxIVwroIgp9M8+sEVhsGonQbX9SY5SsET8H2gHfbU+VStiI19PmVkHGuRY2L4S624xAGu5zC4kYAiq9bVbJIfpMjiqfASPxEhNA/t3OOqBYwdiMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U10gFVpw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U10gFVpw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32db52f2f07so1515943a91.0
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757520447; x=1758125247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/SSUahcKBV25mZdGMT5I31BSXz12HmWVHuFxBX4um8=;
        b=U10gFVpw55h7s/KWjlj93keH9QGqrLSq05TElQMkrPoj1wqCBSGr+5GYu2l7pO2Ng6
         wXAbqRhnm/audnXuAqIXIh3wnx4oPUtY7XXRPZL2+ltVxDWJhXL3E/wQj2nAjpGvpMh/
         RZ96OCKxA4Ww9y0COBy86lzYqe+LaX+xGuPUQr3oQaG1VUOkUjxWRL9i02P6G+1SNokU
         3Lh4xQQMnbuY3XOSb49FWAccFJoRYudM8hMoaQnn+oKM6D8j1zQDB0DSvkB+9wB/yoV0
         2DgK9jGPPLPSxTvsX09yVf1p3dm1CP+/Ez63oE/9gvSWONKnmJSFqF6kBRiNbbg1g98A
         OTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520447; x=1758125247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/SSUahcKBV25mZdGMT5I31BSXz12HmWVHuFxBX4um8=;
        b=oDUEB+whkrI7qJKpXd6a8S89dr9OinavqsuJ1VZzbtXnrt1xVBMVyKjgS1I9nsTJmR
         zgQLKRVRi+rV9VdigdqN+JuUd6EPiiNUMCnZ/aRm+S79N1rDomJIfsKNUmps+Os9Rp4q
         7XROjbao6wSUQlK+yh0peQI6uQTTiTWVUHRCSQOKvoeVobaivLKrN8iBaJ8c2UejbrE0
         7lPramR5n2jB59d6ZF5heELWYx8eSSYouYT0g/5jqxyu63Ok+orNt2A6ruR439tobIu5
         TXfKJNYUyzpgg6Z0DbUAft5H9u51sd9AJ/fL1u/PujK/2IOxLxBYFF9Uq/a1/Y4qWLq0
         LxHg==
X-Forwarded-Encrypted: i=1; AJvYcCXyLp1dgniJKGqOBy3qi6T1RiZMoEfWzoT5lY58kYAoFpW3xUOVYW7IJnYYGCE9Zysk12S/dZSU@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6mMxqFsY7shv+mVuI26R6ce3BtvtE3gALfcomp0kRDul8M+m
	S+k7tILI0jvBxaUdLz44dklk3V6R4VYfkXODZSxsAnRmGkYnkUHGbRqwmkCErYVBRbJhP5NmPqt
	BPnEMxsjydvHThQf7/zBUi16Ll99mC6LUCXhLfOEF9+MsZ8hdyN0=
X-Gm-Gg: ASbGncvikAhdhwRRM4D6Ibii82+LH+xx5sPAjgYAXBMEXfxqofTvqf9SioJIkpXejqD
	Vstyrv5du6jWPXgkdNEtVO1QCCFW3jAY/SYWNa+fV6FVbfAlumDJZhS71aQwaQWjethV3ySY939
	vrKo0/Vjl2Y5+rE9ePRkE/kKUV0UIoDwv1/IhpxHCC+ZjF+R80dcWnPgL2p9ZRCQPGmIAqJTPS5
	KSvlUbcOSuCKUaSdj06fJOooHuR
X-Google-Smtp-Source: AGHT+IEEUvU4X6Q346k+tqtjJFLB7LE4vWJAsInXUACyHnTSDQZY/QgpfO9GTSpUCC6Yy/m37hWkJK44xg8W3MqkEko=
X-Received: by 2002:a17:90a:d443:b0:31e:c62b:477b with SMTP id
 98e67ed59e1d1-32d43eff6f0mr19556678a91.11.1757520447590; Wed, 10 Sep 2025
 09:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com> <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Sep 2025 12:07:14 -0400
X-Gm-Features: Ac12FXzui_z2RYxjBKt_p_FpUOcF4N6uWhg-QmlWBL9IEIVFiAejLQufx08ATWM
Message-ID: <CAHC9VhSemw9wyots53sTzZU9KE=u6z80HrMAZ12ZhS979oKVWg@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > A prior commit, see the 'Fixes:' tag below, added support for a new
> > > > object class, memfd_file.  As part of that change, support for the
> > > > new object class was added to selinux_bprm_creds_for_exec() to
> > > > facilitate execution of memfd_file objects using fexecvc(2), or
> > > > similar.  This patch adjusts some of the sanity checking added in t=
hat
> > > > commit to avoid a "silent denial" in the case of a kernel bug as we=
ll
> > > > as return -EACCES instead of -EPERM so that we can more easily
> > > > distinguish between a permission denial and a fault in the code.
> > >
> > > Technically, this doesn't make it easier to distinguish because we
> > > usually return -EACCES from avc_has_perm() and friends, but return
> > > -EPERM for capability denials and in certain other cases (not always
> > > clear why, arguably a bug unless we were just replicating the error
> > > number for some existing check that also returned -EPERM).
> >
> > It's awfully fuzzy from my perspective.
> >
> > > My
> > > suggestion to use -EACCES was because that is more consistent with ho=
w
> > > we report denials outside of capability checks.
> > > To actually test this, would need an updated libsepol patch that deal=
s
> > > with the fact that the policy capability number changed on merge, or
> > > re-basing the original patch on top. Otherwise,
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > To be honest, this isn't the sort of discussion I like to see for
> > patches that are merged in the -rc5 time frame, if we're merging stuff
> > at this point in the dev cycle we should be past uncertainty like
> > this.  I'm obviously not going to merge this patch and I'm going to
> > drop Thi=C3=A9baud's patch from selinux/dev too so we can sort this out=
.
>
> Not sure it warrants reverting Thiebaud's patch. I was fine ack'ing
> that as is. I just thought we might want to follow up with something
> to improve the error handling here, which can be done anytime IMHO.

I believe it does, the tree on kernel.org should be updated now.

I agree that at the very least we should have a better
discussion/consensus about the error handling, and that is something
that should happen before we send the patch up to Linus.

--=20
paul-moore.com
