Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756426ACB
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237894; cv=none; b=FYWQ0V3B/2DGpIqozOpGPVDboQK0o2pX5gZvFzJmWUpOatsXKuzRXWth1TGLooKz2Kv0BxanclRNEhkqJ7ZHzwzu8wMT5HjzUzHtSWAQ7vz7vTjRd9uNwnUGvtkeR49SeImeue3GTLAQiqTTPmSsL9tWxhenEAPUlq88aZ0fClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237894; c=relaxed/simple;
	bh=SWdd9RTpM42vC5ZNMkrzCkNmTgWrjK/TrQBHQAK+k78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM38meDT12WDXDlepePw/lpbkwjekCTTVT8jX5vtvLajyky+C+sqg5ntVFZVTcbRTi8O8mBxgYx1IVnar85k8B+597Y5JLWBTV8hzgGJ5ZkfEFbAQFfGwz8Q2W6NARZa5VeEwyvKIxDIiOL3E2y4vszdGJgQ2BULRFxvRoZFFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f88vYIWx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f88vYIWx"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fedefb1c9cso2195967b3.0
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744237890; x=1744842690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4woi2xGlWCHzrCPzebUyPEdkLsFWCOIqQ/998TUZGI=;
        b=f88vYIWx6yMftnd776OavRz+1EofjrnydXgO/syIDFz1ghNDulCEA25vE+/8QaUgTz
         GFR9FTkJ03I6fy1Pn845QnV5CYVOn8n1gAX2CWkA8/ZZ7aQPGml/PSoi5lW47fwSxGUy
         Bgx1lBkxncvLN9Qv3jumcRtx6RegLeOkbA7FCe33D703ojORT0+3Ip9wT3ummy6en2Sf
         Rjoqdu54u+lHIdsIcRU1vF5H9Uw3jpUx8QBcf51M3C9jck/LdF00S564FrLwlGJ47W8S
         TCbaRBv1G64Ie/9tulIuGTFejZkj/Tp/jtLlJ/JJgQVBCNy2nDgQR39CkaJJCBdX6VZX
         hZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744237890; x=1744842690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4woi2xGlWCHzrCPzebUyPEdkLsFWCOIqQ/998TUZGI=;
        b=mdSi4E/Kp4ayVpqwdAFUI8zPBHD6NtpHtdxFNm4ZCAT3lt3/b3CuTfVk9JD1fc/Cdm
         yRantt0b3XMZ3mCj3SdOpoNg2hsqea98NZb2hSekYl2UoNRKeJY8bnbHhzDzXyciA9/J
         CrkyIratcWTuZddt3O/AX9hSR2rFvKYRmSgKTA1Z/8QTYtXMEGXdKdZswW1stsycRSoZ
         cFqttFu2wYdtzcI3DeQGPVlez3b2sNyj2lxYLGZ9U8IfGaSeS96tbkUdmjh7GVpknFgL
         pwn2tk6mu1SGkPw4Wd5tNPmiIkwJIAka81JIxOftuQ4pBwaJ+0vSkFybKIWnm0kFSdye
         f3sA==
X-Forwarded-Encrypted: i=1; AJvYcCWJTltHzxIBC2uXKVUAyEvqucVeSAsQe0aXS/zlE+ZARdnXHn27pY9q21uC1y2H/8G2ecyrYKHL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nv1OvodT19+COMhcNdEnUqHWxAuR2m3rcYL70kDnjTYGFV3z
	gVzGZnQxnnOx0yzkKsXCchKhIcd5C1x8xdauq/dgM9NCeMVwW6J8vKM3b5W5jkujRpx/MITi6Yg
	cYBsB9oxSQDf3Uw+0MQ3BYc5Kzoi2gxO/qbIZ
X-Gm-Gg: ASbGnct+8MNAiQDKIGELdNQy+LskpdTnPOWeP5AAgx/uoMXwoDcrn109Ah+opMheprQ
	pDrBb+4cE8AeebcGsJRfP5Vx3/YTtMurl2A7E8Sw6BAyX8hkgq3EWHy/6PqKRlITGEo+rwGC/30
	Nf1Ml6eNNQAbo1F3Y4p5L0cpR8fc11hZeG
X-Google-Smtp-Source: AGHT+IHxj+xJhKVAVZeidbydD08JnIVI+V9xRkPwJ88AD9pQb4gyRiYQ0vkLQ7TS1/g0pr0/pAEfyoXjrdjyN8nC7i4=
X-Received: by 2002:a05:690c:4906:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-70549eccfd8mr9140947b3.20.1744237890543; Wed, 09 Apr 2025
 15:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-35-paul@paul-moore.com>
 <202504091435.E172A67C6@keescook>
In-Reply-To: <202504091435.E172A67C6@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Apr 2025 18:31:18 -0400
X-Gm-Features: ATxdqUF58K2osiGI0aRmIUdrzsTIM0H-CerRYW_6JWr-DyWGlRBbjMVguJ_NTOQ
Message-ID: <CAHC9VhS0Nc_uYMDfmaiQPV9fDwRcB_4wHGvXhEDi0AFpLXeXQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/29] lsm: simplify ordered_lsm_init() and rename to lsm_init_ordered()
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:38=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Apr 09, 2025 at 02:49:49PM -0400, Paul Moore wrote:
> > One part of a larger effort to cleanup the LSM framework initialization
> > code.
>
> Again, needs a better commit log.

See my previous comments as well as the cover letter for the reason why.

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index dffa8dc2da36..407429688f1b 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -32,6 +32,12 @@ static __initdata bool debug;
> >                       pr_info(__VA_ARGS__);                           \
> >       } while (0)
> >
> > +#define lsm_order_for_each(iter)                                     \
> > +     for ((iter) =3D ordered_lsms; *(iter); (iter)++)
> > +#define lsm_early_for_each_raw(iter)                                 \
> > +     for ((iter) =3D __start_early_lsm_info;                          =
 \
> > +          (iter) < __end_early_lsm_info; (iter)++)
>
> The longer I look at this patch the longer I think it needs to be broken
> up into a few separate patches, but they would be relatively small, like
> this one: replace iter loops with iter macros.

Fair point, done.

> > @@ -340,10 +304,23 @@ static void __init ordered_lsm_init(void)
> >       } else
> >               ordered_lsm_parse(builtin_lsm_order, "builtin");
> >
> > -     for (lsm =3D ordered_lsms; *lsm; lsm++)
> > +     lsm_order_for_each(lsm) {
> >               lsm_prep_single(*lsm);
> > +     }
> >
> > -     report_lsm_order();
> > +     pr_info("initializing lsm=3D");
> > +     lsm_early_for_each_raw(early) {
> > +             if (is_enabled(early))
> > +                     pr_cont("%s%s",
> > +                             early =3D=3D __start_early_lsm_info ? "" =
: ",",
> > +                             early->name);
> > +     }
> > +     lsm_order_for_each(lsm) {
> > +             if (is_enabled(*lsm))
> > +                     pr_cont("%s%s",
> > +                             lsm =3D=3D ordered_lsms ? "" : ",", (*lsm=
)->name);
> > +     }
>
> report_lsm_order()'s use of "first" needs to stay here or you don't get
> the right comma/no-comma behavior. It's not about the lsm, it's about
> whether "first" got incremented. Perhaps "count" might be a better name
> for "first".

Sure, I'll just put the "first" code back, it all gets changed later
in the patchset anyway, no need to worry about long term stuff in this
snippet.

--=20
paul-moore.com
