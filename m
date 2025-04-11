Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847F279339
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744339305; cv=none; b=HJX9HFpAfTvoogexitD9sqAyaapBaYmFQYzDtZq98NRAtojGl9ceC24GEBHyBsDSNukw2mNKmpnsPogoVrHbCvxmnYX1QdJRnPQHBTZA39GCEtW2LCHPvXrTahvA46qAZ+LBfWUpW+tLVGsf/p5EUZFSyKsV8T80csSPRnPrWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744339305; c=relaxed/simple;
	bh=as9kSQASNHOZEqVjFgkKcfcacxgPlIJuUo017aL6c5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfQisxAWSmX5G8kXTq3kyufpIrEtnwh/FmBztAWMQr9b8i7Oq0gbZZq9whBJVeFwO0EFVQFJwW+rDKr7MbH//w3kIQOgBYjHTu4/9aEUImV/IyaoVDGglt0WkJTGSlBSGOdy0MUOC0zn658lYuhUZ08efOVea+9O1JecpiYnnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S30PRnNR; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S30PRnNR"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso1365642276.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744339303; x=1744944103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CwF+ie3M3uU4fIen1I6/2Rgy5lqyQhlFhFk+DF1se8=;
        b=S30PRnNRSvuU9IMAkZaarLZMJWxHbN/EY4RbuvdLB3K7nc5n6hm115VtdZB0w3+wmF
         jkkV9HMoSRNed09lrY3VysuoGz+5MzjdDbtdCcffu/vn4zlnZW68BLmkoCBAv+QB6CPG
         xPhGuPYLyghjUCpKuhkLPIDxiJ6Ts6WMIGjkJIrRk6O//WAPRn0Jp8Ws3lGu4RNnQyjH
         6sFj98j2H1QunBb6W5IsmaTihBXBO5/imtgeh5K8YRLCs4YRNRH6UzoHkmQG7zvBIf2r
         1O1V0XDo3QtyeI0AaBnBzy5u37h20VEPTIRLSJt8nB3fu/oGHbDDcwOczPd722CH8tyK
         s0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744339303; x=1744944103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CwF+ie3M3uU4fIen1I6/2Rgy5lqyQhlFhFk+DF1se8=;
        b=LFc11t2QpbN1xUtMcIuIn821ry2Jh6pey5ibwibz+D8As7To73YG7OGRZH0wVOEepq
         dgeISQ0WjKK5yusf5f8RAyKxvHoFE3onOlB435ariRDk8toKYnb74gm956cOXnY9iTuk
         yZScvwvyQXxZm8vSHsdJ1Bn9MUWtuvQ/cPr3V6r7cy/nifjf7dTdAUzteFv2mSjEbNve
         FUUV/WYAypwzary3EMMHxG1yxpOH+eB6GdRHOvjIzlfo5WwulDqZI0QnE+S/J94X53dA
         LmxR7GlljbSK9z4cnFK7ovaRbavjsWqsatWFxD/V+TWQl2qEt/duAP2OkD6jQMyHtEGf
         RymQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmPtFWEhHzD9Zc1F6OYx9WM1A2ByG4COT77SPXXToT5d4oNUHHGx1FnvIAtN2mxtH0Fv0t2zID@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmucHo6+jn5h1Dp1f79blusbgLQdrm95P65weJmPljCm+V7s7
	1ccjzprthfJkFbnrKFjkV94b+CqHAMBQ4iodR6OGagYaDrJin7sRzJ3iS1PmoBHI/LgHe3VxX3P
	FEnHB6O2W1NdVZXIwMvz25M9QBdI6dCZzIxQp66FitB1CUTQ=
X-Gm-Gg: ASbGncv3syZCbHSHzXyyOxaHh0VoKgHkBVp3Zy86I9HD92gvS6yL3MhTjEvO8Ny3bBg
	/gq7yak06CsCFBjobop0Wfy/sjLhgT0ArFxk/rawIY1ch4tMORonvETZO4fd8px9rRlHSikD5qk
	+f/Fl6CEgJPkkDSaffwCMGRg==
X-Google-Smtp-Source: AGHT+IFyF3fZnOWLhxV5JgbmPr2sTVJJVPls46hqxiiCUMkby6GAJYYZggmtKw46ptdM2VMxpFqKc+QvSJIG4R08H8I=
X-Received: by 2002:a05:6902:1545:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e703e6de386mr8638189276.10.1744339303036; Thu, 10 Apr 2025
 19:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-49-paul@paul-moore.com>
 <202504091639.A12E1A853E@keescook> <CAHC9VhTR=ee4SGuvDbFj-dtevVFN3Pm-tVhtMLpHsiYB24Xxcw@mail.gmail.com>
 <202504101915.CA031AE@keescook>
In-Reply-To: <202504101915.CA031AE@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:41:32 -0400
X-Gm-Features: ATxdqUEGP_uYjR2QUaCWVy9WoK8JP8pDyZNvieKfq707AQCl9JSsANJ7Avf5nhA
Message-ID: <CAHC9VhRQ=854kmKnv=gRCUNOk0TK2=-ss8S220yAkwsUP+y-Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
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

On Thu, Apr 10, 2025 at 10:16=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Apr 10, 2025 at 09:15:47PM -0400, Paul Moore wrote:
> > On Wed, Apr 9, 2025 at 7:39=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
> > > On Wed, Apr 09, 2025 at 02:50:03PM -0400, Paul Moore wrote:
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > Do you mind if I convert this into an Acked-by?  Generally speaking I
> > put more weight behind a Reviewed-by tag, but in the case of Loadpin
> > you are the maintainer and I'd much prefer an Acked-by.  While I'm
> > always happy to get more reviews on a patch, the primary reason for
> > CC'ing you directly was to get ACKs on the LSMs you maintain :)
>
> Acked-by: Kees Cook <kees@kernel.org>
>
> :)

Thanks :)

--=20
paul-moore.com
