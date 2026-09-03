Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD94AFE17
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458085; cv=pass; b=kuH7QM3I7shB3sdzKJp4DsPEAZ5/MJADXJ+Ip3RxYwn3O5FffETngo9cqcKnufc0MXbXv32CcScAYp8IFepdUi2Wh7RnqdBpWnlfwNIS5jM1V6pXy/T9+9SE9SHkyCSF+L5yPg0eml9NobjhfGGVnvzrZkUedCYuIip+pyYnskE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458085; c=relaxed/simple;
	bh=Eb/KhBPYrVdCZVZnXYUBQP7PX6xwvKjmsmjk45O53BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZd0rc5hr64lFj3BJiQjyLaamTGiOujjSOkdQEfH6uhN/c5iJOWTMgnwldl7OXOQKnyr83XxBUKF936AqiFwHKdga/Z312DZV0jopQNgCaaRHz3cQFLN5w9ZXYX+Eb7DNMtzWVFiP/s8FVXrvc30mACmtfD79b0G1TfRuLR+v6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxy5o8Ae; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxy5o8Ae"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so76708a91.0
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 10:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788458083; cv=none;
        d=google.com; s=arc-20260327;
        b=iszmK/OpMB+IrwxgI6XuZSkdWztzTjuT8PQ1Cgt2C3RRIk/AlDoP17v1Fk4xC4E/C0
         aspaokhFi5uEOHIp4thYMVTasfHimRgeE6A7sGotltnZrpI7zvQdq5/q+C71VePdl3u7
         jwF+0uHvD6vfXWwNBByZJpFR+61HmlayEeNCF/PLC8aJkJKLp/7Kw8HlynqC5b4nbEy+
         bkutKy7RSvPYPBfzf4zDO7z2cIT29QuccLIyPsavu0NnpeFEw9hSmm+ZmHUPKSJJg17q
         pkoi8C9ydEyF4UU5saiacfmdHulMh2kw9X/6OQXKvLlr1JkIdsb3MHLFX2ZB0zxVwDhd
         TgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDI4hMnJGcLesPQ/jL9UZwM4DiKEnVIKEk2punA20fc=;
        fh=GhzO91hdKn81DHcb0RKcIJeoAIex/EhD4xEeSDQxCCI=;
        b=i0w80EAm+Iw9HmzTnKkmjcYLDXyt5j0B8qOMb/VCAagkV1KQZFs5jWspNyOA1bV14G
         57AfPmzCQ2s4lqx+kuybz7ai9somIYSBhrL0uwk40JLAGOW86fXqakvWK4pJZTjBdTMS
         TZkca8oPPo1HVgvN6gE1pDfuQUokHwEFqVedYK4B3P3TqbvoOEzYVnHwUUtZidLc2dl7
         vxtrGTbMvRcQEJPn5Cj9KJy4p6m8XE57azGQB/usc2oJ2Psxmyl4aNCo1j7vP4dCvD2y
         oD8mZn5cWRWIgIyV7t6i6Caasv0mnufCNgLlEmIMrK12YNCu2uurOZIj3fe+gq2uR60G
         EtcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458083; x=1789062883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDI4hMnJGcLesPQ/jL9UZwM4DiKEnVIKEk2punA20fc=;
        b=cxy5o8Ae8pbher6ijED6ifRIiibu5IlBWet83We/V2pz6tE4+pP+0jVQqnMCf4KfUk
         CVxRBpqAqDbo8LVjBRqtOnU5M5+D6+/cue7XsHSeX1l7N7HKC5fqEG1AjT4D1uw6L7gx
         RHYJmmLJLOkxDlsRSOPyT74+L5RC1fj+mshawveJYEiIG4GAvNmDB0EzbjarcHGyrLHZ
         RV0zzcjuffUUqi2mw3yLhjEwgTZDSmJikegfp41eyap3sB6YdFu//rZmccsl/8+fhbbP
         vfh+bBL1zGCPHq4MAK1uT2BgfZm7jtgXEIMpq96ZRGxLNLiXltFuR/G2/35B4GDG/uVO
         xD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458083; x=1789062883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDI4hMnJGcLesPQ/jL9UZwM4DiKEnVIKEk2punA20fc=;
        b=qyxDqbSeqpui0H3LfkLRtEECOyJvevMx7MUjVFAtZ/CaoD3lJzkLcg8EvrTPBJ/D/C
         E6CCuBd3+5u70GH1KSB8nMyr6IZcIkZAHfr9lI5KzXygskxPBykPLEeowUMmdX+GtBK2
         F12+Pqjk8oRkRJZ1dSs0why69YG0SSOHEuBMHu2bFLrjBH2LLlPrQfRSyWlHDIUxIJwk
         lbIvXigaA9Vo/YrvZw63GK0oBwPTB03VoBGLUtobiFDtIEIgFqp8KIz5PU8+9XMdwSGl
         LZ0iP05lak9+KkVDy9ttZLdtCyoC3x0ABAUsaRHe7gRQ7xrVzPB+dEaMJnKwXcgl0Dug
         Qw2w==
