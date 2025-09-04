Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499A1547E7
	for <selinux@vger.kernel.org>; Thu,  4 Sep 2025 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949330; cv=none; b=XG+rBY80nM3rUFx5CfOTBPrnXcReMSHr14GHotqUK2Jy/clJf1uEapuGIIgLoaXxYej17gPYhqnXmV677x6mJKXtYbPzAZg8uJ+5Ak26rEa00g6rXj77t5h67+Sp36YMBrSwl5bf7nQSXIjQ2ow76hrpVPnJI//ckHofOofSfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949330; c=relaxed/simple;
	bh=IaQ5uwK4QwBnH+gS9G1h8dmnPscMOmuMdmvaxqjSAxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfGW/Z/nX41wqI6Z+6K9hgY0a5xN6M111OpKtP7CelNhAiMSAUclApmSTD4XjFvCvXq3i5SRMtrh6QwdU0dc2RvJ8qCkft6INilNiDoEgEJ2hiSDVhW3gQ8RklEfmk4y1FGuBeD1D5w7d62R0Vn+vgwmkcotxEXr+4sfjEJ3IUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I+mNVC5p; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I+mNVC5p"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b6132e51dso330501a91.0
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756949328; x=1757554128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIOfyHMtIuoJpOd+VlEFA0bHfp6Gtl4PKzs6FIPewXA=;
        b=I+mNVC5p8jsB4c5LGhX+j4MhdLjPXQIPnp5qzLJTPHAE+z6X0j1+aVElLhqIReksk/
         NIq6qDy1eSTdVSYa/aC+dSpTOEt2ghoFtQMkh1LvmN9b+f0X6PyP0bzjaO3mSZ3bwZEi
         XUVNbl+Zvp2RgvzrOyP3H1LtuhJYsTBSdTNxbBvFJciS2pl0CB0DXR0caH26a1/gysKW
         SPiUf1gI1pylraX6ni8iSvfhv0G+SfRAvO2BwqO66EaknX2B35yHPt54GZ9Dg5HnMOyN
         2tbNxR0D6umhQUS7lK6hSQIu7KyUnIZWt+KfkmMDk0e0SFFGjQMG9jIHi/4QW0tE+j3Y
         vj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949328; x=1757554128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIOfyHMtIuoJpOd+VlEFA0bHfp6Gtl4PKzs6FIPewXA=;
        b=pS2opkxiWMHVAAd/Jzd6fj6yYC98ijFWi24pS9EsKe2lCUnmMy3bOxZcydEB1x/ZJY
         X14qqAulbi1Ced1V3Y+ibABybekMoRc+m1S4rOhYx9s4L0KBH4obI8wrT3s5o3QGGRz5
         OWNQTUyW4R/KI1dUml2uGelpheCQo1zOJDGFFhvwXXFLaaW7/IFG07qzTyKHbEfexSch
         CFLqcG+7ZMKgkCOoJfzK0vMJMUNKJGSrZB5+aiMgEYiG0QNWOwej9XcVTkTEBOElEdfp
         ak4bjMgz+UBoID8Qb3HAThkR23aucwrIDJl4RR9j72rgWVoalbkEXqfCGJYVYDbvwXOb
         9mgw==
X-Gm-Message-State: AOJu0Yy2BNFBoZy7C/K0fg97SrWJPFiiMymf96g+5BlCmdDyj30YpIJg
	l4H+Gd9p+1MxIFMkxfc+5VayVao0MlUVXBog22lfg+mmgJPYz/XnYEpJ1239sXSPAW66Qr2PhXY
	U3vzfqoz8uS8dVjJxvE/h0jsqlBS7ufQvFHpBgfiD
X-Gm-Gg: ASbGncttAbwjI0jKtzgSgIsPR1kf9Q/I/tPnxVKD3K70Lg3UfNndK356/wyu0x28m3Z
	Xi4AHxM1SSNfOckeOpvMXwaFrCVNqNJ+dW31brgiPCvJedWMV4R2KjwyX3Wpmw531RLAbxME7Hm
	rOn/7uz6urKIWMv6PZHFdT1B09NxqYaRWomzbyvQqIrSC7w9YAjlMCND2Dk5knn5DD6Dj6GGCmY
	cLFz0UF2599JpCPMXVBvUTR1eeh
X-Google-Smtp-Source: AGHT+IFBKmXhFkhlf3AO3YklhmlQlkknPiNAGzAs3/NGtNx5EdCIX4CD+Vo4Pco6SEL0557kGd49fhJOqXjMoxsF0Cw=
X-Received: by 2002:a17:90b:3fcc:b0:329:f630:6c3 with SMTP id
 98e67ed59e1d1-329f630078dmr9758647a91.20.1756949328511; Wed, 03 Sep 2025
 18:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-65-paul@paul-moore.com>
 <CAHC9VhRwHLaWP-qUCEVC7-6hEWf0K1H9DwbxWMW9c3a5uUF94w@mail.gmail.com> <1932305e-c6df-42c6-906b-d57364652242@canonical.com>
In-Reply-To: <1932305e-c6df-42c6-906b-d57364652242@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 21:28:35 -0400
X-Gm-Features: Ac12FXwM_owd8hqAIDRgoryFAGYaav8zfNn8ISHgZWw1QPDHSomawRHnM-NiHCQ
Message-ID: <CAHC9VhQbRp7i6dP_Z1W41ykeG6N2Dp_fGzE6sh8xXo_pxPSfWw@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:15=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 9/3/25 13:34, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Reviewed-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>   security/apparmor/apparmorfs.c         | 4 +---
> >>   security/apparmor/crypto.c             | 3 +--
> >>   security/apparmor/include/apparmorfs.h | 2 ++
> >>   security/apparmor/include/crypto.h     | 1 +
> >>   security/apparmor/lsm.c                | 9 ++++++++-
> >>   5 files changed, 13 insertions(+), 6 deletions(-)
> >
> > Thanks for reviewing all the other patches John.  Assuming you are
> > okay with this patch, can I get an ACK?
>
> I'm working on it. I managed to get down to I think 3 patches remaining t=
o review/ack, and I wanted to get some testing on this one before acking. H=
opefully will get that done today

No worries, I just wanted to make sure it wasn't an oversight.  Thanks
again for reviewing everything.

--=20
paul-moore.com