X-Gm-Message-State: AFuF++mib/bg1MKahVoCe9rACC5nvGxVjG7+SqilN8PiuOMmEcA0+8hb
	JCntSm6mbj0AJgZjcaDyhSOHCp/xIpyHs0pCW6bGKVHfqjCwFWS0HHOu1NKtAUfY3x6vnlOHv4i
	N2xZEVVY06F0l6I4NvkKUO0ujdlVAawM=
X-Gm-Gg: AYBFou3GQYokgpD144WshNqQOG/+b/hIkOkIQzfWZ7IuXGb0nG1K+WpkTQTvPrQjJct
	SDlyBNElfB+aW+Uq1Q0ie+uHPBYUKZU8v1vza17irCODCMR1VQ4doejdc+n8gvO3WwhSgtG9oRY
	C5aycpH0cc9sb6PL3JB07m6cyuEbZ0aZ2zVIhrlC9SVMn/k+862POgc11f6WAaSbwrPSLEMujdl
	D+O/Nreld2vG8iiPhmXK3gD7GfDlIvWrm/H+KrLHWbQY7l00HwN7DoN4ITp3b+WSt7FiY4gKFvq
	ete6uAoC9/C64aTL0gBa6GYz1J7/2rLjZNj8KDZPmAdUefxAY221oGArznzxZWLqYjYWDwQDaSy
	Vsbz6z4oFMrGEfw==
X-Received: by 2002:a17:90b:2e52:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-39b260dd3efmr358365a91.1.1788458083081; Thu, 03 Sep 2026
 10:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903155615.516010-1-omosnacek@gmail.com> <CAHC9VhQSoWBfWrf97Ch3ZZJXkOvhbwNOGmq8rMxLFzq+a-CkQg@mail.gmail.com>
In-Reply-To: <CAHC9VhQSoWBfWrf97Ch3ZZJXkOvhbwNOGmq8rMxLFzq+a-CkQg@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Thu, 3 Sep 2026 19:54:31 +0200
X-Gm-Features: AcwNN1VZckJ80AmrXNyT2zeNvIrDg0xBBi5yci3USYnxHaD1VlvQhO3H_tXYCmE
Message-ID: <CAAUqJDuPN4_qaCKhAfUz9xQ61NVhf=z-VAG_8Oe+QJeqqgi=SA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_MAINTAINERS=2C_mailmap=3A_update_email_addre?=
	=?UTF-8?Q?ss_for_Ondrej_Mosn=C3=A1=C4=8Dek?=
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sept 2026 at 18:50, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Sep 3, 2026 at 11:56=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosna=
cek@gmail.com> wrote:
> >
> > I'm going to use my personal email for kernel contributions from now on=
.
> > Update MAINTAINERS and .mailmap to reflect this.
> >
> > Also switch to use proper spelling with diacritics, since I normally us=
e
> > the full Unicode name with my personal email address. I'm leaving
> > in-code occurences unchanged though, as that would be just unnecessary
> > churn.
> >
> > Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VY=
pK8KuseMQS-9tNA@mail.gmail.com/
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > ---
> >
> > Hoping for this to get picked up via the SELinux tree, since the main
> > change is in the SELinux MAINTAINERS entry.
> >
> >  .mailmap    | 1 +
> >  MAINTAINERS | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
>
> Of course, I'll take this via the SELinux tree.  Since I'm going to be
> sending up a pull request to Linus soon with a v7.3-rcX fix, do you
> have any objection to me sending this up with that fix, or would you
> prefer this to wait for the next merge window?

No objections, sooner is probably better than later for me.

Thanks!

>
> > diff --git a/.mailmap b/.mailmap
> > index 6803f3bd2865..0e672a60afdc 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -699,6 +699,7 @@ Oliver Hartkopp <socketcan@hartkopp.net> <oliver.ha=
rtkopp@volkswagen.de>
> >  Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
> >  Oliver Upton <oupton@kernel.org> <oupton@google.com>
> >  Oliver Upton <oupton@kernel.org> <oliver.upton@linux.dev>
> > +Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> <omosnace@redhat.com>
> >  Ond=C5=99ej Jirman <megi@xff.cz> <megous@megous.com>
> >  Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
> >  Pali Roh=C3=A1r <pali@kernel.org> <pali.rohar@gmail.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fc320b373656..875d0baed8b9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24772,7 +24772,7 @@ K:      \bsecurity_[a-z_0-9]\+\b
> >  SELINUX SECURITY MODULE
> >  M:     Paul Moore <paul@paul-moore.com>
> >  M:     Stephen Smalley <stephen.smalley.work@gmail.com>
> > -R:     Ondrej Mosnacek <omosnace@redhat.com>
> > +R:     Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> >  L:     selinux@vger.kernel.org
> >  S:     Supported
> >  W:     https://github.com/SELinuxProject
> > --
> > 2.54.0
>
> --
> paul-moore.com
